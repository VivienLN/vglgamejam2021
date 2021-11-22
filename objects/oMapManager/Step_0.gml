// Move map parts
with(oGameController) {
	if(isTitle) {
		return;	
	}
	other.moveAllMapParts(-gameSpeed);
}