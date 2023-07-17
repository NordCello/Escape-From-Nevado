//PM9 jumpscare holder
/atom/movable/screen/fullscreen/jumpscare
	icon = 'modular_septic/icons/hud/jumpscare.dmi'
	icon_state = "poopmadness"
	base_icon_state = "poopmadness"
	plane = FULLSCREEN_PLANE
	layer = JUMPSCARE_LAYER
	show_when_dead = TRUE
	alpha = 0
	/// How many jumpscare sprites we have
	var/jumpscare_amount = 14
	/// Jumpscare sounds we have
	var/list/jumpscare_sounds = list(
		'modular_septic/sound/insanity/poopmadness/atumalaka.ogg',
		'modular_septic/sound/insanity/poopmadness/bitch.ogg',
		'modular_septic/sound/insanity/poopmadness/turi.ogg',
		'modular_septic/sound/insanity/poopmadness/darknessimprisoningme.ogg',
		'modular_septic/sound/insanity/poopmadness/weegee.ogg',
		'modular_septic/sound/insanity/poopmadness/halflifezombie.ogg',
		'modular_septic/sound/insanity/poopmadness/badtothebone.ogg',
		'modular_septic/sound/insanity/poopmadness/trickortreating.ogg',
		'modular_septic/sound/insanity/poopmadness/boywhatthehellboy.ogg',
	)

/atom/movable/screen/fullscreen/jumpscare/proc/flash_scare(mob/user, scare_sound = pick(jumpscare_sounds))
	icon_state = "[base_icon_state][rand(1, jumpscare_amount)]"
	alpha = 255
	add_filter("blur", 1, gauss_blur_filter(3))
	transition_filter("blur", 0.3 SECONDS, gauss_blur_filter(0))
	animate(src, alpha = 0, time = 1 SECONDS, easing = EASE_IN|BOUNCE_EASING)
	if(scare_sound)
		user.playsound_local(scare_sound, scare_sound, vol = 200, vary = FALSE)
