pub type DateTime

@external(javascript, "../datetime.ffi.mjs", "now")
pub fn now() -> DateTime

@external(javascript, "../datetime.ffi.mjs", "toISOString")
pub fn to_iso_string(date: DateTime) -> String
