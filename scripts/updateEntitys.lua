local stage1 = 7130;
local stage2 = 14260;
local stage3 = 21390;


function command (event)
	if event.command == "dysonmod" then 
	
		local par = splitString(event.parameters," ")
		local v1 = par[1]
		
		if v1=="dyson" then 
			local v2 = par[2]
			local num = tonumber(par[3])
			local ok = false
			
			if v2=="set" then
				storage.dysonsphere = num
				ok=true
			elseif v2=="add" then 
				storage.dysonsphere = storage.dysonsphere+num
				ok=true
			elseif v2=="get" then 
				for _, player in pairs(game.players) do
					if player.index == event.player_index then
						player.print("Number of dyson satellites is " .. storage.dysonsphere)
					end
				end
			end
			
			if ok==true then
				for _, player in pairs(game.players) do
					if player.index == event.player_index then
						player.print("Number of dyson satellites changed to " .. storage.dysonsphere)
					end
				end
				
				change_output()
			end
			
		elseif v1 == "planet" then
			local planet = par[2]
			local v2 = par[3]
			local num = tonumber(par[4])
			local ok = false
			
			if storage.dysonloader[planet] ~=nil then
				
				if v2=="set" then
				storage.dysonloader[planet] = num
				ok=true
				elseif v2=="add" then 
					storage.dysonloader[planet] = storage.dysonloader[planet]+num
					ok=true
				elseif v2=="get" then
					for _, player in pairs(game.players) do
						if player.index == event.player_index then
							player.print("Number of planet satellites in ".. planet .. " is " .. storage.dysonloader[planet])
						end
					end
				end
				
				if ok==true then
					
					local val = storage.dysonloader[planet]
					for _, player in pairs(game.players) do
						if player.index == event.player_index then
							player.print("Number of planet satellites changed in ".. planet .. " to " .. val .. ". Launch one energy retranslator to update values")
						end
					end
				end
				
			else
				
				for _, player in pairs(game.players) do
					if player.index == event.player_index then
						player.print("Failed to get planet " .. planet .. ". You need to launch at least one energy retranslator to change this value")
					end
				end
				
			end
		end
	end
end

function splitString(input, delimiter)
    local result = {}
    local pattern = string.format("([^%s]+)", delimiter)
    for word in string.gmatch(input, pattern) do
        table.insert(result, word)
    end
    return result
end

function platformArrived(event)
	local platform = event.platform
	
	if platform.space_location ~= nil and  platform.space_location.name == "slp-solar-system-sun" then 
		for _, player in pairs(game.players) do
			if player.character ~= nil and player.surface == platform.surface then
				if settings.startup["ds-sun-killer"].value then
				player.print({"pl-to-die",player.name,platform.name})
				player.character.damage(1000000000, "enemy")
				end
			end
		end
	end
end

function rocketLaunched(event)
	if event.rocket and event.rocket.valid then	
		if event.rocket.cargo_pod then
			local inv = event.rocket.cargo_pod

			if inv.get_item_count("slp-ds-satellite") > 0 then

				inv.clear_items_inside()
				
				if (storage.dysonsphere == nil)
				then 
					storage.dysonsphere = 1
				else
					storage.dysonsphere = storage.dysonsphere+1
				end
				
				change_output()

				for _, player in pairs(game.players) do 
					if settings.get_player_settings(player.index)["ds-show-messages-dyson"].value then
						player.print({"ds-launched",storage.dysonsphere})
					end
				end
			
			elseif inv.get_item_count("slp-ds-planet-satellite") > 0 then 
				
				if storage.dysonloader == nil then
					storage.dysonloader = { }
				end

				inv.clear_items_inside()
				
				if (storage.dysonloader[event.rocket_silo.surface.name] == nil) then 
					storage.dysonloader[event.rocket_silo.surface.name] = 1
				else
					storage.dysonloader[event.rocket_silo.surface.name] = storage.dysonloader[event.rocket_silo.surface.name]+1
				end
				
				check_planet(event.rocket_silo.surface)
			end
		end
	end
end

function UpdateAll(entity,add) 
	if entity ~=nil then
		if entity.name == "ds-energy-small-loader" then
			if add==true then
				storage.generators[entity.unit_number] = entity
				
				if storage.generators_light[entity.unit_number] then
					storage.generators_light[entity.unit_number].destroy()
				end
				storage.generators_light[entity.unit_number] = rendering.draw_light
				{
					sprite = "utility/light_medium", 
					scale = 1,
					color = {253,233,16},
					surface = entity.surface, 
					target = entity,
				}
				
				if storage.generators_anim[entity.unit_number] then
					storage.generators_anim[entity.unit_number].destroy()
				end
				storage.generators_anim[entity.unit_number] = rendering.draw_animation
				{
					animation = "ds-energy-small-loader-anim",
					target = entity,
					surface = entity.surface,
					render_layer = "object",
				}
			else
				remove_entity(entity)
			end
			change_output()
			
		elseif entity.name == "ds-energy-loader-mk1" or entity.name == "ds-energy-loader-mk2" or entity.name == "ds-energy-loader-mk3" then
			if add==true then
				storage.generators[entity.unit_number] = entity

				if entity.surface.platform ~= nil then
					add_big_anim(entity)
				else
					if (getpersentofretrans(entity.surface.name)==100) then
						add_big_anim(entity)
					else
						set_big_off_anim(entity)
					end
				end
			else
				remove_entity(entity)
			end
			
			change_output()
		end
	end
end

function remove_entity(entity)
	if storage.generators[entity.unit_number] ~= nil then
		storage.generators[entity.unit_number] = nil
	end

	if storage.generators_light[entity.unit_number] then
		storage.generators_light[entity.unit_number].destroy()
		storage.generators_light[entity.unit_number] = nil
	end
	if storage.generators_anim[entity.unit_number] then
		storage.generators_anim[entity.unit_number].destroy()
		storage.generators_anim[entity.unit_number] = nil
	end

	if storage.generators_text[entity.unit_number] then
		storage.generators_text[entity.unit_number].destroy()
		storage.generators_text[entity.unit_number] = nil
	end
end

local need_for_nauvis=500
--local need_for_nauvis=4
local need_for_vulcanus=300
local need_for_gleba=500
local need_for_fulgora=1000
local need_for_aquilo=100

--cheking how much on this planet
function check_planet(surface)
	local name = surface.name
	local done =false
	local havenow = storage.dysonloader[name]
	local fullneed = 100

	if name=="nauvis" and havenow>need_for_nauvis then 
		done=true
		fullneed=need_for_nauvis
	elseif name=="vulcanus" and havenow>need_for_vulcanus then
		done=true
		fullneed=need_for_vulcanus
	elseif name=="gleba" and havenow>need_for_gleba then
		done=true
		fullneed=need_for_gleba
	elseif name=="fulgora" and havenow>need_for_fulgora then
		done=true
		fullneed=need_for_fulgora
	elseif name=="aquilo" and havenow>need_for_aquilo then
		done=true
		fullneed=need_for_aquilo
	end

	if done then
		return
	else 
		if havenow == gethowmuchneedretrans(name) then
			enable_all_on_planet(surface)

			for _, player in pairs(game.players) do 
				if settings.get_player_settings(player.index)["ds-show-messages-dyson"].value then
					player.print({"plst-done",surface.localised_name})
				end
			end
		else 
			for ind,entity in pairs(storage.generators) do
				if entity.valid then 
					if entity.surface == surface then
						
						local line1 = {"ds-building-planet"}
						local line2 = getpersentofretrans(name).."%"

						if storage.generators_text[entity.unit_number] then
							storage.generators_text[entity.unit_number].destroy()
							storage.generators_text[entity.unit_number] = nil
						end
	
						if storage.generators_text2[entity.unit_number] then
							storage.generators_text2[entity.unit_number].destroy()
							storage.generators_text2[entity.unit_number] = nil
						end

						storage.generators_text[entity.unit_number] = rendering.draw_text{
							text  = line1, 
							scale = 1,
							color = {120,200,200},
							surface = entity.surface, 
							target = {entity = entity, offset = {0, -2.55}},
							only_in_alt_mode =true,
							draw_on_ground =false,
							alignment = "center",
							use_rich_text =false,
						}
						storage.generators_text2[entity.unit_number] = rendering.draw_text{
							text  = line2, 
							scale = 1,
							color = {120,200,200},
							surface = entity.surface, 
							target = {entity = entity, offset = {0, -2.15}},
							only_in_alt_mode =true,
							draw_on_ground =false,
							alignment = "center",
							use_rich_text =false,
						}

					end
				else
					remove_entity(entity)
				end
			end

			for _, player in pairs(game.players) do 
				if settings.get_player_settings(player.index)["ds-show-messages-planet"].value then
					player.print({"plst-launched",havenow.. "/" .. gethowmuchneedretrans(name), surface.name})
				end
			end
		end
	end
end

--enabling all outputs on planet
function enable_all_on_planet(surface)
	for ind,entity in pairs(storage.generators) do
		if entity.valid then 
			if entity.surface == surface then
				add_big_anim(entity)
			end
		else
			remove_entity(entity)
		end
	end

	change_output()
end

function add_big_anim(entity)
	local placeto = "ds-energy-big-anim-mk1"

	if entity.name == "ds-energy-loader-mk1" then 
		placeto = "ds-energy-big-anim-mk1"
	elseif entity.name == "ds-energy-loader-mk2" then 
		placeto = "ds-energy-big-anim-mk2"
	elseif entity.name == "ds-energy-loader-mk3" then 
		placeto = "ds-energy-big-anim-mk3"
	end

	if storage.generators_light[entity.unit_number] then
		storage.generators_light[entity.unit_number].destroy()
	end
	if storage.generators_anim[entity.unit_number] then
		storage.generators_anim[entity.unit_number].destroy()
	end

	storage.generators_anim[entity.unit_number] = rendering.draw_animation{
		animation = placeto,
		target = entity,
		surface = entity.surface,
		render_layer = "object",
	}
	
	storage.generators_light[entity.unit_number] = rendering.draw_light{
		sprite = "utility/light_medium", 
		scale = 2,
		color = {190,255,255},
		surface = entity.surface, 
		target = entity,
	}
end

function set_big_off_anim(entity)
local placeto = "ds-energy-big-anim-off"

	if storage.generators_light[entity.unit_number] then
		storage.generators_light[entity.unit_number].destroy()
	end
	if storage.generators_anim[entity.unit_number] then
		storage.generators_anim[entity.unit_number].destroy()
	end

	storage.generators_anim[entity.unit_number] = rendering.draw_animation{
		animation = placeto,
		target = entity,
		surface = entity.surface,
		render_layer = "object",
	}
	storage.generators_light[entity.unit_number] = rendering.draw_light{
		sprite = "utility/light_medium", 
		scale = 2,
		color = {190,255,255},
		surface = entity.surface, 
		target = entity,
	}
	
	local line1 = {"ds-building-planet"}
	local line2 = getpersentofretrans(entity.surface.name).."%"
	if storage.generators_text[entity.unit_number] then
		storage.generators_text[entity.unit_number].destroy()
		storage.generators_text[entity.unit_number] = nil
	end
	
	if storage.generators_text2[entity.unit_number] then
		storage.generators_text2[entity.unit_number].destroy()
		storage.generators_text2[entity.unit_number] = nil
	end

	storage.generators_text[entity.unit_number] = rendering.draw_text{
		text  = line1, 
		scale = 1,
		color = {120,200,200},
		surface = entity.surface, 
		target = {entity = entity, offset = {0, -2.55}},
		only_in_alt_mode =true,
		draw_on_ground =false,
		alignment = "center",
		use_rich_text =false,
	}
	storage.generators_text2[entity.unit_number] = rendering.draw_text{
		text  = line2, 
		scale = 1,
		color = {120,200,200},
		surface = entity.surface, 
		target = {entity = entity, offset = {0, -2.15}},
		only_in_alt_mode =true,
		draw_on_ground =false,
		alignment = "center",
		use_rich_text =false,
	}
end

function change_output()
	storage.generators_usage = getGeneratorsCount(storage.generators)

	if storage.dysonsphere > 0 and storage.generators_usage > 0 then
		local productivity = storage.dysonsphere / storage.generators_usage
		if productivity > 1 then
			productivity=1
		end
		
		local txtline1 = storage.dysonsphere .. "/"..storage.generators_usage
		local txtline2 = ""
		if productivity~=1 then
			txtline2 = {"ds-eff"," ("..tostring(math.floor(productivity*100)).."%)"}
		end

		for ind,entity in pairs(storage.generators) do
			if entity.valid then 
				if entity.name == "ds-energy-small-loader" then
					entity.power_production = ((1  * 100000) /7)* productivity --1MW
					entity.electric_buffer_size = ((1  * 100000) /7)* productivity

					if storage.generators_text[entity.unit_number] then
						storage.generators_text[entity.unit_number].destroy()
						storage.generators_text[entity.unit_number] = nil
					end

					if storage.generators_text2[entity.unit_number] then
						storage.generators_text2[entity.unit_number].destroy()
						storage.generators_text2[entity.unit_number] = nil
					end

					storage.generators_text[entity.unit_number] = rendering.draw_text{
						text  = txtline1, 
						scale = 1,
						color = {255,239,161},
						surface = entity.surface, 
						target = {entity = entity, offset = {0, -1.8}},
						only_in_alt_mode =true,
						draw_on_ground =false,
						alignment = "center",
						use_rich_text =false,
					}
					storage.generators_text2[entity.unit_number] = rendering.draw_text{
						text  = txtline2, 
						scale = 1,
						color = {255,239,161},
						surface = entity.surface, 
						target = {entity = entity, offset = {0, -1.42}},
						only_in_alt_mode =true,
						draw_on_ground =false,
						alignment = "center",
						use_rich_text =false,
					}
				elseif entity.name == "ds-energy-loader-mk1" or entity.name == "ds-energy-loader-mk2" or entity.name == "ds-energy-loader-mk3" then

					local energymult = 1

					if entity.name == "ds-energy-loader-mk1" then
						energymult = 50
					elseif entity.name == "ds-energy-loader-mk2" then
						energymult = 250
					elseif entity.name == "ds-energy-loader-mk3" then
						energymult = 1000
					end

					local done =false

					if entity.surface.platform ~= nil then 
						done=true
					else 
						local surfname = entity.surface.name
						local havenow = storage.dysonloader[surfname]

						if havenow==nil then
							done=false
						else 
							if surfname=="nauvis" and havenow>=need_for_nauvis then 
								done=true
							elseif surfname=="vulcanus" and havenow>=need_for_vulcanus then
								done=true
							elseif surfname=="gleba" and havenow>=need_for_gleba then
								done=true
							elseif surfname=="fulgora" and havenow>=need_for_fulgora then
								done=true
							elseif surfname=="aquilo" and havenow>=need_for_aquilo then
								done=true
							end
						end
					end

					if done then
						entity.power_production = ((1  * 100000) /7)* productivity * energymult 
						entity.electric_buffer_size = ((1  * 100000) /7)* productivity * energymult

						if storage.generators_text[entity.unit_number] then
							storage.generators_text[entity.unit_number].destroy()
							storage.generators_text[entity.unit_number] = nil
						end

						if storage.generators_text2[entity.unit_number] then
							storage.generators_text2[entity.unit_number].destroy()
							storage.generators_text2[entity.unit_number] = nil
						end

						storage.generators_text[entity.unit_number] = rendering.draw_text{
							text  = txtline1, 
							scale = 1,
							color = {120,200,200},
							surface = entity.surface, 
							target = {entity = entity, offset = {0, -2.55}},
							only_in_alt_mode =true,
							draw_on_ground =false,
							alignment = "center",
							use_rich_text =false,
						}
						storage.generators_text2[entity.unit_number] = rendering.draw_text{
							text  = txtline2, 
							scale = 1,
							color = {120,200,200},
							surface = entity.surface, 
							target = {entity = entity, offset = {0, -2.15}},
							only_in_alt_mode =true,
							draw_on_ground =false,
							alignment = "center",
							use_rich_text =false,
						}
					end
				end
			else 
				remove_entity(entity)
			end
		end
	else 
		if storage.dysonsphere<0 then
			storage.dysonsphere=0
		end
	end
end

function getpersentofretrans(name) 
	local lauched = storage.dysonloader[name]
	if lauched == nil then
		return 0
	end
		
	local required = gethowmuchneedretrans(name)
	
	local perc = lauched/required
	if perc >1 then
		perc=1
	end

	return math.floor(perc*100)
end

function gethowmuchneedretrans(name) 
	if name=="nauvis" then 
		return need_for_nauvis
	elseif name=="vulcanus" then
		return need_for_vulcanus
	elseif name=="gleba" then
		return need_for_gleba
	elseif name=="fulgora" then
		return need_for_fulgora
	elseif name=="aquilo" then
		return need_for_aquilo
	end

	return 100
end


function getGeneratorsCount(t)
    local count = 0
    for ind,entity in pairs(t) do
		if entity.valid then 
			if entity.name == "ds-energy-small-loader" then
				count = count + 1
			elseif entity.name == "ds-energy-loader-mk1" then 
				count = count + 50
			elseif entity.name == "ds-energy-loader-mk2" then 
				count = count + 250
			elseif entity.name == "ds-energy-loader-mk3" then 
				count = count + 1000
			end
		end
    end
    return count
end


function rocketLaunchedOld(event)
  local rocket_inventory = event.rocket.get_inventory(1)
  if rocket_inventory.get_item_count("ds-satellite") == 0 then
    return
  end
	if global.dysonsphere<stage3 then
		global.dysonsphere = global.dysonsphere+1
		for _, player in pairs(game.players) do 
			if settings.get_player_settings(player)["ds-show-messages"].value then
				player.print({"ds-launched",global.dysonsphere})
				player.print({"ds-persent",math.floor(global.dysonsphere/stage3*100)})
			end
		end
		change_output()
		update_all_setup_interfaces()
	end
end

function UpdateAllold(entity,add) 
	if entity.name == "ds-energy-loader" then
		if add==true then
			global.generators[entity.unit_number] = entity
			global.generators_count = global.generators_count + 1
			--game.players[1].print("placed "..global.generators_count .." arr " .. table_size(global.generators))
		else
			if global.generators[entity.unit_number] ~= nil then
				global.generators[entity.unit_number] = nil
				
				if global.generators_light[entity.unit_number] then
					rendering.destroy(global.generators_light[entity.unit_number])
					global.generators_light[entity.unit_number] = nil
				end
				if global.generators_anim[entity.unit_number] then
					rendering.destroy(global.generators_anim[entity.unit_number])
					global.generators_anim[entity.unit_number] = nil
				end
				
				global.generators_count = global.generators_count - 1
				--game.players[1].print("removed "..global.generators_count .. " arr " .. table_size(global.generators))
			end
		end
	
		change_output() 
		
	elseif entity.name=="ds-energy-interface" then
		if add==true then
			global.holograms[entity.unit_number] = entity
			global.holograms_count = global.holograms_count + 1
			setup_interface(entity,entity.unit_number)
		else
			if global.holograms[entity.unit_number] ~= nil then
				global.holograms[entity.unit_number] = nil
				
				if global.holograms_render[ind] then
					rendering.destroy(global.holograms_render[ind])
					global.holograms_render[ind] = nil
				end
				if global.holograms_light[ind] then
					rendering.destroy(global.holograms_light[ind])
					global.holograms_light[ind] = nil
				end
				if global.holograms_text[ind] then
					rendering.destroy(global.holograms_text[ind])
					global.holograms_text[ind] = nil
				end
				
				global.holograms_count = global.holograms_count - 1
			end
		end
		--updateEnetityInterface(true)
	end
end

function update_all_setup_interfaces () 
	for ind,entity in pairs(global.holograms) do
		if entity.valid then 
			setup_interface(entity, ind)
		else
			global.holograms[ind] = nil
			global.holograms_count = global.holograms_count - 1
			
			if global.holograms_render[ind] then
				rendering.destroy(global.holograms_render[ind])
				global.holograms_render[ind] = nil
			end
			if global.holograms_light[ind] then
				rendering.destroy(global.holograms_light[ind])
				global.holograms_light[ind] = nil
			end
			if global.holograms_text[ind] then
				rendering.destroy(global.holograms_text[ind])
				global.holograms_text[ind] = nil
			end
		end
	end
end

function setup_interface (entity, ind) 
	--startup loading
	local placeto = "ds-energy-interface-st1"
		if global.dysonsphere >= stage3 then
			placeto = "ds-energy-interface-st4"
			if global.show_message_stage == 2 then
				game.surfaces["nauvis"].freeze_daytime = true
				game.surfaces["nauvis"].daytime = 0.5
				for _, player in pairs(game.players) do 
					if settings.get_player_settings(player)["ds-show-messages"].value then
						player.print({"ds-complete"})
						player.print({"ds-no-sun"})
					end
				end
				global.show_message_stage = 3
			end
		elseif global.dysonsphere >= stage2 then
			placeto = "ds-energy-interface-st3"
			if global.show_message_stage == 1 then
				for _, player in pairs(game.players) do 
					if settings.get_player_settings(player)["ds-show-messages"].value then
						player.print({"ds-two-three"})
					end
				end
				global.show_message_stage = 2
			end
		elseif global.dysonsphere >= stage1 then
			placeto = "ds-energy-interface-st2"
			if global.show_message_stage == 0 then
				for _, player in pairs(game.players) do 
					if settings.get_player_settings(player)["ds-show-messages"].value then
						player.print({"ds-one-three"})
					end
				end
				global.show_message_stage = 1
			end
		end
	
	if global.holograms_render[ind] then
		rendering.destroy(global.holograms_render[ind])
	end
	if global.holograms_light[ind] then
		rendering.destroy(global.holograms_light[ind])
	end
	if global.holograms_text[ind] then
		rendering.destroy(global.holograms_text[ind])
	end
	
	global.holograms_render[ind] = rendering.draw_animation{
		animation = placeto,
		target = entity,
		surface = entity.surface,
		render_layer = "object",
	}
	global.holograms_light[ind] = rendering.draw_light{
		sprite = "utility/light_medium", 
		scale = 2,
		color = {190,255,255},
		surface = entity.surface, 
		target = entity,
	}
	global.holograms_text[ind] = rendering.draw_text{
		text  = global.dysonsphere, 
		scale = 1,
		color = {120,200,200},
		surface = entity.surface, 
		target = entity,
		only_in_alt_mode =true,
		draw_on_ground =false,
		target_offset = {0, -2.55},
		alignment = "center",
	}
end

function change_outputold()
	if global.generators_count > 0 then 
		for ind,entity in pairs(global.generators) do
			if entity.valid then 
				entity.power_production = (((global.dysonsphere^3)/10000000)+global.dysonsphere) / global.generators_count * 1000000 / 60
				entity.electric_buffer_size = (((global.dysonsphere^3)/10000000)+global.dysonsphere) / global.generators_count * 1000000 / 60
				
				if global.generators_light[entity.unit_number] then
					rendering.destroy(global.generators_light[entity.unit_number])
				end
				global.generators_light[entity.unit_number] = rendering.draw_light{
					sprite = "utility/light_medium", 
					scale = 1,
					color = {253,233,16},
					surface = entity.surface, 
					target = entity,
				}
				
				if global.generators_anim[entity.unit_number] then
					rendering.destroy(global.generators_anim[entity.unit_number])
				end
				global.generators_anim[entity.unit_number] = rendering.draw_animation{
					animation = "ds-energy-loader-anim",
					target = entity,
					surface = entity.surface,
					render_layer = "object",
				}
			else 
				global.generators[ind] = nil
				global.generators_count = global.generators_count - 1
			end
		end
	end
end

