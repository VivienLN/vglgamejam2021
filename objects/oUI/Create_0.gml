blink = false;

function floatingText(value, textX, textY) {
	var text = ds_map_create();
	text[? "value"] = value;
	text[? "x"] = textX;
	text[? "y"] = textY;
	
	ds_list_add(floatingTexts, text);
	// TODO: tween
}