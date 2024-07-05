import gleam/float

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

pub fn rand() {
  Vector2(float.random(), float.random())
}

pub fn rand2() {
  Vector2(float.random() -. 0.5, float.random() -. 0.5)
}

pub fn negate(v: Vector2) {
  Vector2(float.negate(v.x), float.negate(v.y))
}
