function cameraStartShake(frames, magnitude, fade = 0) {
	with(oCameraManager) {
		startShake(frames, magnitude, fade);
	}
}

function gameEnqueueSpeedAlteration(endValue, duration, easing, cancelOthers = false) {
	with(oGameController) {
		enqueueSpeedAlteration(endValue, duration, easing, cancelOthers);
	}
}