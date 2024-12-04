local item_sounds = require("__base__.prototypes.item_sounds")


data:extend(
{
	--subgroup
	{
        type = "item-subgroup",
        name = "space-dysongroup",
        group = "space",
        order = "zc"
    },
	--items
	{
		type = "tool",
		name = "slp-sun-science-pack",
		icon = "__slp-dyson-sphere-reworked__/graphics/icons/sun-science-pack.png",
		subgroup = "science-pack",
		color_hint = { text = "W" },
		order = "r",
		inventory_move_sound = item_sounds.science_inventory_move,
		pick_sound = item_sounds.science_inventory_pickup,
		drop_sound = item_sounds.science_inventory_move,
		stack_size = 200,
		weight = 1*kg,
		durability = 1,
		durability_description_key = "description.science-pack-remaining-amount-key",
		durability_description_value = "description.science-pack-remaining-amount-value",
		random_tint_color = item_tints.bluish_science
	},
	{
		type = "item",
		name = "slp-sun-fuel",
		icon = "__slp-dyson-sphere-reworked__/graphics/icons/sun-fuel.png",
		fuel_category = "chemical",
		fuel_value = "10GJ",
		fuel_acceleration_multiplier = 3.5,
		fuel_top_speed_multiplier = 1.5,
		subgroup = "space-dysongroup",
		order = "f-a",
		inventory_move_sound = item_sounds.fuel_cell_inventory_move,
		pick_sound = item_sounds.fuel_cell_inventory_pickup,
		drop_sound = item_sounds.fuel_cell_inventory_move,
		stack_size = 20,
		weight = 5*kg,
		spoil_ticks = 40 * minute,
		spoil_result = nil,
	},
	{
		type = "item",
		name = "slp-sun-fuel-mk2",
		icon = "__slp-dyson-sphere-reworked__/graphics/icons/sun-fuel.png",
		fuel_category = "chemical",
		fuel_value = "10GJ",
		fuel_acceleration_multiplier = 3.5,
		fuel_top_speed_multiplier = 1.5,
		subgroup = "space-dysongroup",
		order = "f-b",
		inventory_move_sound = item_sounds.fuel_cell_inventory_move,
		pick_sound = item_sounds.fuel_cell_inventory_pickup,
		drop_sound = item_sounds.fuel_cell_inventory_move,
		stack_size = 20,
		weight = 5*kg
	},
	--recipes
	{
		type = "recipe",
		name = "slp-sun-science-pack",
		category = "electromagnetics",
		surface_conditions =
		{
		  {
			property = "gravity",
			min = 0,
			max = 0
		  }
		},
		enabled = false,
		ingredients =
		{
		  {type = "item", name = "slp-plasma-chunk", amount = 25}
		},
		energy_required = 60,
		results = {{type="item", name="slp-sun-science-pack", amount=3}},
		allow_productivity = true,
		result_is_always_fresh=true,
		main_product = "slp-sun-science-pack"
	},
	{
		type = "recipe",
		name = "slp-sun-fuel",
		energy_required = 25,
		enabled = false,
		category = "electromagnetics",
		result_is_always_fresh=true,
		ingredients =
		{
		  {type = "item", name = "steel-plate", amount = 5},
		  {type = "item", name = "slp-plasma-chunk", amount = 10}
		},
		results = {{type="item", name="slp-sun-fuel", amount=1}},
		crafting_machine_tint =
		{
		  primary = {r = 1.0, g = 1, b = 1, a = 1.000},
		  secondary = {r = 1.0, g = 1, b = 1, a = 1.000},
		},
		allow_productivity = true,
		allow_as_intermediate=false,
		allow_intermediates =false,
		surface_conditions =
		{
		  {
			property = "gravity",
			min = 0,
			max = 0
		  }
		},
	},
	{
		type = "recipe",
		name = "slp-sun-fuel-mk2",
		energy_required = 10,
		enabled = false,
		category = "chemistry",
		result_is_always_fresh=true,
		ingredients =
		{
		  {type = "item", name = "slp-sun-fuel", amount = 1},
		  {type = "fluid", name = "sulfuric-acid", amount = 100}
		},
		results = {{type="item", name="slp-sun-fuel-mk2", amount=1}},
		crafting_machine_tint =
		{
		  primary = {r = 1.0, g = 1, b = 1, a = 1.000},
		  secondary = {r = 1.0, g = 1, b = 1, a = 1.000},
		},
		allow_productivity = true,
		allow_as_intermediate=false,
		allow_intermediates =false,
		surface_conditions =
		{
		  {
			property = "gravity",
			min = 0,
			max = 0
		  }
		},
	},
	{
		type = "recipe",
		name = "slp-ds-thruster-fuel-double",
		category = "chemistry",
		subgroup="space-processing",
		order = "b[thruster-fuel]",
		auto_recycle = false,
		enabled = false,
		ingredients =
		{
		  {type = "item", name = "slp-plasma-chunk", amount = 40},
		  {type = "fluid", name = "thruster-fuel", amount = 10}
		},
		surface_conditions =
		{
		  {
			property = "gravity",
			min = 0,
			max = 0
		  }
		},
		energy_required = 3,
		results = {{type = "fluid", name = "thruster-fuel", amount = 30}},
		allow_productivity = true,
		show_amount_in_title = false,
		always_show_products = true,
		crafting_machine_tint =
		{
		  primary = {r = 0.99, g = 0.82, b = 0.62, a = 0.9}, -- #fcd19f80
		  secondary = {r = 1, g = 1, b = 1, a = 0.502}, -- #ffffff80
		  tertiary = {r = 0.873, g = 0.649, b = 0.542, a = 0.502}, -- #dea58a80
		  quaternary = {r = 0.92, g = 0.27, b = 0.02, a = 0.3}, -- #eb460580
		}
	  },
	  {
		type = "recipe",
		name = "slp-ds-thruster-oxidizer-double",
		category = "chemistry",
		subgroup="space-processing",
		order = "d[thruster-oxidizer]",
		auto_recycle = false,
		enabled = false,
		ingredients =
		{
		  {type = "item", name = "slp-plasma-chunk", amount = 40},
		  {type = "fluid", name = "thruster-oxidizer", amount = 10}
		},
		surface_conditions =
		{
		  {
			property = "gravity",
			min = 0,
			max = 0
		  }
		},
		energy_required = 3,
		results = {{type = "fluid", name = "thruster-oxidizer", amount = 30}},
		allow_productivity = true,
		show_amount_in_title = false,
		always_show_products = true,
		crafting_machine_tint =
		{
		  primary = {r = 0.83, g = 0.92, b = 1, a = 0.9}, -- #d4eaff
		  secondary = {r = 1, g = 0.88, b = 0.28, a = 0.502}, -- #ffe04780
		  tertiary = {r = 0.05, g = 0.86, b = 0.86, a = 0.7}, -- #0f5f8a80
		  quaternary = {r = 0.683, g = 0.915, b = 1.000, a = 0.502}, -- #aee9ff80
		}
	  }
})