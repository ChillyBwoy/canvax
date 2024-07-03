import app/context.{type RenderContext}
import canvax/canvas.{type CanvasRenderingContext2D}
import canvax/effect.{type Effect}
import canvax/primitives/vector2.{type Vector2, Vector2}

import gleam/float
import gleam_community/maths/elementary as math

pub opaque type Model {
  Model(pos: Vector2, delta: Vector2, radius: Float, speed: Float)
}

pub opaque type Msg {
  Move
  BounceX
  BounceY
}

pub fn init(
  render_context: RenderContext,
  radius: Float,
  speed: Float,
) -> #(Model, Effect(Msg)) {
  let model =
    Model(
      pos: Vector2(
        render_context.viewport_size.x *. float.random(),
        render_context.viewport_size.y *. float.random(),
      ),
      delta: Vector2(speed *. float.random(), speed *. float.random()),
      radius: radius,
      speed: speed,
    )
  #(model, effect.none())
}

pub fn update(
  _render_context: RenderContext,
  model: Model,
  _frame: Int,
  msg: Msg,
) -> #(Model, Effect(Msg)) {
  case msg {
    Move -> #(
      Model(..model, pos: vector2.add(model.pos, model.delta)),
      effect.none(),
    )
    BounceX -> #(
      Model(..model, delta: Vector2(model.delta.x *. -1.0, model.delta.y)),
      effect.none(),
    )
    BounceY -> #(
      Model(..model, delta: Vector2(model.delta.x, model.delta.y *. -1.0)),
      effect.none(),
    )
  }
}

pub fn frame(render_context: RenderContext, model: Model, _frame: Int) -> Msg {
  let width = render_context.viewport_size.x
  let height = render_context.viewport_size.y
  let x = model.pos.x
  let y = model.pos.y
  let dx = model.delta.x
  let dy = model.delta.y

  let bounce_right = x +. dx >. width -. model.radius
  let bounce_left = x +. dx <. model.radius
  let bounce_top = y +. dy >. height -. model.radius
  let bounce_bottom = y +. dy <. model.radius

  case bounce_right, bounce_left, bounce_top, bounce_bottom {
    True, False, False, False -> BounceX
    False, True, False, False -> BounceX
    False, False, True, False -> BounceY
    False, False, False, True -> BounceY
    _, _, _, _ -> Move
  }
}

pub fn render(
  _render_context: RenderContext,
  model: Model,
  _frame: Int,
  ctx: CanvasRenderingContext2D,
) {
  canvas.with_path(ctx, fn(c) {
    c
    |> canvas.arc(model.pos, model.radius, 0.0, math.pi() *. 2.0)
    |> canvas.fill_style("#ffaff3")
    |> canvas.fill()
    |> canvas.stroke_style("#000")
    |> canvas.stroke()
  })
  Nil
}
