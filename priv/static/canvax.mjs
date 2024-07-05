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
function prepend(element, tail) {
  return new NonEmpty(element, tail);
}
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

// build/dev/javascript/gleam_stdlib/gleam/order.mjs
var Lt = class extends CustomType {
};
var Eq = class extends CustomType {
};
var Gt = class extends CustomType {
};

// build/dev/javascript/gleam_stdlib/gleam/int.mjs
function to_string2(x) {
  return to_string(x);
}
function compare(a, b) {
  let $ = a === b;
  if ($) {
    return new Eq();
  } else {
    let $1 = a < b;
    if ($1) {
      return new Lt();
    } else {
      return new Gt();
    }
  }
}

// build/dev/javascript/gleam_stdlib/gleam/list.mjs
function do_reverse(loop$remaining, loop$accumulator) {
  while (true) {
    let remaining = loop$remaining;
    let accumulator = loop$accumulator;
    if (remaining.hasLength(0)) {
      return accumulator;
    } else {
      let item = remaining.head;
      let rest$1 = remaining.tail;
      loop$remaining = rest$1;
      loop$accumulator = prepend(item, accumulator);
    }
  }
}
function reverse(xs) {
  return do_reverse(xs, toList([]));
}
function do_map(loop$list, loop$fun, loop$acc) {
  while (true) {
    let list = loop$list;
    let fun = loop$fun;
    let acc = loop$acc;
    if (list.hasLength(0)) {
      return reverse(acc);
    } else {
      let x = list.head;
      let xs = list.tail;
      loop$list = xs;
      loop$fun = fun;
      loop$acc = prepend(fun(x), acc);
    }
  }
}
function map(list, fun) {
  return do_map(list, fun, toList([]));
}
function do_append(loop$first, loop$second) {
  while (true) {
    let first = loop$first;
    let second = loop$second;
    if (first.hasLength(0)) {
      return second;
    } else {
      let item = first.head;
      let rest$1 = first.tail;
      loop$first = rest$1;
      loop$second = prepend(item, second);
    }
  }
}
function append(first, second) {
  return do_append(reverse(first), second);
}
function tail_recursive_range(loop$start, loop$stop, loop$acc) {
  while (true) {
    let start = loop$start;
    let stop = loop$stop;
    let acc = loop$acc;
    let $ = compare(start, stop);
    if ($ instanceof Eq) {
      return prepend(stop, acc);
    } else if ($ instanceof Gt) {
      loop$start = start;
      loop$stop = stop + 1;
      loop$acc = prepend(stop, acc);
    } else {
      loop$start = start;
      loop$stop = stop - 1;
      loop$acc = prepend(stop, acc);
    }
  }
}
function range(start, stop) {
  return tail_recursive_range(start, stop, toList([]));
}
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

// build/dev/javascript/gleam_stdlib/dict.mjs
var tempDataView = new DataView(new ArrayBuffer(8));
var SHIFT = 5;
var BUCKET_SIZE = Math.pow(2, SHIFT);
var MASK = BUCKET_SIZE - 1;
var MAX_INDEX_NODE = BUCKET_SIZE / 2;
var MIN_ARRAY_NODE = BUCKET_SIZE / 4;

// build/dev/javascript/gleam_stdlib/gleam_stdlib.mjs
function to_string(term) {
  return term.toString();
}
function join(xs, separator) {
  const iterator = xs[Symbol.iterator]();
  let result = iterator.next().value || "";
  let current = iterator.next();
  while (!current.done) {
    result = result + separator + current.value;
    current = iterator.next();
  }
  return result;
}
function round2(float) {
  return Math.round(float);
}
function random_uniform() {
  const random_uniform_result = Math.random();
  if (random_uniform_result === 1) {
    return random_uniform();
  }
  return random_uniform_result;
}

// build/dev/javascript/gleam_stdlib/gleam/float.mjs
function min(a, b) {
  let $ = a < b;
  if ($) {
    return a;
  } else {
    return b;
  }
}
function max(a, b) {
  let $ = a > b;
  if ($) {
    return a;
  } else {
    return b;
  }
}
function clamp(x, min_bound, max_bound) {
  let _pipe = x;
  let _pipe$1 = min(_pipe, max_bound);
  return max(_pipe$1, min_bound);
}
function negate(x) {
  return -1 * x;
}
function do_round(x) {
  let $ = x >= 0;
  if ($) {
    return round2(x);
  } else {
    return 0 - round2(negate(x));
  }
}
function round(x) {
  return do_round(x);
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
function mul(v, s) {
  return new Vector2(v.x * s, v.y * s);
}
function div(v, s) {
  return new Vector2(divideFloat(v.x, s), divideFloat(v.y, s));
}
function rand2() {
  return new Vector2(random_uniform() - 0.5, random_uniform() - 0.5);
}
function negate2(v) {
  return new Vector2(negate(v.x), negate(v.y));
}

// build/dev/javascript/canvax/app/render_context.mjs
var RenderContext = class extends CustomType {
  constructor(viewport) {
    super();
    this.viewport = viewport;
  }
};

// build/dev/javascript/canvax/document.ffi.mjs
function getElementById(id) {
  const $el = document.getElementById(id);
  return $el ? new Ok($el) : new Error(null);
}
function raf(callback) {
  let delta = 0;
  const render5 = () => {
    callback(++delta);
    requestAnimationFrame(render5);
  };
  requestAnimationFrame(render5);
}

// build/dev/javascript/canvax/context.ffi.mjs
function getContext($el, options) {
  const ctx = $el.getContext("2d", options);
  return ctx ? new Ok(ctx) : new Error(null);
}
function save(ctx) {
  ctx.save();
  return ctx;
}
function restore(ctx) {
  ctx.restore();
  return ctx;
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
function rect(ctx, pos, size) {
  ctx.rect(pos.x, pos.y, size.x, size.y);
  return ctx;
}
function rotate(ctx, angle2) {
  ctx.rotate(angle2);
  return ctx;
}
function translate(ctx, pos) {
  ctx.translate(pos.x, pos.y);
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

// build/dev/javascript/canvax/app/background.mjs
var Model = class extends CustomType {
};
var Noop = class extends CustomType {
};
function frame(_, _1) {
  return new Noop();
}
function update(_, model, _1) {
  return model;
}
function render2(ctx, _, render_context) {
  let _pipe = ctx;
  let _pipe$1 = clearRect(
    _pipe,
    new Vector2(0, 0),
    render_context.viewport
  );
  let _pipe$2 = fillStyle(_pipe$1, "#fffbe8");
  fillRect(_pipe$2, new Vector2(0, 0), render_context.viewport);
  return void 0;
}
function init(_) {
  let _pipe = new Model();
  return create_node(_pipe, frame, update, render2);
}

// build/dev/javascript/gleam_community_maths/maths.mjs
function pi() {
  return Math.PI;
}

// build/dev/javascript/gleam_community_maths/gleam_community/maths/elementary.mjs
function pi2() {
  return pi();
}

// build/dev/javascript/canvax/app/ball.mjs
var Model2 = class extends CustomType {
  constructor(pos, direction, radius, velocity, color) {
    super();
    this.pos = pos;
    this.direction = direction;
    this.radius = radius;
    this.velocity = velocity;
    this.color = color;
  }
};
var Move = class extends CustomType {
};
var BounceX = class extends CustomType {
};
var BounceY = class extends CustomType {
};
function frame2(model, render_context) {
  let width = render_context.viewport.x;
  let height = render_context.viewport.y;
  let x = model.pos.x;
  let y = model.pos.y;
  let dx = model.direction.x * model.velocity;
  let dy = model.direction.y * model.velocity;
  let bounce_right = x + dx >= width - model.radius;
  let bounce_left = x + dx <= model.radius;
  let bounce_top = y + dy >= height - model.radius;
  let bounce_bottom = y + dy <= model.radius;
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
function update2(msg, model, _) {
  if (msg instanceof Move) {
    let next_velocity = (() => {
      let $ = model.velocity - 0.01;
      if ($ < 0.1) {
        let x = $;
        return 0.1;
      } else {
        return model.velocity - 0.01;
      }
    })();
    return model.withFields({
      pos: (() => {
        let _pipe = mul(model.direction, model.velocity);
        return add2(_pipe, model.pos);
      })(),
      velocity: next_velocity
    });
  } else if (msg instanceof BounceX) {
    return model.withFields({
      direction: new Vector2(
        negate(model.direction.x),
        model.direction.y
      )
    });
  } else {
    return model.withFields({
      direction: new Vector2(
        model.direction.x,
        negate(model.direction.y)
      )
    });
  }
}
function render3(ctx, model, _) {
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
      let _pipe$2 = fillStyle(_pipe$1, model.color);
      let _pipe$3 = fill(_pipe$2);
      let _pipe$4 = strokeStyle(_pipe$3, "#000");
      return stroke(_pipe$4);
    }
  );
  return void 0;
}
function init2(_, pos, dir, r, v, c) {
  let _pipe = new Model2(pos, dir, r, v, c);
  return create_node(_pipe, frame2, update2, render3);
}

// build/dev/javascript/canvax/app/square.mjs
var Model3 = class extends CustomType {
  constructor(pos, size, velocity, color, angle2) {
    super();
    this.pos = pos;
    this.size = size;
    this.velocity = velocity;
    this.color = color;
    this.angle = angle2;
  }
};
var Noop2 = class extends CustomType {
};
function frame3(_, _1) {
  return new Noop2();
}
function update3(_, model, _1) {
  let next_angle = model.angle + 1;
  if (next_angle > 360) {
    let a = next_angle;
    return model.withFields({ angle: 0 });
  } else {
    return model.withFields({ angle: next_angle });
  }
}
function render4(ctx, model, _) {
  let offset = (() => {
    let _pipe2 = new Vector2(model.size, model.size);
    return div(_pipe2, 2);
  })();
  let translate_to = (() => {
    let _pipe2 = model.pos;
    return add2(_pipe2, offset);
  })();
  let angle2 = divideFloat(model.angle * pi2(), 180) * model.velocity;
  let _pipe = ctx;
  let _pipe$1 = save(_pipe);
  let _pipe$2 = translate(_pipe$1, translate_to);
  let _pipe$3 = rotate(_pipe$2, angle2);
  let _pipe$4 = translate(
    _pipe$3,
    (() => {
      let _pipe$42 = translate_to;
      return negate2(_pipe$42);
    })()
  );
  let _pipe$5 = with_path(
    _pipe$4,
    (_2) => {
      let _pipe$52 = ctx;
      let _pipe$6 = rect(
        _pipe$52,
        model.pos,
        new Vector2(model.size, model.size)
      );
      let _pipe$7 = fillStyle(_pipe$6, model.color);
      let _pipe$8 = fill(_pipe$7);
      let _pipe$9 = strokeStyle(_pipe$8, "#000");
      return stroke(_pipe$9);
    }
  );
  restore(_pipe$5);
  return void 0;
}
function init3(_, pos, size, velocity, color) {
  let _pipe = new Model3(pos, size, velocity, color, 0);
  return create_node(_pipe, frame3, update3, render4);
}

// build/dev/javascript/gleam_stdlib/gleam/string.mjs
function join2(strings, separator) {
  return join(strings, separator);
}

// build/dev/javascript/canvax/canvax/primitives/color.mjs
function random_color_part() {
  let _pipe = random_uniform() * 255;
  let _pipe$1 = round(_pipe);
  return to_string2(_pipe$1);
}
function random_color() {
  return "rgb(" + (() => {
    let _pipe = toList([
      random_color_part(),
      random_color_part(),
      random_color_part()
    ]);
    return join2(_pipe, ",");
  })() + ")";
}

// build/dev/javascript/canvax/canvax.mjs
function random_pos(base, size) {
  let _pipe = random_uniform() * base;
  return clamp(_pipe, size, base - size);
}
function main() {
  let $ = getElementById("canvas");
  if (!$.isOk()) {
    throw makeError(
      "assignment_no_match",
      "canvax",
      20,
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
      21,
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
      22,
      "main",
      "Assignment pattern did not match",
      { value: $2 }
    );
  }
  let ctx = $2[0];
  let render_context = new RenderContext(rect2);
  let viewport_center = div(render_context.viewport, 2);
  let create_square = () => {
    let size = (() => {
      let _pipe = random_uniform() * 50;
      return clamp(_pipe, 25, 50);
    })();
    let velocity = (() => {
      let _pipe = random_uniform() * 10;
      return clamp(_pipe, 1.1, 10);
    })();
    return init3(
      render_context,
      new Vector2(
        random_pos(render_context.viewport.x, size),
        random_pos(render_context.viewport.y, size)
      ),
      size,
      velocity,
      random_color()
    );
  };
  let create_ball = () => {
    let radius = (() => {
      let _pipe = random_uniform() * 10;
      return clamp(_pipe, 5, 10);
    })();
    let velocity = (() => {
      let _pipe = random_uniform() * 5;
      return clamp(_pipe, 5, 10);
    })();
    return init2(
      render_context,
      (() => {
        let _pipe = viewport_center;
        return add2(_pipe, new Vector2(radius, radius));
      })(),
      (() => {
        let _pipe = rand2();
        return mul(_pipe, velocity);
      })(),
      radius,
      velocity,
      random_color()
    );
  };
  let scene = (() => {
    let _pipe = toList([init(render_context)]);
    let _pipe$1 = append(
      _pipe,
      (() => {
        let _pipe$12 = range(0, 50);
        return map(_pipe$12, (_) => {
          return create_square();
        });
      })()
    );
    return append(
      _pipe$1,
      (() => {
        let _pipe$2 = range(0, 500);
        return map(_pipe$2, (_) => {
          return create_ball();
        });
      })()
    );
  })();
  return raf(
    (_) => {
      each(scene, (ball) => {
        return ball(ctx, render_context);
      });
      return void 0;
    }
  );
}

// build/.lustre/entry.mjs
main();
