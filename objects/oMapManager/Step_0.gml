if(global.isTitle) {
	return;	
}

// -----------------------------
// Map scrolling
// -----------------------------
// Set background layers speed according to game speed
layer_hspeed(layer_get_id("Ground"), -global.gameSpeed);
layer_hspeed(layer_get_id("Parallax01"), -global.gameSpeed * .1);
layer_hspeed(layer_get_id("Parallax02"), -global.gameSpeed * .5);
layer_hspeed(layer_get_id("Parallax03"), -global.gameSpeed * .9);

// Set Y to follow camera
//layer_y(layer_get_id("Ground"), camera_get_view_y(view_camera[0]));
layer_y(layer_get_id("Sky"), camera_get_view_y(view_camera[0]));
layer_y(layer_get_id("Parallax01"), camera_get_view_y(view_camera[0]) + 60);
layer_y(layer_get_id("Parallax02"), camera_get_view_y(view_camera[0]));
layer_y(layer_get_id("Parallax03"), camera_get_view_y(view_camera[0]) - 30);

// Move map parts
moveAllMapParts(-global.gameSpeed);