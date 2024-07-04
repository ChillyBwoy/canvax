import { Ok, Error } from "./gleam.mjs";

export function getElementById(id) {
  const $el = document.getElementById(id);
  return $el ? new Ok($el) : new Error(null);
}

export function raf(initialState, callback) {
  let delta = 0;
  let state = initialState;

  const render = () => {
    state = callback(state, ++delta);
    requestAnimationFrame(render);
  };

  requestAnimationFrame(render);
}

export function loop(renderers) {
  let delta = 0;

  const dispatch = () => {
    for (const renderer of renderers) {
    }
    requestAnimationFrame(dispatch);
  };

  requestAnimationFrame(dispatch);
}
