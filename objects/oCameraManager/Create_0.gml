maxCameraY = room_height - camera_get_view_height(CAMERA_DEFAULT);

screenShakeFrames = 0;
screenShakeMagnitude = 0;
screenShakeFade = 0;

offsetMaxSky = 0;
offsetMaxClouds = 50;
offsetMaxParallax01 = 150;
offsetMaxParallax02 = 500;
offsetMaxParallax03 = 800;

function startShake(frames, magnitude, fade = 0){
	screenShakeFrames = frames;
	screenShakeMagnitude = magnitude;
	screenShakeFade = fade;
}
