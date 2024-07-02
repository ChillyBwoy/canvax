import canvax/html.{type HTMLCanvasElement}
import canvax/primitive.{type Vector2}

@external(javascript, "../common.ffi.mjs", "getDimensions")
pub fn get_dimensions(_canvas_el: HTMLCanvasElement) -> Result(Vector2, Nil) {
  Error(Nil)
}
