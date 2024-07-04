pub type Vector2 {
  Vector2(x: Float, y: Float)
}

pub fn add(v1: Vector2, v2: Vector2) {
  Vector2(v1.x +. v2.x, v1.y +. v2.y)
}

pub fn sub(v1: Vector2, v2: Vector2) {
  Vector2(v1.x -. v2.x, v1.y -. v2.y)
}

pub fn mul(v: Vector2, s: Float) {
  Vector2(v.x *. s, v.y *. s)
}

pub fn div(v: Vector2, s: Float) {
  Vector2(v.x /. s, v.y /. s)
}
