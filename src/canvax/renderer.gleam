import canvax/canvas.{type CanvasRenderingContext2D}

pub opaque type Renderer(a) {
  Renderer(items: List(a))
}

// pub fn raf(initial_state: a, callback: fn(a, Int) -> a) -> Nil

pub fn create_renderer(
  ctx: CanvasRenderingContext2D,
  render_context: a,
  initial_model: b,
  update: fn(a, b, Int) -> m,
  render: fn(CanvasRenderingContext2D, a, b, Int) -> Nil,
) {
  let go = fn() { todo }
  // #(
  //   initial_model,
  //   fn(model, frame) {
  //     render(ctx, render_context, model, frame)
  //     update(render_context, model, frame)
  //   },
  //   update,
  // )
}
