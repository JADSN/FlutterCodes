use axum::{Extension, Json};
use serde::{Deserialize, Serialize};
use sqlx::PgPool;

use crate::{
    error::AppError,
    routes::fc_route::{entities::create_entity::CreateEntity, types::DynamicRepository},
};

pub async fn handle(
    Json(payload): Json<CreateEntity>,
    Extension(repository): Extension<DynamicRepository>,
    Extension(pool_connection): Extension<PgPool>,
) -> Result<Json<u64>, AppError> {
    let payload_from_database = repository.create_schema(pool_connection, payload).await?;

    Ok(Json(payload_from_database))
}
