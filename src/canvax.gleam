import canvax/canvas
import canvax/common.{get_dimensions}
import canvax/context.{ContextType2D, get_context}
import canvax/html.{get_element_by_id}
import canvax/primitive.{Vector2}
import gleam/option.{None}

pub fn main() {
  let assert Ok(el) = get_element_by_id("canvas")
  let assert Ok(rect) = get_dimensions(el)
  let assert Ok(ctx) = get_context(el, ContextType2D, None)

  ctx
  |> canvas.clear_rect(Vector2(0, 0), rect)
  |> canvas.fill_style("rgba(128, 0, 128, 0.5)")
  |> canvas.fill_rect(Vector2(0, 0), rect)
  |> canvas.begin_path()
  |> canvas.move_to(Vector2(75, 50))
  |> canvas.line_to(Vector2(100, 75))
  |> canvas.line_to(Vector2(100, 25))
  // |> canvas.close_path()
  |> canvas.fill(None)
}
