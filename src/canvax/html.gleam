pub type HTMLCanvasElement

@external(javascript, "../document.ffi.mjs", "getElementById")
pub fn get_element_by_id(_id: String) -> Result(HTMLCanvasElement, Nil)

@external(javascript, "../document.ffi.mjs", "raf")
pub fn raf(callback: fn(Int) -> Nil) -> Nil
