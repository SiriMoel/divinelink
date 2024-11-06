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
        mult = 1.5
    end
    if difficulty == 3 then -- DIVINE LIGHT
        mult = 1.0
    end
    if difficulty == 2 then -- FLESH AUTOMATON
        mult = 1.0
    end
    if difficulty == 1 then -- POWER IN MISERY
        mult = 0.8
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

function CreateEnlightenedEnemy(entity)
	local x, y = EntityGetTransform(entity)
	-- increase hp
	local comps_damagemodel = EntityGetComponent(entity, "DamageModelComponent") or {}
	for i,comp in ipairs(comps_damagemodel) do
		local hp = ComponentGetValue2(comp, "hp")
		local max_hp = ComponentGetValue2(comp, "max_hp")
		hp = math.ceil(hp * 1.25)
		max_hp = math.ceil(max_hp * 1.25)
		ComponentSetValue2(comp, "hp", hp)
		ComponentSetValue2(comp, "max_hp", max_hp)
	end
	-- add fx
	local effect = EntityLoad("mods/divinelink/files/entities/particles/enlightened_enemy.xml", x, y)
	EntityAddChild(entity, effect)
	-- add death script
	EntityAddComponent2(entity, "LuaComponent", {
		script_death="mods/divinelink/files/scripts/enemy_enlightened_death.lua"
	})
	-- new attack / buff / thing.
	local buffs = {  -- probably want to have ~10
		{ -- healthy, more hp
			thing = function()
				for i,comp in ipairs(comps_damagemodel) do
					local hp = ComponentGetValue2(comp, "hp")
					local max_hp = ComponentGetValue2(comp, "max_hp")
					hp = math.ceil(hp * 1.5)
					max_hp = math.ceil(max_hp * 1.5)
					ComponentSetValue2(comp, "hp", hp)
					ComponentSetValue2(comp, "max_hp", max_hp)
				end
			end,
		},
		{ -- wizardly, fires wizard orbs at player 
			thing = function()
				EntityAddComponent2(entity, "LuaComponent", {
					script_source_file="mods/divinelink/files/enlightened_attacks/wizardly.lua",
					execute_every_n_frame=120,
				})
			end,
		},
		{ -- infernal, immune to fire and converts nearby things to fire
			thing = function()
				local burnable_things = { "water", "water_ice", "water_salt", "water_static", "water_swamp", "radioactive_liquid", "blood_cold", "blood", "oil", "grass" }
				for i,v in ipairs(burnable_things) do
					EntityAddComponent2(entity, "MagicConvertMaterialComponent", {
						from_material = CellFactory_GetType(v),
						to_material = CellFactory_GetType("fire"),
						steps_per_frame = 20,
						loop = true, -- is this correct for EntityAddComponent2() ?
						is_circle = true, -- is this correct for EntityAddComponent2() ?
						radius = 20,
					})
				end
				LoadGameEffectEntityTo(entity, "mods/divinelink/files/enlightened_attacks/infernal_effect.xml")
			end,
		},
		--[[{ -- weakening aura, like those ghost things but weakening
			thing = function()

			end,
		},]]
		--[[{ -- persistent drug offerer, small radius that adds tripping status?
			thing = function()

			end,
		},]]
		--[[{ -- psycho, forces you to aim at it or something (like in cruelty squad!!!)
			thing = function()

			end,
		},]]
	}
	local which = math.random(1,#buffs)
	buffs[which].thing()
end