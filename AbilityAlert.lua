local AbilityAlert = {}

AbilityAlert.optionEnable = Menu.AddOption( {"mlambers", "Ability Alert"}, "1. Enable", "Enable this script.")

local FunctionFloor = math.floor
local ParticleData = {}
ParticleData.Table = {}
ParticleData.RoshanAttack = false 
ParticleData.RoshanAttackNextTime = 0

function AbilityAlert.OnScriptLoad()
	for i = #ParticleData.Table, 1, -1 do
		ParticleData.Table[i] = nil
	end
	
	ParticleData.Table = {}
	ParticleData.RoshanAttack = false 
	ParticleData.RoshanAttackNextTime = 0
end

function AbilityAlert.OnGameStart()
	for i = #ParticleData.Table, 1, -1 do
		ParticleData.Table[i] = nil
	end
	
	ParticleData.Table = {}
	ParticleData.RoshanAttack = false 
	ParticleData.RoshanAttackNextTime = 0
end

function AbilityAlert.OnGameEnd()
	for i = #ParticleData.Table, 1, -1 do
		ParticleData.Table[i] = nil
	end
	
	ParticleData.Table = {}
	ParticleData.RoshanAttack = false 
	ParticleData.RoshanAttackNextTime = 0
end

function AbilityAlert.GetTime()
	
	local GameTime = GameRules.GetGameTime() - GameRules.GetGameStartTime()
	local second = FunctionFloor(GameTime % 60)
	if second < 10 then
		return FunctionFloor(GameTime * 0.016666666666667 ) .. ":0" .. second
	else
		return FunctionFloor(GameTime * 0.016666666666667 ) .. ":" .. second
	end
end

function AbilityAlert.OnUnitAnimation(animation)
	if Menu.IsEnabled(AbilityAlert.optionEnable) == false then return end
	if not Heroes.GetLocal() then return end
	if animation.sequenceName == "roshan_attack" or animation.sequenceName == "roshan_attack2" then 
		if ParticleData.RoshanAttack == false then
			local FriendlyUnitRadiusChecker = NPCs.InRadius(Vector(-2319.4375, 1714.4375, 159.96875), 364, Entity.GetTeamNum(Heroes.GetLocal()), Enum.TeamType.TEAM_FRIEND)
			if #FriendlyUnitRadiusChecker < 1 then
				Chat.Print("ConsoleChat", '<font color="red"> Someone attacking roshan. </font>')
				ParticleData.RoshanAttack = true 
				ParticleData.RoshanAttackNextTime = os.clock() + 4
			end
		end
	end
end

function AbilityAlert.InsertParticleTable(particle)

	if particle.name == "smoke_of_deceit" and particle.entityForModifiers ~= nil then
		ParticleData.Table[particle.index] = {
			Index = particle.index,
			Name = particle.name,
			WhenToErase = os.clock() + 3.0,
			Position = nil,
			ShouldDraw = false,
			Duration = 5,
			Color = 2,
			MinimapIndex = nil,
			MinimapImg = "minimap_plaincircle"
		}
		return true
	elseif particle.name == "antimage_blade_hit" and particle.entity ~= nil then
		if	Entity.IsSameTeam(Heroes.GetLocal(), particle.entity) == false and Entity.IsDormant( particle.entity) == true then
			ParticleData.Table[particle.index] = {
				Index = particle.index,
				Name = particle.name,
				WhenToErase = os.clock() + 3.0,
				Position = nil,
				ShouldDraw = false,
				Duration = 1,
				Color = 1,
				MinimapIndex = nil,
				MinimapImg = "minimap_heroicon_" .. NPC.GetUnitName(particle.entity)
			}
			return true
		end
	elseif particle.name == "axe_beserkers_call_owner" and particle.entity ~= nil then
		if	Entity.IsSameTeam(Heroes.GetLocal(), particle.entity) == false and Entity.IsDormant( particle.entity) == true then
			ParticleData.Table[particle.index] = {
				Index = particle.index,
				Name = particle.name,
				WhenToErase = os.clock() + 3.0,
				Position = nil,
				ShouldDraw = false,
				Duration = 1,
				Color = 1,
				MinimapIndex = nil,
				MinimapImg = "minimap_heroicon_" .. NPC.GetUnitName(particle.entity)
			}
			return true
		end
	elseif particle.name == "clinkz_death_pact_buff" and particle.entity ~= nil then
		if	Entity.IsSameTeam(Heroes.GetLocal(), particle.entity) == false then
			ParticleData.Table[particle.index] = {
				Index = particle.index,
				Name = particle.name,
				WhenToErase = os.clock() + 3.0,
				Position = nil,
				ShouldDraw = false,
				Duration = 2,
				Color = 1,
				MinimapIndex = nil,
				MinimapImg = "minimap_heroicon_" .. NPC.GetUnitName(particle.entity)
			}
			return true
		end
	elseif particle.name == "clinkz_windwalk" and particle.entity ~= nil then
		if	Entity.IsSameTeam(Heroes.GetLocal(), particle.entity) == false then
			ParticleData.Table[particle.index] = {
				Index = particle.index,
				Name = particle.name,
				WhenToErase = os.clock() + 3.0,
				Position = nil,
				ShouldDraw = false,
				Duration = 3,
				Color = 1,
				MinimapIndex = nil,
				MinimapImg = "minimap_heroicon_" .. NPC.GetUnitName(particle.entity)
			}
			return true
		end
	elseif particle.name == "doom_bringer_devour" and particle.entity ~= nil then
		if	Entity.IsSameTeam(Heroes.GetLocal(), particle.entity) == false and Entity.IsDormant( particle.entity) == true then
			ParticleData.Table[particle.index] = {
				Index = particle.index,
				Name = particle.name,
				WhenToErase = os.clock() + 3.0,
				Position = nil,
				ShouldDraw = false,
				Duration = 2,
				Color = 1,
				MinimapIndex = nil,
				MinimapImg = "minimap_heroicon_" .. NPC.GetUnitName(particle.entity)
			}
			return true
		end
	elseif particle.name == "invoker_exort_orb" and particle.entity ~= nil then
		if	Entity.IsSameTeam(Heroes.GetLocal(), particle.entity) == false and Entity.IsDormant( particle.entity) == true then
			--Console.Print("invoker_exort_orb")
			ParticleData.Table[particle.index] = {
				Index = particle.index,
				Name = particle.name,
				WhenToErase = os.clock() + 3.0,
				Position = nil,
				ShouldDraw = false,
				Duration = 0.5,
				Color = 1,
				MinimapIndex = nil,
				MinimapImg = "minimap_heroicon_" .. NPC.GetUnitName(particle.entity)
			}
			return true
		end
	elseif particle.name == "invoker_quas_orb" and particle.entity ~= nil then
		if	Entity.IsSameTeam(Heroes.GetLocal(), particle.entity) == false and Entity.IsDormant( particle.entity) == true then
			ParticleData.Table[particle.index] = {
				Index = particle.index,
				Name = particle.name,
				WhenToErase = os.clock() + 3.0,
				Position = nil,
				ShouldDraw = false,
				Duration = 0.5,
				Color = 1,
				MinimapIndex = nil,
				MinimapImg = "minimap_heroicon_" .. NPC.GetUnitName(particle.entity)
			}
			return true
		end
	elseif particle.name == "invoker_wex_orb" and particle.entity ~= nil then
		if	Entity.IsSameTeam(Heroes.GetLocal(), particle.entity) == false and Entity.IsDormant( particle.entity) == true then
			ParticleData.Table[particle.index] = {
				Index = particle.index,
				Name = particle.name,
				WhenToErase = os.clock() + 3.0,
				Position = nil,
				ShouldDraw = false,
				Duration = 0.5,
				Color = 1,
				MinimapIndex = nil,
				MinimapImg = "minimap_heroicon_" .. NPC.GetUnitName(particle.entity)
			}
			return true
		end
	elseif particle.name == "mirana_moonlight_cast" and particle.entity ~= nil then
		if	Entity.IsSameTeam(Heroes.GetLocal(), particle.entity) == false then
			ParticleData.Table[particle.index] = {
				Index = particle.index,
				Name = particle.name,
				WhenToErase = os.clock() + 3.0,
				Position = nil,
				ShouldDraw = false,
				Duration = 5,
				Color = 1,
				MinimapIndex = nil,
				MinimapImg = "minimap_heroicon_" .. NPC.GetUnitName(particle.entity)
			}
			return true
		end
	elseif particle.name == "nevermore_necro_souls" and particle.entity ~= nil then
		if	Entity.IsSameTeam(Heroes.GetLocal(), particle.entity) == false then
			ParticleData.Table[particle.index] = {
				Index = particle.index,
				Name = particle.name,
				WhenToErase = os.clock() + 3.0,
				Position = nil,
				ShouldDraw = false,
				Duration = 1,
				Color = 1,
				MinimapIndex = nil,
				MinimapImg = "minimap_heroicon_" .. NPC.GetUnitName(particle.entity)
			}
			return true
		end
	elseif particle.name == "nyx_assassin_vendetta_start" and particle.entityForModifiers ~= nil then
		ParticleData.Table[particle.index] = {
			Index = particle.index,
			Name = particle.name,
			WhenToErase = os.clock() + 3.0,
			Position = nil,
			ShouldDraw = false,
			Duration = 5,
			Color = 2,
			MinimapIndex = nil,
			MinimapImg = "minimap_plaincircle"
		}
		return true
	elseif particle.name == "riki_blink_strike" and particle.entityForModifiers ~= nil then
		if	Entity.IsSameTeam(Heroes.GetLocal(), particle.entityForModifiers) == false and Entity.IsDormant( particle.entityForModifiers) == true then
			ParticleData.Table[particle.index] = {
				Index = particle.index,
				Name = particle.name,
				WhenToErase = os.clock() + 3.0,
				Position = nil,
				ShouldDraw = false,
				Duration = 1,
				Color = 1,
				MinimapIndex = nil,
				MinimapImg = "minimap_heroicon_" .. NPC.GetUnitName(particle.entityForModifiers)
			}
			return true
		end
	elseif particle.name == "roshan_spawn" then
		--MiniMap.AddIconByName(nil, "minimap_roshancamp", Vector(-2464.245, 2016.373), 255, 150, 0, 255, 5, 950)
		Chat.Print("ConsoleChat", '<font color="White">'.. AbilityAlert.GetTime() ..' →</font> <font color="Lime"> Roshan spawn!</font>')
		
		ParticleData.Table[particle.index] = {
			Index = particle.index,
			Name = particle.name,
			WhenToErase = os.clock() + 3.0,
			Position = Vector(-2464.245, 2016.373),
			ShouldDraw = false,
			Duration = 5,
			Color = 3,
			MinimapIndex = nil,
			MinimapImg = "minimap_roshancamp"
		}
		return true
	elseif particle.name == "roshan_slam" then
		ParticleData.Table[particle.index] = {
			Index = particle.index,
			Name = particle.name,
			WhenToErase = os.clock() + 3.0,
			Position = nil,
			ShouldDraw = false,
			Duration = 5,
			Color = 2,
			MinimapIndex = nil,
			MinimapImg = "minimap_roshancamp"
		}
		return true
	end
    return false
end

function AbilityAlert.OnParticleCreate(particle)
	if Menu.IsEnabled(AbilityAlert.optionEnable) == false then return end
	
	AbilityAlert.InsertParticleTable(particle)
end

function AbilityAlert.OnParticleUpdate(particle)
	if Menu.IsEnabled(AbilityAlert.optionEnable) == false then return end
	
	if ParticleData.Table[particle.index] then
		if particle.controlPoint == 0 then
			if ParticleData.Table[particle.index].Name == "smoke_of_deceit" then
				local firstRadiusCheck = Heroes.InRadius(particle.position, 50, Entity.GetTeamNum(Heroes.GetLocal()), Enum.TeamType.TEAM_FRIEND)
				
				if #firstRadiusCheck < 1 then 
					Chat.Print("ConsoleChat", '<font color="White">'.. AbilityAlert.GetTime() ..' →</font> <font color="Red"> Smoke of Deceit is being used.</font>')
					if particle.index > -1 then
						ParticleData.Table[particle.index].MinimapIndex = -1 * particle.index
					else
						ParticleData.Table[particle.index].Position = particle.index
					end
					
					ParticleData.Table[particle.index].Position = particle.position
				end
			elseif ParticleData.Table[particle.index].Name == "nyx_assassin_vendetta_start" then
				local firstRadiusCheck = NPCs.InRadius(particle.position, 50, Entity.GetTeamNum(Heroes.GetLocal()), Enum.TeamType.TEAM_FRIEND)
				
				if #firstRadiusCheck < 1 then 
					Chat.Print("ConsoleChat", '<font color="White">'.. AbilityAlert.GetTime() ..' →</font> <font color="Red"> Vendetta is being used.</font>')
					
					if particle.index > -1 then
						ParticleData.Table[particle.index].MinimapIndex = -1 * particle.index
					else
						ParticleData.Table[particle.index].Position = particle.index
					end
					
					ParticleData.Table[particle.index].Position = particle.position
				end
			elseif ParticleData.Table[particle.index].Name == "roshan_slam" then
				local FriendlyUnitRadiusChecker = NPCs.InRadius(Vector(-2319.4375, 1714.4375, 159.96875), 364, Entity.GetTeamNum(Heroes.GetLocal()), Enum.TeamType.TEAM_FRIEND)
				
				if #FriendlyUnitRadiusChecker < 1 then
					Chat.Print("ConsoleChat", '<font color="red"> Someone attacking roshan, Roshan Slam. </font>')
					
					if particle.index > -1 then
						ParticleData.Table[particle.index].MinimapIndex = -1 * particle.index
					else
						ParticleData.Table[particle.index].Position = particle.index
					end
					
					ParticleData.Table[particle.index].Position = particle.position
				end
			end
		end
	end
end

function AbilityAlert.OnParticleUpdateEntity(particle)
	if Menu.IsEnabled(AbilityAlert.optionEnable) == false then return end
	
	if ParticleData.Table[particle.index] then
		if particle.controlPoint == 0 then
			if ParticleData.Table[particle.index].Name == "antimage_blade_hit" then
				ParticleData.Table[particle.index].Position = particle.position
			elseif ParticleData.Table[particle.index].Name == "mirana_moonlight_cast" then
				Chat.Print("ConsoleChat", '<font color="White">'.. AbilityAlert.GetTime() ..' →</font> <font color="Red"> Enemy using Moonlight Shadow </font>')
				
				if particle.index > -1 then
					ParticleData.Table[particle.index].MinimapIndex = -1 * particle.index
				else
					ParticleData.Table[particle.index].Position = particle.index
				end
				
				ParticleData.Table[particle.index].Position = particle.position
			end
		elseif particle.controlPoint == 1 then
			if ParticleData.Table[particle.index].Name == "axe_beserkers_call_owner" then
				if particle.index > -1 then
					ParticleData.Table[particle.index].MinimapIndex = -1 * particle.index
				else
					ParticleData.Table[particle.index].Position = particle.index
				end
				
				ParticleData.Table[particle.index].Position = particle.position
			elseif ParticleData.Table[particle.index].Name == "clinkz_death_pact_buff" then
				if particle.index > -1 then
					ParticleData.Table[particle.index].MinimapIndex = -1 * particle.index
				else
					ParticleData.Table[particle.index].Position = particle.index
				end
				
				ParticleData.Table[particle.index].Position = particle.position
			elseif ParticleData.Table[particle.index].Name == "clinkz_windwalk" then
				Chat.Print("ConsoleChat", '<font color="White">'.. AbilityAlert.GetTime() ..' →</font> <font color="Red"> Windwalk is being used.</font>')
				
				if particle.index > -1 then
					ParticleData.Table[particle.index].MinimapIndex = -1 * particle.index
				else
					ParticleData.Table[particle.index].Position = particle.index
				end
				
				ParticleData.Table[particle.index].Position = particle.position
			elseif ParticleData.Table[particle.index].Name == "doom_bringer_devour" then
				if particle.index > -1 then
					ParticleData.Table[particle.index].MinimapIndex = -1 * particle.index
				else
					ParticleData.Table[particle.index].Position = particle.index
				end
				
				ParticleData.Table[particle.index].Position = particle.position
			elseif ParticleData.Table[particle.index].Name == "invoker_exort_orb" then
				if particle.index > -1 then
					ParticleData.Table[particle.index].MinimapIndex = -1 * particle.index
				else
					ParticleData.Table[particle.index].Position = particle.index
				end
				
				ParticleData.Table[particle.index].Position = particle.position
			elseif ParticleData.Table[particle.index].Name == "invoker_quas_orb" then
				if particle.index > -1 then
					ParticleData.Table[particle.index].MinimapIndex = -1 * particle.index
				else
					ParticleData.Table[particle.index].Position = particle.index
				end
				
				ParticleData.Table[particle.index].Position = particle.position
			elseif ParticleData.Table[particle.index].Name == "invoker_wex_orb" then
				if particle.index > -1 then
					ParticleData.Table[particle.index].MinimapIndex = -1 * particle.index
				else
					ParticleData.Table[particle.index].Position = particle.index
				end
				
				ParticleData.Table[particle.index].Position = particle.position
			elseif ParticleData.Table[particle.index].Name == "nevermore_necro_souls" then
				if particle.index > -1 then
					ParticleData.Table[particle.index].MinimapIndex = -1 * particle.index
				else
					ParticleData.Table[particle.index].Position = particle.index
				end
				
				ParticleData.Table[particle.index].Position = particle.position
			elseif ParticleData.Table[particle.index].Name == "riki_blink_strike" then
				if particle.index > -1 then
					ParticleData.Table[particle.index].MinimapIndex = -1 * particle.index
				else
					ParticleData.Table[particle.index].Position = particle.index
				end
				
				ParticleData.Table[particle.index].Position = particle.position
			end
		end
		
    end
end

function AbilityAlert.OnParticleDestroy(particle)
	if Menu.IsEnabled(AbilityAlert.optionEnable) == false then return end
	
	ParticleData.Table[particle.index] = nil
end


function AbilityAlert.OnDraw()
	if Engine.IsInGame() == false then return end
	if Menu.IsEnabled(AbilityAlert.optionEnable) == false then return end
	if GameRules.GetGameState() < 4 then return end
	if GameRules.GetGameState() > 5 then return end
	
	local myHero = Heroes.GetLocal()
	
	if not myHero then return end
	
	for i, value in pairs(ParticleData.Table) do
		if value then
			if value.WhenToErase <= os.clock() then
				ParticleData.Table[i] = nil
			end
			
			if value.ShouldDraw == false and value.Position ~= nil then
				if value.Color == 1 then
					MiniMap.AddIconByName(value.MinimapIndex, value.MinimapImg, value.Position, 255, 255, 255, 255, value.Duration, 950)
				elseif value.Color == 2 then
					MiniMap.AddIconByName(value.MinimapIndex, value.MinimapImg, value.Position, 255, 0, 0, 255, value.Duration, 950)
				else
					MiniMap.AddIconByName(value.MinimapIndex, value.MinimapImg, value.Position, 255, 150, 0, 255, value.Duration, 950)
				end
				value.ShouldDraw = true
			end
		end
	end
	
	if ParticleData.RoshanAttack then
		if ParticleData.RoshanAttackNextTime < os.clock() then
			ParticleData.RoshanAttackNextTime = 0 
			ParticleData.RoshanAttack = false
		else
			MiniMap.AddIconByName(nil, "minimap_plaincircle", Vector(-2464.245, 2016.373), 255, 0, 0, 255, 1, 600)
		end
	end
end

return AbilityAlert