// Constants
#macro KEY_JUMP vk_up
#macro KEY_DUCK vk_down
#macro GAME_SPEED_BASE 10 // px/frame
#macro GAME_SPEED_INCREASE_THRESHOLD 500
#macro GAME_SPEED_INCREASE_RATIO 1.05
#macro FX_BIRDS_CHANCE 10

// Debugging tools
#macro GAME_OVER_ENABLED true 


// Variables
global.gameSpeed = GAME_SPEED_BASE;
global.isGameOver = false;
global.isTitle = true;

// Score
global.scoreDistance = 0;