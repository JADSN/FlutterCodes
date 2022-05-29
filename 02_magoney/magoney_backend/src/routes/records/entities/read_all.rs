use serde::{Deserialize, Serialize};

use chrono::{naive::serde::ts_milliseconds, NaiveDate, NaiveDateTime};

#[derive(Debug, Deserialize, Serialize)]
#[serde(rename_all(serialize = "camelCase"))]
pub struct RecordReadAll {
    code: String,
    record_date: NaiveDate,
    description: String,
    donate_input: i64,
    donate_output: i64,
    bank_account_input: i64,
    bank_account_output: i64,
    other_input: i64,
    other_output: i64,
    #[serde(rename(serialize = "symbol"))]
    symbol_fk: i16,
    #[serde(with = "ts_milliseconds")]
    created_at: NaiveDateTime,
    #[serde(with = "ts_milliseconds")]
    updated_at: NaiveDateTime,
}

impl RecordReadAll {
    pub fn new(
        code: String,
        record_date: NaiveDate,
        description: String,
        donate_input: i64,
        donate_output: i64,
        bank_account_input: i64,
        bank_account_output: i64,
        other_input: i64,
        other_output: i64,
        symbol_fk: i16,
        created_at: NaiveDateTime,
        updated_at: NaiveDateTime,
    ) -> Self {
        Self {
            code,
            record_date,
            description,
            donate_input,
            donate_output,
            bank_account_input,
            bank_account_output,
            other_input,
            other_output,
            symbol_fk,
            created_at,
            updated_at,
        }
    }
}
