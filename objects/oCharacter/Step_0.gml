// -----------------------------
// Controls
// -----------------------------
jumpFrames--;
duckRecoveryFrames--;
grindRecoveryFrames--;

// -----------------------------
// Game Over
// -----------------------------
if(oGameController.isGameOver) {
	return;
}

// -----------------------------
// Title
// -----------------------------
if(oGameController.isTitle) {
	return;
}

// -----------------------------
// Ground collision
// -----------------------------
var newY = y + ySpeed;

// collision with ground
lastIsOnGround = isOnGround;
isOnGround = false;
// Collision with Ground object
while(place_meeting(x, newY, oMapGroundGroup)) {
	newY--;
	// Now we can update "isOnGround"
	isOnGround = true;
}

// -----------------------------
// Check keys
// -----------------------------
if(!inputJump()) {
	mustReleaseJump = false;
}
if(!inputDuck()) {
	mustReleaseDuck = false;
}

// -----------------------------
// Grinding collision
// -----------------------------
var lastIsGrinding = isGrinding;
isGrinding = false;
if(!isOnGround && inputGrind()) {
	while(place_meeting(x, newY, oMapGrindablesGroup)) {
		newY--;
		isGrinding = true;
		grindRecoveryFrames = maxGrindRecoveryFrames;
	}
}

if(!lastIsGrinding && isGrinding) {
	var pX = x + sprite_width;
	var pY = y + sprite_height;
	part_type_speed(comboParticle, oGameController.gameSpeed, oGameController.gameSpeed, 0, 0);
	part_emitter_region(comboParticleSystem, comboEmitter, pX, pX, pY, pY, ps_shape_ellipse, ps_distr_linear);
	part_emitter_burst(comboParticleSystem, comboEmitter, comboParticle, 1);
	
	// Grind types
	if(inputDown()) {
		grindType = grindTypeDown;
	} else if(inputLeft()) {
		grindType = grindTypeLeft;
	} else if(inputUp()) {
		grindType = grindTypeUp;
	} else if(inputRight()) {
		grindType = grindTypeRight;
	} else {
		grindType = grindTypeNeutral;
	}
	
	// Show trick name (debug)
	show_debug_message(grindType[? "name"]);
	floatingText(grindType[? "name"], x, y, 120);
}

// -----------------------------
// Flags
// -----------------------------
// JustLanded is always false if we were on the ground in the last frame
var hasJustLanded = (!lastIsOnGround && isOnGround);

if(isOnGround) {
	canJump = !mustReleaseJump;
	canDuck = !mustReleaseDuck;
	canGlide = false;
	isFalling = false;
} else {
	canJump = !mustReleaseJump && (isGrinding || grindRecoveryFrames > 0);
	canDuck = false;
	canGlide = !canJump && !mustReleaseJump;
	isFalling = !isGrinding;
}

// "Cancel big jump"
if(isGliding || isGrinding || isOnGround) {
	isBigJump = false;
}

// -----------------------------
// Gliding
// -----------------------------
isGliding = canGlide && inputJump();

// -----------------------------
// Update position and speed for next frame
// -----------------------------
y = newY;
if(isGliding) {
	ySpeed = glidingYSpeed + random_range(-glidingYSpeedVariation, glidingYSpeedVariation);
} else {
	ySpeed = min(ySpeed + grav, maxYspeed);
}

// -----------------------------
// Jumping
// -----------------------------
if(inputJump()) {
	if(canJump) {
		mustReleaseJump = true;
		mustReleaseDuck = true;
		if(duckRecoveryFrames > 0 || grindRecoveryFrames > 0) {
			isBigJump = true;
		}
		jumpFrames = maxJumpFrames;
		duckRecoveryFrames = 0;
		grindRecoveryFrames = 0;
	}
	jumpSpeed = isBigJump ? bigJumpSpeed : baseJumpSpeed;
	if(jumpFrames > 0) {
		ySpeed = -jumpSpeed;
	}
}

// -----------------------------
// Ducking
// -----------------------------
isDucking = canDuck && inputDuck();

// -----------------------------
// Recovery for ducking / grinding and big jump
// -----------------------------
if(isDucking || isGrinding) {
	duckRecoveryFrames = maxDuckRecoveryFrames;
}

// -----------------------------
// Trail
// -----------------------------
ds_list_insert(trailPoints, 0, y);
var trailPointsNumber = ceil((x + trailOffsetX) / oGameController.gameSpeed) + 1;
while(ds_list_size(trailPoints) > trailPointsNumber) {
	ds_list_delete(trailPoints, ds_list_size(trailPoints) - 1);
}

// -----------------------------
// Tailwind (same principle)
// -----------------------------
if(isGliding) {
	var tailwindY = y;
	var tailwindSize = .8; // If 1, takes all the place between player and border of screen
	ds_list_insert(tailwindPoints, 0, tailwindY);
	var tailwindPointsNumber = ceil(((x + tailwindOffsetX) / oGameController.gameSpeed) * tailwindSize) + 1;
	while(ds_list_size(tailwindPoints) > tailwindPointsNumber) {
		ds_list_delete(tailwindPoints, ds_list_size(tailwindPoints) - 1);
	}
} else {
	ds_list_delete(tailwindPoints, 0);
	ds_list_delete(tailwindPoints, ds_list_size(tailwindPoints) - 1);
}

// -----------------------------
// Particles
// -----------------------------
if(hasJustLanded) {
	cameraStartShake(10, 3, .1);
	vibrate(.2, .2, 0, 0, 20, easeLinear);
	part_emitter_region(trailParticleSystem, trailEmitter, x+22, x+52, y+46, y+76, ps_shape_ellipse, ps_distr_gaussian);
	part_emitter_burst(trailParticleSystem, trailEmitter, landingParticle, 50);	
} else if(isGrinding) {
	cameraStartShake(2, 6, 1);
	part_emitter_region(trailParticleSystem, trailEmitter, x, x+52, y+66, y+66, ps_shape_line, ps_distr_gaussian);
	part_emitter_stream(trailParticleSystem, trailEmitter, grindParticle, 6);
} else {
	part_emitter_region(trailParticleSystem, trailEmitter, x, x+52, y+66, y+66, ps_shape_line, ps_distr_gaussian);
	part_emitter_stream(trailParticleSystem, trailEmitter, trailParticle, isOnGround ? 2 : 0);
}


// -----------------------------
// Check Game over
// -----------------------------
if(place_meeting(x, y, oMapObstaclesGroup)) {
	show_debug_message("Game over!");
	cameraStartShake(30, 8, .02);
	part_system_clear(trailParticleSystem);
	part_particles_clear(trailParticle);
	part_particles_clear(grindParticle);
	part_particles_clear(landingParticle);
	part_emitter_clear(trailParticleSystem, trailEmitter);
	
	if(GAME_OVER_ENABLED) {
		with(oGameController) {
			isGameOver = true;
		}	
	}
}