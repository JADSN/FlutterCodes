use std::fmt::Display;

use axum::{
    http::StatusCode,
    response::{IntoResponse, Response},
    Json,
};
use serde::Serialize;

#[derive(Debug, thiserror::Error)]
pub enum AppError {
    SqlxError(#[from] sqlx::Error),
}

impl Display for AppError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            AppError::SqlxError(error) => write!(f, "{}", error),
        }
    }
}

#[derive(Debug, Serialize)]
struct ErrorMessage {
    message: String,
}

impl IntoResponse for AppError {
    fn into_response(self) -> Response {
        let (status, error_message) = match self {
            AppError::SqlxError(error) => (StatusCode::CONFLICT, format!("{error}")),
        };

        let body = Json(ErrorMessage {
            message: error_message,
        });

        (status, body).into_response()
    }
}
