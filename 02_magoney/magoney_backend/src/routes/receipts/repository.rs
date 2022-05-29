use async_trait::async_trait;
use sqlx::PgPool;
use uuid::Uuid;

use crate::error::AppError;

use super::entities::{
    create_one::ReceiptCreateOne, read_all::ReceiptReadAll, read_one::ReceiptReadOne,
    update_one::ReceiptUpdateOne,
};

#[async_trait]
pub trait ReceiptRepo {
    async fn read_all(&self, pool_conn: PgPool) -> Result<Vec<ReceiptReadAll>, AppError>;

    async fn read_one_by_code(
        &self,
        pool_conn: PgPool,
        code: Uuid,
    ) -> Result<ReceiptReadOne, AppError>;

    async fn create_one(&self, pool_conn: PgPool, data: ReceiptCreateOne) -> Result<u64, AppError>;

    async fn delete_one_by_code(&self, pool_conn: PgPool, code: Uuid) -> Result<u64, AppError>;

    async fn update_one_by_code(
        &self,
        pool_conn: PgPool,
        data: ReceiptUpdateOne,
        code: Uuid,
    ) -> Result<u64, AppError>;
}
