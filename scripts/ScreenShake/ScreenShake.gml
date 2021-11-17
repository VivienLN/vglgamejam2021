function startScreenShake(frames, magnitude, fade = 0) {
	with(oCameraManager) {
		startShake(frames, magnitude, fade);
	}
}