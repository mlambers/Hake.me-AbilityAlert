local AbilityAlert = {}

AbilityAlert.optionEnable = Menu.AddOption( {"mlambers", "Ability Alert"}, "1. Enable", "Enable this script.")

local ParticleData = {}
ParticleData.Table = {}
ParticleData.RoshanAttack = false 
ParticleData.RoshanAttackNextTime = nil

function AbilityAlert.OnScriptLoad()
	ParticleData.Table = {}
	ParticleData.RoshanAttack = false 
	ParticleData.RoshanAttackNextTime = nil
end

function AbilityAlert.OnGameStart()
	ParticleData.Table = {}
	ParticleData.RoshanAttack = false 
	ParticleData.RoshanAttackNextTime = nil
end

function AbilityAlert.OnGameEnd()
	ParticleData.Table = {}
	ParticleData.RoshanAttack = false 
	ParticleData.RoshanAttackNextTime = nil
end

function AbilityAlert.OnUnitAnimation(animation)
	if not Menu.IsEnabled(AbilityAlert.optionEnable) then return end

	if animation.sequenceName == "roshan_attack" or animation.sequenceName == "roshan_attack2" then 
		if ParticleData.RoshanAttack == false then
			local FriendlyUnitRadiusChecker = NPCs.InRadius(Vector(-2319.4375, 1714.4375, 159.96875), 364, Entity.GetTeamNum(Heroes.GetLocal()), Enum.TeamType.TEAM_FRIEND)
			if #FriendlyUnitRadiusChecker < 1 then
				Chat.Print("ConsoleChat", '</font><font color="red;"> Someone attacking roshan. </font>')
				ParticleData.RoshanAttack = true 
				ParticleData.RoshanAttackNextTime = GameRules.GetGameTime() + 3
			end
		end
	end
end

function AbilityAlert.InsertParticleTable(particle)
	
	if particle.name == "smoke_of_deceit" then
		ParticleData.Table[#ParticleData.Table + 1] = 
		{
			index = particle.index,
			name = particle.name,
			endTime = GameRules.GetGameTime() + 5,
			alertImg1 = "item_smoke_of_deceit",
			alertImg2 = "item_smoke_of_deceit",
			minimapImg = "minimap_plaincircle",
		}
		return true
	elseif particle.name == "mirana_moonlight_cast" then
		if not Entity.IsSameTeam(Heroes.GetLocal(), particle.entity) then
			ParticleData.Table[#ParticleData.Table + 1] = 
			{
				index = particle.index,
				name = particle.name,
				endTime = GameRules.GetGameTime() + 5,
				alertImg1 = NPC.GetUnitName(particle.entity),
				alertImg2 = "mirana_invis",
				alertImg3 = "double_arrow_right_png",
			}
			return true
		end
	elseif particle.name == "nyx_assassin_vendetta_start" then
		ParticleData.Table[#ParticleData.Table + 1] = 
		{
			index = particle.index,
			name = particle.name,
			endTime = GameRules.GetGameTime() + 5,
			minimapImg = "minimap_plaincircle",
		}
		
		return true
	end
    return false
end

function AbilityAlert.OnParticleCreate(particle)
	if not Menu.IsEnabled(AbilityAlert.optionEnable) then return end
	if not Heroes.GetLocal() then return end
	
	AbilityAlert.InsertParticleTable(particle)
end

function AbilityAlert.OnParticleUpdate(particle)
	if not Menu.IsEnabled(AbilityAlert.optionEnable) then return end
    for keyTable = 1, #ParticleData.Table do
		local TableValue = ParticleData.Table[keyTable]
        if TableValue and particle.index == TableValue.index and particle.controlPoint == 0 then
			if TableValue.name == "smoke_of_deceit" then
			
				local firstRadiusCheck = NPCs.InRadius(particle.position, 400, Entity.GetTeamNum(Heroes.GetLocal()), Enum.TeamType.TEAM_FRIEND)
				
				local secondRadiusCheck = NPCs.InRadius(particle.position, 1200, Entity.GetTeamNum(Heroes.GetLocal()), Enum.TeamType.TEAM_FRIEND)
				
				if #firstRadiusCheck > 0 and #secondRadiusCheck > 0 then 
					ParticleData.Table[keyTable] = nil
				else
					Chat.Print("ConsoleChat", '</font><font color="red;"> Smoke Of Deceit is being used. </font>')
					ParticleData.Table[keyTable].position = particle.position
				end
			elseif TableValue.name == "nyx_assassin_vendetta_start" then
				local firstRadiusCheck = NPCs.InRadius(particle.position, 50, Entity.GetTeamNum(Heroes.GetLocal()), Enum.TeamType.TEAM_FRIEND)
				if #firstRadiusCheck > 0 then 
					ParticleData.Table[keyTable] = nil
				else
					ParticleData.Table[keyTable].position = particle.position
					Chat.Print("ConsoleChat", '</font><font color="red;"> Vendetta is being used. </font>')
				end
				
			end
        end
    end
end

function AbilityAlert.OnParticleUpdateEntity(particle)
	if not Menu.IsEnabled(AbilityAlert.optionEnable) then return end
	for keyTable = 1, #ParticleData.Table do
		local TableValue = ParticleData.Table[keyTable]
        if TableValue and particle.index == TableValue.index then
			if particle.controlPoint == 0 then
			
				if TableValue.name == "mirana_moonlight_cast" then
					Chat.Print("ConsoleChat", '</font><font color="red;"> Moonlight shadow </font>')
					ParticleData.Table[keyTable].position = particle.position
					ParticleData.Table[keyTable].minimapImg = "minimap_heroicon_" .. NPC.GetUnitName(particle.entity)
				end
			end
        end
    end
end

function AbilityAlert.OnParticleDestroy(particle)
	if not Menu.IsEnabled(AbilityAlert.optionEnable) then return end
	
	for keyTable = 1, #ParticleData.Table do
		local TableValue = ParticleData.Table[keyTable]
        if TableValue and particle.index == TableValue.index then
			ParticleData.Table[keyTable] = nil
        end
    end
end

function AbilityAlert.OnUpdate()
	if not Menu.IsEnabled(AbilityAlert.optionEnable) then return end
	local myHero = Heroes.GetLocal()
	
	if not myHero then return end
	
	
	for keyTable = 1, #ParticleData.Table do
		local TableValue = ParticleData.Table[keyTable]
		if TableValue then
			if TableValue.endTime < GameRules.GetGameTime() then
				ParticleData.Table[keyTable] = nil
			else
				if TableValue.position  then
					MiniMap.AddIconByName(nil, TableValue.minimapImg, TableValue.position, 255, 0, 0, 255, 0.1, 800)
				end
				
			end
		end
	end
	
	if ParticleData.RoshanAttack then
		if ParticleData.RoshanAttackNextTime < GameRules.GetGameTime() then
			ParticleData.RoshanAttackNextTime = nil 
			ParticleData.RoshanAttack = false
		else
		
			MiniMap.AddIconByName(nil, "minimap_plaincircle", Vector(-2464.245, 2016.373), 255, 0, 0, 255, 0.1, 600)
		end
	end
end

return AbilityAlert