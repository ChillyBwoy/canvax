export function now() {
  return Date.now();
}

export function toISOString(date) {
  return new Date(date).toISOString();
}
