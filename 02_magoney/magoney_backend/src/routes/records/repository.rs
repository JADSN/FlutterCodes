use async_trait::async_trait;
use sqlx::PgPool;
use uuid::Uuid;

use crate::error::AppError;

use super::entities::{
    create_one::RecordCreateOne, read_all::RecordReadAll, update_one::RecordUpdateOne,
};

#[async_trait]
pub trait RecordRepo {
    async fn read_all(&self, pool_conn: PgPool) -> Result<Vec<RecordReadAll>, AppError>;

    // async fn read_one_by_code(
    //     &self,
    //     pool_conn: PgPool,
    //     code: Uuid,
    // ) -> Result<ReceiptReadOne, AppError>;

    async fn create_one(&self, pool_conn: PgPool, data: RecordCreateOne) -> Result<u64, AppError>;

    async fn delete_one_by_code(&self, pool_conn: PgPool, code: Uuid) -> Result<u64, AppError>;

    async fn update_one_by_code(
        &self,
        pool_conn: PgPool,
        data: RecordUpdateOne,
        code: Uuid,
    ) -> Result<u64, AppError>;
}
