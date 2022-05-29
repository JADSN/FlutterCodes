use std::fmt::Display;

use axum::{
    http::StatusCode,
    response::{IntoResponse, Response},
    Json,
};
use serde::Serialize;

#[derive(thiserror::Error, Debug)]
pub enum AppError {
    SqlxError(#[from] sqlx::Error),
    SqlxUuidError(#[from] sqlx::types::uuid::Error),
    EntityNotFound,
    // ImpossibleState(String),
    // Unknown,
}

impl Display for AppError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        let message: String = match &*self {
            AppError::SqlxError(error) => match &*error {
                error => format!("{error}").into(),
            },
            AppError::SqlxUuidError(error) => match &*error {
                error => format!("{error}").into(),
            },
            // AppError::ImpossibleState(_) => "ImpossibleState".into(),
            // AppError::Unknown => "Unknown".into(),
            AppError::EntityNotFound => "Not Found".into(),
        };
        write!(f, "{message}")
    }
}

#[derive(Debug, Serialize)]
struct ErrorMessage {
    message: String,
}

impl ErrorMessage {
    fn new(message: String) -> Self {
        Self { message }
    }
}

impl IntoResponse for AppError {
    fn into_response(self) -> Response {
        let (status, error_message) = match self {
            AppError::SqlxError(error) => (StatusCode::CONFLICT, error.to_string()),
            AppError::SqlxUuidError(error) => (StatusCode::CONFLICT, error.to_string()),
            // AppError::ImpossibleState(error) => (StatusCode::INTERNAL_SERVER_ERROR, error),
            // AppError::Unknown => (StatusCode::NOT_IMPLEMENTED, String::from("Unknown")),
            AppError::EntityNotFound => (StatusCode::NOT_FOUND, String::from("Not Found")),
        };

        let body = Json(ErrorMessage::new(error_message.to_owned()));

        (status, body).into_response()
    }
}
