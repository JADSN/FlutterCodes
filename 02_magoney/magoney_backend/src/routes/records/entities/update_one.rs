use chrono::NaiveDate;
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize)]
pub struct RecordUpdateOne {
    record_date: Option<NaiveDate>,
    description: Option<String>,
    donate_input: Option<i64>,
    donate_output: Option<i64>,
    bank_account_input: Option<i64>,
    bank_account_output: Option<i64>,
    other_input: Option<i64>,
    other_output: Option<i64>,
    #[serde(rename(deserialize = "symbol"))]
    symbol_fk: Option<i16>,
}

impl RecordUpdateOne {
    /// Get the record update one's record data.
    #[must_use]
    pub fn record_date(&self) -> Option<NaiveDate> {
        self.record_date
    }

    /// Get a reference to the record update one's description.
    #[must_use]
    pub fn description(&self) -> Option<&String> {
        self.description.as_ref()
    }

    /// Get the record create one's donate input.
    #[must_use]
    pub fn donate_input(&self) -> Option<i64> {
        self.donate_input
    }

    /// Get the record create one's donate output.
    #[must_use]
    pub fn donate_output(&self) -> Option<i64> {
        self.donate_output
    }

    /// Get the record create one's bank account input.
    #[must_use]
    pub fn bank_account_input(&self) -> Option<i64> {
        self.bank_account_input
    }

    /// Get the record create one's bank account output.
    #[must_use]
    pub fn bank_account_output(&self) -> Option<i64> {
        self.bank_account_output
    }

    /// Get the record create one's other input.
    #[must_use]
    pub fn other_input(&self) -> Option<i64> {
        self.other_input
    }

    /// Get the record create one's other output.
    #[must_use]
    pub fn other_output(&self) -> Option<i64> {
        self.other_output
    }

    /// Get the record create one's symbol fk.
    #[must_use]
    pub fn symbol_fk(&self) -> Option<i16> {
        self.symbol_fk
    }
}
