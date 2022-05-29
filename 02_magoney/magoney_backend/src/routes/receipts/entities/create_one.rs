use chrono::NaiveDate;
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize)]
pub struct ReceiptCreateOne {
    collection_date: NaiveDate,
    donate_world_work: i64,
    local_congregation_expenses: i64,
    receipt_type: i16,
}

impl ReceiptCreateOne {
    /// Get the receipt create one's collection date.
    #[must_use]
    pub fn collection_date(&self) -> NaiveDate {
        self.collection_date
    }

    /// Get the receipt create one's donate world work.
    #[must_use]
    pub fn donate_world_work(&self) -> i64 {
        self.donate_world_work
    }

    /// Get the receipt create one's local congregation expenses.
    #[must_use]
    pub fn local_congregation_expenses(&self) -> i64 {
        self.local_congregation_expenses
    }

    /// Get the receipt create one's receipt type.
    #[must_use]
    pub fn receipt_type(&self) -> i16 {
        self.receipt_type
    }
}
