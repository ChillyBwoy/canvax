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
function toList(elements, tail) {
  return List.fromArray(elements, tail);
}
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

// build/dev/javascript/gleam_stdlib/gleam/list.mjs
function each(loop$list, loop$f) {
  while (true) {
    let list = loop$list;
    let f = loop$f;
    if (list.hasLength(0)) {
      return void 0;
    } else {
      let x = list.head;
      let xs = list.tail;
      f(x);
      loop$list = xs;
      loop$f = f;
    }
  }
}

// build/dev/javascript/gleam_community_maths/maths.mjs
function pi() {
  return Math.PI;
}

// build/dev/javascript/gleam_community_maths/gleam_community/maths/elementary.mjs
function pi2() {
  return pi();
}

// build/dev/javascript/canvax/canvax/primitives/vector2.mjs
var Vector2 = class extends CustomType {
  constructor(x, y) {
    super();
    this.x = x;
    this.y = y;
  }
};
function add2(v1, v2) {
  return new Vector2(v1.x + v2.x, v1.y + v2.y);
}

// build/dev/javascript/canvax/app/render_context.mjs
var RenderContext = class extends CustomType {
  constructor(viewport_size) {
    super();
    this.viewport_size = viewport_size;
  }
};

// build/dev/javascript/canvax/document.ffi.mjs
function getElementById(id) {
  const $el = document.getElementById(id);
  return $el ? new Ok($el) : new Error(null);
}
function raf(callback) {
  let delta = 0;
  const render4 = () => {
    callback(++delta);
    requestAnimationFrame(render4);
  };
  requestAnimationFrame(render4);
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

// build/dev/javascript/canvax/canvax/canvas/context.mjs
function with_path(ctx, callback) {
  let _pipe = beginPath(ctx);
  let _pipe$1 = callback(_pipe);
  return closePath(_pipe$1);
}

// build/dev/javascript/canvax/common.ffi.mjs
function getDimensions($el) {
  return new Ok(new Vector2($el.width, $el.height));
}
function render(initialState, callback) {
  let state = initialState;
  const run = (ctx, renderContext) => {
    state = callback(state, ctx, renderContext);
  };
  return run;
}

// build/dev/javascript/canvax/canvax/scene.mjs
function create_node(initial, do_frame, do_update, do_render) {
  return render(
    initial,
    (model, ctx, render_context) => {
      do_render(ctx, model, render_context);
      let _pipe = do_frame(model, render_context);
      return do_update(_pipe, model, render_context);
    }
  );
}

// build/dev/javascript/canvax/app/ball.mjs
var Model = class extends CustomType {
  constructor(pos, delta, radius, speed) {
    super();
    this.pos = pos;
    this.delta = delta;
    this.radius = radius;
    this.speed = speed;
  }
};
var Move = class extends CustomType {
};
var BounceX = class extends CustomType {
};
var BounceY = class extends CustomType {
};
function frame(model, render_context) {
  let width = render_context.viewport_size.x;
  let height = render_context.viewport_size.y;
  let x = model.pos.x;
  let y = model.pos.y;
  let dx = model.delta.x;
  let dy = model.delta.y;
  let bounce_right = x + dx > width - model.radius;
  let bounce_left = x + dx < model.radius;
  let bounce_top = y + dy > height - model.radius;
  let bounce_bottom = y + dy < model.radius;
  if (bounce_right && !bounce_left && !bounce_top && !bounce_bottom) {
    return new BounceX();
  } else if (!bounce_right && bounce_left && !bounce_top && !bounce_bottom) {
    return new BounceX();
  } else if (!bounce_right && !bounce_left && bounce_top && !bounce_bottom) {
    return new BounceY();
  } else if (!bounce_right && !bounce_left && !bounce_top && bounce_bottom) {
    return new BounceY();
  } else {
    return new Move();
  }
}
function update(msg, model, _) {
  if (msg instanceof Move) {
    return model.withFields({ pos: add2(model.pos, model.delta) });
  } else if (msg instanceof BounceX) {
    return model.withFields({
      delta: new Vector2(model.delta.x * -1, model.delta.y)
    });
  } else {
    return model.withFields({
      delta: new Vector2(model.delta.x, model.delta.y * -1)
    });
  }
}
function render2(ctx, model, _) {
  with_path(
    ctx,
    (c) => {
      let _pipe = c;
      let _pipe$1 = arc(
        _pipe,
        model.pos,
        model.radius,
        0,
        pi2() * 2
      );
      let _pipe$2 = fillStyle(_pipe$1, "#ffaff3");
      let _pipe$3 = fill(_pipe$2);
      let _pipe$4 = strokeStyle(_pipe$3, "#000");
      return stroke(_pipe$4);
    }
  );
  return void 0;
}
function init(render_context, radius, speed) {
  let model = new Model(
    new Vector2(
      divideFloat(render_context.viewport_size.x, 2) * random_uniform() + radius,
      divideFloat(render_context.viewport_size.y, 2) * random_uniform() + radius
    ),
    new Vector2(speed * random_uniform(), speed * random_uniform()),
    radius,
    speed
  );
  return create_node(model, frame, update, render2);
}

// build/dev/javascript/canvax/app/square.mjs
var Model2 = class extends CustomType {
  constructor(pos, size, color) {
    super();
    this.pos = pos;
    this.size = size;
    this.color = color;
  }
};
var NoOp = class extends CustomType {
};
function frame2(_, _1) {
  return new NoOp();
}
function update2(msg, model, _) {
  return model;
}
function render3(ctx, model, _) {
  with_path(
    ctx,
    (c) => {
      let _pipe = c;
      let _pipe$1 = fillStyle(_pipe, model.color);
      let _pipe$2 = fillRect(_pipe$1, model.pos, model.size);
      return stroke(_pipe$2);
    }
  );
  return void 0;
}
function init2(render_context, size, color) {
  let model = new Model2(
    new Vector2(
      render_context.viewport_size.x * random_uniform(),
      render_context.viewport_size.y * random_uniform()
    ),
    new Vector2(size, size),
    color
  );
  return create_node(model, frame2, update2, render3);
}

// build/dev/javascript/canvax/canvax.mjs
function main() {
  let $ = getElementById("canvas");
  if (!$.isOk()) {
    throw makeError(
      "assignment_no_match",
      "canvax",
      11,
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
      12,
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
      13,
      "main",
      "Assignment pattern did not match",
      { value: $2 }
    );
  }
  let ctx = $2[0];
  let render_context = new RenderContext(rect2);
  let scene = toList([
    init2(render_context, 50, "#880000"),
    init2(render_context, 25, "#008800"),
    init2(render_context, 40, "#880088"),
    init(render_context, 10, 5),
    init(render_context, 12, 3),
    init(render_context, 15, 8),
    init(render_context, 8, 10),
    init(render_context, 10, 5),
    init(render_context, 12, 3),
    init(render_context, 15, 8),
    init(render_context, 8, 10),
    init(render_context, 10, 5),
    init(render_context, 12, 3),
    init(render_context, 15, 8),
    init(render_context, 8, 10)
  ]);
  return raf(
    (_) => {
      let _pipe = ctx;
      let _pipe$1 = clearRect(_pipe, new Vector2(0, 0), rect2);
      let _pipe$2 = fillStyle(_pipe$1, "#fffbe8");
      fillRect(_pipe$2, new Vector2(0, 0), rect2);
      each(scene, (ball) => {
        return ball(ctx, render_context);
      });
      return void 0;
    }
  );
}

// build/.lustre/entry.mjs
main();
