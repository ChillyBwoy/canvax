// build/dev/javascript/prelude.mjs
var CustomType = class {
  withFields(fields) {
    let properties = Object.keys(this).map(
      (label) => label in fields ? fields[label] : this[label]
    );
    return new this.constructor(...properties);
  }
};
var List = class {
  static fromArray(array, tail) {
    let t = tail || new Empty();
    for (let i = array.length - 1; i >= 0; --i) {
      t = new NonEmpty(array[i], t);
    }
    return t;
  }
  [Symbol.iterator]() {
    return new ListIterator(this);
  }
  toArray() {
    return [...this];
  }
  // @internal
  atLeastLength(desired) {
    for (let _ of this) {
      if (desired <= 0)
        return true;
      desired--;
    }
    return desired <= 0;
  }
  // @internal
  hasLength(desired) {
    for (let _ of this) {
      if (desired <= 0)
        return false;
      desired--;
    }
    return desired === 0;
  }
  countLength() {
    let length2 = 0;
    for (let _ of this)
      length2++;
    return length2;
  }
};
var ListIterator = class {
  #current;
  constructor(current) {
    this.#current = current;
  }
  next() {
    if (this.#current instanceof Empty) {
      return { done: true };
    } else {
      let { head, tail } = this.#current;
      this.#current = tail;
      return { value: head, done: false };
    }
  }
};
var Empty = class extends List {
};
var NonEmpty = class extends List {
  constructor(head, tail) {
    super();
    this.head = head;
    this.tail = tail;
  }
};
var Result = class _Result extends CustomType {
  // @internal
  static isResult(data) {
    return data instanceof _Result;
  }
};
var Ok = class extends Result {
  constructor(value) {
    super();
    this[0] = value;
  }
  // @internal
  isOk() {
    return true;
  }
};
var Error = class extends Result {
  constructor(detail) {
    super();
    this[0] = detail;
  }
  // @internal
  isOk() {
    return false;
  }
};
function makeError(variant, module, line, fn, message, extra) {
  let error = new globalThis.Error(message);
  error.gleam_error = variant;
  error.module = module;
  error.line = line;
  error.fn = fn;
  for (let k in extra)
    error[k] = extra[k];
  return error;
}

// build/dev/javascript/gleam_stdlib/dict.mjs
var tempDataView = new DataView(new ArrayBuffer(8));
var SHIFT = 5;
var BUCKET_SIZE = Math.pow(2, SHIFT);
var MASK = BUCKET_SIZE - 1;
var MAX_INDEX_NODE = BUCKET_SIZE / 2;
var MIN_ARRAY_NODE = BUCKET_SIZE / 4;

// build/dev/javascript/gleam_stdlib/gleam_stdlib.mjs
function random_uniform() {
  const random_uniform_result = Math.random();
  if (random_uniform_result === 1) {
    return random_uniform();
  }
  return random_uniform_result;
}

// build/dev/javascript/gleam_community_maths/maths.mjs
function pi() {
  return Math.PI;
}

// build/dev/javascript/gleam_community_maths/gleam_community/maths/elementary.mjs
function pi2() {
  return pi();
}

// build/dev/javascript/canvax/document.ffi.mjs
function getElementById(id) {
  const $el = document.getElementById(id);
  return $el ? new Ok($el) : new Error(null);
}
function raf(initialState, callback) {
  let delta = 0;
  let state = initialState;
  const render = () => {
    state = callback(state, ++delta);
    requestAnimationFrame(render);
  };
  requestAnimationFrame(render);
}

// build/dev/javascript/canvax/canvax/primitives.mjs
var Vector2 = class extends CustomType {
  constructor(x, y) {
    super();
    this.x = x;
    this.y = y;
  }
};

// build/dev/javascript/canvax/common.ffi.mjs
function getDimensions($el) {
  return new Ok(new Vector2($el.width, $el.height));
}

// build/dev/javascript/canvax/context.ffi.mjs
function getContext($el, options) {
  const ctx = $el.getContext("2d", options);
  return ctx ? new Ok(ctx) : new Error(null);
}
function beginPath(ctx) {
  ctx.beginPath();
  return ctx;
}
function fill(ctx, ...args) {
  ctx.fill(...args);
  return ctx;
}
function stroke(ctx) {
  ctx.stroke();
  return ctx;
}
function fillStyle(ctx, style) {
  ctx.fillStyle = style;
  return ctx;
}
function strokeStyle(ctx, style) {
  ctx.strokeStyle = style;
  return ctx;
}
function fillRect(ctx, pos, size) {
  ctx.fillRect(pos.x, pos.y, size.x, size.y);
  return ctx;
}
function clearRect(ctx, pos, size) {
  ctx.clearRect(pos.x, pos.y, size.x, size.y);
  return ctx;
}
function arc(ctx, pos, radius, startAngle, endAngle, counterclockwise) {
  ctx.arc(pos.x, pos.y, radius, startAngle, endAngle, counterclockwise);
  return ctx;
}
function closePath(ctx) {
  ctx.closePath();
  return ctx;
}

// build/dev/javascript/canvax/canvax/context.mjs
function with_path(ctx, callback) {
  let _pipe = beginPath(ctx);
  let _pipe$1 = callback(_pipe);
  return closePath(_pipe$1);
}

// build/dev/javascript/canvax/canvax.mjs
var State = class extends CustomType {
  constructor(pos, delta, rect2, ball_radius) {
    super();
    this.pos = pos;
    this.delta = delta;
    this.rect = rect2;
    this.ball_radius = ball_radius;
  }
};
function draw_ball(inst, pos, radius) {
  return with_path(
    inst,
    (c) => {
      let _pipe = arc(c, pos, radius, 0, pi2() * 2);
      let _pipe$1 = fillStyle(_pipe, "#ffaff3");
      let _pipe$2 = fill(_pipe$1);
      let _pipe$3 = strokeStyle(_pipe$2, "#000");
      return stroke(_pipe$3);
    }
  );
}
function next_pos(state) {
  let dx = (() => {
    let $ = state.pos.x + state.delta.x > state.rect.x - state.ball_radius || state.pos.x + state.delta.x < state.ball_radius;
    if ($) {
      return state.delta.x * -1;
    } else {
      return state.delta.x;
    }
  })();
  let dy = (() => {
    let $ = state.pos.y + state.delta.y > state.rect.y - state.ball_radius || state.pos.y + state.delta.y < state.ball_radius;
    if ($) {
      return state.delta.y * -1;
    } else {
      return state.delta.y;
    }
  })();
  return state.withFields({
    delta: new Vector2(dx, dy),
    pos: new Vector2(state.pos.x + dx, state.pos.y + dy)
  });
}
function main() {
  let $ = getElementById("canvas");
  if (!$.isOk()) {
    throw makeError(
      "assignment_no_match",
      "canvax",
      56,
      "main",
      "Assignment pattern did not match",
      { value: $ }
    );
  }
  let el = $[0];
  let $1 = getDimensions(el);
  if (!$1.isOk()) {
    throw makeError(
      "assignment_no_match",
      "canvax",
      57,
      "main",
      "Assignment pattern did not match",
      { value: $1 }
    );
  }
  let rect2 = $1[0];
  let $2 = getContext(el);
  if (!$2.isOk()) {
    throw makeError(
      "assignment_no_match",
      "canvax",
      58,
      "main",
      "Assignment pattern did not match",
      { value: $2 }
    );
  }
  let inst = $2[0];
  let speed = 5;
  let ball_radius = 10;
  return raf(
    new State(
      new Vector2(rect2.x * random_uniform(), rect2.y * random_uniform()),
      new Vector2(speed * random_uniform(), speed * random_uniform()),
      rect2,
      ball_radius * random_uniform() + 2
    ),
    (state, _) => {
      let $3 = getDimensions(el);
      if (!$3.isOk()) {
        throw makeError(
          "assignment_no_match",
          "canvax",
          71,
          "",
          "Assignment pattern did not match",
          { value: $3 }
        );
      }
      let rect$1 = $3[0];
      let _pipe = inst;
      let _pipe$1 = clearRect(_pipe, new Vector2(0, 0), rect$1);
      let _pipe$2 = fillStyle(_pipe$1, "#fffbe8");
      let _pipe$3 = fillRect(_pipe$2, new Vector2(0, 0), rect$1);
      draw_ball(_pipe$3, state.pos, state.ball_radius);
      return next_pos(state);
    }
  );
}

// build/.lustre/entry.mjs
main();
