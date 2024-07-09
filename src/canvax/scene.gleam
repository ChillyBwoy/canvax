import canvax/canvas/context.{type CanvasRenderingContext2D}
import canvax/effect.{type Effect}

pub opaque type Node(model, msg, rc, t) {
  Node(
    init: fn(rc, t) -> #(model, Effect(msg)),
    frame: fn(model, rc) -> #(msg, Effect(msg)),
    update: fn(msg, model, rc) -> model,
    render: fn(CanvasRenderingContext2D, model, rc) -> Nil,
  )
}

pub type NodeCtr(rc, t) =
  fn(rc, t) -> fn(CanvasRenderingContext2D, rc) -> Nil

pub type NodeError {
  NotABrowsser
}

pub fn create_node(
  rc: rc,
  init: fn(rc, t) -> #(model, Effect(msg)),
  frame: fn(model, rc) -> #(msg, Effect(msg)),
  update: fn(msg, model, rc) -> model,
  render: fn(CanvasRenderingContext2D, model, rc) -> Nil,
) {
  let node = Node(init, frame, update, render)
  create_node_ffi(rc, node)
}

@external(javascript, "../common.ffi.mjs", "create_scene_node")
fn create_node_ffi(
  _rc: rc,
  _node: Node(model, msg, rc, t),
) -> Result(NodeCtr(rc, t), NodeError) {
  Error(NotABrowsser)
}
// pub fn create_scene_node(
//   init: fn(rc, t) -> #(m, Effect(msg)),
//   render: fn(CanvasRenderingContext2D, m, rc) -> Nil,
//   frame: fn(m, rc) -> Effect(msg),
//   update: fn(msg, m, rc) -> #(m, Effect(msg)),
// ) {
//   fn(ctx: CanvasRenderingContext2D, render_context: rc, payload: t) { todo }
// }

// @external(javascript, "../common.ffi.mjs", "render")
// fn render_ffi(
//   initial_state: model,
//   step: fn(model, CanvasRenderingContext2D, rc) -> model,
// ) -> fn(CanvasRenderingContext2D, rc) -> Nil

// pub fn create_node(
//   initial: m,
//   on_frame do_frame: fn(m, rc) -> msg,
//   on_update do_update: fn(msg, m, rc) -> m,
//   on_render do_render: fn(CanvasRenderingContext2D, m, rc) -> Nil,
// ) {
//   render_ffi(initial, fn(model, ctx, render_context) {
//     do_render(ctx, model, render_context)
//     do_frame(model, render_context)
//     |> do_update(model, render_context)
//   })
// }
