use async_trait::async_trait;
use sqlx::{query, FromRow, PgPool};

use crate::error::AppError;

use super::{entities::create_entity::CreateEntity, repository::SchemaRepository};

pub struct SchemaRepositoryImpl;

#[derive(Debug, FromRow)]
struct Exists {
    exists: bool,
}

#[async_trait]
impl SchemaRepository for SchemaRepositoryImpl {
    async fn read_cout_schemas(&self, pool_connection: PgPool) -> Result<usize, AppError> {
        let mut transaction = pool_connection.begin().await?;

        let payload = query!(r#"SELECT nspname FROM pg_catalog.pg_namespace;"#)
            .fetch_all(&mut transaction)
            .await?;

        let data = payload
            .into_iter()
            .filter(|record| record.nspname.starts_with(&"fc_"))
            .map(|record| record.nspname)
            .collect::<Vec<_>>();

        let result = data.len();
        Ok(result)
    }

    async fn get_all_schemas_names(
        &self,
        pool_connection: PgPool,
    ) -> Result<Vec<String>, AppError> {
        let mut transaction = pool_connection.begin().await?;

        let payload = query!(r#"SELECT nspname FROM pg_catalog.pg_namespace;"#)
            .fetch_all(&mut transaction)
            .await?;

        let data = payload
            .into_iter()
            .filter(|record| record.nspname.starts_with(&"fc_"))
            .map(|record| record.nspname)
            .collect::<Vec<_>>();

        tracing::debug!("SCHEMAS: {data:?}");
        transaction.rollback().await?;

        Ok(data)
    }

    async fn create_schema(
        &self,
        pool_connection: PgPool,
        payload: CreateEntity,
    ) -> Result<u64, AppError> {
        let mut transaction = pool_connection.begin().await?;

        let query = format!(
            r#"CREATE SCHEMA IF NOT EXISTS fc_{}_{};"#,
            payload.month(),
            payload.year()
        );

        let _ = sqlx::query(&query).execute(&mut transaction).await?;

        let query = format!(
            r#"CREATE TABLE IF NOT EXISTS fc_{}_{}.fc_info
            (
                id smallserial NOT NULL UNIQUE,
                congregation_name character varying NOT NULL,
                state_name character varying NOT NULL,      
                city_name character varying NOT NULL,
                month smallint NOT NULL,
                year smallint NOT NULL,
                PRIMARY KEY (id)
            );"#,
            payload.month(),
            payload.year()
        );

        let _ = sqlx::query(&query).execute(&mut transaction).await?;

        let query = format!(
            r#"INSERT INTO fc_{}_{}.fc_info(congregation_name, city_name, state_name, month, year)
            VALUES ('{}', '{}', '{}', {}, {});"#,
            payload.month(),
            payload.year(),
            payload.congregation_name(),
            payload.city_name(),
            payload.state_name(),
            payload.month(),
            payload.year(),
        );

        let query_result = sqlx::query(&query).execute(&mut transaction).await?;

        let mut rows_affected = 0;

        rows_affected += query_result.rows_affected();

        let query = format!(
            r#"SELECT EXISTS ( SELECT FROM information_schema. tables WHERE table_schema = 'fc_{}_{}' AND table_name = 'fc_info' ); "#,
            payload.month(),
            payload.year()
        );

        let query_result = sqlx::query_as::<_, Exists>(&query)
            .fetch_one(&mut transaction)
            .await?;

        if query_result.exists == true {
            rows_affected += 1;
        }

        let query = format!(
            r#"CREATE TABLE IF NOT EXISTS fc_{}_{}.fc_records
            (
                id smallserial NOT NULL UNIQUE,
                PRIMARY KEY (id)
            );"#,
            payload.month(),
            payload.year()
        );

        let _ = sqlx::query(&query).execute(&mut transaction).await?;

        let query = format!(
            r#"SELECT EXISTS ( SELECT FROM information_schema. tables WHERE table_schema = 'fc_{}_{}' AND table_name = 'fc_records' ); "#,
            payload.month(),
            payload.year()
        );

        let query_result = sqlx::query_as::<_, Exists>(&query)
            .fetch_one(&mut transaction)
            .await?;

        if query_result.exists == true {
            rows_affected += 1;
        }

        transaction.commit().await?;

        Ok(rows_affected)
    }
}
