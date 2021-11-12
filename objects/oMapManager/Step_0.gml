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

// Move map parts
moveAllMapParts(-global.gameSpeed);