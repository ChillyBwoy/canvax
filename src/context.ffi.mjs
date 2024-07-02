import { None } from "../gleam_stdlib/gleam/option.mjs";
import { Ok, Error } from "./gleam.mjs";
import { Vector2 } from "./canvax/primitives.mjs";

export function getContext($el, options) {
  const ctx = $el.getContext("2d", options);
  return ctx ? new Ok(ctx) : new Error(null);
}

// CanvasDrawPath START
export function beginPath(ctx) {
  ctx.beginPath();
  return ctx;
}

export function clip(ctx, ...args) {
  // clip(fillRule?: CanvasFillRule): void;
  // clip(path: Path2D, fillRule?: CanvasFillRule): void;
  ctx.clip(...args);
  return ctx;
}

export function fill(ctx, ...args) {
  // fill(fillRule?: CanvasFillRule): void;
  // fill(path: Path2D, fillRule?: CanvasFillRule): void;
  // TODO: update args
  ctx.fill(...args);
  return ctx;
}

export function isPointInPath(ctx, ...args) {
  // isPointInPath(x: number, y: number, fillRule?: CanvasFillRule): boolean;
  // isPointInPath(path: Path2D, x: number, y: number, fillRule?: CanvasFillRule): boolean;
  throw new Error("Not implemented");
}

export function isPointInStroke(ctx, ...args) {
  // isPointInStroke(x: number, y: number): boolean;
  // isPointInStroke(path: Path2D, x: number, y: number): boolean;
  throw new Error("Not implemented");
}

export function stroke(ctx) {
  ctx.stroke();
  return ctx;
}
// stroke(path: Path2D): void;
// CanvasDrawPath END

// CanvasFillStrokeStyles START
export function fillStyle(ctx, style) {
  ctx.fillStyle = style;
  return ctx;
}

export function strokeStyle(ctx, style) {
  ctx.strokeStyle = style;
  return ctx;
}
// CanvasFillStrokeStyles END

// CanvasRect START
export function fillRect(ctx, pos, size) {
  ctx.fillRect(pos.x, pos.y, size.x, size.y);
  return ctx;
}

export function clearRect(ctx, pos, size) {
  ctx.clearRect(pos.x, pos.y, size.x, size.y);
  return ctx;
}

export function strokeRect(ctx, pos, size) {
  ctx.strokeRect(pos.x, pos.y, size.x, size.y);
  return ctx;
}
// CanvasRect END

// CanvasPath START
export function arc(ctx, pos, radius, startAngle, endAngle, counterclockwise) {
  ctx.arc(pos.x, pos.y, radius, startAngle, endAngle, counterclockwise);
  return ctx;
}

export function arcTo(ctx, from, to, radius) {
  ctx.arcTo(from.x, from.y, to.x, to.y, radius);
  return ctx;
}

export function bezierCurveTo(ctx, cp1, cp2, pos) {
  ctx.bezierCurveTo(cp1.x, cp1.y, cp2.x, cp2.y, pos.x, pos.y);
  return ctx;
}

export function closePath(ctx) {
  ctx.closePath();
  return ctx;
}

export function ellipse(
  ctx,
  pos,
  radius,
  rotation,
  startAngle,
  endAngle,
  counterclockwise
) {
  ctx.ellipse(
    pos.x,
    pos.y,
    radius.x,
    radius.y,
    rotation,
    startAngle,
    endAngle,
    counterclockwise
  );
  return ctx;
}
export function lineTo(ctx, coord) {
  ctx.lineTo(coord.x, coord.y);
  return ctx;
}

export function moveTo(ctx, pos) {
  ctx.moveTo(pos.x, pos.y);
  return ctx;
}

export function quadraticCurveTo(ctx, cp, point) {
  ctx.quadraticCurveTo(cp.x, cp.y, point.x, point.y);
  return ctx;
}

export function rect(ctx, pos, size) {
  ctx.rect(pos.x, pos.y, size.x, size.y);
  return ctx;
}

export function roundRect(ctx) {
  // roundRect(x: number, y: number, w: number, h: number, radii?: number | DOMPointInit | (number | DOMPointInit)[]): void;
  throw new Error("Not implemented");
}

// CanvasPath END
