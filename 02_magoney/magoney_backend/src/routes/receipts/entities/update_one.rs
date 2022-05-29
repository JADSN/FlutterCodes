use chrono::NaiveDate;
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize)]
pub struct ReceiptUpdateOne {
    collection_date: Option<NaiveDate>,
    donate_world_work: Option<i64>,
    local_congregation_expenses: Option<i64>,
    receipt_type: Option<i16>,
}

impl ReceiptUpdateOne {
    /// Get the receipt update one's collection date.
    #[must_use]
    pub fn collection_date(&self) -> Option<NaiveDate> {
        self.collection_date
    }

    /// Get the receipt update one's donate world work.
    #[must_use]
    pub fn donate_world_work(&self) -> Option<i64> {
        self.donate_world_work
    }

    /// Get the receipt update one's local congregation expenses.
    #[must_use]
    pub fn local_congregation_expenses(&self) -> Option<i64> {
        self.local_congregation_expenses
    }

    /// Get the receipt update one's receipt type.
    #[must_use]
    pub fn receipt_type(&self) -> Option<i16> {
        self.receipt_type
    }
}
