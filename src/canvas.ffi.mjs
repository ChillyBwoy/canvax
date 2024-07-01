import { Ok, Error } from "./gleam.mjs";

export function getContext($el, contextId, options) {
  const ctx = $el.getContext(contextId, options);
  return ctx ? new Ok(ctx) : new Error(null);
}

export function getDimensions($el) {
  return new Ok([$el.width, $el.height]);
}

export function fillRect(ctx, pos, size, style) {
  ctx.fillStyle = style;
  ctx.fillRect(pos.x, pos.y, size.x, size.y);
}
