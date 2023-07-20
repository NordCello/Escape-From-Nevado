//stupid helmet for emoney
/obj/item/clothing/head/helmet/m56
    name = "DDR M56/76 steel helmet"
    desc = "An East German steel helmet from the cold war. \
			It eminates a hostile and down right racist aurora... \
			Moderate protection against most types of damage. Does not cover the face."
    icon = 'modular_septic/icons/obj/clothing/hats.dmi'
    icon_state = "m56-cover"
    worn_icon = 'modular_septic/icons/mob/clothing/head.dmi'
    worn_icon_state = "m56-cover"
    max_integrity = 150
    limb_integrity = 150
    integrity_failure = 0.1
    subarmor = list(SUBARMOR_FLAGS = NONE, \
                EDGE_PROTECTION = 40, \
                CRUSHING = 13, \
                CUTTING = 15, \
                PIERCING = 20, \
                IMPALING = 5, \
                LASER = 1, \
                ENERGY = 0, \
                BOMB = 8, \
                BIO = 0, \
                FIRE = 2, \
                ACID = 2, \
                MAGIC = 0, \
                WOUND = 0, \
                ORGAN = 0)

/obj/item/clothing/head/helmet/m56/equipped(mob/user, slot)
	. = ..()
	if(slot & ITEM_SLOT_HEAD)
		user.playsound_local(user, 'modular_septic/sound/memeshit/ddr.ogg', vol = 100, vary = FALSE)
