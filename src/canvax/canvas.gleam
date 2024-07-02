import canvax/context.{type CanvasRenderingContext}
import canvax/primitive.{type Vector2}
import gleam/option.{type Option, None, Some}

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
@external(javascript, "../canvas.ffi.mjs", "fillStyle")
pub fn fill_style(
  ctx: CanvasRenderingContext,
  style: String,
) -> CanvasRenderingContext

@external(javascript, "../canvas.ffi.mjs", "strokeStyle")
pub fn stroke_style(
  ctx: CanvasRenderingContext,
  style: String,
) -> CanvasRenderingContext

// CanvasFillStrokeStyles END

// CanvasRect START
@external(javascript, "../canvas.ffi.mjs", "fillRect")
pub fn fill_rect(
  ctx: CanvasRenderingContext,
  pos: Vector2,
  size: Vector2,
) -> CanvasRenderingContext

@external(javascript, "../canvas.ffi.mjs", "clearRect")
pub fn clear_rect(
  ctx: CanvasRenderingContext,
  pos: Vector2,
  size: Vector2,
) -> CanvasRenderingContext

@external(javascript, "../canvas.ffi.mjs", "strokeRect")
pub fn stroke_rect(
  ctx: CanvasRenderingContext,
  pos: Vector2,
  size: Vector2,
) -> CanvasRenderingContext

// CanvasRect END

// CanvasPath START

@external(javascript, "../canvas.ffi.mjs", "arc")
pub fn arc(
  ctx: CanvasRenderingContext,
  pos: Vector2,
  radius: Float,
  start_angle: Float,
  end_angle: Float,
  counterclockwise: Option(Bool),
) -> CanvasRenderingContext

@external(javascript, "../canvas.ffi.mjs", "arcTo")
pub fn arc_to(
  ctx: CanvasRenderingContext,
  from: Vector2,
  to: Vector2,
  radius: Int,
) -> CanvasRenderingContext

@external(javascript, "../canvas.ffi.mjs", "bezierCurveTo")
pub fn bezier_curve_to(
  ctx: CanvasRenderingContext,
  cp1: Vector2,
  cp2: Vector2,
  pos: Vector2,
) -> CanvasRenderingContext

@external(javascript, "../canvas.ffi.mjs", "closePath")
pub fn close_path(ctx: CanvasRenderingContext) -> CanvasRenderingContext

@external(javascript, "../canvas.ffi.mjs", "ellipse")
pub fn ellipse(
  ctx: CanvasRenderingContext,
  pos: Vector2,
  radius: Int,
  rotation: Float,
  start_angle: Float,
  end_angle: Float,
  counterclockwise: Option(Bool),
) -> CanvasRenderingContext

@external(javascript, "../canvas.ffi.mjs", "lineTo")
pub fn line_to(
  ctx: CanvasRenderingContext,
  coord: Vector2,
) -> CanvasRenderingContext

@external(javascript, "../canvas.ffi.mjs", "moveTo")
pub fn move_to(
  ctx: CanvasRenderingContext,
  coord: Vector2,
) -> CanvasRenderingContext

@external(javascript, "../canvas.ffi.mjs", "rect")
pub fn rect(
  ctx: CanvasRenderingContext,
  pos: Vector2,
  size: Vector2,
) -> CanvasRenderingContext

// CanvasPath END

// CanvasDrawPath START
@external(javascript, "../canvas.ffi.mjs", "beginPath")
pub fn begin_path(ctx: CanvasRenderingContext) -> CanvasRenderingContext

// clip(fillRule?: CanvasFillRule): void;
// clip(path: Path2D, fillRule?: CanvasFillRule): void;

@external(javascript, "../canvas.ffi.mjs", "fill")
fn fill_ffi(
  ctx: CanvasRenderingContext,
  rule: Option(String),
) -> CanvasRenderingContext

pub fn fill(
  ctx: CanvasRenderingContext,
  rule: Option(CanvasFillRule),
) -> CanvasRenderingContext {
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

@external(javascript, "../canvas.ffi.mjs", "stroke")
pub fn stroke(ctx: CanvasRenderingContext) -> CanvasRenderingContext
// stroke(path: Path2D): void;
// CanvasDrawPath END
