/// @description Insert description here
// You can write your code in this editor
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
	//sprite_index = ySpeed >= 0 ? sCharacterFalling : sCharacterJumping;
	//sprite_index = sCharacterTrick;	
} else if(isDucking || isGrinding) {
	sprite_index = sCharacterDucking;
} else {
	sprite_index = sCharacter;
}