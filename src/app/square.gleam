import app/render_context.{type RenderContext}
import canvax/canvas/context.{type CanvasRenderingContext2D}
import canvax/effect.{type Effect}
import canvax/primitives/vector2 as v2
import canvax/primitives/vector2.{type Vector2, Vector2}
import canvax/scene.{create_node}
import gleam_community/maths/elementary as math

pub opaque type Model {
  Model(position: Vector2, size: Float, color: String, angle: Float)
}

pub opaque type Msg {
  Noop
}

pub fn init(position position: Vector2, size size: Float, color color: String) {
  use _ <- create_node(frame, update, render)
  #(
    Model(position: position, size: size, color: color, angle: 0.0),
    effect.none(),
  )
}

fn frame(_model: Model, _render_context: RenderContext) -> #(Msg, Effect(Msg)) {
  #(Noop, effect.none())
}

fn update(_: Msg, model: Model, _render_context: RenderContext) -> Model {
  let next_angle = case model.angle +. 1.0 {
    a if a >. 360.0 -> 0.0
    _ -> model.angle +. 1.0
  }

  Model(..model, angle: next_angle)
}

fn render(ctx: CanvasRenderingContext2D, model: Model, _: RenderContext) {
  let offset = Vector2(model.size, model.size) |> v2.div(2.0)
  let translate_to = model.position |> v2.add(offset)
  let angle = model.angle *. math.pi() /. 180.0

  ctx
  |> context.save()
  |> context.translate(translate_to)
  |> context.rotate(angle)
  |> context.translate(translate_to |> v2.negate())
  |> context.with_path(fn(_) {
    ctx
    |> context.rect(model.position, Vector2(model.size, model.size))
    |> context.fill_style(model.color)
    |> context.fill()
    |> context.stroke_style("#000")
    |> context.stroke()
  })
  |> context.restore()

  Nil
}
