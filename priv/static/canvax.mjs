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
function divideInt(a, b) {
  return Math.trunc(divideFloat(a, b));
}
function divideFloat(a, b) {
  if (b === 0) {
    return 0;
  } else {
    return a / b;
  }
}
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

// build/dev/javascript/gleam_stdlib/gleam/option.mjs
var Some = class extends CustomType {
  constructor(x0) {
    super();
    this[0] = x0;
  }
};
var None = class extends CustomType {
};

// build/dev/javascript/gleam_stdlib/dict.mjs
var tempDataView = new DataView(new ArrayBuffer(8));
var SHIFT = 5;
var BUCKET_SIZE = Math.pow(2, SHIFT);
var MASK = BUCKET_SIZE - 1;
var MAX_INDEX_NODE = BUCKET_SIZE / 2;
var MIN_ARRAY_NODE = BUCKET_SIZE / 4;

// build/dev/javascript/gleam_stdlib/gleam_stdlib.mjs
function round(float) {
  return Math.round(float);
}

// build/dev/javascript/gleam_stdlib/gleam/float.mjs
function negate(x) {
  return -1 * x;
}
function do_round(x) {
  let $ = x >= 0;
  if ($) {
    return round(x);
  } else {
    return 0 - round(negate(x));
  }
}
function round2(x) {
  return do_round(x);
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

// build/dev/javascript/canvax/canvax/primitive.mjs
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
  ctx.fill();
  return ctx;
}
function fillStyle(ctx, style) {
  ctx.fillStyle = style;
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
var EvenOdd = class extends CustomType {
};
function canvas_fill_rule(rule) {
  if (rule instanceof EvenOdd) {
    return "evenodd";
  } else {
    return "nonzero";
  }
}
function fill2(ctx, rule) {
  if (rule instanceof Some) {
    let rule$1 = rule[0];
    return fill(ctx, new Some(canvas_fill_rule(rule$1)));
  } else {
    return fill(ctx, new None());
  }
}
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
      let _pipe = arc(c, pos, radius, 0, pi2() * 2, new None());
      let _pipe$1 = fillStyle(_pipe, "#f00");
      return fill2(_pipe$1, new None());
    }
  );
}
function next_pos(state) {
  let dx = (() => {
    let $ = state.pos.x + state.delta.x > state.rect.x - round2(
      state.ball_radius
    ) || state.pos.x + state.delta.x < round2(state.ball_radius);
    if ($) {
      return state.delta.x * -1;
    } else {
      return state.delta.x;
    }
  })();
  let dy = (() => {
    let $ = state.pos.y + state.delta.y > state.rect.y - round2(
      state.ball_radius
    ) || state.pos.y + state.delta.y < round2(state.ball_radius);
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
      46,
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
      47,
      "main",
      "Assignment pattern did not match",
      { value: $1 }
    );
  }
  let rect2 = $1[0];
  let $2 = getContext(el, new None());
  if (!$2.isOk()) {
    throw makeError(
      "assignment_no_match",
      "canvax",
      48,
      "main",
      "Assignment pattern did not match",
      { value: $2 }
    );
  }
  let inst = $2[0];
  return raf(
    new State(
      new Vector2(divideInt(rect2.x, 5), divideInt(rect2.y, 3)),
      new Vector2(5, 5),
      rect2,
      15
    ),
    (state, _) => {
      let _pipe = clearRect(inst, new Vector2(0, 0), rect2);
      let _pipe$1 = fillStyle(_pipe, "rgba(128, 128, 128, 0.5)");
      let _pipe$2 = fillRect(_pipe$1, new Vector2(0, 0), rect2);
      let _pipe$3 = fillStyle(_pipe$2, "rgb(255, 255, 255)");
      draw_ball(_pipe$3, state.pos, state.ball_radius);
      return next_pos(state);
    }
  );
}

// build/.lustre/entry.mjs
main();
