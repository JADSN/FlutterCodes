use std::sync::Arc;

use axum::{
    routing::{delete, head},
    Extension, Router,
};

use super::{database::SchemaRepositoryImpl, types::DynamicRepository};

pub fn dispatch() -> Router {
    let schema_repository = Arc::new(SchemaRepositoryImpl) as DynamicRepository;

    Router::new()
        .route(
            "/fc",
            head(super::handlers::read_count_handler::handle)
                .get(super::handlers::read_all_handler::handle)
                .post(super::handlers::create_one_handler::handle),
        )
        .route(
            "/fc/:code",
            delete(super::handlers::delete_one_by_code_handler::handle)
                .put(super::handlers::update_one_by_code_handler::handle),
        )
        .layer(Extension(schema_repository))
}
