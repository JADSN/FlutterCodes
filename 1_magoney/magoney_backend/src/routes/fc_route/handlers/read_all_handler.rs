use axum::{Extension, Json};
use sqlx::PgPool;

use crate::{error::AppError, routes::fc_route::types::DynamicRepository};

pub async fn handle(
    Extension(repository): Extension<DynamicRepository>,
    Extension(pool_connection): Extension<PgPool>,
) -> Result<Json<Vec<String>>, AppError> {
    let payload_from_database = repository.get_all_schemas_names(pool_connection).await?;

    Ok(Json(payload_from_database))
}
