use chrono::NaiveDate;
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize)]
pub struct RecordCreateOne {
    record_date: NaiveDate,
    description: String,
    donate_input: i64,
    donate_output: i64,
    bank_account_input: i64,
    bank_account_output: i64,
    other_input: i64,
    other_output: i64,
    #[serde(rename(deserialize = "symbol"))]
    symbol_fk: i16,
}

impl RecordCreateOne {
    /// Get the record create one's record date.
    #[must_use]
    pub fn record_date(&self) -> NaiveDate {
        self.record_date
    }

    /// Get a reference to the record create one's description.
    #[must_use]
    pub fn description(&self) -> &str {
        self.description.as_ref()
    }

    /// Get the record create one's donate input.
    #[must_use]
    pub fn donate_input(&self) -> i64 {
        self.donate_input
    }

    /// Get the record create one's donate output.
    #[must_use]
    pub fn donate_output(&self) -> i64 {
        self.donate_output
    }

    /// Get the record create one's bank account input.
    #[must_use]
    pub fn bank_account_input(&self) -> i64 {
        self.bank_account_input
    }

    /// Get the record create one's bank account output.
    #[must_use]
    pub fn bank_account_output(&self) -> i64 {
        self.bank_account_output
    }

    /// Get the record create one's other input.
    #[must_use]
    pub fn other_input(&self) -> i64 {
        self.other_input
    }

    /// Get the record create one's other output.
    #[must_use]
    pub fn other_output(&self) -> i64 {
        self.other_output
    }

    /// Get the record create one's symbol fk.
    #[must_use]
    pub fn symbol_fk(&self) -> i16 {
        self.symbol_fk
    }
}
