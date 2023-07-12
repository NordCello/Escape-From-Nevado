/mob/say(message, bubble_type, list/spans, sanitize, datum/language/language, ignore_spam, forced, filterproof)
	. = ..()
	if(client && GLOB.buddy_regex.Find(message))
		client?.give_award(/datum/award/achievement/misc/secretphrase, src)
