var gameSpeed = oGameController.gameSpeed;
var comboTimer = oGameController.comboTimer;
if(!oGameController.isGameOver) {
	// Draw trail	
	draw_set_colour($ffff00);
	gpu_set_blendmode(bm_add);
	draw_set_alpha(comboTimer + random_range(-.3, 0));

	for(var i = 0; i < ds_list_size(trailPoints) - 1; i++) {
		var pointX = x - (i * gameSpeed) + trailOffsetX;
		var pointY = trailPoints[|i] + trailOffsetY;
		var nextX = x - ((i + 1) * gameSpeed) + trailOffsetX;
		var nextY = trailPoints[|i + 1] + trailOffsetY;
		draw_line_width(pointX, pointY, nextX, nextY, 6);
	}
	
	// Draw tailwind
	var maxAlpha = .6;
	draw_set_colour($ffffff);
	gpu_set_blendmode(bm_normal);
	for(var i = 0; i < ds_list_size(tailwindPoints) - 1; i++) {
		var lineAlpha = maxAlpha - (i / ds_list_size(tailwindPoints) * maxAlpha);
		draw_set_alpha(lineAlpha);
		
		var pointX = x - (i * gameSpeed) + tailwindOffsetX;
		var pointY = tailwindPoints[|i] + tailwindOffsetY;
		var nextX = x - ((i + 1) * gameSpeed) + tailwindOffsetX;
		var nextY = tailwindPoints[|i + 1] + tailwindOffsetY;
		draw_line_width(pointX, pointY, nextX, nextY, 2);
		
		var point2X = x - (i * gameSpeed) + tailwindOffset2X;
		var point2Y = tailwindPoints[|i] + tailwindOffset2Y;
		var next2X = x - ((i + 1) * gameSpeed) + tailwindOffset2X;
		var next2Y = tailwindPoints[|i + 1] + tailwindOffset2Y;
		draw_line_width(point2X, point2Y, next2X, next2Y, 2);
	}
	
	// Reset draw values
	gpu_set_blendmode(bm_normal);
	draw_set_alpha(1);
}

draw_self();