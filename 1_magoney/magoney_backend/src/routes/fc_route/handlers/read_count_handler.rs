use axum::{
    http::{HeaderMap, HeaderValue},
    Extension,
};
use sqlx::PgPool;

use crate::{error::AppError, routes::fc_route::types::DynamicRepository};

pub async fn handle(
    Extension(repository): Extension<DynamicRepository>,
    Extension(pool_connection): Extension<PgPool>,
) -> Result<HeaderMap, AppError> {
    let payload_from_database = repository.read_cout_schemas(pool_connection).await?;

    let mut header = HeaderMap::new();

    header.append("X-Count", HeaderValue::from(payload_from_database));
    Ok(header)
}
