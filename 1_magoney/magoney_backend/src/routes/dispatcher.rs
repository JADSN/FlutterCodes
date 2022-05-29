use axum::Router;

pub fn dispatch() -> Router {
    Router::new().merge(super::fc_route::dispatcher::dispatch())
}
