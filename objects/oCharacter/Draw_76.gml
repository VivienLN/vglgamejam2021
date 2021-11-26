if(isGliding) {
	sprite_index = sCharacterGliding;
} else if(isBigJump) {
	sprite_index = sCharacterTrick;
} else if(isFalling) {
	if(ySpeed >= 0) {
		sprite_index = sCharacterFalling;
	} else {
		sprite_index = sCharacterJumping;
	}
} else if(isDucking) {
	sprite_index = sCharacterDucking;
} else if(isGrinding) {
	sprite_index = grindType[? "animation"];
} else {
	sprite_index = sCharacter;
}