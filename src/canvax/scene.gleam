import canvax/canvas/context.{type CanvasRenderingContext2D}

@external(javascript, "../common.ffi.mjs", "render")
fn render_ffi(
  initial_state: model,
  step: fn(model, CanvasRenderingContext2D, rc) -> model,
) -> fn(CanvasRenderingContext2D, rc) -> Nil

pub fn create_node(
  initial: m,
  on_frame do_frame: fn(m, rc) -> msg,
  on_update do_update: fn(msg, m, rc) -> m,
  on_render do_render: fn(CanvasRenderingContext2D, m, rc) -> Nil,
) {
  render_ffi(initial, fn(model, ctx, render_context) {
    do_render(ctx, model, render_context)
    do_frame(model, render_context)
    |> do_update(model, render_context)
  })
}
