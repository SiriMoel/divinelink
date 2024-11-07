dofile_once("mods/divinelink/files/scripts/utils.lua")
dofile_once("mods/divinelink/files/scripts/dl.lua")

dofile_once("mods/divinelink/lib/nxml.lua")
local nxml = dofile_once("mods/divinelink/lib/nxml.lua")

-- death scripts
local dropdoers = {
    {
        path = "data/entities/player.xml",
        script = "mods/divinelink/files/scripts/player_death.lua",
    },
	{
        path = "data/entities/animals/boss_pit/boss_pit.xml",
        script = "mods/divinelink/files/scripts/death_drop_divinelightorb.lua",
    },
}

for i,v in ipairs(dropdoers) do
    local xml = nxml.parse(ModTextFileGetContent(v.path))
    xml:add_child(nxml.parse(([[
        <LuaComponent
              script_death="%s"
              >
        </LuaComponent>
    ]]):format(v.script)))
    ModTextFileSetContent(v.path, tostring(xml))
end

-- nxml things
local xml = nxml.parse(ModTextFileGetContent("data/entities/base_humanoid.xml"))
xml:add_child(nxml.parse(([[
    <LuaComponent
        script_source_file="mods/divinelink/files/scripts/enemy_become_enlightened.lua"
		execute_every_n_frame="1"
		remove_after_executed="1"
        >
    </LuaComponent>
]])))
ModTextFileSetContent("data/entities/base_humanoid.xml", tostring(xml))

-- pixel scenes (thanks graham)
local function add_scene(table)
	local biome_path = ModIsEnabled("noitavania") and "mods/noitavania/data/biome/_pixel_scenes.xml" or "data/biome/_pixel_scenes.xml"
	local content = ModTextFileGetContent(biome_path)
	local string = "<mBufferedPixelScenes>"
	local worldsize = ModTextFileGetContent("data/compatibilitydata/worldsize.txt") or 35840
	for i = 1, #table do
		string = string .. [[<PixelScene pos_x="]] .. table[i][1] .. [[" pos_y="]] .. table[i][2] .. [[" just_load_an_entity="]] .. table[i][3] .. [["/>]]
		if table[i][4] then
			-- make things show up in first 2 parallel worlds
			-- hopefully this won't cause too much lag when starting a run
			string = string .. [[<PixelScene pos_x="]] .. table[i][1] + worldsize .. [[" pos_y="]] .. table[i][2] .. [[" just_load_an_entity="]] .. table[i][3] .. [["/>]]
			string = string .. [[<PixelScene pos_x="]] .. table[i][1] - worldsize .. [[" pos_y="]] .. table[i][2] .. [[" just_load_an_entity="]] .. table[i][3] .. [["/>]]
			string = string .. [[<PixelScene pos_x="]] .. table[i][1] + worldsize * 2 .. [[" pos_y="]] .. table[i][2] .. [[" just_load_an_entity="]] .. table[i][3] .. [["/>]]
			string = string .. [[<PixelScene pos_x="]] .. table[i][1] - worldsize * 2 .. [[" pos_y="]] .. table[i][2] .. [[" just_load_an_entity="]] .. table[i][3] .. [["/>]]
		end
	end
	content = content:gsub("<mBufferedPixelScenes>", string)
	ModTextFileSetContent(biome_path, content)
end

local scenes = {
	-- divine light orb in souls room (or in the middle of the tree if souls isnt enabled) GO PLAY SOULS!!!
	{ -1543, -403, "mods/divinelink/files/entities/difficulty_orbs/divinelight/thing.xml", false },
}

add_scene(scenes)

-- player
function OnPlayerSpawned( player )

    local px, py = EntityGetTransform(player)

	dofile_once("mods/divinelink/files/gui.lua")

    if GameHasFlagRun("divinelink_init") then return end

	--EntityLoad("mods/divinelink/files/entities/difficulty_orbs/divinelight/thing.xml", px, py)
	--EntityLoad("mods/divinelink/files/entities/misc/moonflower/thing.xml", px, py)

	-- doing difficulty stuff
	if ModSettingGet("divinelink.reset_progress") then
		SetDLDifficulty(-1)
		ModSettingSet("divinelink.dotd", 0)
		ModSettingSet("divinelink.reset_progress", false)
		ModSettingSetNextValue("divinelink.reset_progress", false, false)
	end
	DLinit()
	ApplyDifficultyDamageMultipliers()
	ApplyDifficultyThingsToPlayer()

	-- adding scripts to player
	--[[EntityAddComponent2(player, "LuaComponent", {
		script_source_file="mods/divinelink/files/scripts/player_everyframe.lua",
		execute_every_n_frame=1,
	})]]

    GameAddFlagRun("divinelink_init")
end

--translations
local translations = ModTextFileGetContent( "data/translations/common.csv" );
if translations ~= nil then
    while translations:find("\r\n\r\n") do
        translations = translations:gsub("\r\n\r\n","\r\n");
    end

    local new_translations = ModTextFileGetContent( table.concat({"mods/divinelink/files/translations.csv"}) );
    translations = translations .. new_translations;

    ModTextFileSetContent( "data/translations/common.csv", translations );
end

function OnModSettingsChanged()

end