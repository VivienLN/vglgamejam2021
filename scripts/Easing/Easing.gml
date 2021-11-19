function easeLinear(x) {
	return x;	
}

function easeInSine(x) {
  return 1 - cos((x * pi) / 2);
}

function easeOutSine(x) {
  return sin((x * pi) / 2);
}

function easeInOutSine(x) {
	return -(cos(pi * x) - 1) / 2;
}

function easeInOutCubic(x) {
	return x < .5 ? 4 * x * x * x : 1 - power(-2 * x + 2, 3) / 2;
}