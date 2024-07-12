import app/render_context.{type RenderContext}
import canvax/canvas/context.{type CanvasRenderingContext2D}
import canvax/effect.{type Effect}
import canvax/primitives/vector2.{type Vector2, Vector2}
import canvax/scene.{create_node}

pub opaque type Model {
  Model
}

pub opaque type Msg {
  Noop
}

pub fn init() {
  use _ <- create_node(frame, update, render)
  #(Model, effect.none())
}

fn frame(_model: Model, _render_context: RenderContext) -> #(Msg, Effect(Msg)) {
  #(Noop, effect.none())
}

fn update(_: Msg, model: Model, _render_context: RenderContext) -> Model {
  model
}

fn render(
  ctx: CanvasRenderingContext2D,
  _: Model,
  render_context: RenderContext,
) {
  ctx
  |> context.clear_rect(Vector2(0.0, 0.0), render_context.viewport)
  |> context.fill_style("#fffbe8")
  |> context.fill_rect(Vector2(0.0, 0.0), render_context.viewport)
  Nil
}
