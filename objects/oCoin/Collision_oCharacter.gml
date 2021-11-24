if(isCollected) {
	return;
}
isCollected = true;

with(oGameController) {
	comboTimer = 1;
	scoreMultiplier++;
}

cameraStartShake(10, 2, .1);

var pX = x + 16;
var pY = y;
with(oCharacter) {
	part_type_speed(comboParticle, oGameController.gameSpeed, oGameController.gameSpeed, 0, 0);
	part_emitter_region(comboParticleSystem, comboEmitter, pX, pX, pY, pY, ps_shape_ellipse, ps_distr_linear);
	part_emitter_burst(comboParticleSystem, comboEmitter, comboParticle, 1);
	
	//part_type_shape(comboParticle, pt_shape_ring);
	//part_emitter_burst(comboParticleSystem, comboEmitter, comboParticle, 1);
}