---------------------------------
--- Ability Alert Version 0.6 ---
---------------------------------

local AbilityAlert  = {}

AbilityAlert.OptionEnable = Menu.AddOption({"mlambers", "Ability Alert"}, "1. Enable", "Enable this script.")

--[[
	Array index number 1 represent ParticleUnique.
	Array index number 2 represent ParticleNonUnique.
	Array index number 3 represent GetParticleUpdateZeroUnique.
	Array index number 4 represent GetParticleUpdateEntityZero.
	Array index number 5 represent GetParticleUpdateEntityOne.
--]]
local ParticleManager = {
	{
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
	{
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
			Name = "techies_remote_mine_plant",
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
	{
		bounty_hunter_windwalk = true,
		nyx_assassin_vendetta_start = true,
		roshan_slam = true,
		smoke_of_deceit = true
	},
	{
		antimage_blade_hit = true,
		bounty_hunter_hand_l = true,
		mirana_moonlight_cast = true,
		techies_remote_mine_plant = true
	},
	{
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

local Floor = math.floor
local Ceil = math.ceil
local ValueParticleUpdate, ValueParticleUpdateEntity = nil, nil
local idx = nil
local TableData = nil
local ValueOnDraw = nil
local NeedInit = true
local ParticleData = {}

function AbilityAlert.OnScriptLoad()
	Console.Print("\n[" .. os.date("%I:%M:%S %p") .. "] - - [ AbilityAlert.lua ] [ Version 0.6 ] Script load.\n\n")
	for i = #ParticleData, 1, -1 do
		ParticleData[i] = nil
	end
	ParticleData = {}
	
	ValueParticleUpdate = nil 
	ValueParticleUpdateEntity = nil
	ValueOnDraw = nil
	idx = nil
	TableData = nil
	NeedInit = true
end

function AbilityAlert.OnGameEnd()
	Console.Print("[" .. os.date("%I:%M:%S %p") .. "] - - [ AbilityAlert.lua ] [ Version 0.6 ] Game end. Reset all variable.")
	
	for i = #ParticleData, 1, -1 do
		ParticleData[i] = nil
	end
	ParticleData = {}
	
	ValueParticleUpdate = nil 
	ValueParticleUpdateEntity = nil
	ValueOnDraw = nil
	idx = nil
	TableData = nil
	NeedInit = true
	
	collectgarbage("collect")
end

--[[ 
	This function try to check if particle present in the unique particle table mapping, ParticleManager table index 1 for unique particle.
--]]
function AbilityAlert.IsUniqueParticle(particle)
	idx = nil
	TableData = nil
	
	for i = 1, #ParticleManager[1] do
		TableData = ParticleManager[1][i]
		
		if particle.name == TableData.Name then
			if TableData.Name == "roshan_spawn" and GameRules.GetGameState() == 4 then
				return false
			else
				idx = particle.index
				
				if idx > -1 then
					idx = idx * -1
				end
				
				ParticleData[#ParticleData + 1] = {
					index = particle.index,
					name = TableData.Name,
					TrackUntil = os.clock() + TableData.TrackDuration,
					entity = particle.entity or nil,
					PrintMessage = TableData.HasMessage,
					Msg = TableData.Message or nil,
					duration = TableData.Duration,
					Position =  TableData.Position or nil,
					DrawIcon = nil,
					IconIndex = idx,
					Texture = TableData.MinimapImage,
					DoneDraw = false
				}
				return true
			end
		end
	end
	
	return false
end

--[[ 
	This function try to check if particle present in the non unique particle table mapping, ParticleManager table index 2 for non unique particle.
--]]
function AbilityAlert.IsNonUniqueParticle(particle)
	idx = nil
	TableData = nil
	
	for i = 1, #ParticleManager[2] do
		TableData = ParticleManager[2][i]

		if particle.name == TableData.Name then
			idx = particle.index
			
			if idx > -1 then
				idx = idx * -1
			end
			
			ParticleData[#ParticleData + 1] = {
				index = particle.index,
				name = TableData.Name,
				TrackUntil = os.clock() + TableData.TrackDuration,
				entity = particle.entity or nil,
				PrintMessage = TableData.HasMessage,
				Msg = TableData.Message or nil,
				duration = TableData.Duration,
				Position = nil,
				DrawIcon = nil,
				IconIndex = idx,
				Texture = nil,
				DoneDraw = false
			}
			return true
		end
	end
	
	return false
end

function AbilityAlert.OnParticleCreate(particle)
	if (Menu.IsEnabled(AbilityAlert.OptionEnable) == false) then return end
	if NeedInit then return end
	if (Heroes.GetLocal() == nil) then return end
	
	if AbilityAlert.IsNonUniqueParticle(particle) == false then
		AbilityAlert.IsUniqueParticle(particle)
	end
end

--[[ 
	Tell whether given position is ally.
--]]
function AbilityAlert.IsAlly(name, pos)
    local range = nil
	
	if name ~= "roshan_slam" then
		range = 50
	else
		range = 350
	end
	
    local allies = NPCs.InRadius(pos, range, Entity.GetTeamNum(Heroes.GetLocal()), Enum.TeamType.TEAM_FRIEND)
	
    if allies and #allies > 0 then 
		return true 
	end
    
	return false
end

function AbilityAlert.OnParticleUpdate(particle)
	if (Menu.IsEnabled(AbilityAlert.OptionEnable) == false) then return end
	if NeedInit then return end
	if (Heroes.GetLocal() == nil) then return end
	
	for i = 1, #ParticleData do
		ValueParticleUpdate = ParticleData[i] or nil
		
        if 
			ValueParticleUpdate ~= nil 
			and particle.index == ValueParticleUpdate.index 
		then
			if particle.controlPoint == 0 then
				if ParticleManager[3][ValueParticleUpdate.name] then
					if 
						ValueParticleUpdate.Position == nil
						and AbilityAlert.IsAlly(ValueParticleUpdate.name, particle.position) == false
					then
						ParticleData[i].Position = particle.position
					end
				end
			end
        end
    end
end

function AbilityAlert.OnParticleUpdateEntity(particle)
	if Menu.IsEnabled(AbilityAlert.OptionEnable) == false then return end
	if NeedInit then return end
	if Heroes.GetLocal() == nil then return end
    
	for i = 1, #ParticleData do
		ValueParticleUpdateEntity = ParticleData[i]
		
        if 
			ValueParticleUpdateEntity ~= nil 
			and particle.index == ValueParticleUpdateEntity.index 
			and particle.entity ~= nil 
		then
			if 
				particle.controlPoint == 0 
				and ParticleManager[4][ValueParticleUpdateEntity.name] 
			then
				if ValueParticleUpdateEntity.Position == nil and Entity.IsSameTeam(Heroes.GetLocal(), particle.entity) == false then
					
					ParticleData[i].Texture = "minimap_heroicon_" .. NPC.GetUnitName(particle.entity)
					ParticleData[i].Position = particle.position
				
				end
			end
			
			if 
				particle.controlPoint == 1 
				and ParticleManager[5][ValueParticleUpdateEntity.name] 
			then
				if 
					ValueParticleUpdateEntity.Position == nil 
					and Entity.IsSameTeam(Heroes.GetLocal(), particle.entity) == false 
				then
					ParticleData[i].Texture = "minimap_heroicon_" .. NPC.GetUnitName(particle.entity)
					ParticleData[i].Position = particle.position
				end
			end
        end
    end
end

function AbilityAlert.OnUpdate()
	if Menu.IsEnabled(AbilityAlert.OptionEnable) == false then return end
	
	if NeedInit then
		for i = #ParticleData, 1, -1 do
			ParticleData[i] = nil
		end
		ParticleData = {}
		
		ValueParticleUpdate = nil 
		ValueParticleUpdateEntity = nil
		ValueOnDraw = nil
		idx = nil
		TableData = nil
		NeedInit = false
		
		Console.Print("\n[" .. os.date("%I:%M:%S %p") .. "] - - [ AbilityAlert.lua ] [ Version 0.6 ] Game started, init script done.\n\n")
	end
end

--[[
	Get Dota time into readable time, still on progress about this function.
--]]
function AbilityAlert.GetTime()
	local GameTime, second = nil, nil
	
	if GameRules.GetGameState() == 4 then
		if 
			GameRules.GetGameMode() == 1
			or GameRules.GetGameMode() == 2
			or GameRules.GetGameMode() == 3
			or GameRules.GetGameMode() == 4
			or GameRules.GetGameMode() == 22
		then
			GameTime = (GameRules.GetPreGameStartTime() + 90) - GameRules.GetGameTime()
			second = Ceil(GameTime % 60)
			
			if second < 10 then
				return Floor(GameTime * 0.016666666666667 ) .. ":0" .. second
			else
				return Floor(GameTime * 0.016666666666667 ) .. ":" .. second
			end
		elseif GameRules.GetGameMode() == 23 then
			GameTime = (GameRules.GetPreGameStartTime() + 60) - GameRules.GetGameTime()
			second = Ceil(GameTime % 60)
			
			if second < 10 then
				return Floor(GameTime * 0.016666666666667 ) .. ":0" .. second
			else
				return Floor(GameTime * 0.016666666666667 ) .. ":" .. second
			end
		end
	else
		GameTime = GameRules.GetGameTime() - GameRules.GetGameStartTime()
		second = Floor(GameTime % 60)
			
		if second < 10 then
			return Floor(GameTime * 0.016666666666667 ) .. ":0" .. second
		else
			return Floor(GameTime * 0.016666666666667 ) .. ":" .. second
		end
	end
end

function AbilityAlert.OnDraw()
	if Menu.IsEnabled(AbilityAlert.OptionEnable) == false then return end
	if Engine.IsInGame() == false then return end
	if GameRules.GetGameState() < 4 then return end
	if GameRules.GetGameState() > 5 then return end
	if NeedInit then return end
	if Heroes.GetLocal() == nil then return end

	for i = 1, #ParticleData do
		ValueOnDraw = ParticleData[i]
		
		if ValueOnDraw ~= nil then
			if (ValueOnDraw.TrackUntil - os.clock()) < 0 then
				ParticleData[i] = nil
			end
			
			if ValueOnDraw.Position ~= nil and ValueOnDraw.DoneDraw == false then
				MiniMap.AddIconByName(ValueOnDraw.IconIndex, ValueOnDraw.Texture, ValueOnDraw.Position, 255, 255, 255, 255, ValueOnDraw.duration, 900)
				
				if ValueOnDraw.PrintMessage then
					Chat.Print("ConsoleChat", '<font color="White">'.. AbilityAlert.GetTime() ..' →</font> <font color="Red">'.. ValueOnDraw.Msg .. '</font>')
				end
				
				ParticleData[i].DoneDraw = true
			end
		end
	end
end

return AbilityAlert 