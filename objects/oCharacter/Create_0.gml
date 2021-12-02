// Config
// Note: ySpeed is a float to be able to have grav as a float to
grav = 1.2; //0.9;
ySpeed = 0.0;

maxYspeed = 14;
baseJumpSpeed = 7.5; //7;
bigJumpSpeed = 9; //9;
maxDuckRecoveryFrames = 8;
maxGrindRecoveryFrames = 8;

glidingYSpeed = 1.2;
glidingYSpeedVariation = 1;
maxJumpFrames = 13;

// Tricks
grindTypeNeutral = ds_map_create();
grindTypeNeutral[? "name"] = "Back Side";
grindTypeNeutral[? "animation"] = sCharacterGrindBackSide;
grindTypeDown = ds_map_create();
grindTypeDown[? "name"] = "Soul Grind";
grindTypeDown[? "animation"] = sCharacterGrindSoul;
grindTypeLeft = ds_map_create();
grindTypeLeft[? "name"] = "Alley Oop Soul Grind";
grindTypeLeft[? "animation"] = sCharacterGrindAoSoul;
grindTypeUp = ds_map_create();
grindTypeUp[? "name"] = "Fast Slide";
grindTypeUp[? "animation"] = sCharacterGrindFrontFastSlide;
grindTypeRight = ds_map_create();
grindTypeRight[? "name"] = "Back Torque + Grab";
grindTypeRight[? "animation"] = sCharacterGrindBackTorqueGrab;

// Other variables
isOnGround = false;
canJump = false;
isFalling = false;
isBigJump = false;
canGlide = false;
isGliding = false;
jumpFrames = 0;
jumpSpeed = 0;
mustReleaseJump = false;

canDuck = false;
isDucking = false;
mustReleaseDuck = false;

isGrinding = false;
grindType = noone;

duckRecoveryFrames = 0;
grindRecoveryFrames = 0;

trailPoints = ds_list_create();
trailOffsetX = 34;
trailOffsetY = 62;

tailwindPoints = ds_list_create();
tailwindOffsetX = 26;
tailwindOffsetY = 17;
tailwindOffset2X = 46;
tailwindOffset2Y = 15;

// Particles
// Define system
trailParticleSystem = part_system_create();
comboParticleSystem = part_system_create();
trailParticle = part_type_create();
landingParticle = part_type_create();
grindParticle = part_type_create();
windParticle = part_type_create();
comboParticle = part_type_create();

// Define Trail particle
part_type_shape(trailParticle, pt_shape_square);
part_type_size(trailParticle, .02, .1, -.004, 0);
part_type_color2(trailParticle, $ffffaa, $ffff00);
part_type_alpha2(trailParticle, 1, .7);
part_type_speed(trailParticle, 5, 7, 0, 0);
part_type_direction(trailParticle, 160, 180, 0, 0);
part_type_gravity(trailParticle, 0.1, 100);
part_type_orientation(trailParticle, 0, 359, 10, 0, false);
part_type_life(trailParticle, 18, 24);
part_type_blend(trailParticle, true);

// Define Landing particle
part_type_shape(landingParticle, pt_shape_square);
part_type_size(landingParticle, .03, .1, -.001, 0);
part_type_color2(landingParticle, $ffffff, $ffff00);
part_type_alpha2(landingParticle, 1, .7);
part_type_speed(landingParticle, 4, 12, 0, 0);
part_type_direction(landingParticle, 140, 180, 0, 0);
part_type_gravity(landingParticle, 0.1, 100);
part_type_orientation(landingParticle, 0, 359, 10, 0, false);
part_type_life(landingParticle, 40, 80);
part_type_blend(landingParticle, true);

// Define Grind particle
part_type_shape(grindParticle, pt_shape_square);
part_type_size(grindParticle, .01, .08, -.001, 0);
part_type_color3(grindParticle, $44ff00, $aaff00, $00ff00);
part_type_alpha2(grindParticle, 1, .7);
part_type_speed(grindParticle, 6, 12, 0, 0);
part_type_direction(grindParticle, 120, 160, 0, 0);
part_type_gravity(grindParticle, 0.6, 240);
part_type_orientation(grindParticle, 0, 359, 10, 0, false);
part_type_life(grindParticle, 60, 120);
part_type_blend(grindParticle, true);

// Define Combo particle
part_type_shape(comboParticle, pt_shape_ring);
part_type_size(comboParticle, .3, .3, +.2, 0);
part_type_color3(comboParticle, $ffff00, $ffff00, $ffffff);
part_type_alpha3(comboParticle, .7, .2, 0);
part_type_speed(comboParticle, 10, 10, 0, 0);
part_type_direction(comboParticle, 180, 180, 0, 0);
part_type_gravity(comboParticle, 0, 0);
part_type_orientation(comboParticle, 0, 0, 0, 0, false);
part_type_life(comboParticle, 30, 30);
part_type_blend(comboParticle, true);

// Define emitter
trailEmitter = part_emitter_create(trailParticleSystem);
comboEmitter = part_emitter_create(comboParticleSystem);
