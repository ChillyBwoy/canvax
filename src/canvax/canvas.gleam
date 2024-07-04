import canvax/html.{type HTMLCanvasElement}
import canvax/primitives/vector2.{type Vector2}

pub type Path2D

pub type PredefinedColorSpace {
  DisplayP3
  SRGB
}

pub type CanvasRenderingContext2DSettings {
  CanvasRenderingContext2DSettings(
    alpha: Bool,
    color_space: PredefinedColorSpace,
    desynchronized: Bool,
    will_read_frequently: Bool,
  )
}

pub type CanvasRenderingContext2D

@external(javascript, "../context.ffi.mjs", "getContext")
pub fn get_context(
  _: HTMLCanvasElement,
) -> Result(CanvasRenderingContext2D, Nil)

@external(javascript, "../context.ffi.mjs", "getContext")
pub fn get_context2(
  _: HTMLCanvasElement,
  _: CanvasRenderingContext2DSettings,
) -> Result(CanvasRenderingContext2D, Nil)

pub fn predefined_color_space(model: PredefinedColorSpace) -> String {
  case model {
    DisplayP3 -> "display-p3"
    SRGB -> "srgb"
  }
}

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

// CanvasFillStrokeStyles START
@external(javascript, "../context.ffi.mjs", "fillStyle")
pub fn fill_style(
  ctx: CanvasRenderingContext2D,
  style: String,
) -> CanvasRenderingContext2D

@external(javascript, "../context.ffi.mjs", "strokeStyle")
pub fn stroke_style(
  ctx: CanvasRenderingContext2D,
  style: String,
) -> CanvasRenderingContext2D

// CanvasFillStrokeStyles END

// CanvasRect START
@external(javascript, "../context.ffi.mjs", "fillRect")
pub fn fill_rect(
  ctx: CanvasRenderingContext2D,
  pos: Vector2,
  size: Vector2,
) -> CanvasRenderingContext2D

@external(javascript, "../context.ffi.mjs", "clearRect")
pub fn clear_rect(
  ctx: CanvasRenderingContext2D,
  pos: Vector2,
  size: Vector2,
) -> CanvasRenderingContext2D

@external(javascript, "../context.ffi.mjs", "strokeRect")
pub fn stroke_rect(
  ctx: CanvasRenderingContext2D,
  pos: Vector2,
  size: Vector2,
) -> CanvasRenderingContext2D

// CanvasRect END

// CanvasPath START

@external(javascript, "../context.ffi.mjs", "arc")
pub fn arc(
  ctx: CanvasRenderingContext2D,
  pos: Vector2,
  radius: Float,
  start_angle: Float,
  end_angle: Float,
) -> CanvasRenderingContext2D

@external(javascript, "../context.ffi.mjs", "arc")
pub fn arc2(
  ctx: CanvasRenderingContext2D,
  pos: Vector2,
  radius: Float,
  start_angle: Float,
  end_angle: Float,
  counterclockwise: Bool,
) -> CanvasRenderingContext2D

@external(javascript, "../context.ffi.mjs", "arcTo")
pub fn arc_to(
  ctx: CanvasRenderingContext2D,
  from: Vector2,
  to: Vector2,
  radius: Int,
) -> CanvasRenderingContext2D

@external(javascript, "../context.ffi.mjs", "bezierCurveTo")
pub fn bezier_curve_to(
  ctx: CanvasRenderingContext2D,
  cp1: Vector2,
  cp2: Vector2,
  pos: Vector2,
) -> CanvasRenderingContext2D

@external(javascript, "../context.ffi.mjs", "closePath")
pub fn close_path(ctx: CanvasRenderingContext2D) -> CanvasRenderingContext2D

@external(javascript, "../context.ffi.mjs", "ellipse")
pub fn ellipse(
  ctx: CanvasRenderingContext2D,
  pos: Vector2,
  radius: Int,
  rotation: Float,
  start_angle: Float,
  end_angle: Float,
) -> CanvasRenderingContext2D

@external(javascript, "../context.ffi.mjs", "ellipse")
pub fn ellipse2(
  ctx: CanvasRenderingContext2D,
  pos: Vector2,
  radius: Int,
  rotation: Float,
  start_angle: Float,
  end_angle: Float,
  counterclockwise: Bool,
) -> CanvasRenderingContext2D

@external(javascript, "../context.ffi.mjs", "lineTo")
pub fn line_to(
  ctx: CanvasRenderingContext2D,
  coord: Vector2,
) -> CanvasRenderingContext2D

@external(javascript, "../context.ffi.mjs", "moveTo")
pub fn move_to(
  ctx: CanvasRenderingContext2D,
  coord: Vector2,
) -> CanvasRenderingContext2D

@external(javascript, "../context.ffi.mjs", "quadraticCurveTo")
pub fn quadratic_curve_to(
  ctx: CanvasRenderingContext2D,
  cp: Vector2,
  point: Vector2,
) -> CanvasRenderingContext2D

@external(javascript, "../context.ffi.mjs", "rect")
pub fn rect(
  ctx: CanvasRenderingContext2D,
  pos: Vector2,
  size: Vector2,
) -> CanvasRenderingContext2D

pub fn round_rect(
  _ctx: CanvasRenderingContext2D,
  _pos: Vector2,
  _size: Vector2,
  _radii: Float,
) -> CanvasRenderingContext2D {
  todo
}

// CanvasPath END

// CanvasDrawPath START
@external(javascript, "../context.ffi.mjs", "beginPath")
pub fn begin_path(ctx: CanvasRenderingContext2D) -> CanvasRenderingContext2D

@external(javascript, "../context.ffi.mjs", "clip")
pub fn clip(ctx: CanvasRenderingContext2D) -> CanvasRenderingContext2D

@external(javascript, "../context.ffi.mjs", "clip")
fn clip2_ffi(
  ctx: CanvasRenderingContext2D,
  fill_rule: String,
) -> CanvasRenderingContext2D

pub fn clip2(
  ctx: CanvasRenderingContext2D,
  fill_rule: CanvasFillRule,
) -> CanvasRenderingContext2D {
  // clip(fillRule?: CanvasFillRule): void;
  clip2_ffi(ctx, canvas_fill_rule(fill_rule))
}

pub fn clip3(
  _ctx: CanvasRenderingContext2D,
  _path: Path2D,
  _fill_rule: CanvasFillRule,
) -> CanvasRenderingContext2D {
  // clip(path: Path2D, fillRule?: CanvasFillRule): void;
  todo
}

@external(javascript, "../context.ffi.mjs", "fill")
pub fn fill(ctx: CanvasRenderingContext2D) -> CanvasRenderingContext2D

@external(javascript, "../context.ffi.mjs", "fill")
fn fill2_ffi(
  ctx: CanvasRenderingContext2D,
  fill_rule: String,
) -> CanvasRenderingContext2D

pub fn fill2(
  ctx: CanvasRenderingContext2D,
  fill_rule: CanvasFillRule,
) -> CanvasRenderingContext2D {
  // fill(fillRule?: CanvasFillRule): void;
  fill2_ffi(ctx, canvas_fill_rule(fill_rule))
}

pub fn fill3(
  _ctx: CanvasRenderingContext2D,
  _path: Path2D,
) -> CanvasRenderingContext2D {
  // fill(path: Path2D, fillRule?: CanvasFillRule): void;
  todo
}

pub fn fill4(
  _ctx: CanvasRenderingContext2D,
  _path: Path2D,
  _rule: CanvasFillRule,
) -> CanvasRenderingContext2D {
  // fill(path: Path2D, fillRule?: CanvasFillRule): void;
  todo
}

@external(javascript, "../context.ffi.mjs", "isPointInPath")
pub fn is_point_in_path(ctx: CanvasRenderingContext2D, pos: Vector2) -> Bool

@external(javascript, "../context.ffi.mjs", "isPointInPath")
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

pub fn is_point_in_path3(
  _ctx: CanvasRenderingContext2D,
  _path: Path2D,
  _pos: Vector2,
) -> Bool {
  todo
}

pub fn is_point_in_path4(
  _ctx: CanvasRenderingContext2D,
  _path: Path2D,
  _pos: Vector2,
  _fill_rule: CanvasFillRule,
) -> Bool {
  todo
}

pub fn is_point_in_stroke(_ctx: CanvasRenderingContext2D, _pos: Vector2) -> Bool {
  todo
}

pub fn is_point_in_stroke2(
  _ctx: CanvasRenderingContext2D,
  _path: Path2D,
  _pos: Vector2,
) -> Bool {
  todo
}

@external(javascript, "../context.ffi.mjs", "stroke")
pub fn stroke(ctx: CanvasRenderingContext2D) -> CanvasRenderingContext2D

pub fn stroke2(
  _ctx: CanvasRenderingContext2D,
  _path: Path2D,
) -> CanvasRenderingContext2D {
  todo
}

// CanvasDrawPath END

// ---------- Utility Functions ----------

pub fn with_path(
  ctx: CanvasRenderingContext2D,
  callback: fn(CanvasRenderingContext2D) -> CanvasRenderingContext2D,
) {
  begin_path(ctx) |> callback() |> close_path()
}
