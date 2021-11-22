if(global.isTitle) {
	return;	
}

// Move map parts
with(oGameController) {
	other.moveAllMapParts(-gameSpeed);
}