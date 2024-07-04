import canvax/canvas/common.{type DOMMatrix2DInit}
import canvax/canvas/context.{type CanvasRenderingContext2D}
import canvax/canvas/dot_matrix.{type DOMMatrix}
import canvax/primitives/vector2.{type Vector2}

// [MDN Reference](https://developer.mozilla.org/docs/Web/API/CanvasRenderingContext2D/getTransform)
pub fn get_transform(ctx: CanvasRenderingContext2D) -> DOMMatrix {
  todo
}

// [MDN Reference](https://developer.mozilla.org/docs/Web/API/CanvasRenderingContext2D/resetTransform)
pub fn reset_transform(ctx: CanvasRenderingContext2D) -> Nil {
  todo
}

// [MDN Reference](https://developer.mozilla.org/docs/Web/API/CanvasRenderingContext2D/rotate)
pub fn rotate(ctx: CanvasRenderingContext2D, angle: Float) -> Nil {
  todo
}

// [MDN Reference](https://developer.mozilla.org/docs/Web/API/CanvasRenderingContext2D/scale)
pub fn scale(pos: Vector2) -> Nil {
  todo
}

// [MDN Reference](https://developer.mozilla.org/docs/Web/API/CanvasRenderingContext2D/setTransform)

pub fn set_transform(
  a: Float,
  b: Float,
  c: Float,
  d: Float,
  e: Float,
  f: Float,
) -> Nil {
  todo
}

pub fn set_transform2(transform: DOMMatrix2DInit) -> Nil {
  todo
}

// [MDN Reference](https://developer.mozilla.org/docs/Web/API/CanvasRenderingContext2D/transform)
pub fn transform(
  a: Float,
  b: Float,
  c: Float,
  d: Float,
  e: Float,
  f: Float,
) -> Nil {
  todo
}

// [MDN Reference](https://developer.mozilla.org/docs/Web/API/CanvasRenderingContext2D/translate)
pub fn translate(pos: Vector2) -> Nil {
  todo
}
