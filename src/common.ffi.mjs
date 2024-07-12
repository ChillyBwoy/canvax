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

export function create_scene_node({ frame, update, render, init }) {
  let initialized = false;
  let model;

  const loop = (ctx, rc) => {
    if (!initialized) {
      initialized = true;
      const [initialModel, _initialEffect] = init(rc);
      model = initialModel;
      render(ctx, model, rc);
    }

    const [msg, _effect] = frame(model, rc);
    model = update(msg, model, rc);
    render(ctx, model, rc);
  };

  return loop;
}
