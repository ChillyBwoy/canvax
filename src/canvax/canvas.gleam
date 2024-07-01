import canvax/html.{type HTMLCanvasElement}
import canvax/primitive.{type Vector2}
import gleam/option.{type Option}

pub type PredefinedColorSpace {
  DisplayP3
  SRGB
}

pub fn predefined_color_space(model: PredefinedColorSpace) -> String {
  case model {
    DisplayP3 -> "display-p3"
    SRGB -> "srgb"
  }
}

pub type CanvasRenderingContext2DSettings {
  CanvasRenderingContext2DSettings(
    alpha: Bool,
    color_space: PredefinedColorSpace,
    desynchronized: Bool,
    will_read_frequently: Bool,
  )
}

pub type CanvasRenderingContext {
  CanvasRenderingContext2D
  ImageBitmapRenderingContext
  WebGLRenderingContext
  WebGL2RenderingContext
}

pub type ContextType {
  ContextType2D
  ContextTypeVitmapRenderer
  ContextTypeWebGL
  ContextTypeWebGL2
}

fn canvas_context_type(context: ContextType) {
  case context {
    ContextType2D -> "2d"
    ContextTypeVitmapRenderer -> "bitmaprenderer"
    ContextTypeWebGL -> "webgl"
    ContextTypeWebGL2 -> "webgl2"
  }
}

@external(javascript, "../canvas.ffi.mjs", "getContext")
fn get_context_ffi(
  _canvas_el: HTMLCanvasElement,
  _context_id: String,
  _settings: Option(CanvasRenderingContext2DSettings),
) -> Result(CanvasRenderingContext, Nil) {
  Error(Nil)
}

pub fn get_context(
  canvas_el: HTMLCanvasElement,
  context_id: ContextType,
  settings: Option(CanvasRenderingContext2DSettings),
) {
  let ctx_type = canvas_context_type(context_id)
  get_context_ffi(canvas_el, ctx_type, settings)
}

@external(javascript, "../canvas.ffi.mjs", "getDimensions")
pub fn dimensions(_canvas_el: HTMLCanvasElement) -> Result(#(Int, Int), Nil) {
  Error(Nil)
}

@external(javascript, "../canvas.ffi.mjs", "fillRect")
pub fn fill_rect(
  ctx: CanvasRenderingContext,
  pos: Vector2,
  size: Vector2,
  style: String,
) -> CanvasRenderingContext
