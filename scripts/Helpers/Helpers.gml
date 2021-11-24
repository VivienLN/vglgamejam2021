function cameraStartShake(frames, magnitude, fade = 0) {
	with(oCameraManager) {
		startShake(frames, magnitude, fade);
	}
}

function vibrate(leftFrom, rightFrom, leftTo, rightTo, duration, easing) {
	with(oGameController) {
		padVibrate(leftFrom, rightFrom, leftTo, rightTo, duration, easing);	
	}
}