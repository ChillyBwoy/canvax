import app/render_context.{type RenderContext}
import canvax/canvas/context.{type CanvasRenderingContext2D}
import canvax/primitives/vector2.{type Vector2, Vector2}
import canvax/scene.{create_node}

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

pub fn init(render_context: RenderContext, radius: Float, speed: Float) {
  let model =
    Model(
      pos: Vector2(
        render_context.viewport_size.x /. 2.0 *. float.random() +. radius,
        render_context.viewport_size.y /. 2.0 *. float.random() +. radius,
      ),
      delta: Vector2(speed *. float.random(), speed *. float.random()),
      radius: radius,
      speed: speed,
    )

  create_node(model, on_frame: frame, on_update: update, on_render: render)
}

fn frame(model: Model, render_context: RenderContext) -> Msg {
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

fn update(msg: Msg, model: Model, _: RenderContext) -> Model {
  case msg {
    Move -> {
      Model(..model, pos: vector2.add(model.pos, model.delta))
    }
    BounceX -> {
      Model(..model, delta: Vector2(model.delta.x *. -1.0, model.delta.y))
    }
    BounceY -> {
      Model(..model, delta: Vector2(model.delta.x, model.delta.y *. -1.0))
    }
  }
}

fn render(ctx: CanvasRenderingContext2D, model: Model, _: RenderContext) {
  context.with_path(ctx, fn(c) {
    c
    |> context.arc(model.pos, model.radius, 0.0, math.pi() *. 2.0)
    |> context.fill_style("#ffaff3")
    |> context.fill()
    |> context.stroke_style("#000")
    |> context.stroke()
  })
  Nil
}
