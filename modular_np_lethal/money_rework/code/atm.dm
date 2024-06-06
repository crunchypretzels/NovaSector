// THE ATM
// i think coding this took years off my life
// but we persist in a doomed world of my creation

/obj/machinery/autobank
	name = "banking terminal"
	desc = "An automatic teller machine, or ATM. What bank is this connected to? Who knows? It takes your money and- usually- gives it back."
	icon = 'modular_np_lethal/money_rework/icons/atm.dmi'
	icon_state = "atm"
	anchored = TRUE
	density = TRUE
	idle_power_usage = BASE_MACHINE_IDLE_CONSUMPTION
	// currently loaded bank account
	var/datum/bank_account/synced_bank_account
	// account balance
	var/balance = 0
	// amount of credits withdrawn
	var/withdrawn_credits = 0

/obj/machinery/computer/bank_machine/Initialize(mapload)
	. = ..()
	synced_bank_account = null

/obj/machinery/autobank/attackby(obj/item/weapon, mob/user, params)
	var/value = 0
	if(istype(weapon, /obj/item/lethalcash))
		var/obj/item/lethalcash/insertedcash = weapon
		value = insertedcash.value
	else if(istype(weapon, /obj/item/holochip))
		var/obj/item/holochip/inserted_holochip = weapon
		value = inserted_holochip.credits
	if(value)
		if(synced_bank_account)
			synced_bank_account.adjust_money(value)
			say("Credits deposited! Your account now holds [synced_bank_account.account_balance] credits.")
		qdel(weapon)
		return
	return ..()

/obj/machinery/autobank/ui_data(mob/user)
	. = list()

	// the horror of the future; the atm just scans you for your bank account and some guy shoves you out of the way and swipes your checking account
	var/obj/item/card/id/used_id_card
	if(isliving(user))
		var/mob/living/living_user = user
		used_id_card = living_user.get_idcard(TRUE)

	synced_bank_account = used_id_card?.registered_account
	balance = used_id_card?.registered_account?.account_balance

	var/list/data = list()
	data["current_balance"] = synced_bank_account?.account_balance
	data["withdrawal_amount"] = 0


	return data

/obj/machinery/autobank/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!anchored)
		return
	if(!ui)
		ui = new(user, src, "AutoBank", name)
		ui.open()

/obj/machinery/autobank/ui_act(action, params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	// we have no card to take money from
	var/mob/living/living_user = ui.user
	var/obj/item/card/id/used_id_card = living_user.get_idcard(TRUE)
	if(isnull(used_id_card))
		say("No usable account number on file. If you believe this to be in error, please contact 7-001-0451 at extension '9' for customer service!")
		return

	switch(action)
		if("withdraw")
			var/dosh_taken = text2num(params["totalcreds"])
			if(dosh_taken <= balance)
				synced_bank_account.adjust_money(-dosh_taken)
				say("Withdrawal complete! Have a great day!")
				spawn_lethal_money(dosh_taken, drop_location())
				playsound(src, 'sound/effects/cashregister.ogg', 50, TRUE)
			else
				say("Unable to complete transaction.")
			. = TRUE

/obj/item/flatpacked_machine/atm
	name = "banking terminal parts kit"
	icon = 'modular_np_lethal/money_rework/icons/atm.dmi'
	icon_state = "recycler"
	type_to_deploy = /obj/machinery/autobank
	deploy_time = 2 SECONDS
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 5,
	)

