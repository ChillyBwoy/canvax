import canvax/common
import canvax/context as ctx
import canvax/html
import canvax/primitives.{type Vector2, Vector2}
import gleam/float
import gleam_community/maths/elementary as math

type State {
  State(
    pos: Vector2(Float),
    delta: Vector2(Float),
    rect: Vector2(Float),
    ball_radius: Float,
  )
}

fn draw_ball(
  inst: ctx.CanvasRenderingContext2D,
  pos: Vector2(Float),
  radius: Float,
) {
  ctx.with_path(inst, fn(c) {
    ctx.arc(c, pos, radius, 0.0, math.pi() *. 2.0)
    |> ctx.fill_style("#ffaff3")
    |> ctx.fill()
    |> ctx.stroke_style("#000")
    |> ctx.stroke()
  })
}

fn next_pos(state: State) -> State {
  let dx = case
    state.pos.x +. state.delta.x >. state.rect.x -. state.ball_radius
    || state.pos.x +. state.delta.x <. state.ball_radius
  {
    True -> state.delta.x *. -1.0
    False -> state.delta.x
  }

  let dy = case
    state.pos.y +. state.delta.y >. state.rect.y -. state.ball_radius
    || state.pos.y +. state.delta.y <. state.ball_radius
  {
    True -> state.delta.y *. -1.0
    False -> state.delta.y
  }

  State(
    ..state,
    delta: Vector2(dx, dy),
    pos: Vector2(state.pos.x +. dx, state.pos.y +. dy),
  )
}

pub fn main() {
  let assert Ok(el) = html.get_element_by_id("canvas")
  let assert Ok(rect) = common.get_dimensions(el)
  let assert Ok(inst) = ctx.get_context(el)

  let speed = 5.0
  let ball_radius = 10.0

  html.raf(
    State(
      pos: Vector2(rect.x *. float.random(), rect.y *. float.random()),
      delta: Vector2(speed *. float.random(), speed *. float.random()),
      rect: rect,
      ball_radius: ball_radius *. float.random() +. 2.0,
    ),
    fn(state, _frame) {
      let assert Ok(rect) = common.get_dimensions(el)

      inst
      |> ctx.clear_rect(Vector2(0.0, 0.0), rect)
      |> ctx.fill_style("#fffbe8")
      |> ctx.fill_rect(Vector2(0.0, 0.0), rect)
      |> draw_ball(state.pos, state.ball_radius)

      next_pos(state)
    },
  )
}
