const el = document.getElementById("canvas") as HTMLCanvasElement;
if (!el) {
  throw new Error("Canvas element not found");
}

const ctx = el.getContext("2d");
if (!ctx) {
  throw new Error("2d context not found");
}

ctx.fillRect;
