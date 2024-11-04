dofile_once("mods/divinelink/files/scripts/utils.lua")

function GetDLDifficulty()
	local difficulty = ModSettingGet("divinelink.difficulty") or -1
    return difficulty
end

function SetDLDifficulty(difficulty)
	ModSettingSet("divinelink.difficulty", difficulty)
end

function ResetPlayerDamageMultipliers()
    local player = GetPlayer()
    local comps_damagemodel = EntityGetComponent(player, "DamageModelComponent") or {}
    if #comps_damagemodel > 0 then
        for i,comp in ipairs(comps_damagemodel) do
            local melee = tonumber(ComponentObjectGetValue( comp, "damage_multipliers", "melee" ) )
			local projectile = tonumber(ComponentObjectGetValue( comp, "damage_multipliers", "projectile" ) )
			local explosion = tonumber(ComponentObjectGetValue( comp, "damage_multipliers", "explosion" ) )
			local electricity = tonumber(ComponentObjectGetValue( comp, "damage_multipliers", "electricity" ) )
			local fire = tonumber(ComponentObjectGetValue( comp, "damage_multipliers", "fire" ) )
			local drill = tonumber(ComponentObjectGetValue( comp, "damage_multipliers", "drill" ) )
			local slice = tonumber(ComponentObjectGetValue( comp, "damage_multipliers", "slice" ) )
			local ice = tonumber(ComponentObjectGetValue( comp, "damage_multipliers", "ice" ) )
			local healing = tonumber(ComponentObjectGetValue( comp, "damage_multipliers", "healing" ) )
			local physics_hit = tonumber(ComponentObjectGetValue( comp, "damage_multipliers", "physics_hit" ) )
			local radioactive = tonumber(ComponentObjectGetValue( comp, "damage_multipliers", "radioactive" ) )
			local poison = tonumber(ComponentObjectGetValue( comp, "damage_multipliers", "poison" ) )
            local holy = tonumber(ComponentObjectGetValue( comp, "damage_multipliers", "holy" ) )
			melee = 1
			projectile = 1
			explosion = 0.35
			electricity = 1
			fire = 1
			drill = 1
			slice = 1
			ice = 1
            healing = 1
            physics_hit = 1
			radioactive = 1
			poison = 1
            holy = 1.5
			ComponentObjectSetValue( comp, "damage_multipliers", "melee", tostring(melee) )
			ComponentObjectSetValue( comp, "damage_multipliers", "projectile", tostring(projectile) )
			ComponentObjectSetValue( comp, "damage_multipliers", "explosion", tostring(explosion) )
			ComponentObjectSetValue( comp, "damage_multipliers", "electricity", tostring(electricity) )
			ComponentObjectSetValue( comp, "damage_multipliers", "fire", tostring(fire) )
			ComponentObjectSetValue( comp, "damage_multipliers", "drill", tostring(drill) )
			ComponentObjectSetValue( comp, "damage_multipliers", "slice", tostring(slice) )
			ComponentObjectSetValue( comp, "damage_multipliers", "ice", tostring(ice) )
			ComponentObjectSetValue( comp, "damage_multipliers", "healing", tostring(healing) )
			ComponentObjectSetValue( comp, "damage_multipliers", "physics_hit", tostring(physics_hit) )
			ComponentObjectSetValue( comp, "damage_multipliers", "radioactive", tostring(radioactive) )
			ComponentObjectSetValue( comp, "damage_multipliers", "poison", tostring(poison) )
            ComponentObjectSetValue( comp, "damage_multipliers", "holy", tostring(holy) )
        end
    end
end

function ApplyDifficultyDamageMultipliers()
    local player = GetPlayer()
    local difficulty = GetDLDifficulty()
    ResetPlayerDamageMultipliers()
    local comps_damagemodel = EntityGetComponent(player, "DamageModelComponent") or {}
    local mult = 0
    if difficulty == 4 then -- HOPE ERADICATED
        mult = 2
    end
    if difficulty == 3 then -- DIVINE LIGHT
        mult = 1.5
    end
    if difficulty == 2 then -- FLESH AUTOMATON
        mult = 1
    end
    if difficulty == 1 then -- POWER IN MISERY
        mult = 0.75
    end
    if #comps_damagemodel > 0 then
        for i,comp in ipairs(comps_damagemodel) do
            local melee = tonumber(ComponentObjectGetValue( comp, "damage_multipliers", "melee" ) )
			local projectile = tonumber(ComponentObjectGetValue( comp, "damage_multipliers", "projectile" ) )
			local explosion = tonumber(ComponentObjectGetValue( comp, "damage_multipliers", "explosion" ) )
			local electricity = tonumber(ComponentObjectGetValue( comp, "damage_multipliers", "electricity" ) )
			local fire = tonumber(ComponentObjectGetValue( comp, "damage_multipliers", "fire" ) )
			local drill = tonumber(ComponentObjectGetValue( comp, "damage_multipliers", "drill" ) )
			local slice = tonumber(ComponentObjectGetValue( comp, "damage_multipliers", "slice" ) )
			local ice = tonumber(ComponentObjectGetValue( comp, "damage_multipliers", "ice" ) )
			local healing = tonumber(ComponentObjectGetValue( comp, "damage_multipliers", "healing" ) )
			local physics_hit = tonumber(ComponentObjectGetValue( comp, "damage_multipliers", "physics_hit" ) )
			local radioactive = tonumber(ComponentObjectGetValue( comp, "damage_multipliers", "radioactive" ) )
			local poison = tonumber(ComponentObjectGetValue( comp, "damage_multipliers", "poison" ) )
            local holy = tonumber(ComponentObjectGetValue( comp, "damage_multipliers", "holy" ) )
			melee = melee * mult
			projectile = projectile * mult
			explosion = explosion * mult
			electricity = electricity * mult
			fire = fire * mult
			drill = drill * mult
			slice = slice * mult
			ice = ice * mult
            healing = healing * ( 1 / mult )
            physics_hit = physics_hit * mult
			radioactive = radioactive * mult
			poison = poison * mult
            holy = holy * mult
			ComponentObjectSetValue( comp, "damage_multipliers", "melee", tostring(melee) )
			ComponentObjectSetValue( comp, "damage_multipliers", "projectile", tostring(projectile) )
			ComponentObjectSetValue( comp, "damage_multipliers", "explosion", tostring(explosion) )
			ComponentObjectSetValue( comp, "damage_multipliers", "electricity", tostring(electricity) )
			ComponentObjectSetValue( comp, "damage_multipliers", "fire", tostring(fire) )
			ComponentObjectSetValue( comp, "damage_multipliers", "drill", tostring(drill) )
			ComponentObjectSetValue( comp, "damage_multipliers", "slice", tostring(slice) )
			ComponentObjectSetValue( comp, "damage_multipliers", "ice", tostring(ice) )
			ComponentObjectSetValue( comp, "damage_multipliers", "healing", tostring(healing) )
			ComponentObjectSetValue( comp, "damage_multipliers", "physics_hit", tostring(physics_hit) )
			ComponentObjectSetValue( comp, "damage_multipliers", "radioactive", tostring(radioactive) )
			ComponentObjectSetValue( comp, "damage_multipliers", "poison", tostring(poison) )
            ComponentObjectSetValue( comp, "damage_multipliers", "holy", tostring(holy) )
        end
    end
end

function DLinit()
    local difficulty = GetDLDifficulty()
    if difficulty == -1 then
        difficulty = 3 -- DIVINE LINK ESTABLISHED
    end
    SetDLDifficulty(difficulty)
end

function ApplyDifficultyThingsToPlayer()
	local player = GetPlayer()
	local difficulty = GetDLDifficulty()
	local player_thingies = EntityGetWithTag("DL_player_thingy") or {}
	if #player_thingies > 0 then
		for i,v in ipairs(player_thingies) do
			EntityKill(v)
		end
	end
	if difficulty == 4 then
		
	end
	if difficulty == 3 then
		
	end
	if difficulty == 2 then
		
	end
	if difficulty == 1 then
		LoadGameEffectEntityTo(player, "mods/divinelink/files/entities/misc/effect_power_in_misery.xml")
	end
end

function ChangeDifficultyDuringRun(difficulty)
	SetDLDifficulty(difficulty)
	ModSettingSet("divinelink.dotd", 0)
	ResetPlayerDamageMultipliers()
	ApplyDifficultyDamageMultipliers()
	ApplyDifficultyThingsToPlayer()
end