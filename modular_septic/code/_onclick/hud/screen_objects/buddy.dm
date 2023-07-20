//Fraggots
/atom/movable/screen/fullscreen/buddy
	name = "BUDDY"
	icon = 'modular_septic/icons/hud/screen_chungus.dmi'
	icon_state = "buddy"
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/atom/movable/screen/fullscreen/buddy/Initialize(mapload)
	. = ..()
	animate(src, alpha = 255, time = 0, loop = -1, flags = ANIMATION_PARALLEL)
	animate(src, alpha = 64, time = 1 SECONDS)

/atom/movable/screen/fullscreen/buddy/update_for_view(client_view)
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	update_appearance()
