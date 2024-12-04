local asteroid_util = require("__space-age__.prototypes.planet.asteroid-spawn-definitions")
local sounds = require("__base__.prototypes.entity.sounds")
local space_age_sounds = require("__space-age__.prototypes.entity.sounds")
local item_sounds = require("__base__.prototypes.item_sounds")
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")
local item_tints = require("__base__.prototypes.item-tints")
local item_effects = require("__space-age__.prototypes.item-effects")

--asteroids
local plasma=table.deepcopy(data.raw["asteroid-chunk"]["carbonic-asteroid-chunk"])
plasma.name = "slp-plasma-chunk"
plasma.icon = "__slp-dyson-sphere-reworked__/graphics/icons/plasma.png"
plasma.dying_trigger_effect = nil
plasma.minable  = 
{
	mining_time = 0.2,
	result = "slp-plasma-chunk"
}
plasma.graphics_set =
	{
		rotation_speed = 1,
      	normal_strength = 1,
      	light_width = 1,
      	brightness = 1,
      	specular_strength = 3,
      	specular_power = 0,
      	specular_purity = 0,
      	sss_contrast = 1,
      	sss_amount = 0.25,
      	lights = {
       		 { color = {1,1,1}, direction = {0.7,0.4,-1} },
       		 { color = {1,1,1}, direction = {-1,-1,0} },
       		 { color = {1,1,1}, direction = {-0.4,-0.1,-1} },
     	},
     	 ambient_light = {1, 1, 1},
	 	 sprite = 
		{
			filename = "__slp-dyson-sphere-reworked__/graphics/orbit/plasma-chunk.png",
			priority = "medium",
			width = 256,
			height = 256,
			scale = 0.1
		} 
	}


local plasmaasteroid=table.deepcopy(data.raw["asteroid"]["medium-promethium-asteroid"])
plasmaasteroid.name = "slp-plasma-asteroid"
plasmaasteroid.icon = "__slp-dyson-sphere-reworked__/graphics/icons/plasma-asteroid.png"
plasmaasteroid.resistances =
{
  {
    type = "physical",
      percent = 100
  },
  {
    type = "explosion",
    percent = 60
  }
}
plasmaasteroid.graphics_set =
	{
		rotation_speed = 3,
		normal_strength = 1,
		light_width = 1,
		brightness = 1,
		specular_strength = 3,
		specular_power = 0,
		specular_purity = 0,
		sss_contrast = 1,
		sss_amount = 0.25,
		lights = {
			{ color = {1,1,1}, direction = {0.7,0.4,-1} },
			{ color = {1,1,1}, direction = {-1,-1,0} },
			{ color = {1,1,1}, direction = {-0.4,-0.1,-1} },
		},
		ambient_light = {1, 1, 1},
		-- variations = 
		-- {
		-- 	{
		-- 		color_texture =
		-- 			{
		-- 				filename = "__slp-dyson-sphere-reworked__/graphics/orbit/plasma-asteroid-1.png",
		-- 				size =  512,
		-- 				scale = 0.25
		-- 			},
		-- 		normal_map =
		-- 			{
		-- 				filename = "__slp-dyson-sphere-reworked__/graphics/orbit/plasma-asteroid-1n.png",
		-- 				size =  512,
		-- 				scale = 0.25
		-- 			},
		-- 		roughness_map =
		-- 			{
		-- 				filename = "__slp-dyson-sphere-reworked__/graphics/orbit/plasma-asteroid-1r.png",
		-- 				size =  512,
		-- 				scale = 0.25
		-- 			}
		-- 	},
		-- 	{
		-- 		color_texture =
		-- 			{
		-- 				filename = "__slp-dyson-sphere-reworked__/graphics/orbit/plasma-asteroid-2.png",
		-- 				size =  512,
		-- 				scale = 0.25
		-- 			},
		-- 		normal_map =
		-- 			{
		-- 				filename = "__slp-dyson-sphere-reworked__/graphics/orbit/plasma-asteroid-n.png",
		-- 				size =  512,
		-- 				scale = 0.25
		-- 			},
		-- 		roughness_map =
		-- 			{
		-- 				filename = "__slp-dyson-sphere-reworked__/graphics/orbit/plasma-asteroid-r.png",
		-- 				size =  512,
		-- 				scale = 0.25
		-- 			}
		-- 	},
		-- 	{
		-- 		color_texture =
		-- 			{
		-- 				filename = "__slp-dyson-sphere-reworked__/graphics/orbit/plasma-asteroid-3.png",
		-- 				size =  512,
		-- 				scale = 0.25
		-- 			},
		-- 		normal_map =
		-- 			{
		-- 				filename = "__slp-dyson-sphere-reworked__/graphics/orbit/plasma-asteroid-n.png",
		-- 				size =  512,
		-- 				scale = 0.25
		-- 			},
		-- 		roughness_map =
		-- 			{
		-- 				filename = "__slp-dyson-sphere-reworked__/graphics/orbit/plasma-asteroid-r.png",
		-- 				size =  512,
		-- 				scale = 0.25
		-- 			}
		-- 	},
		-- 	{
		-- 		color_texture =
		-- 			{
		-- 				filename = "__slp-dyson-sphere-reworked__/graphics/orbit/plasma-asteroid-4.png",
		-- 				size =  512,
		-- 				scale = 0.25
		-- 			},
		-- 		normal_map =
		-- 			{
		-- 				filename = "__slp-dyson-sphere-reworked__/graphics/orbit/plasma-asteroid-n.png",
		-- 				size =  512,
		-- 				scale = 0.25
		-- 			},
		-- 		roughness_map =
		-- 			{
		-- 				filename = "__slp-dyson-sphere-reworked__/graphics/orbit/plasma-asteroid-r.png",
		-- 				size =  512,
		-- 				scale = 0.25
		-- 			}
		-- 	}
		-- },
		sprite = 
		{
			filename = "__slp-dyson-sphere-reworked__/graphics/orbit/plasma-asteroid-1.png",
			priority = "medium",
			width = 512,
			height = 512,
			scale = 0.25
		}
    }
plasmaasteroid.dying_trigger_effect = 
	{
		type = "create-asteroid-chunk",
		asteroid_name = "slp-plasma-chunk",
		offset_deviation = {{-2, -2}, {2, 2}},
		repeat_count=3,
		offsets =
		{
			{-2, -2/4},
			{0, -2/2},
			{2, -2/4}
		},
  	}
plasmaasteroid.factoriopedia_simulation = nil


local waveasteroid=table.deepcopy(data.raw["asteroid-chunk"]["carbonic-asteroid-chunk"])
waveasteroid.name = "slp-plasmawave-asteroid"
waveasteroid.icon = "__slp-dyson-sphere-reworked__/graphics/icons/plasma-asteroid.png"
waveasteroid.hidden_in_factoriopedia=true
waveasteroid.hidden = true
-- waveasteroid.is_military_target=false
-- waveasteroid.allow_run_time_change_of_is_military_target=false
-- waveasteroid.collision_mask = {layers = {water_tile = true}, colliding_with_tiles_only=true}
waveasteroid.minable  = nil
-- waveasteroid.resistances =
-- {

-- }
waveasteroid.graphics_set =
	{
		rotation_speed = 4,
		normal_strength = 1,
		light_width = 1,
		brightness = 1,
		specular_strength = 3,
		specular_power = 0,
		specular_purity = 0,
		sss_contrast = 1,
		sss_amount = 0.25,
		lights = {
			{ color = {1,1,1}, direction = {0.7,0.4,-1} },
			{ color = {1,1,1}, direction = {-1,-1,0} },
			{ color = {1,1,1}, direction = {-0.4,-0.1,-1} },
		},
		ambient_light = {1, 1, 1},
		sprite = 
		{
			filename = "__slp-dyson-sphere-reworked__/graphics/orbit/plasmawave-asteroid.png",
			priority = "medium",
			width = 512,
			height = 512,
			scale = 0.25
		}
    }
waveasteroid.dying_trigger_effect = nil
waveasteroid.factoriopedia_simulation = nil



--asteroid spawns
local asteroid_spawns = 
{
	{
		type = "asteroid-chunk",
		asteroid = "slp-plasma-chunk",
		probability = 0.025,
		speed = 7 * meter/second,
		angle_when_stopped =1
	},
	{
		type = "asteroid-chunk",
		asteroid = "carbonic-asteroid-chunk",
		probability = 0.003,
		speed = 10 * meter/second
	},
	{
		type = "asteroid-chunk",
		asteroid = "metallic-asteroid-chunk",
		probability = 0.003,
		speed = 10 * meter/second
	},
	{
		type = "asteroid-chunk",
		asteroid = "oxide-asteroid-chunk",
		probability = 0.003,
		speed = 10 * meter/second
	},
	{
		type = "asteroid-chunk",
		asteroid = "slp-plasmawave-asteroid",
		probability = 0.01,
		speed = 15 * meter/second,
		angle_when_stopped = 1
	}
}

local asteroid_spawns2 = 
{
	{
		type = "asteroid-chunk",
		asteroid = "slp-plasma-chunk",
		probability = 0.3,
		speed = 12 * meter/second,
		angle_when_stopped =1
	},
	{
		type = "entity",
		asteroid = "slp-plasma-asteroid",
		probability = 0.005,
		speed = 3 * meter/second,
		angle_when_stopped =1
	},
	{
		type = "asteroid-chunk",
		asteroid = "slp-plasmawave-asteroid",
		probability = 0.7,
		speed = 15 * meter/second,
		angle_when_stopped = 1
	}
}

local asteroid_spawns_travel = 
{
	{
		type = "asteroid-chunk",
		asteroid = "slp-plasma-chunk",
		spawn_points = 
		{
			{
				distance = 0.6,
				probability = 0.0005,
				speed = 7 * meter/second,
				angle_when_stopped = 1
			},
			{
				distance = 0.9,
				probability = 0.01,
				speed = 7 * meter/second,
				angle_when_stopped = 1
			}
		}
	},
	{
		type = "entity",
		asteroid = "medium-metallic-asteroid",
		spawn_points = 
		{
			{
				distance = 0.4,
				probability = 0.03,
				speed = 5 * meter/second,
				angle_when_stopped = 0
			},
			{
				distance = 0.8,
				probability = 0.001,
				speed = 5 * meter/second,
				angle_when_stopped = 1
			}
		}
	},
	{
		type = "entity",
		asteroid = "medium-carbonic-asteroid",
		spawn_points = 
		{
			{
				distance = 0.7,
				probability = 0.025,
				speed = 5 * meter/second,
				angle_when_stopped = 0
			},
			{
				distance = 0.9,
				probability = 0.01,
				speed = 5 * meter/second,
				angle_when_stopped = 1
			}
		}
	},
	{
		type = "entity",
		asteroid = "medium-oxide-asteroid",
		spawn_points = 
		{
			{
				distance = 0.2,
				probability = 0.02,
				speed = 5 * meter/second,
				angle_when_stopped = 0
			},
			{
				distance = 0.6,
				probability = 0.006,
				speed = 5 * meter/second,
				angle_when_stopped = 1
			}
		}
	}
}

local asteroid_spawns_travel2 = 
{
	{
		type = "asteroid-chunk",
		asteroid = "slp-plasma-chunk",
		spawn_points = 
		{
			{
				distance = 0.6,
				probability = 0.001,
				speed = 2 * meter/second,
				angle_when_stopped = 1
			},
			{
				distance = 0.9,
				probability = 0.003,
				speed = 7 * meter/second,
				angle_when_stopped = 1
			}
		}
	},
	{
		type = "entity",
		asteroid = "medium-metallic-asteroid",
		spawn_points = 
		{
			{
				distance = 0.2,
				probability = 0.005,
				speed = 3 * meter/second,
				angle_when_stopped = 0
			},
			{
				distance = 0.5,
				probability = 0.015,
				speed = 6 * meter/second,
				angle_when_stopped = 0
			},
			{
				distance = 0.7,
				probability = 0.005,
				speed = 8 * meter/second,
				angle_when_stopped = 0
			},
			{
				distance = 0.9,
				probability = 0.001,
				speed = 3 * meter/second,
				angle_when_stopped = 1
			}
		}
	},
	{
		type = "entity",
		asteroid = "medium-carbonic-asteroid",
		spawn_points = 
		{
			{
				distance = 0.2,
				probability = 0.001,
				speed = 1 * meter/second,
				angle_when_stopped = 0
			},
			{
				distance = 0.3,
				probability = 0.004,
				speed = 3 * meter/second,
				angle_when_stopped = 0
			},
			{
				distance = 0.5,
				probability = 0.015,
				speed = 7 * meter/second,
				angle_when_stopped = 0
			},
			{
				distance = 0.8,
				probability = 0.005,
				speed = 5 * meter/second,
				angle_when_stopped = 1
			}
		}
	},
	{
		type = "entity",
		asteroid = "medium-oxide-asteroid",
		spawn_points = 
		{
			{
				distance = 0.2,
				probability = 0.005,
				speed = 3 * meter/second,
				angle_when_stopped = 0
			},
			{
				distance = 0.4,
				probability = 0.015,
				speed = 7 * meter/second,
				angle_when_stopped = 0
			},
			{
				distance = 0.65,
				probability = 0.007,
				speed = 5 * meter/second,
				angle_when_stopped = 0
			},
			{
				distance = 0.8,
				probability = 0.002,
				speed = 3 * meter/second,
				angle_when_stopped = 1
			}
		}
	}
}

local asteroid_spawns_sun_to_sun = 
{
	{
		type = "entity",
		asteroid = "slp-plasma-asteroid",
		spawn_points = 
		{
			{
				distance = 0.2,
				probability = 0.015,
				speed = 3 * meter/second,
				angle_when_stopped = 0
			},
			{
				distance = 0.5,
				probability = 0.025,
				speed = 6 * meter/second,
				angle_when_stopped = 0
			},
			{
				distance = 0.7,
				probability = 0.03,
				speed = 8 * meter/second,
				angle_when_stopped = 0
			},
			{
				distance = 0.9,
				probability = 0.01,
				speed = 3 * meter/second,
				angle_when_stopped = 0
			}
		}
	}
}


--write
data:extend(
{
	{
		type = "item",
		name = "slp-plasma-chunk",
		icon = "__slp-dyson-sphere-reworked__/graphics/orbit/plasma-chunk.png",
		icon_size = 256,
		subgroup = "space-material",
		order = "f-a",
		inventory_move_sound = item_sounds.sulfur_inventory_move,
		pick_sound = item_sounds.resource_inventory_pickup,
		drop_sound = item_sounds.sulfur_inventory_move,
		stack_size = 1,
		weight = 100 * kg,
		spoil_ticks = 1.5 * minute,
		spoil_result = nil,
		random_tint_color = { 1.0, 1.0, 1.0, 1.0 }
	},
	plasma, plasmaasteroid, waveasteroid,
	{
		type = "space-location",
		name = "slp-solar-system-sun",
		icon = "__slp-dyson-sphere-reworked__/graphics/icons/sun_icon.png",
		starmap_icon = "__slp-dyson-sphere-reworked__/graphics/orbit/sun.png",
		starmap_icon_size = 512,
		order = "b[solar-system-edge]",
		subgroup = "planets",
		gravity_pull = 100,
		distance = 6,
		orientation = 0.25,
		magnitude = 1.0,
		label_orientation = 0.15,
		asteroid_spawn_influence = 1,
		asteroid_spawn_definitions = asteroid_spawns,
		solar_power_in_space = 5000
	},
	{
		type = "space-location",
		name = "slp-solar-system-sun2",
		icon = "__slp-dyson-sphere-reworked__/graphics/icons/sun2.png",
		icon_size = 512,
		starmap_icon = "__slp-dyson-sphere-reworked__/graphics/orbit/sun2.png",
		starmap_icon_size = 512,
		order = "с[solar-system-edge]",
		subgroup = "planets",
		gravity_pull = 100,
		distance = 4.5,
		orientation = 0.35,
		magnitude = 1.0,
		label_orientation = 0.15,
		asteroid_spawn_influence = 1,
		asteroid_spawn_definitions = asteroid_spawns2,
		solar_power_in_space = 15000
	},
	{
		type = "space-connection",
		name = "slp-vulcanus-sun",
		subgroup = "planet-connections",
		from = "vulcanus",
		to = "slp-solar-system-sun",
		order = "a",
		length = 31970,
		asteroid_spawn_definitions = asteroid_spawns_travel
	},
	{
		type = "space-connection",
		name = "slp-nauvis-sun",
		subgroup = "planet-connections",
		from = "nauvis",
		to = "slp-solar-system-sun",
		order = "b",
		length = 41944,
		asteroid_spawn_definitions = asteroid_spawns_travel2
	},
	{
		type = "space-connection",
		name = "slp-sun-to-sun",
		subgroup = "planet-connections",
		from = "slp-solar-system-sun",
		to = "slp-solar-system-sun2",
		order = "c",
		length = 4687,
		asteroid_spawn_definitions = asteroid_spawns_sun_to_sun
	}
})