use axum::{extract::Path, Extension, Json};
use serde::{Deserialize, Serialize};
use uuid::Uuid;

use crate::{error::AppError, routes::fc_route::types::DynamicRepository};

#[derive(Debug, Deserialize, Serialize)]
pub struct Temp {}

pub async fn handle(
    Path(identifer): Path<Uuid>,
    Extension(repository): Extension<DynamicRepository>,
) -> Result<Json<u64>, AppError> {
    // let user = schema_repository.find(user_id).await?;

    Ok(Json(42))
}
