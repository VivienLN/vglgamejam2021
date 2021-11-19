/**
	animationStep: anim progression between 0 (not started) and 1 (finished)
	startValue: the starting value of what we need to animate (the value for animation = 0)
	endValue: the end value of what we need to animate (the value for animation = 1)
	easeFunction: the easing function to use
	
	return: the value after easing function applied
**/

function easeValues(animationStep, startValue, endValue, easeFunction) {
	return startValue + (endValue - startValue) * easeFunction(animationStep);
}

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