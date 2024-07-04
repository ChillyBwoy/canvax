import app/render_context.{type RenderContext}
import canvax/canvas/context.{type CanvasRenderingContext2D}
import canvax/primitives/vector2.{type Vector2, Vector2}
import canvax/scene.{create_node}

import gleam/float

pub opaque type Model {
  Model(pos: Vector2, size: Vector2, color: String)
}

pub opaque type Msg {
  NoOp
}

pub fn init(render_context: RenderContext, size: Float, color: String) {
  let model =
    Model(
      pos: Vector2(
        render_context.viewport_size.x *. float.random(),
        render_context.viewport_size.y *. float.random(),
      ),
      size: Vector2(size, size),
      color: color,
    )
  create_node(model, on_frame: frame, on_update: update, on_render: render)
}

fn frame(_model: Model, _render_context: RenderContext) -> Msg {
  NoOp
}

fn update(msg: Msg, model: Model, _render_context: RenderContext) -> Model {
  case msg {
    NoOp -> model
  }
}

fn render(
  ctx: CanvasRenderingContext2D,
  model: Model,
  _render_context: RenderContext,
) {
  context.with_path(ctx, fn(c) {
    c
    |> context.fill_style(model.color)
    |> context.fill_rect(model.pos, model.size)
    |> context.stroke()
  })

  Nil
}
