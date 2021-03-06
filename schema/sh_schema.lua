SCHEMA.name = "NutsZ" -- Change this name if you're going to create new schema.
SCHEMA.author = "Black Tea"
SCHEMA.desc = "Zombie Schema you nuts"

-- Schema Help Menu. You can add more stuffs in cl_hooks.lua.
SCHEMA.helps = {
}

SCHEMA.itemLists = {
    ["foods"] = {
		items = {
            ["food_chip"] = 1,
            ["food_mre"] = .1,
            ["food_oat"] = .88,
            ["food_chobar"] = .58,
            ["food_grabar"] = .77,
            ["food_pascan"] = .11,
            ["food_soupcan"] = .18,
            ["food_hamcan"] = .11,
            ["food_tunacan"] = .22,
            ["food_coco"] = .5,
            ["food_endrink"] = .2,
            ["food_ion"] = .1,
            ["food_cherry"] = .2,
            ["food_bread"] = .6,
            ["food_soda"] = .2,
            ["food_lwater"] = .4,
            ["food_swater"] = .6,
            ["aidkit"] = .8,
            ["healthkit"] = .4,
            ["healvial"] = .1,
        },
		max = 40,
		interval = 60,
	},
    ["components"] = {
		items = {

		},
		max = 15,
		interval = 600,
	},
    ["ammo"] = {
		items = {
			["ammo_pistol"] = 1,
			["ammo_ar2"] = 0.8,
			["ammo_smg1"] = 1,
			["ammo_buckshot"] = 0.6,
			["ammo_sniperround"] = 0.2,
		},
		max = 16,
		interval = 300,
	},
    ["artifacts"] = {
		items = {},
		max = 3,
		interval = 600,
	},
    ["wears"] = {
		items = {
			["banda"] = 1,
			["bandol"] = 1,
			["beerhat"] = 1,
			["biker"] = 1,
			["buttbag"] = 1,
			["chiefhat"] = 1,
			["civbag"] = 1,
			["civbag2"] = 1,
			["gunjang"] = 1,
			["hat"] = 1,
			["hat2"] = 1,
			["hat3"] = 1,
			["hat4"] = 1,
			["hat5"] = 1,
			["hphone"] = 1,
			["mask"] = 1,
			["mask2"] = 1,
			["mask3"] = 1,
			["mask4"] = 1,
			["scarf"] = 1,
			["smallbag"] = 1,
		},
		max = 4,
		interval = 600,
	},
    ["rarewears"] = {
		items = {
			["balivest"] = 0.3,
			["largebag"] = 1,
			["civbag3"] = 1,
			["hugebag"] = 1,
			["vest2"] = 0.4,
			["vest3"] = 0.4,
			["vision_a"] = 0.2,
			["vision_b"] = 0.2,
		},
		max = 4,
		interval = 600,
	},
    ["weapons"] = {
		items = {
			["ma85_wf_pt22"] = 1,
			["ma85_wf_pt21"] = 1,
			["ma85_wf_pt41_ww2"] = 0.2,
			["ma85_wf_pt27"] = 0.6,
			["ma85_wf_pt14"] = 0.4,
			["ma85_wf_pt10"] = 1,
			["ma85_wf_smg35"] = 1,
			["ma85_wf_shg37"] = 1,
			["ma85_wf_smg31"] = 1,
		},
		max = 4,
		interval = 600,
	},
    ["rareweapons"] = {
		items = {
			["ma85_wf_shg38"] = 1,
			["ma85_wf_shg13"] = 1,
			["ma85_wf_shg03"] = 1,
			["ma85_wf_shg07"] = 1,
			["ma85_wf_smg25"] = 1,
			["ma85_wf_smg26"] = 1,
			["ma85_wf_smg17"] = 1,
			["ma85_wf_smg33"] = 1,
			["ma85_wf_shg38"] = 1,
			["ma85_wf_smg41"] = 1,
			["ma85_wf_ar04"] = 1,
			["ma85_wf_ar22"] = 1,
			["ma85_wf_ar22_old"] = 1,
			["ma85_wf_ar03"] = 1,
			["ma85_wf_ar25"] = 1,
			["ma85_wf_ar06"] = 1,
			["ma85_wf_ar24"] = 1,
			["ma85_wf_ar12"] = 1,
			["ma85_wf_ar26"] = 1,
			["ma85_wf_ar01"] = 1,
			["ma85_wf_sr07"] = 1,
			["ma85_wf_sr35"] = 1,
			["ma85_wf_sr34"] = 1,
			["ma85_wf_sr12"] = 1,
		},
		max = 1,
		interval = 600,
	},
    ["uniqueweapons"] = {
		items = {
			["ma85_wf_shg05"] = 1,
			["ma85_wf_ar11"] = 1,
			["ma85_wf_mg07"] = 1,
			["ma85_wf_ar41"] = 1,
			["ma85_wf_sr04"] = 1,
			["ma85_wf_sr09"] = 1,
			["ma85_wf_sr37"] = 1,
		},
		max = 1,
		interval = 600,
	},
}
SCHEMA.itemSpawns = SCHEMA.itemSpawns or {}

SCHEMA.npcLists = {
    ["normal"] = {
		items = {
            ["nz_berserker"] = 1,
            ["nz_elite_zombine"] = 1,
            ["nz_metro_zombie"] = 1,
            ["nz_boss_zombine"] = 1,
            ["nz_risen"] = 1,
        },
		max = 40,
		interval = 300,
	},
    ["rare"] = {
		items = {},
		max = 15,
		interval = 600,
	},
    ["boss"] = {
		items = {},
        nospawn = true,
		max = 15,
		interval = 600,
	},
}
SCHEMA.npcSpawns = SCHEMA.npcSpawns or {}

-- RANK레벨 관련 선언
-- RANK가 먼저 이걸 설정하려면 rankLevel를 잘 해야한다
-- 이 예제와 같이 -3이라면 rankLevel은 3이 되야하는것.
SCHEMA.ranks = {
	[-3] = "정예 약탈자",
	[-2] = "숙련 약탈자",
	[-1] = "약탈자",
	[0] = "생존자",
	[1] = "자경단",
	[2] = "숙련 자경단",
	[3] = "정예 자경단",
}
SCHEMA.rankLevels = 3

if (SERVER) then
	resource.AddWorkshop(207739713) -- Nutscript content

	resource.AddWorkshop(104634865)
	resource.AddWorkshop(104691717)
	resource.AddWorkshop(129873473)
	resource.AddWorkshop(130414613)
	resource.AddWorkshop(148638160)
	resource.AddWorkshop(152429869)
	resource.AddWorkshop(152430372)
	resource.AddWorkshop(152431665)
	resource.AddWorkshop(165772389)
	resource.AddWorkshop(193137261)
	resource.AddWorkshop(195744668)
	resource.AddWorkshop(207739713)
	resource.AddWorkshop(320536858)
	resource.AddWorkshop(380225333)
	resource.AddWorkshop(384303540)
	resource.AddWorkshop(406603968)
	resource.AddWorkshop(462764607)
	resource.AddWorkshop(524675815)
	resource.AddWorkshop(527885257)
	resource.AddWorkshop(551144079)
	resource.AddWorkshop(572310302)
	resource.AddWorkshop(677125227)
	resource.AddWorkshop(715762890)
	resource.AddWorkshop(757604550)
	resource.AddWorkshop(848953359)
	resource.AddWorkshop(848953556)
	resource.AddWorkshop(873302121)
	resource.AddWorkshop(875284959)
	resource.AddWorkshop(951557268)
	resource.AddWorkshop(974667753)
	resource.AddWorkshop(165845730)
	resource.AddWorkshop(1090302970)
	resource.AddWorkshop(974309392)
	resource.AddWorkshop(575135767)
	resource.AddWorkshop(893736359)

	-- Adding Gasmask Resources
	resource.AddFile("sound/gasmaskon.wav")
	resource.AddFile("sound/gasmaskoff.wav")
	resource.AddFile("sound/gmsk_in.wav")
	resource.AddFile("sound/gmsk_out.wav")
	resource.AddFile("materials/gasmask_fnl.vmt")
	resource.AddFile("materials/gasmask3.vtf")
	resource.AddFile("materials/gasmask3_n.vtf")
	resource.AddFile("materials/shtr_01.vmt")
	resource.AddFile("materials/shtr.vtf")
	resource.AddFile("materials/shtr_n.vtf")

	-- Adding Schema Resources
	resource.AddFile("materials/modernrp/dankweed.png")
	resource.AddFile("materials/modernrp/hitmarker.png")
	resource.AddFile("materials/effects/fas_muzzle1.png")
	resource.AddFile("materials/effects/fas_muzzle2.png")
	resource.AddFile("materials/effects/fas_muzzle3.png")
	resource.AddFile("materials/effects/fas_muzzle4.png")
	resource.AddFile("materials/effects/fas_muzzle5.png")
	resource.AddFile("materials/effects/fas_muzzle6.png")
	resource.AddFile("materials/effects/fas_muzzle7.png")
	resource.AddFile("materials/effects/fas_muzzle8.png")
	resource.AddFile("materials/effects/money.png")
	resource.AddFile("sound/ui/bad.wav")
	resource.AddFile("sound/ui/bip.wav")
	resource.AddFile("sound/ui/boop.wav")
	resource.AddFile("sound/ui/charged.wav")
	resource.AddFile("sound/ui/confirm.wav")
	resource.AddFile("sound/ui/deny.wav")
	resource.AddFile("sound/ui/extended.wav")
	resource.AddFile("sound/ui/good.wav")
	resource.AddFile("sound/ui/notify.wav")
	resource.AddFile("sound/ui/okay.wav")
	resource.AddFile("sound/ui/welcome.wav")
	resource.AddFile("sound/policesiren.wav")
	
	resource.AddFile("resource/fonts/NanumBarunGothic.ttf")
	resource.AddFile("resource/fonts/NanumBarunGothicBold.ttf")
	resource.AddFile("resource/fonts/NanumBarunGothicLight.ttf")
	resource.AddFile("resource/fonts/NanumBarunGothicUltraLight.ttf")
	resource.AddFile("resource/fonts/malgun.ttf")
	resource.AddFile("resource/fonts/malgunbd.ttf")
	--Adding Sound Resources
	resource.AddFile("sound/mainbgm.mp3")
end

nut.util.include("sv_database.lua")
nut.util.include("sh_configs.lua")
nut.util.include("cl_effects.lua")
nut.util.include("sv_hooks.lua")
nut.util.include("cl_hooks.lua")
nut.util.include("sh_hooks.lua")
nut.util.include("sh_commands.lua")
nut.util.include("meta/sh_player.lua")
nut.util.include("meta/sh_entity.lua")
nut.util.include("meta/sh_character.lua")
nut.util.include("sh_dev.lua") -- Developer Functions
nut.util.include("sv_schema.lua")

nut.anim.player = {
	fist = {
		[ACT_MP_RUN] = "sprint_all"
	},
	normal = {
		[ACT_MP_STAND_IDLE] = ACT_HL2MP_IDLE,
		[ACT_MP_CROUCH_IDLE] = ACT_HL2MP_IDLE_CROUCH,
		[ACT_MP_WALK] = ACT_HL2MP_WALK,
		[ACT_MP_RUN] = "sprint_all"
	},
	passive = {
		[ACT_MP_STAND_IDLE] = ACT_HL2MP_IDLE_PASSIVE,
		[ACT_MP_WALK] = ACT_HL2MP_WALK_PASSIVE,
		[ACT_MP_CROUCHWALK] = ACT_HL2MP_WALK_CROUCH_PASSIVE,
		[ACT_MP_RUN] = ACT_HL2MP_RUN_PASSIVE
	}
}

-- Black Tea Citizen Model Registeration
nut.anim.setModelClass("models/btcitizen/male_01.mdl", "player")
nut.anim.setModelClass("models/btcitizen/male_02.mdl", "player")
nut.anim.setModelClass("models/btcitizen/male_03.mdl", "player")
nut.anim.setModelClass("models/btcitizen/male_04.mdl", "player")
nut.anim.setModelClass("models/btcitizen/male_05.mdl", "player")
nut.anim.setModelClass("models/btcitizen/male_06.mdl", "player")
nut.anim.setModelClass("models/btcitizen/male_07.mdl", "player")
nut.anim.setModelClass("models/btcitizen/male_08.mdl", "player")
nut.anim.setModelClass("models/btcitizen/male_09.mdl", "player")
nut.anim.setModelClass("models/btcitizen/male_10.mdl", "player")
nut.anim.setModelClass("models/btcitizen/male_11.mdl", "player")
nut.anim.setModelClass("models/btcitizen/male_12.mdl", "player")
nut.anim.setModelClass("models/btcitizen/male_13.mdl", "player")
nut.anim.setModelClass("models/btcitizen/male_14.mdl", "player")
nut.anim.setModelClass("models/btcitizen/female_01.mdl", "player")
nut.anim.setModelClass("models/btcitizen/female_02.mdl", "player")
nut.anim.setModelClass("models/btcitizen/female_03.mdl", "player")
nut.anim.setModelClass("models/btcitizen/female_04.mdl", "player")
nut.anim.setModelClass("models/btcitizen/female_05.mdl", "player")
nut.anim.setModelClass("models/btcitizen/female_06.mdl", "player")
nut.anim.setModelClass("models/btcitizen/female_07.mdl", "player")
nut.anim.setModelClass("models/btcitizen/female_08.mdl", "player")
nut.anim.setModelClass("models/btcitizen/female_09.mdl", "player")
nut.anim.setModelClass("models/btcitizen/female_10.mdl", "player")
nut.anim.setModelClass("models/btcitizen/female_11.mdl", "player")
nut.anim.setModelClass("models/btcitizen/female_12.mdl", "player")
nut.anim.setModelClass("models/btcitizen/female_13.mdl", "player")
nut.anim.setModelClass("models/btcitizen/female_14.mdl", "player")

-- This hook prevents default Nutscript plugins to load.
local noLoad = {
	chatbox  = false, -- CityRP is using XPChat as default chat.
	thirdperson = false, -- CityRP does not use Thridperson.
	saveitems = false, -- CityRP does not save any items on the map.
}
function SCHEMA:PluginShouldLoad(uniqueID)
	return noLoad[uniqueID] -- true = don't load the specified plugin.
end
