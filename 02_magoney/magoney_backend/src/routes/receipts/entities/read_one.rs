use chrono::NaiveDate;
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize)]
#[serde(rename_all(serialize = "camelCase"))]
pub struct ReceiptReadOne {
    code: String,
    collection_date: NaiveDate,
    donate_world_work: i64,
    local_congregation_expenses: i64,
}

impl ReceiptReadOne {
    pub fn new(
        code: String,
        collection_date: NaiveDate,
        donate_world_work: i64,
        local_congregation_expenses: i64,
    ) -> Self {
        Self {
            code,
            collection_date,
            donate_world_work,
            local_congregation_expenses,
        }
    }
}
