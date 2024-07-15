import canvax/canvas/context.{type CanvasRenderingContext2D}
import canvax/effect.{type Effect}

pub opaque type Node(model, msg, rc) {
  Node(
    frame: fn(model, rc) -> #(msg, Effect(msg)),
    update: fn(msg, model, rc) -> model,
    render: fn(CanvasRenderingContext2D, model, rc) -> Nil,
    init: fn(rc) -> #(model, Effect(msg)),
  )
}

pub type NodeList(rc) =
  List(fn(CanvasRenderingContext2D, rc) -> Nil)

pub type NodeError {
  NotABrowsser
}

pub fn create_node(
  frame: fn(model, rc) -> #(msg, Effect(msg)),
  update: fn(msg, model, rc) -> model,
  render: fn(CanvasRenderingContext2D, model, rc) -> Nil,
  init: fn(rc) -> #(model, Effect(msg)),
) {
  Node(frame, update, render, init) |> create_node_ffi()
}

@external(javascript, "../common.ffi.mjs", "create_scene_node")
fn create_node_ffi(
  _node: Node(model, msg, rc),
) -> fn(CanvasRenderingContext2D, rc) -> Nil
