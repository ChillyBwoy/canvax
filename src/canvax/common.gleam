import canvax/html.{type HTMLCanvasElement}
import canvax/primitives.{type Vector2}

@external(javascript, "../common.ffi.mjs", "getDimensions")
pub fn get_dimensions(
  _canvas_el: HTMLCanvasElement,
) -> Result(Vector2(Float), Nil) {
  Error(Nil)
}
