mod error;
mod routes;

use std::net::SocketAddr;

use anyhow::Context;
use axum::{extract::Extension, http::Request, Router};
use sqlx::postgres::PgPoolOptions;
use tower::ServiceBuilder;
use tower_http::{cors::CorsLayer, trace::TraceLayer};
use tracing::Span;
use tracing_subscriber::{layer::SubscriberExt, util::SubscriberInitExt};

#[tokio::main]
async fn main() -> anyhow::Result<()> {
    tracing_subscriber::registry()
        .with(tracing_subscriber::EnvFilter::new(
            std::env::var("RUST_LOG").unwrap_or_else(|_| "magoney_backend=debug".into()),
        ))
        .with(
            tracing_subscriber::fmt::layer()
                .with_line_number(true)
                .with_file(true),
        )
        .init();

    let database_pool_connection = PgPoolOptions::new()
        .max_connections(1)
        .connect("postgres://postgres:admin@localhost/magoneyDatabase")
        .await
        .context("Could not connect to database_url")?;

    let app = Router::new()
        .nest("/api", routes::dispatcher::dispatch())
        .layer(
            ServiceBuilder::new()
                .layer(CorsLayer::very_permissive())
                .layer(Extension(database_pool_connection)),
        )
        // .layer(TraceLayer::new_for_http());
        .layer(
            TraceLayer::new_for_http().on_request(|request: &Request<_>, _span: &Span| {
                let method_name = request.method().as_str();
                let uri = request.uri().to_string();

                tracing::debug!("{method_name}: {uri}");
                // ...
            }), // .on_response(|_response: &Response, _latency: Duration, _span: &Span| {
                //     // ...
                // })
                // .on_body_chunk(|_chunk: &Bytes, _latency: Duration, _span: &Span| {
                //     // ..
                // })
                // .on_eos(
                //     |_trailers: Option<&HeaderMap>, _stream_duration: Duration, _span: &Span| {
                //         // ...
                //     },
                // )
                // .on_failure(
                //     |_error: ServerErrorsFailureClass, _latency: Duration, _span: &Span| {
                //         // ...
                //     },
                // ),
        );

    // Run our application
    let addr = SocketAddr::from(([0, 0, 0, 0], 3000));
    tracing::debug!("Listening on http://{}", addr);
    axum::Server::bind(&addr)
        .serve(app.into_make_service())
        .await
        .context("Unable to start server")?;

    Ok(())
}
