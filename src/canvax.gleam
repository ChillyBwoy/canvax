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

  // let speed = 5.0
  // let ball_radius = 10.0
  // let initial_model = #(ball1.0, ball2.0, ball3.0, ball4.0)
  // let renderers = #(ball1.1, ball2.1, ball3.1, ball4.1)

  html.raf(#(render_context), fn(model, _frame) {
    ctx
    |> canvas.clear_rect(Vector2(0.0, 0.0), rect)
    |> canvas.fill_style("#fffbe8")
    |> canvas.fill_rect(Vector2(0.0, 0.0), rect)

    model
  })
  // html.raf(
  //   State(
  //     pos: Vector2(rect.x *. float.random(), rect.y *. float.random()),
  //     delta: Vector2(speed *. float.random(), speed *. float.random()),
  //     rect: rect,
  //     ball_radius: ball_radius *. float.random() +. 2.0,
  //   ),
  //   fn(state, _frame) {
  //     let assert Ok(rect) = common.get_dimensions(el)

  //     inst
  //     |> ctx.clear_rect(Vector2(0.0, 0.0), rect)
  //     |> ctx.fill_style("#fffbe8")
  //     |> ctx.fill_rect(Vector2(0.0, 0.0), rect)
  //     |> draw_ball(state.pos, state.ball_radius)

  //     next_state(state)
  //   },
  // )
}
