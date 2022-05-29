use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize)]
pub struct CreateEntity {
    congregation_name: String,
    city_name: String,
    state_name: String,
    month: i8,
    year: i16,
}

impl CreateEntity {
    pub fn congregation_name(&self) -> &str {
        self.congregation_name.as_ref()
    }

    pub fn city_name(&self) -> &str {
        self.city_name.as_ref()
    }

    pub fn state_name(&self) -> &str {
        self.state_name.as_ref()
    }

    pub fn month(&self) -> i8 {
        self.month
    }

    pub fn year(&self) -> i16 {
        self.year
    }
}
