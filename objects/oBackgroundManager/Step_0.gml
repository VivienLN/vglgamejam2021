if(global.isTitle) {
	return;	
}

// -----------------------------
// Horizontal scrolling
// -----------------------------
// Set background layers speed according to game speed
layer_hspeed(layer_get_id("Ground"), -global.gameSpeed);
layer_hspeed(layer_get_id("Clouds"), -global.gameSpeed * .01);
layer_hspeed(layer_get_id("Parallax01"), -global.gameSpeed * .2);
layer_hspeed(layer_get_id("Parallax02"), -global.gameSpeed * .5);
layer_hspeed(layer_get_id("Parallax03"), -global.gameSpeed * .8);

// -----------------------------
// Vertical scrolling
// -----------------------------
var cameraY = camera_get_view_y(view_camera[0]);
var cameraRatio = cameraY / maxCameraY;
show_debug_message(cameraRatio);


var positionSky = cameraY - cameraRatio * offsetMaxSky;
layer_y(layer_get_id("Sky"), cameraY);

var positionClouds = cameraY - cameraRatio * offsetMaxClouds;
layer_y(layer_get_id("Clouds"), positionClouds);

var positionParallax01 = cameraY - cameraRatio * offsetMaxParallax01;
layer_y(layer_get_id("Parallax01"), positionParallax01);

var positionParallax02 = cameraY - cameraRatio * offsetMaxParallax02;
layer_y(layer_get_id("Parallax02"), positionParallax02);

var positionParallax03 = cameraY - cameraRatio * offsetMaxParallax03;
layer_y(layer_get_id("Parallax03"), positionParallax03);
