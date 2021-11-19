// Constants
#macro KEY_JUMP vk_up
#macro KEY_DUCK vk_down
#macro GAME_SPEED_BASE 10 // px/frame
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
global.gameSpeed = GAME_SPEED_BASE;
global.isGameOver = false;
global.isTitle = true;

// Score
global.scoreDistance = 0;

// Tween timeline system for camera movements
tlGameSpeed = tweenTimelineCreate();
tlPlayerX = tweenTimelineCreate();
// store gamespeed locally to be able to use tweens
// (workaround the impossibility to access global inside tween script)
gameSpeed = global.gameSpeed;