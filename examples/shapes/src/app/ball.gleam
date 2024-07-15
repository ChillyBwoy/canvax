import app/render_context.{type RenderContext}
import canvax/canvas/context.{type CanvasRenderingContext2D}
import canvax/effect.{type Effect}
import canvax/primitives/vector2 as v2
import canvax/primitives/vector2.{type Vector2, Vector2}
import canvax/scene.{create_node}
import gleam/float
import gleam_community/maths/elementary as math

pub opaque type Model {
  Model(
    position: Vector2,
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
  position position: Vector2,
  direction direction: Vector2,
  radius radius: Float,
  velocity velocity: Float,
  color color: String,
) {
  use _ <- create_node(frame, update, render)
  #(
    Model(
      position: position,
      direction: direction,
      radius: radius,
      velocity: velocity,
      color: color,
    ),
    effect.none(),
  )
}

fn frame(model: Model, render_context: RenderContext) -> #(Msg, Effect(Msg)) {
  let width = render_context.viewport.x
  let height = render_context.viewport.y

  let dx = model.direction.x *. model.velocity
  let dy = model.direction.y *. model.velocity

  case
    model.position.x +. dx >=. width -. model.radius,
    model.position.x +. dx <=. model.radius,
    model.position.y +. dy >=. height -. model.radius,
    model.position.y +. dy <=. model.radius
  {
    True, False, False, False -> #(BounceX, effect.none())
    False, True, False, False -> #(BounceX, effect.none())
    False, False, True, False -> #(BounceY, effect.none())
    False, False, False, True -> #(BounceY, effect.none())
    _, _, _, _ -> #(Move, effect.none())
  }
}

fn update(msg: Msg, model: Model, _: RenderContext) -> Model {
  case msg {
    Move -> {
      let next_velocity = case model.velocity -. 0.005 {
        x if x <. 0.1 -> 0.1
        _ -> model.velocity -. 0.005
      }

      Model(
        ..model,
        position: v2.mul(model.direction, model.velocity)
          |> v2.add(model.position),
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
    |> context.arc(model.position, model.radius, 0.0, math.pi() *. 2.0)
    |> context.fill_style(model.color)
    |> context.fill()
    |> context.stroke_style("#000")
    |> context.stroke()
  })
  Nil
}
