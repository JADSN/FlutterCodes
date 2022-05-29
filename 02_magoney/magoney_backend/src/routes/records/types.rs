use std::sync::Arc;

use super::repository::RecordRepo;

pub type DynRepo = Arc<dyn RecordRepo + Send + Sync>;
