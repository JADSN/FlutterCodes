use async_trait::async_trait;
use sqlx::PgPool;

use crate::error::AppError;

use super::entities::create_entity::CreateEntity;

#[async_trait]
pub trait SchemaRepository {
    async fn read_cout_schemas(&self, pool_connection: PgPool) -> Result<usize, AppError>;
    async fn get_all_schemas_names(&self, pool_connection: PgPool)
        -> Result<Vec<String>, AppError>;
    async fn create_schema(
        &self,
        pool_connection: PgPool,
        payload: CreateEntity,
    ) -> Result<u64, AppError>;
}
