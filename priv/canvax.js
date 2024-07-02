"use strict";
function drawBall(ctx, x, y, radius) {
    ctx.beginPath();
    ctx.arc(x, y, radius, 0, 2 * Math.PI);
    ctx.fillStyle = "#f00";
    ctx.fill();
    ctx.closePath();
}
function render(ctx, state) {
    ctx.clearRect(0, 0, state.width, state.height);
    ctx.fillStyle = "rgb(128, 128, 128)";
    ctx.fillRect(0, 0, state.width, state.height);
    ctx.fillStyle = "rgb(255, 255, 255)";
    drawBall(ctx, state.x, state.y, state.ballRadius);
    if (state.x + state.dx > state.width - state.ballRadius ||
        state.x + state.dx < state.ballRadius) {
        state.dx = -state.dx;
    }
    if (state.y + state.dy > state.height - state.ballRadius ||
        state.y + state.dy < state.ballRadius) {
        state.dy = -state.dy;
    }
    state.x += state.dx;
    state.y += state.dy;
}
function main() {
    const $canvas = document.getElementById("canvas");
    if (!$canvas) {
        throw new Error("Canvas not found");
    }
    const ctx = $canvas.getContext("2d");
    if (!ctx) {
        throw new Error("Canvas context not found");
    }
    const state = {
        x: ctx.canvas.width / 2,
        y: ctx.canvas.height / 10,
        dx: 5,
        dy: 5,
        ballRadius: 10,
        width: ctx.canvas.width,
        height: ctx.canvas.height,
    };
    function draw() {
        if (!ctx) {
            return;
        }
        render(ctx, state);
        requestAnimationFrame(draw);
    }
    draw();
}
main();
