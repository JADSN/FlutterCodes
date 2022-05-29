use std::sync::Arc;

use super::repository::ReceiptRepo;

pub type DynRepo = Arc<dyn ReceiptRepo + Send + Sync>;
