function floatingText(text, x, y, duration) {
	var instance;
	var instanceX = x - camera_get_view_x(CAMERA_DEFAULT);
	var instanceY = y - camera_get_view_y(CAMERA_DEFAULT);
	instance = instance_create_depth(instanceX, instanceY, -1000, oFloatingText);
	instance.text = text;
	tween(instance, "y", instanceY, (instanceY-120), duration, easeOutQuad);
	tween(instance, "textAlpha", 1, 0, duration, easeOutQuad);
}