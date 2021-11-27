/*
	Timeline: a series of tweens, that will play one at a time
	Tween: a list of variables used to animate something
*/
global.tweenTimelines = ds_list_create();

//-------------------------------------------------------------
// Create a new timeline
//-------------------------------------------------------------
function tweenTimelineCreate(onFinished = noone, destroyWhenFinished = false) {
	var timelineId = ds_map_create();
	ds_map_add(timelineId, "onFinished", onFinished);
	ds_map_add(timelineId, "destroyWhenFinished", destroyWhenFinished);
	ds_map_add(timelineId, "tweens", ds_list_create());
	ds_list_add(global.tweenTimelines, timelineId);
	
	return timelineId;
}

//-------------------------------------------------------------
// Clear a timeline
//-------------------------------------------------------------
// This will remove all tweens and stop animation where it is
//-------------------------------------------------------------
function tweenTimelineClear(timelineId) {
	ds_list_clear(timelineId[? "tweens"]);
}

//-------------------------------------------------------------
// Destroy a timeline
//-------------------------------------------------------------
function tweenTimelineDestroy(timelineId) {
	ds_list_destroy(timelineId[? "tweens"]);
	ds_map_destroy(timelineId);
	
	var index = ds_list_find_index(global.tweenTimelines, timelineId)
	ds_list_delete(global.tweenTimelines, index);
}

//-------------------------------------------------------------
// Check if timeline is running
//-------------------------------------------------------------
function tweenTimelineIsRunning(timelineId) {
	return tweenTimelineSize(timelineId) > 0;
}

//-------------------------------------------------------------
// Check timeline size
//-------------------------------------------------------------
function tweenTimelineSize(timelineId) {
	return ds_list_size(timelineId[? "tweens"]);
}

//-------------------------------------------------------------
// Create a tween (and add it to a internal timeline)
//-------------------------------------------------------------
function tween(targetId, property, from, to, duration, easing, onFinished = noone) {
	var timelineId = tweenTimelineCreate(onFinished, true)
	tweenAdd(timelineId, targetId, property, from, to, duration, easing);
}

//-------------------------------------------------------------
// Add a tween to a timeline
//-------------------------------------------------------------
// Note: to use global var, a workaround is to track the value in your instance
// And update global var just after tweenStep().
// 
// Example: move x of current instance from 60 to 70, in 10 frames
//  tl = tweenTimelineCreate();
//  tweenAdd(tl, id, "x", 60, 70, 10, easeLinear, false);
// 
// Example: do the same with a player object
//  tl = tweenTimelineCreate();
//  tweenAdd(tl, oPlayer.id, "x", 60, 70, 10, easeLinear, false);
//-------------------------------------------------------------
function tweenAdd(timelineId, targetId, property, from, to, duration, easing, cancelOthers = false) {
	if(cancelOthers) {
		tweenTimelineClear(timelineId);
	}
	// Create tween
	var tweenId = ds_map_create();
	ds_map_add(tweenId, "targetId", targetId);
	ds_map_add(tweenId, "property", property);
	ds_map_add(tweenId, "from", from);
	ds_map_add(tweenId, "to", to);
	ds_map_add(tweenId, "easing", easing);
	// We start at frame #1 of anim to ensure we end up exactly at "to" value, not just before
	ds_map_add(tweenId, "frames", 1);
	ds_map_add(tweenId, "framesTotal", duration);
	
	// Add it to timeline
	ds_list_add(timelineId[? "tweens"], tweenId);
	
	// Note: Return tweenID useless because we only animate timelines
	// So we return the timeline ID; this way we can write something like:
	// timeline = tweenAdd(tweenTimelineCreate(), ...)
	return timelineId;
}

//-------------------------------------------------------------
// Run step code for all timelines
//-------------------------------------------------------------
function tweenStep() {
	for(var i = 0; i < ds_list_size(global.tweenTimelines); i++) {
		timelineStep(global.tweenTimelines[| i]);
	}
}

//-------------------------------------------------------------
// Run step code for the provided timeline
//-------------------------------------------------------------
function timelineStep(timelineId) {	
	if(tweenTimelineSize(timelineId) == 0) {
		return;
	}
	
	var tweensList = timelineId[? "tweens"];
	
	if(tweensList[| 0][? "frames"] > tweensList[| 0][? "framesTotal"]) {
		// Current tween is over
		// Remove it from timeline and shift everything
		ds_list_delete(tweensList, 0);
		
		// If there is no other tween to play, return
		if(tweenTimelineSize(timelineId) == 0) {
			if(timelineId[? "onFinished"] != noone) {
				timelineId[? "onFinished"]();
			}
			if(timelineId[? "destroyWhenFinished"]) {
				tweenTimelineDestroy(timelineId);
			}
			return;
		}
	}
	
	// Here we are sure to have a valid tween reference
	var frames =  tweensList[| 0][? "frames"];
	var framesTotal = tweensList[| 0][? "framesTotal"];
	var from = tweensList[| 0][? "from"];
	var to = tweensList[| 0][? "to"];
	var targetId = tweensList[| 0][? "targetId"];
	var property = tweensList[| 0][? "property"];
	var easeFunction = tweensList[| 0][? "easing"];
	
	var animationStep = frames / framesTotal;
	var newValue = from + (to - from) * easeFunction(animationStep);
	
	if (variable_instance_exists(targetId, property)) {
		variable_instance_set(targetId, property, newValue);
	}
	
	// Increment frames
	tweensList[| 0][? "frames"]++;
	
}