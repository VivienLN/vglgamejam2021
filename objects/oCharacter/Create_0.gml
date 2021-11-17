/// @description Init character
// You can write your code in this editor
show_debug_message("character creation");

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
maxJumpFrames = 13; //13;


// Other variables
isOnGround = false;
canJump = false;
isFalling = false;
isBigJump = false;
canGlide = false;
isGliding = false;
jumpFrames = 0;
jumpSpeed = 0;

canDuck = false;
isDucking = false;

canGrindInstance = noone;
isGrinding = false;

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
trailParticle = part_type_create();
landingParticle = part_type_create();
grindParticle = part_type_create();

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
part_type_size(grindParticle, .02, .1, -.001, 0);
part_type_color2(grindParticle, $88ff88, $00ff00);
part_type_alpha2(grindParticle, 1, .7);
part_type_speed(grindParticle, 6, 12, 0, 0);
part_type_direction(grindParticle, 120, 160, 0, 0);
part_type_gravity(grindParticle, 0.6, 240);
part_type_orientation(grindParticle, 0, 359, 10, 0, false);
part_type_life(grindParticle, 60, 120);
part_type_blend(grindParticle, true);

// Define emitter
trailEmitter = part_emitter_create(trailParticleSystem);