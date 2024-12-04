local big_collision_box = {{-0.5, -0.5}, {0.5, 0.5}}
local big_selection_box = {{-1, -1}, {1, 1}}
local big_drawing_box = {{-4, -5}, {4, 4}}
local big_collision_mask = {layers = {item = true, meltable = true, object = true, player = true, water_tile = true, is_object = true}}
local item_sounds = require("__base__.prototypes.item_sounds")

data:extend(
{
	--satellite
	{
		type = "item",
		name = "slp-ds-satellite",
		icon = "__slp-dyson-sphere-reworked__/graphics/icons/dyson-swarm-part.png",
		icon_size = 512,
		icon_mipmaps = 4,
		subgroup = "space-dysongroup",
		order = "a-a",
		inventory_move_sound = item_sounds.sulfur_inventory_move,
		pick_sound = item_sounds.resource_inventory_pickup,
		drop_sound = item_sounds.sulfur_inventory_move,
		stack_size = 1,
		weight = 1000 * kg,
		send_to_orbit_mode = "automated"
	},
	{
		type = "recipe",
		name = "slp-ds-satellite",
		energy_required = 5,
		enabled = false,
		category = "crafting",
		ingredients =
		{
		  {type = "item", name = "radar", amount = 10},
		  {type = "item", name = "processing-unit", amount = 60},
		  {type = "item", name = "solar-panel", amount = 100},
		  {type = "item", name = "slp-sun-fuel", amount = 10},
		  {type = "item", name = "ds-entangled-core", amount = 1}
		},
		results = {{type="item", name="slp-ds-satellite", amount=1}},
		requester_paste_multiplier = 1
	},
	
	--satellite near planet
	{
		type = "item",
		name = "slp-ds-planet-satellite",
		icon = "__slp-dyson-sphere-reworked__/graphics/icons/planet-swarm-part.png",
		icon_size = 512,
		icon_mipmaps = 4,
		subgroup = "space-dysongroup",
		order = "a-b",
		inventory_move_sound = item_sounds.sulfur_inventory_move,
		pick_sound = item_sounds.resource_inventory_pickup,
		drop_sound = item_sounds.sulfur_inventory_move,
		stack_size = 1,
		weight = 1000 * kg,
		send_to_orbit_mode = "automated"
	},
	{
		type = "recipe",
		name = "slp-ds-planet-satellite",
		energy_required = 5,
		enabled = false,
		category = "crafting",
		ingredients =
		{
			--to do
			{type = "item", name = "radar", amount = 5},
			{type = "item", name = "processing-unit", amount = 100},
			{type = "item", name = "solar-panel", amount = 20},
			{type = "item", name = "lithium-plate",amount = 50},
			{type = "item", name = "slp-sun-fuel-mk2", amount = 10},
			{type = "item", name = "ds-entangled-core", amount = 2}
		},
		results = {{type="item", name="slp-ds-planet-satellite", amount=1}},
		requester_paste_multiplier = 1
	},
	
	--core
	{
		type = "item",
		name = "ds-entangled-core",
		icon = "__slp-dyson-sphere-reworked__/graphics/icons/ds-entangled-core.png",
		icon_size = 512,
		icon_mipmaps = 4,
		subgroup = "space-dysongroup",
		order = "c-a",
		stack_size = 10,
		weight = 100 * kg,
	},
	{
		type = "recipe",
		name = "ds-entangled-core",
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
		  {type = "item", name = "tungsten-plate", amount = 10},
		  {type = "item", name = "superconductor", amount = 1},
		  {type = "item", name = "carbon-fiber", amount = 30},
		  {type = "item", name = "uranium-fuel-cell", amount = 5},
		},
		energy_required = 20,
		results = {{type="item", name="ds-entangled-core", amount=1}},
		allow_productivity = true,
		result_is_always_fresh=true,
		main_product = "ds-entangled-core"
	},
	--connector small
	{
		type = "animation",
		name = "ds-energy-small-loader-anim",
		animation_speed = 0.3,
		frame_count = 30,
		line_length = 6,
		filename = "__slp-dyson-sphere-reworked__/graphics/ds-energy-loader/animation.png",
		priority = "high",
		shift = { 0, -1 },
		scale = 0.095,
		width = 1330,
		height = 1108,
	},
	{
		type = "electric-energy-interface",
		name = "ds-energy-small-loader",
		icon = "__slp-dyson-sphere-reworked__/graphics/ds-energy-loader/icon.png",
		icon_size = 512,
		flags = {"placeable-neutral", "placeable-player", "player-creation"},
		minable = {hardness = 0.2, mining_time = 0.5, result = "ds-energy-small-loader"},
		max_health = 250,
		energy_source = {
			type = "electric",
			usage_priority = "tertiary",
			buffer_capacity = "1J",
			render_no_power_icon = false,
		},
		surface_conditions =
    	{
				{
					property = "pressure",
					min = 0,
					max = 0
				}
    	},
		allow_copy_paste = true,
		collision_box = {{-1.5, -1.4}, {1.5, 1.4}},
		selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
		collision_mask = {layers = {item = true, meltable = true, object = true, player = true, water_tile = true, is_object = true, is_lower_object = true}},
		picture = {
		layers =
			{
				{
					filename = "__slp-dyson-sphere-reworked__/graphics/ds-energy-loader/main.png",
					priority = "high",
					width = 1330,
					height = 1108,
					shift = { 0, -1 },
					scale = 0.095,
				},
				{
					filename = "__slp-dyson-sphere-reworked__/graphics/ds-energy-loader/shadow.png",
					priority = "high",
					width = 1330,
					height = 1108,
					shift = { 0, -1 },
					scale = 0.095,
					draw_as_shadow = true,
				}
			}
		  },
		energy_production = "0kW",
		energy_usage = "0kW",
		corpse = "medium-remnants",
		subgroup = "other",
	},
	{
		type = "item",
		name = "ds-energy-small-loader",
		icon = "__slp-dyson-sphere-reworked__/graphics/ds-energy-loader/icon.png",
		icon_size = 512, 
		icon_mipmaps = 4,
		subgroup = "space-dysongroup",
		order = "c-b",
		place_result = "ds-energy-small-loader",
		stack_size = 10,
		weight = 500 * kg,
	},
	{
			type = "recipe",
			name = "ds-energy-small-loader",
			enabled = false,
			energy_required = 100,
			ingredients = 
			{
				{type = "item", name = "radar",amount = 5},
				{type = "item", name = "accumulator",amount = 100},
				{type = "item", name = "superconductor", amount = 1},
				{type = "item", name = "ds-entangled-core",amount = 1},
			},
			results = {{type="item", name="ds-energy-small-loader", amount=1}}
	},

--inplanet anim
	{
		type = "animation",
		name = "ds-energy-big-anim-off",
		animation_speed = 0.2,
		frame_count = 29,
		line_length = 6,
		filename = "__slp-dyson-sphere-reworked__/graphics/ds-energy-big-loader/hologram_off.png",
		priority = "high",
		shift = { 0, -1.55 },
		scale = 0.12,
		width = 800,
		height = 1260,
	},
	{
		type = "animation",
		name = "ds-energy-big-anim-mk1",
		animation_speed = 0.2,
		frame_count = 29,
		line_length = 6,
		filename = "__slp-dyson-sphere-reworked__/graphics/ds-energy-big-loader/hologram_mk1.png",
		priority = "high",
		shift = { 0, -1.55 },
		scale = 0.12,
		width = 800,
		height = 1260,
	},
	{
		type = "animation",
		name = "ds-energy-big-anim-mk2",
		animation_speed = 0.2,
		frame_count = 29,
		line_length = 6,
		filename = "__slp-dyson-sphere-reworked__/graphics/ds-energy-big-loader/hologram_mk2.png",
		priority = "high",
		shift = { 0, -1.55 },
		scale = 0.12,
		width = 800,
		height = 1260,
	},
	{
		type = "animation",
		name = "ds-energy-big-anim-mk3",
		animation_speed = 0.2,
		frame_count = 29,
		line_length = 6,
		filename = "__slp-dyson-sphere-reworked__/graphics/ds-energy-big-loader/hologram_mk3.png",
		priority = "high",
		shift = { 0, -1.55 },
		scale = 0.12,
		width = 800,
		height = 1260,
	},

--inplanet entity
{
	type = "electric-energy-interface",
	name = "ds-energy-loader-mk1",
	icon = "__slp-dyson-sphere-reworked__/graphics/ds-energy-big-loader/icon-mk1.png",
	icon_size = 512,
	flags = {"placeable-neutral", "placeable-player", "player-creation"},
	minable = {hardness = 0.2, mining_time = 1, result = "ds-energy-loader-mk1"},
	max_health = 250,
	energy_source = {
		type = "electric",
		usage_priority = "tertiary",
		buffer_capacity = "1J",
		render_no_power_icon = false,
	},
	allow_copy_paste = true,
	collision_box = big_collision_box,
	selection_box = big_selection_box,
	drawing_box = big_drawing_box,
	collision_mask = big_collision_mask,
	picture = {
	layers =
		{
			{
				filename = "__slp-dyson-sphere-reworked__/graphics/ds-energy-big-loader/hologram_main.png",
				priority = "high",
				width = 800,
				height = 1260,
				shift = { 0, -1.55 },
				scale = 0.095,
			},
			{
				filename = "__slp-dyson-sphere-reworked__/graphics/ds-energy-big-loader/hologram_shadow.png",
				priority = "high",
				width = 800,
				height = 1260,
				shift = { 0, -1.55 },
				scale = 0.095,
				draw_as_shadow = true,
			}
		}
	  },
	energy_production = "0kW",
	energy_usage = "0kW",
	corpse = "medium-remnants",
	subgroup = "other",
},
{
	type = "electric-energy-interface",
	name = "ds-energy-loader-mk2",
	icon = "__slp-dyson-sphere-reworked__/graphics/ds-energy-big-loader/icon-mk2.png",
	icon_size = 512,
	flags = {"placeable-neutral", "placeable-player", "player-creation"},
	minable = {hardness = 0.2, mining_time = 1, result = "ds-energy-loader-mk2"},
	max_health = 250,
	energy_source = {
		type = "electric",
		usage_priority = "tertiary",
		buffer_capacity = "1J",
		render_no_power_icon = false,
	},
	allow_copy_paste = true,
	collision_box = big_collision_box,
	selection_box = big_selection_box,
	drawing_box = big_drawing_box,
	collision_mask = big_collision_mask,
	picture = {
	layers =
		{
			{
				filename = "__slp-dyson-sphere-reworked__/graphics/ds-energy-big-loader/hologram_main.png",
				priority = "high",
				width = 800,
				height = 1260,
				shift = { 0, -1.55 },
				scale = 0.095,
			},
			{
				filename = "__slp-dyson-sphere-reworked__/graphics/ds-energy-big-loader/hologram_shadow.png",
				priority = "high",
				width = 800,
				height = 1260,
				shift = { 0, -1.55 },
				scale = 0.095,
				draw_as_shadow = true,
			}
		}
	  },
	energy_production = "0kW",
	energy_usage = "0kW",
	corpse = "medium-remnants",
	subgroup = "other",
},
{
	type = "electric-energy-interface",
	name = "ds-energy-loader-mk3",
	icon = "__slp-dyson-sphere-reworked__/graphics/ds-energy-big-loader/icon-mk3.png",
	icon_size = 512,
	flags = {"placeable-neutral", "placeable-player", "player-creation"},
	minable = {hardness = 0.2, mining_time = 1, result = "ds-energy-loader-mk3"},
	max_health = 250,
	energy_source = {
		type = "electric",
		usage_priority = "tertiary",
		buffer_capacity = "1J",
		render_no_power_icon = false,
	},
	allow_copy_paste = true,
	collision_box = big_collision_box,
	selection_box = big_selection_box,
	drawing_box = big_drawing_box,
	collision_mask = big_collision_mask,
	picture = {
	layers =
		{
			{
				filename = "__slp-dyson-sphere-reworked__/graphics/ds-energy-big-loader/hologram_main.png",
				priority = "high",
				width = 800,
				height = 1260,
				shift = { 0, -1.55 },
				scale = 0.095,
			},
			{
				filename = "__slp-dyson-sphere-reworked__/graphics/ds-energy-big-loader/hologram_shadow.png",
				priority = "high",
				width = 800,
				height = 1260,
				shift = { 0, -1.55 },
				scale = 0.095,
				draw_as_shadow = true,
			}
		}
	  },
	energy_production = "0kW",
	energy_usage = "0kW",
	corpse = "medium-remnants",
	subgroup = "other",
},
--inplanet item
{
	type = "item",
	name = "ds-energy-loader-mk1",
	icon = "__slp-dyson-sphere-reworked__/graphics/ds-energy-big-loader/icon-mk1.png",
	icon_size = 512, 
	subgroup = "space-dysongroup",
	order = "c-f-a",
	place_result = "ds-energy-loader-mk1",
	stack_size = 5,
	weight = 1000 * kg,
},
{
	type = "item",
	name = "ds-energy-loader-mk2",
	icon = "__slp-dyson-sphere-reworked__/graphics/ds-energy-big-loader/icon-mk2.png",
	icon_size = 512, 
	subgroup = "space-dysongroup",
	order = "c-f-b",
	place_result = "ds-energy-loader-mk2",
	stack_size = 5,
	weight = 1000 * kg,
},
{
	type = "item",
	name = "ds-energy-loader-mk3",
	icon = "__slp-dyson-sphere-reworked__/graphics/ds-energy-big-loader/icon-mk3.png",
	icon_size = 512,
	subgroup = "space-dysongroup",
	order = "c-f-c",
	place_result = "ds-energy-loader-mk3",
	stack_size = 5,
	weight = 1000 * kg,
},
--inplanet recipe
{
	type = "recipe",
	name = "ds-energy-loader-mk1",
	enabled = false,
	energy_required = 100,
	ingredients = 
	{
		{type = "item", name = "ds-energy-small-loader",amount = 1},
		{type = "item", name = "ds-entangled-core",amount = 5},
		{type = "item", name = "lithium-plate",amount = 30},
	},
	results = {{type="item", name="ds-energy-loader-mk1", amount=1}}
},
{
	type = "recipe",
	name = "ds-energy-loader-mk2",
	enabled = false,
	energy_required = 100,
	ingredients = 
	{
		{type = "item", name = "ds-energy-loader-mk1",amount = 1},
		{type = "item", name = "quantum-processor",amount = 10},
	},
	results = {{type="item", name="ds-energy-loader-mk2", amount=1}}
},
{
	type = "recipe",
	name = "ds-energy-loader-mk3",
	enabled = false,
	energy_required = 100,
	ingredients = 
	{
		{type = "item", name = "ds-energy-loader-mk2",amount = 1},
		{type = "item", name = "promethium-asteroid-chunk",amount = 100},
	},
	results = {{type="item", name="ds-energy-loader-mk3", amount=1}}
},
})