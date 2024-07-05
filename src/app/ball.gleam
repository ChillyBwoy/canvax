import app/render_context.{type RenderContext}
import canvax/canvas/context.{type CanvasRenderingContext2D}
import canvax/primitives/vector2 as v2
import canvax/primitives/vector2.{type Vector2, Vector2}
import canvax/scene.{create_node}
import gleam/float
import gleam_community/maths/elementary as math

pub opaque type Model {
  Model(
    pos: Vector2,
    direction: Vector2,
    radius: Float,
    velocity: Float,
    color: String,
  )
}

pub opaque type Msg {
  Move
  BounceX
  BounceY
}

pub fn init(
  _: RenderContext,
  position pos: Vector2,
  direction dir: Vector2,
  radius r: Float,
  velocity v: Float,
  color c: String,
) {
  Model(pos: pos, direction: dir, radius: r, velocity: v, color: c)
  |> create_node(on_frame: frame, on_update: update, on_render: render)
}

fn frame(model: Model, render_context: RenderContext) -> Msg {
  let width = render_context.viewport.x
  let height = render_context.viewport.y
  let x = model.pos.x
  let y = model.pos.y
  let dx = model.direction.x *. model.velocity
  let dy = model.direction.y *. model.velocity

  let bounce_right = x +. dx >=. width -. model.radius
  let bounce_left = x +. dx <=. model.radius
  let bounce_top = y +. dy >=. height -. model.radius
  let bounce_bottom = y +. dy <=. model.radius

  case bounce_right, bounce_left, bounce_top, bounce_bottom {
    True, False, False, False -> BounceX
    False, True, False, False -> BounceX
    False, False, True, False -> BounceY
    False, False, False, True -> BounceY
    _, _, _, _ -> Move
  }
}

fn update(msg: Msg, model: Model, _: RenderContext) -> Model {
  case msg {
    Move -> {
      let next_velocity = case model.velocity -. 0.01 {
        x if x <. 0.1 -> 0.1
        _ -> model.velocity -. 0.01
      }

      Model(
        ..model,
        pos: v2.mul(model.direction, model.velocity) |> v2.add(model.pos),
        velocity: next_velocity,
      )
    }
    BounceX -> {
      Model(
        ..model,
        direction: Vector2(float.negate(model.direction.x), model.direction.y),
      )
    }
    BounceY -> {
      Model(
        ..model,
        direction: Vector2(model.direction.x, float.negate(model.direction.y)),
      )
    }
  }
}

fn render(ctx: CanvasRenderingContext2D, model: Model, _: RenderContext) {
  context.with_path(ctx, fn(c) {
    c
    |> context.arc(model.pos, model.radius, 0.0, math.pi() *. 2.0)
    |> context.fill_style(model.color)
    |> context.fill()
    |> context.stroke_style("#000")
    |> context.stroke()
  })
  Nil
}
