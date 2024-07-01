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
    let length = 0;
    for (let _ of this)
      length++;
    return length;
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

// build/dev/javascript/gleam_stdlib/gleam/option.mjs
var None = class extends CustomType {
};

// build/dev/javascript/canvax/canvas.ffi.mjs
function getContext($el, contextId, options) {
  const ctx = $el.getContext(contextId, options);
  return ctx ? new Ok(ctx) : new Error(null);
}
function fillRect(ctx, pos, size, style) {
  ctx.fillStyle = style;
  ctx.fillRect(pos.x, pos.y, size.x, size.y);
}

// build/dev/javascript/canvax/document.ffi.mjs
function getElementById(id) {
  const $el = document.getElementById(id);
  return $el ? new Ok($el) : new Error(null);
}

// build/dev/javascript/canvax/canvax/primitive.mjs
var Vector2 = class extends CustomType {
  constructor(x, y) {
    super();
    this.x = x;
    this.y = y;
  }
};

// build/dev/javascript/canvax/canvax/canvas.mjs
var ContextType2D = class extends CustomType {
};
var ContextTypeVitmapRenderer = class extends CustomType {
};
var ContextTypeWebGL = class extends CustomType {
};
function canvas_context_type(context) {
  if (context instanceof ContextType2D) {
    return "2d";
  } else if (context instanceof ContextTypeVitmapRenderer) {
    return "bitmaprenderer";
  } else if (context instanceof ContextTypeWebGL) {
    return "webgl";
  } else {
    return "webgl2";
  }
}
function get_context(canvas_el, context_id, settings) {
  let ctx_type = canvas_context_type(context_id);
  return getContext(canvas_el, ctx_type, settings);
}

// build/dev/javascript/canvax/canvax.mjs
function main() {
  let $ = getElementById("canvas");
  if (!$.isOk()) {
    throw makeError(
      "assignment_no_match",
      "canvax",
      7,
      "main",
      "Assignment pattern did not match",
      { value: $ }
    );
  }
  let el = $[0];
  let $1 = get_context(el, new ContextType2D(), new None());
  if (!$1.isOk()) {
    throw makeError(
      "assignment_no_match",
      "canvax",
      8,
      "main",
      "Assignment pattern did not match",
      { value: $1 }
    );
  }
  let ctx = $1[0];
  let _pipe = ctx;
  return fillRect(
    _pipe,
    new Vector2(50, 50),
    new Vector2(100, 100),
    "rgba(128, 0, 0, 0.5)"
  );
}

// build/.lustre/entry.mjs
main();
