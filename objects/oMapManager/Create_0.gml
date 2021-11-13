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
	"Map20",
	"Map21",
	"MapDown01",
	"MapUp01"
];

global.AVAILABLE_MAP_PARTS = [
	"Map21",
	"MapDown01",
	"MapUp01"
];

#region methods
function init() {
	// For RNG to be... random ¯\_(ツ)_/¯
	randomize();
	
	// Variables
	activeMapParts = ds_list_create();
	toDeleteMapPart = noone;
	mustCreateNewPart = false;
	lastPartEndY = room_height / 2;

	// Set instances origin X (position according to layer)
	// (didnt find another way to move a group...)
	with(oMapObstaclesGroup) {
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
	with(oMapPartStartMarker) {
	 	originX = x;
		originY = y;
	}
	with(oMapPartEndMarker) {
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
	do {
		layerBaseName = global.AVAILABLE_MAP_PARTS[irandom(array_length_1d(global.AVAILABLE_MAP_PARTS)-1)];
	} until(ds_list_find_index(activeMapParts, layerBaseName) == -1);
	
	activateMapPart(layerBaseName);
}


function activateMapPart(layerBaseName) {
	var bgLayer = layer_get_id(layerBaseName + "Bg");
	var mdLayer = layer_get_id(layerBaseName + "Md");
	var fgLayer = layer_get_id(layerBaseName + "Fg");
	var instancesLayer = layer_get_id(layerBaseName + "Instances");
	var instances = layer_get_all_elements(instancesLayer);
	var mapPartY = 0;
	var mapPartX = room_width;
	
	// Get map start marker to align with previous map end
	// And offset the y of everything
	for(var i = 0; i < array_length_1d(instances); i++) {
		instance = layer_instance_get_instance(instances[i]);
		
		if(instance.object_index == oMapPartStartMarker) {
			mapPartY = lastPartEndY - instance.originY;
		}
	}
	
	// Move layers
	layer_x(bgLayer, mapPartX);
	layer_x(mdLayer, mapPartX);
	layer_x(fgLayer, mapPartX);
	layer_y(bgLayer, mapPartY);
	layer_y(mdLayer, mapPartY);
	layer_y(fgLayer, mapPartY);
	layer_set_visible(bgLayer, true);
	layer_set_visible(mdLayer, true);
	layer_set_visible(fgLayer, true);
	layer_set_visible(instancesLayer, true);
	instance_activate_layer(instancesLayer);
	
	// Instances
	var showBirds = (irandom(100) < FX_BIRDS_CHANCE);
	for(var i = 0; i < array_length_1d(instances); i++) {
		with(layer_instance_get_instance(instances[i])) {
			x = originX + room_width;
			y = originY + mapPartY;
			if(object_index == oMapPartEndMarker) {
				other.lastPartEndY = y;
			}
			// Randomly activate birds for this map part
			if(object_index == oBird) {
				visible = showBirds;
			}
			
		}
	}
	
	// Add to list
	ds_list_add(activeMapParts, layerBaseName);
}

function deactivateMapPart(layerBaseName) {
	// show_debug_message("deactivate: " + layerBaseName);
	var bgLayer = layer_get_id(layerBaseName + "Bg");
	var mdLayer = layer_get_id(layerBaseName + "Md");
	var fgLayer = layer_get_id(layerBaseName + "Fg");
	var instancesLayer = layer_get_id(layerBaseName + "Instances");
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
	var bgLayer = layer_get_id(layerBaseName + "Bg");
	var mdLayer = layer_get_id(layerBaseName + "Md");
	var fgLayer = layer_get_id(layerBaseName + "Fg");
	var instancesLayer = layer_get_id(layerBaseName + "Instances");
	layer_x(bgLayer, layer_get_x(bgLayer) + offsetX);
	layer_x(mdLayer, layer_get_x(mdLayer) + offsetX);
	layer_x(fgLayer, layer_get_x(fgLayer) + offsetX);
	
	// Move instances	
	var instances = layer_get_all_elements(instancesLayer);
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