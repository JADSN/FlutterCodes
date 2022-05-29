use anyhow::Context;
use axum::{Extension, Router};
use chrono::{naive::serde::ts_milliseconds, NaiveDate, NaiveDateTime};
use serde::{Deserialize, Serialize};
use sqlx::postgres::PgPoolOptions;
use std::net::SocketAddr;

use tower::ServiceBuilder;
use tower_http::cors::CorsLayer;
use tower_http::trace::TraceLayer;
use tracing_subscriber::{layer::SubscriberExt, util::SubscriberInitExt};
use utoipa::Component;

mod error;
mod routes;

#[derive(Component, Debug, Deserialize, Serialize)]
#[serde(rename_all(serialize = "camelCase"))]
struct ReceiptReadAll {
    code: String,
    collection_date: NaiveDate,
    donate_world_work: i64,
    local_congregation_expenses: i64,
    #[serde(rename(serialize = "receiptType"))]
    receipt_type_fk: i16,
    #[serde(with = "ts_milliseconds")]
    created_at: NaiveDateTime,
    #[serde(with = "ts_milliseconds")]
    updated_at: NaiveDateTime,
}

#[derive(Component, Debug, Deserialize, Serialize)]
// #[derive(Debug, Deserialize, Serialize)]
#[serde(rename_all(serialize = "camelCase"))]
struct ReceiptReadOne {
    code: String,
    collection_date: NaiveDate,
    donate_world_work: i64,
    local_congregation_expenses: i64,
}

#[derive(Component, Debug, Deserialize, Serialize)]
struct ReceiptCreateOne {
    collection_date: NaiveDate,
    donate_world_work: i64,
    local_congregation_expenses: i64,
    receipt_type: i16,
}

#[derive(Component, Debug, Deserialize, Serialize)]
struct ReceiptUpdateOne {
    collection_date: Option<NaiveDate>,
    donate_world_work: Option<i64>,
    local_congregation_expenses: Option<i64>,
    receipt_type: Option<i16>,
}

#[tokio::main]
async fn main() -> anyhow::Result<()> {
    // * OpeanApi Settings
    // struct CustomServer;
    // impl Modify for CustomServer {
    //     fn modify(&self, openapi: &mut utoipa::openapi::OpenApi) {
    //         // utoipa::openapi::Info::new("my application", "0.1.0");
    //         // utoipa::openapi::Paths::new();
    //         openapi.servers = Some(vec![ServerBuilder::new()
    //             .url("http://0.0.0.0:{port}")
    //             .description(Some("Server settings"))
    //             .parameter(
    //                 "port",
    //                 ServerVariableBuilder::new()
    //                     .enum_values(Some(vec!["3000"]))
    //                     .default_value("3000")
    //                     .description(Some("Server port")),
    //             )
    //             .build()]);
    //     }
    // }
    // #[derive(OpenApi)]
    // #[openapi(
    //     handlers(
    //         receipt_read_all
    //     ),
    //     components(ReceiptReadAll),
    //     modifiers(&CustomServer),
    //     tags()
    // )]
    // struct ApiDoc;

    let database_url = "postgres://postgres:admin@localhost/magoneyDatabase";

    let postgres_database = PgPoolOptions::new()
        .max_connections(1)
        .connect(database_url)
        .await
        .context("Could not connect to database_url")?;

    tracing_subscriber::registry()
        .with(tracing_subscriber::EnvFilter::new(
            std::env::var("RUST_LOG")
                .unwrap_or_else(|_| "magoney_backend=debug,tower_http=debug".into()),
        ))
        .with(
            tracing_subscriber::fmt::layer()
                .with_file(true)
                .with_line_number(true)
                .with_level(true),
        )
        .init();

    // let receipt_repository_impl = Arc::new(ReceiptRepoImpl) as DynUserRepo;

    let app = Router::new()
        .nest("/api", crate::routes::dispatcher::dispatch())
        // .route("/receipts", get(receipt_read_all).post(receipt_create_one))
        // .route(
        //     "/receipts/:id",
        //     get(receipt_one_by_code)
        //         .delete(receipt_delete_one_by_code)
        //         .put(update_one_by_code),
        // )
        .layer(
            ServiceBuilder::new()
                // TODO: Remove very permissive and be more specific
                .layer(CorsLayer::very_permissive())
                .layer(Extension(postgres_database)), // .layer(Extension(receipt_repository_impl)),
        )
        .layer(TraceLayer::new_for_http());

    // let open_api_json = ApiDoc::openapi().to_yaml().map_err(|error| {
    //     tracing::error!("[ERROR: {error:?}]");
    //     error
    // })?;
    // let mut file = File::create("openapi.yaml").await.map_err(|error| {
    //     tracing::error!("[ERROR: {error:?}]");
    //     error
    // })?;
    // file.write_all(open_api_json.as_bytes())
    //     .await
    //     .map_err(|error| {
    //         tracing::error!("[ERROR: {error:?}]");
    //         error
    //     })?;

    let addr = SocketAddr::from(([0, 0, 0, 0], 4000));
    tracing::debug!("Listening on {}", addr);
    axum::Server::bind(&addr)
        .serve(app.into_make_service())
        .await
        .map_err(|error| {
            tracing::error!("[ERROR: {error:?}]");
            error
        })?;

    Ok(())
}

// struct ReceiptRepoImpl;

// #[async_trait]
// impl ReceiptRepo for ReceiptRepoImpl {
//     async fn read_all(&self, pool_conn: PgPool) -> Result<Vec<ReceiptReadAll>, ReceiptRepoError> {
//         let mut tx = pool_conn
//             .begin()
//             .await
//             .map_err(|error| ReceiptRepoError::Custom(error.to_string()))?;

//         let payload = sqlx::query!(r#"SELECT id, code, collection_date, donate_world_work, local_congregation_expenses, receipt_type_fk, created_at, updated_at FROM receipts ORDER BY id DESC;"#)
//             .fetch_all(&mut tx)
//             .await
//             .map_err(|error| ReceiptRepoError::Custom(error.to_string()))?;

//         let transformed_payload = payload
//             .into_iter()
//             .map(|record| ReceiptReadAll {
//                 code: record.code.to_string(),
//                 collection_date: record.collection_date,
//                 donate_world_work: record.donate_world_work,
//                 receipt_type_fk: record.receipt_type_fk,
//                 local_congregation_expenses: record.local_congregation_expenses,
//                 created_at: record.created_at,
//                 updated_at: record.updated_at,
//             })
//             .collect::<Vec<_>>();

//         tx.commit()
//             .await
//             .map_err(|error| ReceiptRepoError::Custom(error.to_string()))?;

//         Ok(transformed_payload)
//     }

//     async fn read_one_by_code(
//         &self,
//         pool_conn: PgPool,
//         code: Uuid,
//     ) -> Result<ReceiptReadOne, ReceiptRepoError> {
//         let mut tx = pool_conn
//             .begin()
//             .await
//             .map_err(|error| ReceiptRepoError::Custom(error.to_string()))?;

//         let uuid = code.to_string();
//         let uuid_str = uuid.as_str();
//         let sqlx_uuid = sqlx::types::Uuid::parse_str(uuid_str)
//             .map_err(|error| ReceiptRepoError::Custom(error.to_string()))?;

//         if let Some(record) = sqlx::query!(r#"SELECT code, collection_date, donate_world_work, local_congregation_expenses FROM receipts WHERE code=$1;"#, sqlx_uuid)
//         .fetch_optional(&mut tx)
//         .await
//         .map_err(|error| ReceiptRepoError::Custom(error.to_string()))? {

//         tx.commit()
//         .await
//         .map_err(|error| ReceiptRepoError::Custom(error.to_string()))?;

//         return Ok(   ReceiptReadOne {
//                 code: record.code.to_string(),
//                 collection_date: record.collection_date,
//                 donate_world_work: record.donate_world_work,
//                 local_congregation_expenses: record.local_congregation_expenses,
//             })
//         }

//         return Err(ReceiptRepoError::Custom("NOT FOUND".to_string()));
//     }

//     async fn create_one(
//         &self,
//         pool_conn: PgPool,
//         data: ReceiptCreateOne,
//     ) -> Result<u64, ReceiptRepoError> {
//         let ReceiptCreateOne {
//             collection_date,
//             donate_world_work,
//             local_congregation_expenses,
//             receipt_type,
//         } = data;

//         let now = Utc::now().naive_utc();

//         let uuid = Uuid::new_v4().to_string();
//         let uuid_str = uuid.as_str();
//         let sqlx_uuid = sqlx::types::Uuid::parse_str(uuid_str)
//             .map_err(|error| ReceiptRepoError::Custom(error.to_string()))?;

//         let mut tx = pool_conn
//             .begin()
//             .await
//             .map_err(|error| ReceiptRepoError::Custom(error.to_string()))?;

//         let query_result = sqlx::query!(
//                 r#"INSERT INTO public.receipts(code, collection_date, donate_world_work, local_congregation_expenses, receipt_type_fk, created_at, updated_at)
//                     VALUES ($1, $2, $3, $4, $5, $6, $7);"#, sqlx_uuid, collection_date, donate_world_work, local_congregation_expenses, receipt_type, now, now
//             )
//             .execute(&mut tx)
//             .await
//             .map_err(|error| ReceiptRepoError::Custom(error.to_string()))?;

//         let affected_rows = query_result.rows_affected();

//         tx.commit()
//             .await
//             .map_err(|error| ReceiptRepoError::Custom(error.to_string()))?;

//         Ok(affected_rows)
//     }

//     async fn delete_one_by_code(
//         &self,
//         pool_conn: PgPool,
//         code: Uuid,
//     ) -> Result<u64, ReceiptRepoError> {
//         let code_string = code.to_string();
//         let code_str = code_string.as_str();

//         let sqlx_uuid = sqlx::types::Uuid::parse_str(code_str)
//             .map_err(|error| ReceiptRepoError::Custom(error.to_string()))?;

//         let mut tx = pool_conn
//             .begin()
//             .await
//             .map_err(|error| ReceiptRepoError::Custom(error.to_string()))?;

//         let query_result = sqlx::query!(r#"DELETE FROM public.receipts WHERE code=$1;"#, sqlx_uuid)
//             .execute(&mut tx)
//             .await
//             .map_err(|error| ReceiptRepoError::Custom(error.to_string()))?;

//         let affected_rows = query_result.rows_affected();

//         tx.commit()
//             .await
//             .map_err(|error| ReceiptRepoError::Custom(error.to_string()))?;

//         Ok(affected_rows)
//     }

//     async fn update_one_by_code(
//         &self,
//         pool_conn: PgPool,
//         data: ReceiptUpdateOne,
//         code: Uuid,
//     ) -> Result<u64, ReceiptRepoError> {
//         let ReceiptUpdateOne {
//             collection_date,
//             donate_world_work,
//             local_congregation_expenses,
//             receipt_type,
//         } = data;

//         let code_string = code.to_string();
//         let code_str = code_string.as_str();

//         let sqlx_uuid = sqlx::types::Uuid::parse_str(code_str)
//             .map_err(|error| ReceiptRepoError::Custom(error.to_string()))?;

//         let mut tx = pool_conn
//             .begin()
//             .await
//             .map_err(|error| ReceiptRepoError::Custom(error.to_string()))?;

//         let mut affected_rows = 0;
//         let now = Utc::now().naive_utc();

//         if let Some(payload) = collection_date {
//             let query_result = sqlx::query!(
//                 r#"UPDATE public.receipts SET collection_date=$1, updated_at=$2 WHERE code=$3;"#,
//                 payload,
//                 now,
//                 sqlx_uuid
//             )
//             .execute(&mut tx)
//             .await
//             .map_err(|error| ReceiptRepoError::Custom(error.to_string()))?;
//             affected_rows += query_result.rows_affected();
//         }

//         if let Some(payload) = donate_world_work {
//             let query_result = sqlx::query!(
//                 r#"UPDATE public.receipts SET donate_world_work=$1, updated_at=$2 WHERE code=$3;"#,
//                 payload,
//                 now,
//                 sqlx_uuid
//             )
//             .execute(&mut tx)
//             .await
//             .map_err(|error| ReceiptRepoError::Custom(error.to_string()))?;
//             affected_rows += query_result.rows_affected();
//         }

//         if let Some(payload) = local_congregation_expenses {
//             let query_result = sqlx::query!(
//                 r#"UPDATE public.receipts SET local_congregation_expenses=$1, updated_at=$2 WHERE code=$3;"#,
//                 payload,now,
//                 sqlx_uuid
//             )
//             .execute(&mut tx)
//             .await
//             .map_err(|error| ReceiptRepoError::Custom(error.to_string()))?;
//             affected_rows += query_result.rows_affected();
//         }

//         if let Some(payload) = receipt_type {
//             let query_result = sqlx::query!(
//                 r#"UPDATE public.receipts SET receipt_type_fk=$1, updated_at=$2 WHERE code=$3;"#,
//                 payload,
//                 now,
//                 sqlx_uuid
//             )
//             .execute(&mut tx)
//             .await
//             .map_err(|error| ReceiptRepoError::Custom(error.to_string()))?;
//             affected_rows += query_result.rows_affected();
//         }

//         tx.commit()
//             .await
//             .map_err(|error| ReceiptRepoError::Custom(error.to_string()))?;

//         Ok(affected_rows)
//     }
// }

// type DynUserRepo = Arc<dyn ReceiptRepo + Send + Sync>;

// #[async_trait]
// trait ReceiptRepo {
//     async fn read_all(&self, pool_conn: PgPool) -> Result<Vec<ReceiptReadAll>, ReceiptRepoError>;
//     async fn read_one_by_code(
//         &self,
//         pool_conn: PgPool,
//         code: Uuid,
//     ) -> Result<ReceiptReadOne, ReceiptRepoError>;

//     async fn create_one(
//         &self,
//         pool_conn: PgPool,
//         data: ReceiptCreateOne,
//     ) -> Result<u64, ReceiptRepoError>;

//     async fn delete_one_by_code(
//         &self,
//         pool_conn: PgPool,
//         code: Uuid,
//     ) -> Result<u64, ReceiptRepoError>;

//     async fn update_one_by_code(
//         &self,
//         pool_conn: PgPool,
//         data: ReceiptUpdateOne,
//         code: Uuid,
//     ) -> Result<u64, ReceiptRepoError>;
// }

// #[utoipa::path(
//     get,
//     tag = "",
//     path = "/receipts",
//     responses(
//         (status = 200, content_type = "application/json", description = "Success response", body = [ReceiptReadAll])
//     )
// )]
// async fn receipt_read_all(
//     Extension(pool_conn): Extension<PgPool>,
//     Extension(repo): Extension<DynUserRepo>,
// ) -> Result<Json<Vec<ReceiptReadAll>>, AppError> {
//     match repo.read_all(pool_conn).await {
//         Ok(payload) => Ok(Json(payload)),
//         Err(error) => {
//             tracing::error!("[ERROR]: {error:?}");
//             Ok(Json(vec![]))
//         }
//     }
// }

// #[utoipa::path(
//     get,
//     tag = "",
//     path = "/receipts",
//     responses(
//         (status = 200, content_type = "application/json", description = "Success response", body = [ReceiptReadAll])
//     )
// )]
// async fn receipt_one_by_code(
//     Path(code): Path<Uuid>,

//     Extension(pool_conn): Extension<PgPool>,
//     Extension(repo): Extension<DynUserRepo>,
// ) -> Result<Json<ReceiptReadOne>, AppError> {
//     match repo.read_one_by_code(pool_conn, code).await {
//         Ok(payload) => Ok(Json(payload)),
//         Err(error) => {
//             tracing::error!("[ERROR]: {error:?}");
//             Err(AppError::from(error))
//         }
//     }
// }

// #[utoipa::path(
//     post,
//     tag = "",
//     path = "/receipts",
//     request_body = ReceiptCreateOne,
//     responses(
//         (status = 200, content_type = "application/json", description = "Success response", body = [u64])
//     )
// )]
// async fn receipt_create_one(
//     Json(body): Json<ReceiptCreateOne>,
//     Extension(pool_conn): Extension<PgPool>,
//     Extension(repo): Extension<DynUserRepo>,
// ) -> Result<Json<u64>, AppError> {
//     match repo.create_one(pool_conn, body).await {
//         Ok(payload) => Ok(Json(payload)),
//         Err(error) => {
//             tracing::error!("[ERROR]: {error:?}");
//             Ok(Json(0))
//         }
//     }
// }

// #[utoipa::path(
//     delete,
//     tag = "",
//     path = "/receipts",
//     responses(
//         (status = 200, content_type = "application/json", description = "Success response", body = [u64])
//     )
// )]
// async fn receipt_delete_one_by_code(
//     Path(code): Path<Uuid>,
//     Extension(pool_conn): Extension<PgPool>,
//     Extension(repo): Extension<DynUserRepo>,
// ) -> Result<Json<u64>, AppError> {
//     match repo.delete_one_by_code(pool_conn, code).await {
//         Ok(payload) => Ok(Json(payload)),
//         Err(error) => {
//             tracing::error!("[ERROR]: {error:?}");
//             Ok(Json(0))
//         }
//     }
// }

// #[utoipa::path(
//     put,
//     tag = "",
//     path = "/receipts",
//     request_body = ReceiptUpdateOne,
//     responses(
//         (status = 200, content_type = "application/json", description = "Success response", body = [u64])
//     )
// )]
// async fn update_one_by_code(
//     Path(code): Path<Uuid>,
//     Json(body): Json<ReceiptUpdateOne>,
//     Extension(pool_conn): Extension<PgPool>,
//     Extension(repo): Extension<DynUserRepo>,
// ) -> Result<Json<u64>, AppError> {
//     match repo.update_one_by_code(pool_conn, body, code).await {
//         Ok(payload) => Ok(Json(payload)),
//         Err(error) => {
//             tracing::error!("[ERROR]: {error:?}");
//             Ok(Json(0))
//         }
//     }
// }
