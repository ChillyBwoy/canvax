import { Ok, Error } from "./gleam.mjs";

export function getElementById(id) {
  const $el = document.getElementById(id);
  return $el ? new Ok($el) : new Error(null);
}
