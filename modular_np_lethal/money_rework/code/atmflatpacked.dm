// atm flatpack stuff

/datum/techweb_node/colony_fabricator_flatpacks
	design_ids = list(
		"flatpack_solar_panel",
		"flatpack_solar_tracker",
		"flatpack_arc_furnace",
		"flatpack_colony_fab",
		"flatpack_station_battery",
		"flatpack_station_battery_large",
		"flatpack_fuel_generator",
		"flatpack_rtg",
		"flatpack_thermo",
		"flatpack_ore_silo",
		"flatpack_atm",
		"flatpack_turbine_team_fortress_two",
		"flatpack_bootleg_teg",
	)

/datum/design/flatpack_atm
	name = "Flat-Packed Banking Terminal"
	desc = "A convenient way to store necessary currency through a peer-to-peer trans-spatial \
		banking network. Low-risk, but no-reward."
	id = "flatpack_atm"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 5,
	)
	build_path = /obj/item/flatpacked_machine/atm
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_FLATPACK_MACHINES + FABRICATOR_SUBCATEGORY_MATERIALS,
	)
	construction_time = 30 SECONDS
