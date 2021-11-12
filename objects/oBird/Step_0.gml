// If outside of screen, reinitialize position
if(x > room_width) {
	// Note: no need to reset X, it's done in HandleMapPart scripts
	y = initialY;	
	sprite_index = sBird;
	ySpeed = irandom_range(4, 10);
	xSpeed = irandom_range(8, 12);
	targetX = irandom_range(280, 400);
}

// When getting close to player, fly away
if(x <= targetX) {
	y -= ySpeed;
	x += xSpeed - global.gameSpeed;
	sprite_index = sBirdFlying;
}