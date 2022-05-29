use std::sync::Arc;

use async_trait::async_trait;
use axum::{
    routing::{delete, get},
    Extension, Router,
};
use chrono::Utc;
use sqlx::PgPool;
use uuid::Uuid;

use crate::error::AppError;

use super::{
    entities::{create_one::RecordCreateOne, read_all::RecordReadAll, update_one::RecordUpdateOne},
    repository::RecordRepo,
    types::DynRepo,
};

pub fn mount_routes() -> Router {
    let receipt_repository_impl = Arc::new(RecordRepoImpl) as DynRepo;

    Router::new()
        .route(
            "/records",
            get(super::handlers::handler_read_all).post(super::handlers::handler_create_one),
        )
        .route(
            "/records/:code",
            // get(super::handlers::handler_read_one)
            delete(super::handlers::handler_delete_one_by_code)
                .put(super::handlers::handler_update_one_by_code),
        )
        .layer(Extension(receipt_repository_impl))
}

struct RecordRepoImpl;

#[async_trait]
impl RecordRepo for RecordRepoImpl {
    async fn read_all(&self, pool_conn: PgPool) -> Result<Vec<RecordReadAll>, AppError> {
        let mut tx = pool_conn.begin().await?;

        let payload = sqlx::query!(r#"SELECT id, code, record_date, detail, donate_input, donate_output, bank_account_input, bank_account_output, other_input, other_output, symbol_fk, created_at, updated_at
        FROM public.records ORDER BY id DESC;"#)
            .fetch_all(&mut tx)
            .await?;

        let transformed_payload = payload
            .into_iter()
            .map(|record| {
                RecordReadAll::new(
                    record.code.to_string(),
                    record.record_date,
                    record.detail,
                    record.donate_input,
                    record.donate_output,
                    record.bank_account_input,
                    record.bank_account_output,
                    record.other_input,
                    record.other_output,
                    record.symbol_fk,
                    record.created_at,
                    record.updated_at,
                )
            })
            .collect::<Vec<_>>();

        tx.commit().await?;

        Ok(transformed_payload)
    }

    async fn create_one(&self, pool_conn: PgPool, data: RecordCreateOne) -> Result<u64, AppError> {
        let now = Utc::now().naive_utc();

        let uuid = Uuid::new_v4().to_string();
        let uuid_str = uuid.as_str();
        let sqlx_uuid = sqlx::types::Uuid::parse_str(uuid_str)?;

        let mut tx = pool_conn.begin().await?;

        let query_result = sqlx::query!(
                r#"INSERT INTO public.records(code, record_date, detail, donate_input, donate_output, bank_account_input, bank_account_output, other_input, other_output, symbol_fk, created_at, updated_at)
                VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12);"#, sqlx_uuid, data.record_date(), data.description(), data.donate_input(), data.donate_output(), data.bank_account_input(), data.bank_account_output(), data.other_input(), data.other_output(), data.symbol_fk(), now, now
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

        let query_result = sqlx::query!(r#"DELETE FROM public.records WHERE code=$1;"#, sqlx_uuid)
            .execute(&mut tx)
            .await?;

        let affected_rows = query_result.rows_affected();

        tx.commit().await?;

        Ok(affected_rows)
    }

    async fn update_one_by_code(
        &self,
        pool_conn: PgPool,
        data: RecordUpdateOne,
        code: Uuid,
    ) -> Result<u64, AppError> {
        let code_string = code.to_string();
        let code_str = code_string.as_str();

        let sqlx_uuid = sqlx::types::Uuid::parse_str(code_str)?;

        let mut tx = pool_conn.begin().await?;

        let mut affected_rows = 0;
        let now = Utc::now().naive_utc();

        if let Some(payload) = data.record_date() {
            let query_result = sqlx::query!(
                r#"UPDATE public.records SET record_date=$1, updated_at=$2 WHERE code=$3;"#,
                payload,
                now,
                sqlx_uuid
            )
            .execute(&mut tx)
            .await?;
            affected_rows += query_result.rows_affected();
        }

        if let Some(payload) = data.description() {
            let query_result = sqlx::query!(
                r#"UPDATE public.records SET detail=$1, updated_at=$2 WHERE code=$3;"#,
                payload,
                now,
                sqlx_uuid
            )
            .execute(&mut tx)
            .await?;
            affected_rows += query_result.rows_affected();
        }

        if let Some(payload) = data.donate_input() {
            let query_result = sqlx::query!(
                r#"UPDATE public.records SET donate_input=$1, updated_at=$2 WHERE code=$3;"#,
                payload,
                now,
                sqlx_uuid
            )
            .execute(&mut tx)
            .await?;
            affected_rows += query_result.rows_affected();
        }

        if let Some(payload) = data.donate_output() {
            let query_result = sqlx::query!(
                r#"UPDATE public.records SET donate_output=$1, updated_at=$2 WHERE code=$3;"#,
                payload,
                now,
                sqlx_uuid
            )
            .execute(&mut tx)
            .await?;
            affected_rows += query_result.rows_affected();
        }

        if let Some(payload) = data.bank_account_input() {
            let query_result = sqlx::query!(
                r#"UPDATE public.records SET bank_account_input=$1, updated_at=$2 WHERE code=$3;"#,
                payload,
                now,
                sqlx_uuid
            )
            .execute(&mut tx)
            .await?;
            affected_rows += query_result.rows_affected();
        }

        if let Some(payload) = data.bank_account_output() {
            let query_result = sqlx::query!(
                r#"UPDATE public.records SET bank_account_output=$1, updated_at=$2 WHERE code=$3;"#,
                payload,
                now,
                sqlx_uuid
            )
            .execute(&mut tx)
            .await?;
            affected_rows += query_result.rows_affected();
        }

        if let Some(payload) = data.other_input() {
            let query_result = sqlx::query!(
                r#"UPDATE public.records SET other_input=$1, updated_at=$2 WHERE code=$3;"#,
                payload,
                now,
                sqlx_uuid
            )
            .execute(&mut tx)
            .await?;
            affected_rows += query_result.rows_affected();
        }

        if let Some(payload) = data.other_output() {
            let query_result = sqlx::query!(
                r#"UPDATE public.records SET other_output=$1, updated_at=$2 WHERE code=$3;"#,
                payload,
                now,
                sqlx_uuid
            )
            .execute(&mut tx)
            .await?;
            affected_rows += query_result.rows_affected();
        }

        if let Some(payload) = data.symbol_fk() {
            let query_result = sqlx::query!(
                r#"UPDATE public.records SET symbol_fk=$1, updated_at=$2 WHERE code=$3;"#,
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
