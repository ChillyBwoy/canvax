import app/ball
import app/render_context.{RenderContext}
import app/square
import canvax/canvas/context
import canvax/common
import canvax/html
import canvax/primitives/vector2.{Vector2}
import gleam/list

pub fn main() {
  let assert Ok(el) = html.get_element_by_id("canvas")
  let assert Ok(rect) = common.get_dimensions(el)
  let assert Ok(ctx) = context.get_context(el)
  let render_context = RenderContext(viewport_size: rect)

  let scene = [
    square.init(render_context, 50.0, "#880000"),
    square.init(render_context, 25.0, "#008800"),
    square.init(render_context, 40.0, "#880088"),
    ball.init(render_context, 10.0, 5.0),
    ball.init(render_context, 12.0, 3.0),
    ball.init(render_context, 15.0, 8.0),
    ball.init(render_context, 8.0, 10.0),
    ball.init(render_context, 10.0, 5.0),
    ball.init(render_context, 12.0, 3.0),
    ball.init(render_context, 15.0, 8.0),
    ball.init(render_context, 8.0, 10.0),
    ball.init(render_context, 10.0, 5.0),
    ball.init(render_context, 12.0, 3.0),
    ball.init(render_context, 15.0, 8.0),
    ball.init(render_context, 8.0, 10.0),
  ]

  html.raf(fn(_frame) {
    ctx
    |> context.clear_rect(Vector2(0.0, 0.0), rect)
    |> context.fill_style("#fffbe8")
    |> context.fill_rect(Vector2(0.0, 0.0), rect)

    list.each(scene, fn(ball) { ball(ctx, render_context) })

    Nil
  })
}
