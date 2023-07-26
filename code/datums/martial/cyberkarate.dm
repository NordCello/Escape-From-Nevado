#define MACH_PUNCH_COMBO "HHD"

/datum/martial_art/cyberkarate
	name = "Cyber Karate"
	id = MARTIALART_CYBERKARATE
	help_verb = /mob/living/proc/cyberkarate_help
	allow_temp_override = FALSE
	display_combos = TRUE

/datum/martial_art/the_sleeping_carp/teach(mob/living/target, make_temporary = FALSE)
	. = ..()
	if(!.)
		return
	ADD_TRAIT(target, TRAIT_NOGUNS, SLEEPING_CARP_TRAIT)
	ADD_TRAIT(target, TRAIT_HARDLY_WOUNDED, SLEEPING_CARP_TRAIT)
	ADD_TRAIT(target, TRAIT_NODISMEMBER, SLEEPING_CARP_TRAIT)
	RegisterSignal(target, COMSIG_PARENT_ATTACKBY, PROC_REF(on_attackby))
	target.faction |= "carp" //:D

/datum/martial_art/cyberkarate/proc/check_streak(mob/living/A, mob/living/D)
	if(findtext(streak,MACH_PUNCH_COMBO))
		reset_streak()
		machpunch(A,D)
		return TRUE
	return FALSE

/datum/martial_art/cyberkarate/proc/machpunch(mob/living/A, mob/living/D)
	var/power_level = A.attributes.get_attribute_value(SKILL_BRAWLING)
	if(D.diceroll(power_level) <= DICE_RESULT_SUCCESS)
		D.visible_message(span_warning("[A] punches [D]!"), \
						span_userdanger("Before you can react something from [A] hits you!"), span_hear("You hear a sickening sound of flesh hitting flesh!"), null, A)
		to_chat(A, span_danger("You throw a powerful and swift at [D]!"))
		playsound(get_turf(A), 'sound/effects/hit_kick.ogg', 50, TRUE, -1)
		D.apply_damage(30, BRUTE, BODY_ZONE_CHEST)
		D.Knockdown(30)
		log_combat(A, D, "mach punched (normal)")
		return
	if(D.diceroll(power_level) <=DICE_RESULT_CRIT_SUCCESS)
		D.visible_message(span_warning("[A] punches right through [D]'s stomach!"), \
						span_userdanger("Before you can react, [A] fist punches right through your stomach!"), span_hear("You hear the sickening sound of a flesh ripping apart"), null, A)
		to_chat(A, span_danger("You punch right through [D]!"))
		playsound(get_turf(A), 'sound/effects/hit_kick.ogg', 50, TRUE, -1)
		D.apply_damage(100, BRUTE, BODY_ZONE_CHEST)
		D.Knockdown(60)
		log_combat(A,D, "mach punched (crit)")
		return
	if (D.diceroll(power_level) <= DICE_RESULT_CRIT_FAILURE)
		D.visible_message(span_warning("[A]'s fist shatters upon punching [D]!"), \
						span_userdanger("A hastily thrown fist from [A] breaks upon you"), span_hear("You hear the sickening sound of flesh hitting flesh!"), null, A)
		to_chat(A, span_danger("Your fist breaks upon [D]!"))
		playsound(get_turf(A), 'sound/effects/attackblob.ogg', 50, TRUE, -1)
		A.apply_damage(15, BRUTE, BODY_ZONE_L_ARM)
		D.apply_damage(5, BRUTE, BODY_ZONE_CHEST)
		log_combat(A, D, "Mach punched (crit_fail)")
		return

/datum/martial_art/cyberkarate/harm_act(mob/living/A, mob/living/D)
	add_to_streak("H",D)
	if(check_streak(A,D))
		return TRUE
	var/obj/item/bodypart/affecting = D.get_bodypart(D.get_random_valid_zone(A.zone_selected))
	A.do_attack_animation(D, ATTACK_EFFECT_PUNCH)
	var/atk_verb = pick("kick", "chop", "hit", "slam")
	D.visible_message(span_danger("[A] [atk_verb]s [D]!"), \
					span_userdanger("[A] [atk_verb]s you!"), null, null, A)
	to_chat(A, span_danger("You [atk_verb] [D]!"))
	D.apply_damage(rand(10,15), BRUTE, affecting, wound_bonus = CANT_WOUND)
	playsound(get_turf(D), 'sound/weapons/punch1.ogg', 25, TRUE, -1)
	log_combat(A, D, "punched (Cyber Karate)")
	return TRUE

/datum/martial_art/cyberkarate/disarm_act(mob/living/A, mob/living/D)
	add_to_streak("D",D)
	if(check_streak(A,D))
		return TRUE
	log_combat(A, D, "disarmed (Cyber Karate)")
	return ..()

/datum/martial_art/cyberkarate/grab_act(mob/living/A, mob/living/D)
	add_to_streak("G",D)
	if(check_streak(A,D))
		return TRUE
	log_combat(A, D, "grabbed (Cyber Karate)")
	return ..()

/mob/living/proc/cyberkarate_help()
	set name = "Recall Teachings"
	set desc = "Recall the techniques from your cyberchip."
	set category = "Cyber Karate"

	var/datum/martial_art/cyberkarate/martial = usr.mind.martial_art
	to_chat(usr, "<b><i>You clench your fists and have a flashback of knowledge...</i></b>")
	to_chat(usr, "[span_notice("Mach Punch")]: Punch Punch. A fast punch with a devastating result.")



