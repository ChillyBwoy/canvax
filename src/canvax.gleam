import app/ball
import app/context.{RenderContext}
import canvax/canvas
import canvax/common
import canvax/html
import canvax/primitives/vector2.{Vector2}

// import gleam/float
// import gleam/iterator
// import gleam/list
// import gleam_community/maths/elementary as math

pub fn main() {
  let assert Ok(el) = html.get_element_by_id("canvas")
  let assert Ok(rect) = common.get_dimensions(el)
  let assert Ok(ctx) = canvas.get_context(el)
  let render_context = RenderContext(viewport_size: rect)

  let _b1 = ball.init(render_context, 10.0, 5.0)
  let _b2 = ball.init(render_context, 12.0, 3.0)
  let _b3 = ball.init(render_context, 8.0, 8.0)
  let _b4 = ball.init(render_context, 5.0, 10.0)

  html.raf(render_context, fn(model, _frame) {
    ctx
    |> canvas.clear_rect(Vector2(0.0, 0.0), rect)
    |> canvas.fill_style("#fffbe8")
    |> canvas.fill_rect(Vector2(0.0, 0.0), rect)

    model
  })
}
