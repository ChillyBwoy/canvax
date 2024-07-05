import canvax/canvas/common.{type PredefinedColorSpace}
import canvax/canvas/dot_matrix.{type DOMMatrix}
import canvax/html.{type HTMLCanvasElement}
import canvax/primitives/vector2.{type Vector2}

pub type CanvasRenderingContext2D

pub type CanvasRenderingContext2DSettings {
  CanvasRenderingContext2DSettings(
    alpha: Bool,
    color_space: PredefinedColorSpace,
    desynchronized: Bool,
    will_read_frequently: Bool,
  )
}

@external(javascript, "../../context.ffi.mjs", "getContext")
pub fn get_context(
  _: HTMLCanvasElement,
) -> Result(CanvasRenderingContext2D, Nil)

@external(javascript, "../../context.ffi.mjs", "getContext")
pub fn get_context2(
  _: HTMLCanvasElement,
  _: CanvasRenderingContext2DSettings,
) -> Result(CanvasRenderingContext2D, Nil)

pub type CanvasFillRule {
  EvenOdd
  NonZero
}

fn canvas_fill_rule(rule: CanvasFillRule) -> String {
  case rule {
    EvenOdd -> "evenodd"
    NonZero -> "nonzero"
  }
}

@external(javascript, "../../context.ffi.mjs", "save")
pub fn save(ctx: CanvasRenderingContext2D) -> CanvasRenderingContext2D

@external(javascript, "../../context.ffi.mjs", "restore")
pub fn restore(ctx: CanvasRenderingContext2D) -> CanvasRenderingContext2D

// CanvasFillStrokeStyles START
@external(javascript, "../../context.ffi.mjs", "fillStyle")
pub fn fill_style(
  ctx: CanvasRenderingContext2D,
  style: String,
) -> CanvasRenderingContext2D

@external(javascript, "../../context.ffi.mjs", "strokeStyle")
pub fn stroke_style(
  ctx: CanvasRenderingContext2D,
  style: String,
) -> CanvasRenderingContext2D

// CanvasFillStrokeStyles END

// CanvasRect START
@external(javascript, "../../context.ffi.mjs", "fillRect")
pub fn fill_rect(
  ctx: CanvasRenderingContext2D,
  pos: Vector2,
  size: Vector2,
) -> CanvasRenderingContext2D

@external(javascript, "../../context.ffi.mjs", "clearRect")
pub fn clear_rect(
  ctx: CanvasRenderingContext2D,
  pos: Vector2,
  size: Vector2,
) -> CanvasRenderingContext2D

@external(javascript, "../../context.ffi.mjs", "strokeRect")
pub fn stroke_rect(
  ctx: CanvasRenderingContext2D,
  pos: Vector2,
  size: Vector2,
) -> CanvasRenderingContext2D

// CanvasRect END

// CanvasPath START

@external(javascript, "../../context.ffi.mjs", "arc")
pub fn arc(
  ctx: CanvasRenderingContext2D,
  pos: Vector2,
  radius: Float,
  start_angle: Float,
  end_angle: Float,
) -> CanvasRenderingContext2D

@external(javascript, "../../context.ffi.mjs", "arc")
pub fn arc2(
  ctx: CanvasRenderingContext2D,
  pos: Vector2,
  radius: Float,
  start_angle: Float,
  end_angle: Float,
  counterclockwise: Bool,
) -> CanvasRenderingContext2D

@external(javascript, "../../context.ffi.mjs", "arcTo")
pub fn arc_to(
  ctx: CanvasRenderingContext2D,
  from: Vector2,
  to: Vector2,
  radius: Int,
) -> CanvasRenderingContext2D

@external(javascript, "../../context.ffi.mjs", "bezierCurveTo")
pub fn bezier_curve_to(
  ctx: CanvasRenderingContext2D,
  cp1: Vector2,
  cp2: Vector2,
  pos: Vector2,
) -> CanvasRenderingContext2D

@external(javascript, "../../context.ffi.mjs", "closePath")
pub fn close_path(ctx: CanvasRenderingContext2D) -> CanvasRenderingContext2D

@external(javascript, "../../context.ffi.mjs", "ellipse")
pub fn ellipse(
  ctx: CanvasRenderingContext2D,
  pos: Vector2,
  radius: Int,
  rotation: Float,
  start_angle: Float,
  end_angle: Float,
) -> CanvasRenderingContext2D

@external(javascript, "../../context.ffi.mjs", "ellipse")
pub fn ellipse2(
  ctx: CanvasRenderingContext2D,
  pos: Vector2,
  radius: Int,
  rotation: Float,
  start_angle: Float,
  end_angle: Float,
  counterclockwise: Bool,
) -> CanvasRenderingContext2D

@external(javascript, "../../context.ffi.mjs", "lineTo")
pub fn line_to(
  ctx: CanvasRenderingContext2D,
  coord: Vector2,
) -> CanvasRenderingContext2D

@external(javascript, "../../context.ffi.mjs", "moveTo")
pub fn move_to(
  ctx: CanvasRenderingContext2D,
  coord: Vector2,
) -> CanvasRenderingContext2D

@external(javascript, "../../context.ffi.mjs", "quadraticCurveTo")
pub fn quadratic_curve_to(
  ctx: CanvasRenderingContext2D,
  cp: Vector2,
  point: Vector2,
) -> CanvasRenderingContext2D

@external(javascript, "../../context.ffi.mjs", "rect")
pub fn rect(
  ctx: CanvasRenderingContext2D,
  pos: Vector2,
  size: Vector2,
) -> CanvasRenderingContext2D

@external(javascript, "../../context.ffi.mjs", "roundRect")
pub fn round_rect(
  ctx: CanvasRenderingContext2D,
  pos: Vector2,
  size: Vector2,
  radii: Float,
) -> CanvasRenderingContext2D

// CanvasPath END

// CanvasDrawPath START
@external(javascript, "../../context.ffi.mjs", "beginPath")
pub fn begin_path(ctx: CanvasRenderingContext2D) -> CanvasRenderingContext2D

@external(javascript, "../../context.ffi.mjs", "clip")
pub fn clip(ctx: CanvasRenderingContext2D) -> CanvasRenderingContext2D

@external(javascript, "../../context.ffi.mjs", "clip")
fn clip2_ffi(
  ctx: CanvasRenderingContext2D,
  fill_rule: String,
) -> CanvasRenderingContext2D

pub fn clip2(
  ctx: CanvasRenderingContext2D,
  fill_rule: CanvasFillRule,
) -> CanvasRenderingContext2D {
  clip2_ffi(ctx, canvas_fill_rule(fill_rule))
}

@external(javascript, "../../context.ffi.mjs", "fill")
pub fn fill(ctx: CanvasRenderingContext2D) -> CanvasRenderingContext2D

@external(javascript, "../../context.ffi.mjs", "fill")
fn fill2_ffi(
  ctx: CanvasRenderingContext2D,
  fill_rule: String,
) -> CanvasRenderingContext2D

pub fn fill2(
  ctx: CanvasRenderingContext2D,
  fill_rule: CanvasFillRule,
) -> CanvasRenderingContext2D {
  fill2_ffi(ctx, canvas_fill_rule(fill_rule))
}

@external(javascript, "../../context.ffi.mjs", "isPointInPath")
pub fn is_point_in_path(ctx: CanvasRenderingContext2D, pos: Vector2) -> Bool

@external(javascript, "../../context.ffi.mjs", "isPointInPath")
fn is_point_in_path2_ffi(
  ctx: CanvasRenderingContext2D,
  pos: Vector2,
  fill_rule: String,
) -> Bool

pub fn is_point_in_path2(
  ctx: CanvasRenderingContext2D,
  pos: Vector2,
  fill_rule: CanvasFillRule,
) {
  is_point_in_path2_ffi(ctx, pos, canvas_fill_rule(fill_rule))
}

@external(javascript, "../../context.ffi.mjs", "isPointInStroke")
pub fn is_point_in_stroke(ctx: CanvasRenderingContext2D, pos: Vector2) -> Bool

@external(javascript, "../../context.ffi.mjs", "stroke")
pub fn stroke(ctx: CanvasRenderingContext2D) -> CanvasRenderingContext2D

// CanvasDrawPath END

// [MDN Reference](https://developer.mozilla.org/docs/Web/API/CanvasRenderingContext2D/getTransform)
@external(javascript, "../../context.ffi.mjs", "getTransform")
pub fn get_transform(ctx: CanvasRenderingContext2D) -> DOMMatrix

// [MDN Reference](https://developer.mozilla.org/docs/Web/API/CanvasRenderingContext2D/resetTransform)
@external(javascript, "../../context.ffi.mjs", "resetTransform")
pub fn reset_transform(
  ctx: CanvasRenderingContext2D,
) -> CanvasRenderingContext2D

// [MDN Reference](https://developer.mozilla.org/docs/Web/API/CanvasRenderingContext2D/rotate)
@external(javascript, "../../context.ffi.mjs", "rotate")
pub fn rotate(
  ctx: CanvasRenderingContext2D,
  angle: Float,
) -> CanvasRenderingContext2D

// [MDN Reference](https://developer.mozilla.org/docs/Web/API/CanvasRenderingContext2D/scale)
@external(javascript, "../../context.ffi.mjs", "scale")
pub fn scale(
  ctx: CanvasRenderingContext2D,
  pos: Vector2,
) -> CanvasRenderingContext2D

// [MDN Reference](https://developer.mozilla.org/docs/Web/API/CanvasRenderingContext2D/setTransform)
@external(javascript, "../../context.ffi.mjs", "setTransform")
pub fn set_transform(
  ctx: CanvasRenderingContext2D,
  a: Float,
  b: Float,
  c: Float,
  d: Float,
  e: Float,
  f: Float,
) -> CanvasRenderingContext2D

// [MDN Reference](https://developer.mozilla.org/docs/Web/API/CanvasRenderingContext2D/transform)
@external(javascript, "../../context.ffi.mjs", "transform")
pub fn transform(
  ctx: CanvasRenderingContext2D,
  a: Float,
  b: Float,
  c: Float,
  d: Float,
  e: Float,
  f: Float,
) -> CanvasRenderingContext2D

// [MDN Reference](https://developer.mozilla.org/docs/Web/API/CanvasRenderingContext2D/translate)
@external(javascript, "../../context.ffi.mjs", "translate")
pub fn translate(
  ctx: CanvasRenderingContext2D,
  pos: Vector2,
) -> CanvasRenderingContext2D

// ---------- Utility Functions ----------

pub fn with_path(
  ctx: CanvasRenderingContext2D,
  callback: fn(CanvasRenderingContext2D) -> CanvasRenderingContext2D,
) {
  begin_path(ctx) |> callback() |> close_path()
}
