import { Ok, Error } from "./gleam.mjs";
import { Vector2 } from "./canvax/primitive.mjs";

export function getDimensions($el) {
  return new Ok(new Vector2($el.width, $el.height));
}
