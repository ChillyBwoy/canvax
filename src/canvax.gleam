import app/background
import app/ball
import app/render_context.{RenderContext}
import app/square
import canvax/canvas/context
import canvax/common
import canvax/html
import canvax/primitives/color
import canvax/primitives/vector2 as v2
import canvax/primitives/vector2.{Vector2}
import gleam/float
import gleam/list

fn random_pos(base: Float, size: Float) {
  float.random() *. base
  |> float.clamp(min: size, max: base -. size)
}

pub fn main() {
  let assert Ok(el) = html.get_element_by_id("canvas")
  let assert Ok(rect) = common.get_dimensions(el)
  let assert Ok(ctx) = context.get_context(el)
  let render_context = RenderContext(viewport: rect)

  let viewport_center = v2.div(render_context.viewport, 2.0)

  let create_square = fn() {
    let size = float.random() *. 50.0 |> float.clamp(min: 25.0, max: 50.0)

    square.init(
      position: Vector2(
        random_pos(render_context.viewport.x, size),
        random_pos(render_context.viewport.y, size),
      ),
      size: size,
      color: color.random_color(),
    )
  }
  let create_ball = fn() {
    let radius = float.random() *. 10.0 |> float.clamp(min: 5.0, max: 10.0)
    let velocity = float.random() *. 5.0 |> float.clamp(min: 5.0, max: 10.0)
    ball.init(
      position: viewport_center |> v2.add(Vector2(radius, radius)),
      direction: v2.rand2() |> v2.mul(velocity),
      radius: radius,
      velocity: velocity,
      color: color.random_color(),
    )
  }
  let scene =
    [background.init()]
    |> list.append(list.range(0, 50) |> list.map(fn(_) { create_square() }))
    |> list.append(list.range(0, 1000) |> list.map(fn(_) { create_ball() }))

  html.raf(fn(_frame) {
    list.each(scene, fn(node) { node(ctx, render_context) })

    Nil
  })
}
