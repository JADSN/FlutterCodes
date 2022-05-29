use axum::{extract::Path, Extension, Json};
use sqlx::PgPool;
use uuid::Uuid;

use crate::error::AppError;

use super::{
    entities::{create_one::RecordCreateOne, read_all::RecordReadAll, update_one::RecordUpdateOne},
    types::DynRepo,
};

pub async fn handler_read_all(
    Extension(pool_conn): Extension<PgPool>,
    Extension(repository): Extension<DynRepo>,
) -> Result<Json<Vec<RecordReadAll>>, AppError> {
    match repository.read_all(pool_conn).await {
        Ok(payload) => Ok(Json(payload)),
        Err(error) => {
            tracing::error!("[ERROR]: {error}");
            Ok(Json(vec![]))
        }
    }
}

pub async fn handler_create_one(
    Json(body): Json<RecordCreateOne>,
    Extension(pool_conn): Extension<PgPool>,
    Extension(repository): Extension<DynRepo>,
) -> Result<Json<u64>, AppError> {
    match repository.create_one(pool_conn, body).await {
        Ok(payload) => Ok(Json(payload)),
        Err(error) => {
            tracing::error!("[ERROR]: {error:?}");
            Ok(Json(0))
        }
    }
}

// pub async fn handler_read_one(
//     Path(code): Path<Uuid>,
//     Extension(pool_conn): Extension<PgPool>,
//     Extension(repository): Extension<DynRepo>,
// ) -> Result<Json<ReceiptReadOne>, AppError> {
//     match repository.read_one_by_code(pool_conn, code).await {
//         Ok(payload) => Ok(Json(payload)),
//         Err(error) => {
//             tracing::error!("[ERROR]: {error:?}");
//             Err(AppError::EntityNotFound)
//         }
//     }
// }

pub async fn handler_delete_one_by_code(
    Path(code): Path<Uuid>,
    Extension(pool_conn): Extension<PgPool>,
    Extension(repository): Extension<DynRepo>,
) -> Result<Json<u64>, AppError> {
    match repository.delete_one_by_code(pool_conn, code).await {
        Ok(payload) => Ok(Json(payload)),
        Err(error) => {
            tracing::error!("[ERROR]: {error:?}");
            Ok(Json(0))
        }
    }
}

pub async fn handler_update_one_by_code(
    Path(code): Path<Uuid>,
    Json(body): Json<RecordUpdateOne>,
    Extension(pool_conn): Extension<PgPool>,
    Extension(repository): Extension<DynRepo>,
) -> Result<Json<u64>, AppError> {
    match repository.update_one_by_code(pool_conn, body, code).await {
        Ok(payload) => Ok(Json(payload)),
        Err(error) => {
            tracing::error!("[ERROR]: {error:?}");
            Ok(Json(0))
        }
    }
}
