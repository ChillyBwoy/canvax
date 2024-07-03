import { Ok, Error } from "./gleam.mjs";
import { Vector2 } from "./canvax/primitives/vector2.mjs";

export function getDimensions($el) {
  return new Ok(new Vector2($el.width, $el.height));
}
