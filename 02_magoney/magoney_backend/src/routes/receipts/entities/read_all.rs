use serde::{Deserialize, Serialize};

use chrono::{naive::serde::ts_milliseconds, NaiveDate, NaiveDateTime};

#[derive(Debug, Deserialize, Serialize)]
#[serde(rename_all(serialize = "camelCase"))]
pub struct ReceiptReadAll {
    pub code: String,
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

impl ReceiptReadAll {
    pub fn new(
        code: String,
        collection_date: NaiveDate,
        donate_world_work: i64,
        local_congregation_expenses: i64,
        receipt_type_fk: i16,
        created_at: NaiveDateTime,
        updated_at: NaiveDateTime,
    ) -> Self {
        Self {
            code,
            collection_date,
            donate_world_work,
            local_congregation_expenses,
            receipt_type_fk,
            created_at,
            updated_at,
        }
    }
}
