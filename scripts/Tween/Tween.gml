/*
	Timeline: a series of tweens, that will play one at a time
	Tween: a list of variables used to animate something
*/

//-------------------------------------------------------------
// Create a new timeline
//-------------------------------------------------------------
function tweenTimelineCreate() {
	timelineId = ds_list_create();
	return timelineId;
}

//-------------------------------------------------------------
// Clear a timeline
//-------------------------------------------------------------
// This will remove all tweens and stop animation where it is
//-------------------------------------------------------------
function tweenTimelineClear(timelineId) {
	ds_list_clear(timelineId);
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
	return ds_list_size(timelineId);
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
	ds_list_add(timelineId, tweenId);
	
	// Note: Return tweenID useless because we only animate timelines
	// So we return the timeline ID; this way we can write something like:
	// timeline = tweenAdd(tweenTimelineCreate(), ...)
	return timelineId;
}

//-------------------------------------------------------------
// Run step code for the provided timeline
//-------------------------------------------------------------
function tweenStep(timelineId) {	
	if(ds_list_size(timelineId) == 0) {
		return;
	}
	
	if(timelineId[| 0][? "frames"] > timelineId[| 0][? "framesTotal"]) {
		// Current tween is over
		// Remove it from timeline and shift everything
		ds_list_delete(timelineId, 0);
		
		// If there is no other tween to play, return
		if(ds_list_size(timelineId) == 0) {
			// TODO: timeline is finished, add a callback functionality??
			return;
		}
	}
	
	// Here we are sure to have a valid tween reference
	var frames =  timelineId[| 0][? "frames"];
	var framesTotal = timelineId[| 0][? "framesTotal"];
	var from = timelineId[| 0][? "from"];
	var to = timelineId[| 0][? "to"];
	var targetId = timelineId[| 0][? "targetId"];
	var property = timelineId[| 0][? "property"];
	var easeFunction = timelineId[| 0][? "easing"];
	
	var animationStep = frames / framesTotal;
	var newValue = from + (to - from) * easeFunction(animationStep);
	
	if (variable_instance_exists(targetId, property)) {
		variable_instance_set(targetId, property, newValue);
	}
	
	// Increment frames
	timelineId[| 0][? "frames"]++;
	
}