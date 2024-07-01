import canvax/canvas.{ContextType2D, fill_rect, get_context}
import canvax/html.{get_element_by_id}
import canvax/primitive.{Vector2}
import gleam/option.{None}

pub fn main() {
  let assert Ok(el) = get_element_by_id("canvas")
  let assert Ok(ctx) = get_context(el, ContextType2D, None)

  ctx |> fill_rect(Vector2(50, 50), Vector2(100, 100), "rgba(128, 0, 0, 0.5)")
}
