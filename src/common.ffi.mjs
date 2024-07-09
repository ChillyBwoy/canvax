import { Ok, Error } from "./gleam.mjs";
import { Vector2 } from "./canvax/primitives/vector2.mjs";

export function getDimensions($el) {
  return new Ok(new Vector2($el.width, $el.height));
}

export function render(initialState, callback) {
  let state = initialState;

  const run = (ctx, renderContext) => {
    state = callback(state, ctx, renderContext);
  };

  return run;
}

export function create_scene_node() {
  throw new Error("not implemented");
}
