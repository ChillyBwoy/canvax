import canvax/html.{type HTMLCanvasElement}
import canvax/primitive.{type Vector2}
import gleam/option.{type Option, None, Some}

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
  _: Option(CanvasRenderingContext2DSettings),
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
  counterclockwise: Option(Bool),
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
  counterclockwise: Option(Bool),
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

@external(javascript, "../context.ffi.mjs", "rect")
pub fn rect(
  ctx: CanvasRenderingContext2D,
  pos: Vector2,
  size: Vector2,
) -> CanvasRenderingContext2D

// CanvasPath END

// CanvasDrawPath START
@external(javascript, "../context.ffi.mjs", "beginPath")
pub fn begin_path(ctx: CanvasRenderingContext2D) -> CanvasRenderingContext2D

// clip(fillRule?: CanvasFillRule): void;
// clip(path: Path2D, fillRule?: CanvasFillRule): void;

@external(javascript, "../context.ffi.mjs", "fill")
fn fill_ffi(
  ctx: CanvasRenderingContext2D,
  rule: Option(String),
) -> CanvasRenderingContext2D

pub fn fill(
  ctx: CanvasRenderingContext2D,
  rule: Option(CanvasFillRule),
) -> CanvasRenderingContext2D {
  case rule {
    Some(rule) -> fill_ffi(ctx, Some(canvas_fill_rule(rule)))
    None -> fill_ffi(ctx, None)
  }
}

// fill(fillRule?: CanvasFillRule): void;
// fill(path: Path2D, fillRule?: CanvasFillRule): void;

// isPointInPath(x: number, y: number, fillRule?: CanvasFillRule): boolean;
// isPointInPath(path: Path2D, x: number, y: number, fillRule?: CanvasFillRule): boolean;

// isPointInStroke(x: number, y: number): boolean;
// isPointInStroke(path: Path2D, x: number, y: number): boolean;

@external(javascript, "../context.ffi.mjs", "stroke")
pub fn stroke(ctx: CanvasRenderingContext2D) -> CanvasRenderingContext2D

// stroke(path: Path2D): void;
// CanvasDrawPath END

pub fn with_path(
  ctx: CanvasRenderingContext2D,
  callback: fn(CanvasRenderingContext2D) -> CanvasRenderingContext2D,
) {
  begin_path(ctx) |> callback() |> close_path()
}
