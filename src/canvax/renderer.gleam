import canvax/canvas.{type CanvasRenderingContext2D}

pub fn create_renderer(
  initial: m,
  on_frame do_frame: fn(m, rc) -> msg,
  on_update do_update: fn(msg, m, rc) -> m,
  on_render do_render: fn(CanvasRenderingContext2D, m, rc) -> Nil,
) {
  let dispatch = fn(ctx: CanvasRenderingContext2D, model: m, render_context: rc) {
    do_render(ctx, model, render_context)
    do_frame(model, render_context)
    |> do_update(model, render_context)
  }
}
