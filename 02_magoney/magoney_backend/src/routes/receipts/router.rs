use std::sync::Arc;

use async_trait::async_trait;
use axum::{routing::get, Extension, Router};
use chrono::Utc;
use sqlx::PgPool;
use uuid::Uuid;

use crate::error::AppError;

use super::{
    entities::{
        create_one::ReceiptCreateOne, read_all::ReceiptReadAll, read_one::ReceiptReadOne,
        update_one::ReceiptUpdateOne,
    },
    repository::ReceiptRepo,
    types::DynRepo,
};

pub fn mount_routes() -> Router {
    let receipt_repository_impl = Arc::new(ReceiptRepoImpl) as DynRepo;

    Router::new()
        .route(
            "/receipts",
            get(super::handlers::handler_read_all).post(super::handlers::handler_create_one),
        )
        .route(
            "/receipts/:code",
            get(super::handlers::handler_read_one)
                .delete(super::handlers::handler_delete_one_by_code)
                .put(super::handlers::handler_update_one_by_code),
        )
        .layer(Extension(receipt_repository_impl))
}

struct ReceiptRepoImpl;

#[async_trait]
impl ReceiptRepo for ReceiptRepoImpl {
    async fn read_all(&self, pool_conn: PgPool) -> Result<Vec<ReceiptReadAll>, AppError> {
        let mut tx = pool_conn.begin().await?;

        let payload = sqlx::query!(r#"SELECT id, code, collection_date, donate_world_work, local_congregation_expenses, receipt_type_fk, created_at, updated_at FROM receipts ORDER BY id DESC;"#)
            .fetch_all(&mut tx)
            .await?;

        let transformed_payload = payload
            .into_iter()
            .map(|record| {
                ReceiptReadAll::new(
                    record.code.to_string(),
                    record.collection_date,
                    record.donate_world_work,
                    record.local_congregation_expenses,
                    record.receipt_type_fk,
                    record.created_at,
                    record.updated_at,
                )
            })
            .collect::<Vec<_>>();

        tx.commit().await?;

        Ok(transformed_payload)
    }

    async fn read_one_by_code(
        &self,
        pool_conn: PgPool,
        code: Uuid,
    ) -> Result<ReceiptReadOne, AppError> {
        let mut tx = pool_conn.begin().await?;

        let uuid = code.to_string();
        let uuid_str = uuid.as_str();
        let sqlx_uuid = sqlx::types::Uuid::parse_str(uuid_str)?;

        if let Some(record) = sqlx::query!(r#"SELECT code, collection_date, donate_world_work, local_congregation_expenses FROM receipts WHERE code=$1;"#, sqlx_uuid)
        .fetch_optional(&mut tx).await
        ? {

        tx.commit()
        .await
        ?;

        return Ok(   ReceiptReadOne::new(
                 record.code.to_string(),
                 record.collection_date,
                 record.donate_world_work,
                 record.local_congregation_expenses,
            ))
        }

        return Err(AppError::EntityNotFound);
    }

    async fn create_one(&self, pool_conn: PgPool, data: ReceiptCreateOne) -> Result<u64, AppError> {
        let now = Utc::now().naive_utc();

        let uuid = Uuid::new_v4().to_string();
        let uuid_str = uuid.as_str();
        let sqlx_uuid = sqlx::types::Uuid::parse_str(uuid_str)?;

        let mut tx = pool_conn.begin().await?;

        let query_result = sqlx::query!(
                r#"INSERT INTO public.receipts(code, collection_date, donate_world_work, local_congregation_expenses, receipt_type_fk, created_at, updated_at)
                    VALUES ($1, $2, $3, $4, $5, $6, $7);"#, sqlx_uuid, data.collection_date(), data.donate_world_work(), data.local_congregation_expenses(), data.receipt_type(), now, now
            )
            .execute(&mut tx)
            .await?;

        let affected_rows = query_result.rows_affected();

        tx.commit().await?;

        Ok(affected_rows)
    }

    async fn delete_one_by_code(&self, pool_conn: PgPool, code: Uuid) -> Result<u64, AppError> {
        let code_string = code.to_string();
        let code_str = code_string.as_str();

        let sqlx_uuid = sqlx::types::Uuid::parse_str(code_str)?;

        let mut tx = pool_conn.begin().await?;

        let query_result = sqlx::query!(r#"DELETE FROM public.receipts WHERE code=$1;"#, sqlx_uuid)
            .execute(&mut tx)
            .await?;

        let affected_rows = query_result.rows_affected();

        tx.commit().await?;

        Ok(affected_rows)
    }

    async fn update_one_by_code(
        &self,
        pool_conn: PgPool,
        data: ReceiptUpdateOne,
        code: Uuid,
    ) -> Result<u64, AppError> {
        let code_string = code.to_string();
        let code_str = code_string.as_str();

        let sqlx_uuid = sqlx::types::Uuid::parse_str(code_str)?;

        let mut tx = pool_conn.begin().await?;

        let mut affected_rows = 0;
        let now = Utc::now().naive_utc();

        if let Some(payload) = data.collection_date() {
            let query_result = sqlx::query!(
                r#"UPDATE public.receipts SET collection_date=$1, updated_at=$2 WHERE code=$3;"#,
                payload,
                now,
                sqlx_uuid
            )
            .execute(&mut tx)
            .await?;
            affected_rows += query_result.rows_affected();
        }

        if let Some(payload) = data.donate_world_work() {
            let query_result = sqlx::query!(
                r#"UPDATE public.receipts SET donate_world_work=$1, updated_at=$2 WHERE code=$3;"#,
                payload,
                now,
                sqlx_uuid
            )
            .execute(&mut tx)
            .await?;
            affected_rows += query_result.rows_affected();
        }

        if let Some(payload) = data.local_congregation_expenses() {
            let query_result = sqlx::query!(
                    r#"UPDATE public.receipts SET local_congregation_expenses=$1, updated_at=$2 WHERE code=$3;"#,
                    payload,now,
                    sqlx_uuid
                )
                .execute(&mut tx)
                .await
                ?;
            affected_rows += query_result.rows_affected();
        }

        if let Some(payload) = data.receipt_type() {
            let query_result = sqlx::query!(
                r#"UPDATE public.receipts SET receipt_type_fk=$1, updated_at=$2 WHERE code=$3;"#,
                payload,
                now,
                sqlx_uuid
            )
            .execute(&mut tx)
            .await?;
            affected_rows += query_result.rows_affected();
        }

        tx.commit().await?;

        Ok(affected_rows)
    }
}
