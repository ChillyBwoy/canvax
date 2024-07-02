import { Ok, Error } from "./gleam.mjs";
import { Vector2 } from "./canvax/primitive.mjs";

export function getContext($el, contextId, options) {
  const ctx = $el.getContext(contextId, options);
  return ctx ? new Ok(ctx) : new Error(null);
}
