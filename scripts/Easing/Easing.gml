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

function easeInCubic(x) {
	return x * x * x;
}

function easeOutCubic(x) {
	return 1 - power(1 - x, 3);
}

function easeInOutCubic(x) {
	return x < .5 ? 4 * x * x * x : 1 - power(-2 * x + 2, 3) / 2;
}

function easeInQuint(x) {
	return x * x * x * x * x;
}

function easeOutQuint(x) {
	return 1 - power(1 - x, 5);
}

function easeInOutQuint(x) {
	return x < .5 ? 16 * x * x * x * x * x : 1 - power(-2 * x + 2, 5) / 2;
}

function easeInCirc(x) {
	return 1 - sqrt(1 - power(x, 2));
}

function easeOutCirc(x) {
	return sqrt(1 - power(x - 1, 2));
}

function easeInOutCirc(x) {
	return x < .5
	  ? (1 - sqrt(1 - power(2 * x, 2))) / 2
	  : (sqrt(1 - power(-2 * x + 2, 2)) + 1) / 2;
}

function easeInElastic(x) {
	var c = (2 * pi) / 3;
	
	if(x == 0) return 0;
	if(x == 1) return 1;
	else return -power(2, 10 * x - 10) * sin((x * 10 - 10.75) * c);
}

function easeOutElastic(x) {
	var c = (2 * pi) / 3;
	
	if(x == 0) return 0;
	if(x == 1) return 1;
	else return power(2, -10 * x) * sin((x * 10 - .75) * c) + 1;
}

function easeInOutElastic(x) {
	var c = (2 * pi) / 4.5;
	
	if(x == 0) return 0;
	if(x == 1) return 1;
	if(x < .5) return -(power(2, 20 * x - 10) * sin((20 * x - 11.125) * c)) / 2;
	else return (power(2, -20 * x + 10) * sin((20 * x - 11.125) * c)) / 2 + 1;
}

function easeInQuad(x) {
	return x * x;
}

function easeOutQuad(x) {
	return 1 - (1 - x) * (1 - x);
}

function easeInOutQuad(x) {
	return x < .5 ? 2 * x * x : 1 - power(-2 * x + 2, 2) / 2;
}

function easeInQuart(x) {
	return x * x * x * x;
}

function easeOutQuart(x) {
	return 1 - power(1 - x, 4);
}

function easeInOutQuart(x) {
	return x < .5 ? 8 * x * x * x * x : 1 - power(-2 * x + 2, 4) / 2;
}

function easeInExpo(x) {
	return x == 0 ? 0 : power(2, 10 * x - 10);
}

function easeOutExpo(x) {
	return x == 1 ? 1 : 1 - power(2, -10 * x);
}

function easeInOutExpo(x) {
	if(x == 0) return 0;
	if(x == 1) return 1;
	if(x < .5) return power(2, 20 * x - 10) / 2;
	else return (2 - power(2, -20 * x + 10)) / 2;
}

function easeInBack(x) {
	var c = 1.70158;
	return (c + 1) * x * x * x - c * x * x;
}

function easeOutBack(x) {
	var c = 1.70158;

	return 1 + (c + 1) * power(x - 1, 3) + c * power(x - 1, 2);
}

function easeInOutBack(x) {
	var c1 = 1.70158;
	var c2 = c1 * 1.525;
	
	if(x < .5) return (power(2 * x, 2) * ((c2 + 1) * 2 * x - c2)) / 2;
	else return (power(2 * x - 2, 2) * ((c2 + 1) * (x * 2 - 2) + c2) + 2) / 2;
}