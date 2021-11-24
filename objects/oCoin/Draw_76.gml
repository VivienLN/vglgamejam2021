if(isCollected && sprite_index != sCoinCollect) {
	image_index = 0;
}
sprite_index = isCollected ? sCoinCollect : sCoin;

if(sprite_index == sCoinCollect && image_index >= image_number) {
	image_speed = 0;
} else {
	image_speed = 1;
}