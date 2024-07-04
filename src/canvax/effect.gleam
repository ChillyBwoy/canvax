import gleam/list

pub opaque type Effect(msg) {
  Effect(all: List(fn(fn(msg) -> Nil, fn(String) -> Nil) -> Nil))
}

pub fn from(effect: fn(fn(msg) -> Nil) -> Nil) -> Effect(msg) {
  Effect([fn(dispatch, _) { effect(dispatch) }])
}

pub fn event(name: String) -> Effect(msg) {
  Effect([fn(_, emit) { emit(name) }])
}

pub fn none() -> Effect(msg) {
  Effect([])
}

pub fn batch(effects: List(Effect(msg))) -> Effect(msg) {
  Effect({
    use b, Effect(a) <- list.fold(effects, [])
    list.append(b, a)
  })
}

pub fn map(effect: Effect(a), f: fn(a) -> b) -> Effect(b) {
  Effect({
    use eff <- list.map(effect.all)
    fn(dispatch, emit) { eff(fn(msg) { dispatch(f(msg)) }, emit) }
  })
}

pub fn perform(
  effect: Effect(a),
  dispatch: fn(a) -> Nil,
  emit: fn(String) -> Nil,
) -> Nil {
  use eff <- list.each(effect.all)

  eff(dispatch, emit)
}
