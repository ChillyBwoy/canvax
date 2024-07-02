import canvax/common.{get_dimensions}
import canvax/context as ctx
import canvax/html.{get_element_by_id, raf}
import canvax/primitive.{type Vector2, Vector2}
import gleam/float
import gleam/option.{None}
import gleam_community/maths/elementary as math

type State {
  State(pos: Vector2, delta: Vector2, rect: Vector2, ball_radius: Float)
}

fn draw_ball(inst: ctx.CanvasRenderingContext2D, pos: Vector2, radius: Float) {
  ctx.with_path(inst, fn(c) {
    ctx.arc(c, pos, radius, 0.0, math.pi() *. 2.0, None)
    |> ctx.fill_style("#f00")
    |> ctx.fill(None)
  })
}

fn next_pos(state: State) -> State {
  let dx = case
    state.pos.x + state.delta.x > state.rect.x - float.round(state.ball_radius)
    || state.pos.x + state.delta.x < float.round(state.ball_radius)
  {
    True -> state.delta.x * -1
    False -> state.delta.x
  }

  let dy = case
    state.pos.y + state.delta.y > state.rect.y - float.round(state.ball_radius)
    || state.pos.y + state.delta.y < float.round(state.ball_radius)
  {
    True -> state.delta.y * -1
    False -> state.delta.y
  }

  State(
    ..state,
    delta: Vector2(dx, dy),
    pos: Vector2(state.pos.x + dx, state.pos.y + dy),
  )
}

pub fn main() {
  let assert Ok(el) = get_element_by_id("canvas")
  let assert Ok(rect) = get_dimensions(el)
  let assert Ok(inst) = ctx.get_context(el, None)

  raf(
    State(
      pos: Vector2(rect.x / 5, rect.y / 3),
      delta: Vector2(5, 5),
      rect: rect,
      ball_radius: 15.0,
    ),
    fn(state, _frame) {
      ctx.clear_rect(inst, Vector2(0, 0), rect)
      |> ctx.fill_style("rgba(128, 128, 128, 0.5)")
      |> ctx.fill_rect(Vector2(0, 0), rect)
      |> ctx.fill_style("rgb(255, 255, 255)")
      |> draw_ball(state.pos, state.ball_radius)

      next_pos(state)
    },
  )
}
