import gleam/float
import gleam/int
import gleam/string

fn random_color_part() {
  float.random() *. 255.0
  |> float.round()
  |> int.to_string()
}

pub fn random_color() {
  "rgb("
  <> [random_color_part(), random_color_part(), random_color_part()]
  |> string.join(",")
  <> ")"
}
