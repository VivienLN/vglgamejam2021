// List of map parts
global.MAP_PARTS = [
	"Map01",
	"Map02",
	"Map03",
	"Map04",
	"Map05",
	"Map06",
	"Map07",
	"Map08",
	"Map09",
	"Map10",
	"Map11",
	"Map12",
	"Map13",
	"Map14",
	"Map15",
	"Map16",
	"Map17",
	"Map18",
	"Map19",
	"Map20"
];

global.AVAILABLE_MAP_PARTS = [
	"Map19",
	"Map20"
];

#region methods
function init() {
	// For RNG to be... random ¯\_(ツ)_/¯
	randomize();
	
	// Variables
	activeMapParts = ds_list_create();
	toDeleteMapPart = noone;
	mustCreateNewPart = false;

	// Set instances origin X
	// (didnt find another way to move a group...)
	with(oMapObstaclesGroup) {
		// x position on the layer
		originX = x;
		originY = y;
	}
	with(oMapGrindablesGroup) {
		originX = x;
		originY = y;
	}
	with(oMapFxGroup) {
	 	originX = x;
		originY = y;
	}
	with(oMapGroundGroup) {
	 	originX = x;
		originY = y;
	}

	// Disable all map parts at startup
	for(var i = 0; i < array_length_1d(global.MAP_PARTS); i++) {
		deactivateMapPart(global.MAP_PARTS[i]);
	}
	
	// Create a new map part at random
	activateRandomMapPart();
}

function activateRandomMapPart() {
	var layerBaseName = noone;
	if(FORCE_MAP_PART != noone && ds_list_find_index(activeMapParts, FORCE_MAP_PART) == -1) {
		layerBaseName = FORCE_MAP_PART;
	} else {
		do {
			layerBaseName = global.AVAILABLE_MAP_PARTS[irandom(array_length_1d(global.AVAILABLE_MAP_PARTS)-1)];
		} until(ds_list_find_index(activeMapParts, layerBaseName) == -1);
	}
	
	
	
	activateMapPart(layerBaseName);
}


function activateMapPart(layerBaseName) {
	bgLayer = layer_get_id(layerBaseName + "Bg");
	mdLayer = layer_get_id(layerBaseName + "Md");
	fgLayer = layer_get_id(layerBaseName + "Fg");
	instancesLayer = layer_get_id(layerBaseName + "Instances");
	layer_x(bgLayer, room_width);
	layer_x(mdLayer, room_width);
	layer_x(fgLayer, room_width);
	layer_set_visible(bgLayer, true);
	layer_set_visible(mdLayer, true);
	layer_set_visible(fgLayer, true);
	layer_set_visible(instancesLayer, true);
	instance_activate_layer(instancesLayer);
	
	// Instances
	instances = layer_get_all_elements(instancesLayer);
	var showBirds = (irandom(100) < FX_BIRDS_CHANCE);
	for(var i = 0; i < array_length_1d(instances); i++) {
		instance = layer_instance_get_instance(instances[i]);
		instance.x = instance.originX + room_width;
		// Randomly activate birds for this map part
		if(instance.object_index == oBird) {
			instance.visible = showBirds;
		}
	}
	
	// Add to list
	ds_list_add(activeMapParts, layerBaseName);
}

function deactivateMapPart(layerBaseName) {
	// show_debug_message("deactivate: " + layerBaseName);
	bgLayer = layer_get_id(layerBaseName + "Bg");
	mdLayer = layer_get_id(layerBaseName + "Md");
	fgLayer = layer_get_id(layerBaseName + "Fg");
	instancesLayer = layer_get_id(layerBaseName + "Instances");
	instance_deactivate_layer(instancesLayer);
	layer_set_visible(bgLayer, false);
	layer_set_visible(mdLayer, false);
	layer_set_visible(fgLayer, false);
	
	// Remove from active list
	index = ds_list_find_index(activeMapParts, layerBaseName);
	ds_list_delete(activeMapParts, index);
}

function moveAllMapParts(offsetX) {	
	for(var i = 0; i < ds_list_size(activeMapParts); i++) {
		moveMapPart(activeMapParts[|i], offsetX);
	}
	
	// Delete map part outside of screen
	if(toDeleteMapPart != noone) {
		deactivateMapPart(toDeleteMapPart);
	}
	
	// If needed, create a new one
	if(mustCreateNewPart) {
		mustCreateNewPart = false;
		activateRandomMapPart();
	}
		
	// Clear delete list
	toDeleteMapPart = noone;
}

function moveMapPart(layerBaseName, offsetX) {
	// show_debug_message("move map part: " + layerBaseName );
	bgLayer = layer_get_id(layerBaseName + "Bg");
	mdLayer = layer_get_id(layerBaseName + "Md");
	fgLayer = layer_get_id(layerBaseName + "Fg");
	instancesLayer = layer_get_id(layerBaseName + "Instances");
	layer_x(bgLayer, layer_get_x(bgLayer) + offsetX);
	layer_x(mdLayer, layer_get_x(mdLayer) + offsetX);
	layer_x(fgLayer, layer_get_x(fgLayer) + offsetX);
	
	// Move instances	
	instances = layer_get_all_elements(instancesLayer);
	for(var i = 0; i < array_length_1d(instances); i++) {
		layer_instance_get_instance(instances[i]).x += offsetX;
	}
	
	// When a map part reach 0, create a new one
	if(layer_get_x(bgLayer) <= 0 && layer_get_x(bgLayer) > offsetX) {
		mustCreateNewPart = true;
	}
	
	// When a part reach -room_width (its out of screen), flag for deletion
	if(layer_get_x(bgLayer) <= -room_width) {
		toDeleteMapPart = layerBaseName;
	}
}
#endregion methods

// Init!
init();