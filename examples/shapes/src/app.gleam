import app/background
import app/ball
import app/render_context.{RenderContext}
import app/square
import canvax
import canvax/common
import canvax/primitives/vector2 as v2
import canvax/primitives/vector2.{Vector2}
import gleam/float
import gleam/int
import gleam/list
import gleam/string

fn random_color_part() {
  float.random() *. 255.0
  |> float.round()
  |> int.to_string()
}

fn random_color() {
  "rgb("
  <> [random_color_part(), random_color_part(), random_color_part()]
  |> string.join(",")
  <> ")"
}

fn random_pos(base: Float, size: Float) {
  float.random() *. base
  |> float.clamp(min: size, max: base -. size)
}

pub fn main() {
  let assert Ok(app) = canvax.create_app(root: "canvas")

  app
  |> canvax.run(fn(el, _) {
    let assert Ok(rect) = common.get_dimensions(el)

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
        color: random_color(),
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
        color: random_color(),
      )
    }

    let scene =
      [background.init()]
      |> list.append(list.range(0, 50) |> list.map(fn(_) { create_square() }))
      |> list.append(list.range(0, 1000) |> list.map(fn(_) { create_ball() }))

    #(render_context, scene)
  })
}
