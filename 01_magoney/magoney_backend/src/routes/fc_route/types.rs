use std::sync::Arc;

use super::repository::SchemaRepository;

pub type DynamicRepository = Arc<dyn SchemaRepository + Send + Sync>;
