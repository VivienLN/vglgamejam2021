// Constants
#macro KEY_JUMP vk_up
#macro KEY_DUCK vk_down
#macro GAME_SPEED_BASE 14 // px/frame
#macro GAME_SPEED_INCREASE_THRESHOLD 500
#macro GAME_SPEED_INCREASE_RATIO 1.05
#macro FX_BIRDS_CHANCE 10

// Camera
#macro CAMERA_OFFSET_Y -32
#macro CAMERA_DEFAULT view_camera[0]
#macro CAMERA_BORDER 260

// Debugging tools
#macro GAME_OVER_ENABLED true 

// Variables
gameSpeed = GAME_SPEED_BASE;
isGameOver = false;
isTitle = true;

// Score
score = 0;
distance = 0;
scoreMultiplier = 1;

// Define Wind particle
windParticleSystem = part_system_create();
windEmitter = part_emitter_create(windParticleSystem);
windParticle = part_type_create();
//part_type_shape(windParticle, pt_shape_line);
part_type_sprite(windParticle, sWindParticle, false, false, true);
part_type_size(windParticle, .5, 1, 0, 0);
part_type_color1(windParticle, $ffffff);
part_type_alpha2(windParticle, .1, .8);
part_type_speed(windParticle, 40, 60, 0, 0);
part_type_direction(windParticle, 180, 180, 0, 0);
part_type_gravity(windParticle, 0, 0);
part_type_orientation(windParticle, 0, 0, 0, 0, false);
part_type_life(windParticle, 300, 300);
part_type_blend(windParticle, false);
part_emitter_region(windParticleSystem, windEmitter, room_width, room_width, 0, room_height, pt_shape_line, ps_distr_gaussian);

// Tween timeline system for camera movements
tlGameSpeed = tweenTimelineCreate();
tlPlayerX = tweenTimelineCreate();