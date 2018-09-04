---------------------------------
--- Ability Alert Version 0.5 ---
---------------------------------

local AbilityAlert = {}

AbilityAlert.optionEnable = Menu.AddOption({"mlambers", "Ability Alert"}, "1. Enable", "Enable this script.")

local ParticleManager = {
	ParticleUnique = {
		{
			Name = "roshan_spawn",
			TrackDuration = 1,
			Duration = 4,
			HasMessage = true,
			Message = "Roshan spawn!",
			Position = Vector(-2464.245, 2016.373),
			MinimapImage = "minimap_roshancamp"
		},
		{
			Name = "roshan_slam",
			TrackDuration = 1,
			Duration = 4,
			HasMessage = true,
			Message = "Someone attack Roshan.",
			MinimapImage = "minimap_roshancamp"
		},
		{
			Name = "bounty_hunter_windwalk",
			TrackDuration = 1,
			Duration = 4,
			HasMessage = true,
			Message = "bounty_hunter_windwalk is being used.",
			MinimapImage = "minimap_plaincircle"
		},
		{
			Name = "smoke_of_deceit",
			TrackDuration = 1,
			Duration = 4,
			HasMessage = true,
			Message = "Smoke of Deceit is being used.",
			MinimapImage = "minimap_plaincircle"
		},
		{
			Name = "nyx_assassin_vendetta_start",
			TrackDuration = 1,
			Duration = 4,
			HasMessage = true,
			Message = "Vendetta is being used.",
			MinimapImage = "minimap_plaincircle"
		}
	},
	ParticleNonUnique = {
		{
			Name = "antimage_blade_hit",
			TrackDuration = 1,
			Duration = 1.2,
			HasMessage = false
		},
		{
			Name = "antimage_blink_end",
			TrackDuration = 1,
			Duration = 1.5,
			HasMessage = false
		},
		{
			Name = "axe_beserkers_call_owner",
			TrackDuration = 1,
			Duration = 1.5,
			HasMessage = false
		},
		{
			Name = "bounty_hunter_hand_l",
			TrackDuration = 1,
			Duration = 2,
			HasMessage = false
		},
		{
			Name = "clinkz_death_pact_buff",
			TrackDuration = 1,
			Duration = 3,
			HasMessage = true,
			Message = "Death pact is being used."
		},
		{
			Name = "clinkz_windwalk",
			TrackDuration = 1,
			Duration = 4,
			HasMessage = true,
			Message = "clinkz_windwalk is being used."
		},
		{
			Name = "invoker_exort_orb",
			TrackDuration = 1,
			Duration = 1,
			HasMessage = false
		},
		{
			Name = "invoker_quas_orb",
			TrackDuration = 1,
			Duration = 1,
			HasMessage = false
		},
		{
			Name = "invoker_wex_orb",
			TrackDuration = 1,
			Duration = 1,
			HasMessage = false
		},
		{
			Name = "legion_commander_courage_hit",
			TrackDuration = 1,
			Duration = 1.5,
			HasMessage = false
		},
		{
			Name = "mirana_moonlight_cast",
			TrackDuration = 1,
			Duration = 5,
			HasMessage = true,
			Message = "Enemy using Moonlight Shadow."
		},
		{
			Name = "necrolyte_sadist",
			TrackDuration = 1,
			Duration = 1.5,
			HasMessage = false
		},
		{
			Name = "nevermore_necro_souls",
			TrackDuration = 1,
			Duration = 1.5,
			HasMessage = false
		},
		{
			Name = "riki_blink_strike",
			TrackDuration = 1,
			Duration = 1.5,
			HasMessage = false
		},
		{
			Name = "tinker_rearm",
			TrackDuration = 1,
			Duration = 1.5,
			HasMessage = false
		},
		{
			Name = "doom_bringer_devour",
			TrackDuration = 1,
			Duration = 1.5,
			HasMessage = false
		}
	},
	GetParticleUpdateZeroUnique = {
		bounty_hunter_windwalk = true,
		nyx_assassin_vendetta_start = true,
		roshan_slam = true,
		smoke_of_deceit = true
	},
	GetParticleUpdateEntityZero = {
		antimage_blade_hit = true,
		bounty_hunter_hand_l = true,
		mirana_moonlight_cast = true
	},
	GetParticleUpdateEntityOne = {
		antimage_blink_end = true,
		axe_beserkers_call_owner = true,
		clinkz_death_pact_buff = true,
		clinkz_windwalk = true,
		doom_bringer_devour = true,
		invoker_exort_orb = true,
		invoker_quas_orb = true,
		invoker_wex_orb = true,
		legion_commander_courage_hit = true,
		necrolyte_sadist = true,
		nevermore_necro_souls = true,
		riki_blink_strike = true,
		tinker_rearm = true
	}
}

local FunctionFloor = math.floor
local ParticleData = {}

function AbilityAlert.OnScriptLoad()
	for i = #ParticleData, 1, -1 do
		ParticleData[k] = nil
	end
	
	ParticleData = {}
	
	Console.Print("AbilityAlert.OnScriptLoad()")
end

function AbilityAlert.OnGameStart()
	for i = #ParticleData, 1, -1 do
		ParticleData[k] = nil
	end
	
	ParticleData = {}
	
	Console.Print("AbilityAlert.OnGameStart()")
end

function AbilityAlert.OnGameEnd()
	for i = #ParticleData, 1, -1 do
		ParticleData[k] = nil
	end
	
	ParticleData = {}
	
	Console.Print("AbilityAlert.OnGameEnd()")
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

function AbilityAlert.GetDataUnique(particle)
	local idx = nil
	
	for _, v in pairs(ParticleManager.ParticleUnique) do
		if particle.name == v.Name then
			idx = particle.index
			
			if idx > -1 then
				idx = idx * -1
			end
			
			table.insert(ParticleData, {
								index = particle.index,
								name = v.Name,
								TrackUntil = os.clock() + v.TrackDuration,
								entity = particle.entity or nil,
								PrintMessage = v.HasMessage,
								Msg = v.Message or nil,
								duration = v.Duration,
								Position =  v.Position or nil,
								DrawIcon = nil,
								IconIndex = idx,
								Texture = v.MinimapImage,
								DoneDraw = false
							}
						)
			
			return true
		end
	end
	return false
end

function AbilityAlert.GetData(particle)
	local idx = nil
	
	for _, v in pairs(ParticleManager.ParticleNonUnique) do
		if particle.name == v.Name then
			idx = particle.index
			
			if idx > -1 then
				idx = idx * -1
			end
			
			table.insert(ParticleData, {
								index = particle.index,
								name = v.Name,
								TrackUntil = os.clock() + v.TrackDuration,
								entity = particle.entity or nil,
								PrintMessage = v.HasMessage,
								Msg = v.Message or nil,
								duration = v.Duration,
								Position = nil,
								DrawIcon = nil,
								IconIndex = idx,
								Texture = nil,
								DoneDraw = false
							}
						)
			
			return true
		end
	end
	return false
end

function AbilityAlert.OnParticleCreate(particle)
	if Menu.IsEnabled(AbilityAlert.optionEnable) == false then return end
	if Heroes.GetLocal() == nil then return end
	
	if AbilityAlert.GetData(particle) == false then
		AbilityAlert.GetDataUnique(particle)
	end
end

function AbilityAlert.OnParticleUpdate(particle)
	if Menu.IsEnabled(AbilityAlert.optionEnable) == false then return end
	if Heroes.GetLocal() == nil then return end
	
	local tableValue = nil
    
	for i = 1, #ParticleData do
		tableValue = ParticleData[i]
        if tableValue ~= nil and particle.index == tableValue.index then
			if particle.controlPoint == 0 then
				if ParticleManager.GetParticleUpdateZeroUnique[tableValue.name] then
					if tableValue.Position == nil then
						local FriendlyUnit = Heroes.InRadius(particle.position, 50, Entity.GetTeamNum(Heroes.GetLocal()), Enum.TeamType.TEAM_FRIEND)
						
						if #FriendlyUnit < 1 then 
							ParticleData[i].Position = particle.position
						end
					end
				end
			end
        end
    end
end

function AbilityAlert.OnParticleUpdateEntity(particle)
	if Menu.IsEnabled(AbilityAlert.optionEnable) == false then return end
	if Heroes.GetLocal() == nil then return end
	
	local tableValue = nil
    
	for i = 1, #ParticleData do
		tableValue = ParticleData[i]
        if tableValue ~= nil and particle.index == tableValue.index and particle.entity ~= nil then
			if particle.controlPoint == 0 and ParticleManager.GetParticleUpdateEntityZero[tableValue.name] then
				if tableValue.Position == nil and Entity.IsSameTeam(Heroes.GetLocal(), particle.entity) == false then
					
					ParticleData[i].Texture = "minimap_heroicon_" .. NPC.GetUnitName(particle.entity)
					ParticleData[i].Position = particle.position
				
				end
			end
			
			if particle.controlPoint == 1 and ParticleManager.GetParticleUpdateEntityOne[tableValue.name] then
				if tableValue.Position == nil and Entity.IsSameTeam(Heroes.GetLocal(), particle.entity) == false then
					ParticleData[i].Texture = "minimap_heroicon_" .. NPC.GetUnitName(particle.entity)
					ParticleData[i].Position = particle.position
				end
			end
        end
    end
end

function AbilityAlert.OnDraw()
	if Engine.IsInGame() == false then return end
	if Menu.IsEnabled(AbilityAlert.optionEnable) == false then return end
	if Heroes.GetLocal() == nil then return end
	
	local tableValue = nil

	for i = 1, #ParticleData do
		tableValue = ParticleData[i]
		if tableValue ~= nil then
			if (tableValue.TrackUntil - os.clock()) < 0 then
				ParticleData[i] = nil
			end
			
			if tableValue.Position ~= nil and tableValue.DoneDraw == false then
				MiniMap.AddIconByName(tableValue.IconIndex, tableValue.Texture, tableValue.Position, 255, 255, 255, 255, tableValue.duration, 900)
				
				if tableValue.PrintMessage then
					Chat.Print("ConsoleChat", '<font color="White">'.. AbilityAlert.GetTime() ..' →</font> <font color="Red">'.. tableValue.Msg .. '</font>')
				end
				
				ParticleData[i].DoneDraw = true
			end
		end
	end
end

return AbilityAlert