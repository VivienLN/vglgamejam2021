if(global.isTitle) {
	draw_set_halign(fa_center);
	draw_set_font(fTitle);
	draw_set_color($ffff00);
	draw_text(room_width / 2, 30, "SCARF BOY");
	if(blink) {
		draw_set_font(fDefault);
		draw_set_color($ffffff);
		draw_text(room_width / 2, 500, "Appuie sur une touche pour commencer !");
	}
} else {
	draw_set_color($ffffff);
	draw_set_halign(fa_left);
	draw_set_font(fDefault);
	
	with(oGameController) {
		draw_text(20, 20, string(score) + " points");
		draw_text(20, 60, "Combo x" + string(scoreMultiplier) + "!");
	}
}


if(global.isGameOver) {
	draw_set_font(fGameOver);
	draw_set_color($00ffff);
	draw_set_halign(fa_center);
	draw_text(room_width / 2, 200, "GAME OVER");
	with(oGameController) {
		draw_text(room_width / 2, 260, "Tu as fait " + string(score) + " points");
	}
	if(blink) {
		draw_set_font(fDefault);
		draw_set_color($ffffff);
		draw_text(room_width / 2, 340, "Appuie sur espace pour reessayer");
	}
}