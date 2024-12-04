require "util"
require "scripts.updateEntitys"

script.on_configuration_changed(function()

    -- First increase maximum allowed stack size
end)

script.on_event(defines.events.on_space_platform_changed_state,function(event)
  platformArrived(event)
end)

script.on_event(defines.events.on_rocket_launched,function(event)
  rocketLaunched(event)
end)

script.on_event(defines.events.on_rocket_launch_ordered,function(event)
  rocketLaunched(event)
end)

--/c __slp-dyson-sphere-reworked__ game.player.print(serpent.dump(storage))
script.on_init(function(event)
	genFirst(event)
end)

script.on_configuration_changed(function(event)
	--genFirst(event)
end)


function genFirst(entity) 
	storage.dysonsphere = 0
	storage.dysonloader = {}
	storage.generators = {}
	storage.generators_type = {}
	storage.generators_light = {}
	storage.generators_anim = {}
	storage.generators_text = {}
	storage.generators_text2 = {}
	storage.generators_usage = 0

	--[[for _, player in pairs(game.players) do 
		player.print("Updated!")
	end--]]

    -- global.generators = {}
    -- global.generators_count = 0
	-- global.generators_light = {}
	-- global.generators_anim = {}
	-- global.holograms = {}
	-- global.holograms_count = 0
	-- global.holograms_render = {}
	-- global.holograms_light = {}
	-- global.holograms_text = {}
	-- global.show_message_stage = 0
end

script.on_event(defines.events.on_console_command,function(event)
	command(event)
end)



script.on_event(defines.events.on_robot_built_entity,function(event)
	UpdateAll(event.entity,true)
end)

script.on_event(defines.events.on_built_entity,function(event)
	UpdateAll(event.entity ,true)
end)

script.on_event(defines.events.script_raised_built,function(event)
	UpdateAll(event.entity,true)
end)

script.on_event(defines.events.on_space_platform_built_entity,function(event)
	UpdateAll(event.entity,true)
end)

script.on_event(defines.events.on_player_mined_entity,function(event)
	UpdateAll(event.entity,false)
		
end)

script.on_event(defines.events.on_robot_pre_mined,function(event)
	UpdateAll(event.entity,false)
end)

script.on_event(defines.events.on_entity_died,function(event)
	UpdateAll(event.entity,false)
end)

script.on_event(defines.events.script_raised_destroy,function(event)
	UpdateAll(event.entity,false)
end)

script.on_event(defines.events.on_space_platform_mined_entity,function(event)
	UpdateAll(event.entity,false)
end)