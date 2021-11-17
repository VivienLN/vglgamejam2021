// Note: object is visible ONLY to be able to hook onto Draw Begin event
// Because in Step event, camera is not yet updated
if(global.isTitle) {
	return;	
}

// -----------------------------
// Follow Player
// -----------------------------
var targetY = oCharacter.y + CAMERA_OFFSET_Y;
var cameraX = 0;
var cameraY = camera_get_view_y(CAMERA_DEFAULT);
var cameraHeight = camera_get_view_height(CAMERA_DEFAULT);
var targetScreenY = targetY - cameraY;

// If outside camera bounds, move camera
if(targetScreenY <= CAMERA_BORDER) {
	cameraY = targetY - CAMERA_BORDER;
} else if (targetScreenY >= cameraHeight - CAMERA_BORDER) {
	cameraY = targetY - cameraHeight + CAMERA_BORDER;
}

// -----------------------------
// SCREENSHAKE!!
// -----------------------------
if(screenShakeFrames > 0) {
	cameraX += irandom_range(-screenShakeMagnitude, screenShakeMagnitude);
	cameraY += irandom_range(-screenShakeMagnitude, screenShakeMagnitude);
	screenShakeFrames--;
	screenShakeMagnitude = max(screenShakeMagnitude - screenShakeFade, 0);
}

// -----------------------------
// Update view
// -----------------------------
camera_set_view_pos(CAMERA_DEFAULT, cameraX, cameraY);

// -----------------------------
// Background horizontal scrolling
// -----------------------------
// Set background layers speed according to game speed
layer_hspeed(layer_get_id("Ground"), -global.gameSpeed);
layer_hspeed(layer_get_id("Clouds"), -global.gameSpeed * .01);
layer_hspeed(layer_get_id("Parallax01"), -global.gameSpeed * .2);
layer_hspeed(layer_get_id("Parallax02"), -global.gameSpeed * .5);
layer_hspeed(layer_get_id("Parallax03"), -global.gameSpeed * .8);

// -----------------------------
// Background vertical scrolling
// -----------------------------
var cameraRatio = cameraY / maxCameraY;

var positionSky = ceil(cameraY - cameraRatio * offsetMaxSky);
layer_y(layer_get_id("Sky"), positionSky);

var positionClouds = ceil(cameraY - cameraRatio * offsetMaxClouds);
layer_y(layer_get_id("Clouds"), positionClouds);

var positionParallax01 = ceil(cameraY - cameraRatio * offsetMaxParallax01);
layer_y(layer_get_id("Parallax01"), positionParallax01);

var positionParallax02 = ceil(cameraY - cameraRatio * offsetMaxParallax02);
layer_y(layer_get_id("Parallax02"), positionParallax02);

var positionParallax03 = ceil(cameraY - cameraRatio * offsetMaxParallax03);
layer_y(layer_get_id("Parallax03"), positionParallax03);
