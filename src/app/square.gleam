import app/context.{type RenderContext}
import canvax/canvas.{type CanvasRenderingContext2D}
import canvax/effect.{type Effect}
import canvax/primitives/vector2.{type Vector2, Vector2}

import gleam/float

pub opaque type Model {
  Model(pos: Vector2)
}

pub opaque type Msg {
  NoOp
}

pub fn init(render_context: RenderContext) -> #(Model, Effect(Msg)) {
  let model =
    Model(pos: Vector2(
      render_context.viewport_size.x *. float.random(),
      render_context.viewport_size.y *. float.random(),
    ))
  #(model, effect.none())
}

pub fn update(
  _render_context: RenderContext,
  model: Model,
  _frame: Int,
  msg: Msg,
) -> #(Model, Effect(Msg)) {
  case msg {
    NoOp -> #(model, effect.none())
  }
}

pub fn frame(_render_context: RenderContext, _model: Model, _frame: Int) -> Msg {
  NoOp
}

pub fn render(
  _render_context: RenderContext,
  _model: Model,
  _ctx: CanvasRenderingContext2D,
  _frame: Int,
) {
  Nil
}
