// -----------------------------
// Controls
// -----------------------------
jumpFrames--;
duckRecoveryFrames--;
grindRecoveryFrames--;

// Game Over
if(global.isGameOver) {
	return;	
}

// Title
if(global.isTitle) {
	return;	
}

// Grinding
isGrinding = (canGrindInstance != noone) && keyboard_check(KEY_DUCK);
if(isGrinding) {
	grindRecoveryFrames = maxGrindRecoveryFrames;
}

// Jumping
if(keyboard_check(KEY_JUMP)) {
	if(canJump) {
		if(duckRecoveryFrames > 0 || grindRecoveryFrames > 0) {
			isBigJump = true;
		}
		jumpSpeed = isBigJump ? bigJumpSpeed : baseJumpSpeed;
		jumpFrames = maxJumpFrames;
		duckRecoveryFrames = 0;
		grindRecoveryFrames = 0;
	}
	if(jumpFrames > 0) {
		ySpeed = -jumpSpeed;
	}
}

// Ducking
if(canDuck) {
	isDucking = keyboard_check(KEY_DUCK);
}

// Gliding
isGliding = canGlide && keyboard_check(KEY_JUMP);

// Recovery for ducking / grinding and big jump
if(isDucking || isGrinding) {
	duckRecoveryFrames = maxDuckRecoveryFrames;
}

// Trail
ds_list_insert(trailPoints, 0, y);
var trailPointsNumber = ceil((x + trailOffsetX) / global.gameSpeed) + 1;
while(ds_list_size(trailPoints) > trailPointsNumber) {
	ds_list_delete(trailPoints, ds_list_size(trailPoints) - 1);
}

// Tailwind (same principle)
if(isGliding) {
	var tailwindY = y;
	var tailwindSize = .8; // If 1, takes all the place between player and border of screen
	ds_list_insert(tailwindPoints, 0, tailwindY);
	var tailwindPointsNumber = ceil(((x + tailwindOffsetX) / global.gameSpeed) * tailwindSize) + 1;
	while(ds_list_size(tailwindPoints) > tailwindPointsNumber) {
		ds_list_delete(tailwindPoints, ds_list_size(tailwindPoints) - 1);
	}
} else {
	ds_list_delete(tailwindPoints, 0);
	ds_list_delete(tailwindPoints, ds_list_size(tailwindPoints) - 1);
}

// -----------------------------
// Update position
// -----------------------------
if(isGrinding) {
	ySpeed = 0;
	var newY = canGrindInstance.y + canGrindInstance.grindY - sprite_height;
} else {
	ySpeed = isGliding ? glidingYSpeed + random_range(-glidingYSpeedVariation, glidingYSpeedVariation) : min(ySpeed + grav, maxYspeed);
	var newY = y + (ySpeed);

	// collision with ground
	lastIsOnGround = isOnGround;
	isOnGround = false;
	// Collision with Ground object
	while(place_meeting(x, newY, oMapGroundGroup)) {
		newY--;
		// Now we can update "isOnGround"
		isOnGround = true;
	}	
}

// JustLanded is always false if we were on the ground in the last frame
var hasJustLanded = (!lastIsOnGround && isOnGround);

// Flags
if(isOnGround) {
	canJump = !keyboard_check(KEY_JUMP);
	canDuck = true;
	canGlide = false;
	isFalling = false;
	canGrindInstance = noone;
} else {
	canJump = isGrinding || grindRecoveryFrames > 0;
	canDuck = false;
	canGlide = !canJump && (isGliding || !keyboard_check(KEY_JUMP));
	isFalling = !isGrinding;
	
	canGrindInstance = instance_place(x, newY, oMapGrindablesGroup);
}

// "Cancel big jump"
if(isGliding || isGrinding || isOnGround) {
	isBigJump = false;
}

// Update
y = newY;

// -----------------------------
// Particles
// -----------------------------
if(hasJustLanded) {
	shakeScreen(10, 3, .1);
	part_emitter_region(trailParticleSystem, trailEmitter, x+22, x+52, y+46, y+76, ps_shape_ellipse, ps_distr_gaussian);
	part_emitter_burst(trailParticleSystem, trailEmitter, landingParticle, 40);	
} else if(isGrinding) {
	shakeScreen(2, 4, 1);
	part_emitter_region(trailParticleSystem, trailEmitter, x, x+52, y+66, y+66, ps_shape_line, ps_distr_gaussian);
	part_emitter_stream(trailParticleSystem, trailEmitter, grindParticle, 4);
} else {
	part_emitter_region(trailParticleSystem, trailEmitter, x, x+52, y+66, y+66, ps_shape_line, ps_distr_gaussian);
	part_emitter_stream(trailParticleSystem, trailEmitter, trailParticle, isOnGround ? 1 : 0);
}


// -----------------------------
// Check Game over
// -----------------------------
if(place_meeting(x, y, oMapObstaclesGroup)) {
	show_debug_message("Game over!");
	shakeScreen(30, 8, .02);
	part_system_clear(trailParticleSystem);
	part_particles_clear(trailParticle);
	part_particles_clear(grindParticle);
	part_particles_clear(landingParticle);
	part_emitter_clear(trailParticleSystem, trailEmitter);
	
	if(GAME_OVER_ENABLED) {
		global.isGameOver = true;		
	}
}