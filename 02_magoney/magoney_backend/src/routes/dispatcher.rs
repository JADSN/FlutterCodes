use axum::Router;

pub fn dispatch() -> Router {
    Router::new()
        .merge(super::receipts::router::mount_routes())
        .merge(super::records::router::mount_routes())
}
