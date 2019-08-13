package ninjakiwi.monkeyTown.common
{
   import flash.utils.setTimeout;
   import ninjakiwi.dancingShadows.DancingShadows;
   import ninjakiwi.dancingShadows.INumber;
   import ninjakiwi.monkeyTown.utils.LocalisationUtil;
   import org.osflash.signals.Signal;
   
   public class Constants
   {
      
      public static var IS_PRODUCTION_BUILD:Boolean = true;
      
      public static var BUILD_DATE:String = "171109b";
      
      public static var CLIENT_VERSION:String = "2.2.0";
      
      public static var BUST_STRING:String = "";
      
      public static var DEPLOY_STATE:int = ConfigureDeployConstants.PRODUCTION;
      
      public static const KLOUD_HOST_IP:String = "192.168.0.53";
      
      public static const KLOUD_HOST_INTRANET_PORT:String = "8889";
      
      public static const KLOUD_HOST_LOCAL_PORT:String = "8880";
      
      public static const ENABLE_CONTEST_CHEAT_BUTTON:Boolean = true;
      
      public static var IS_HALLOWEEN:Boolean = false;
      
      public static var IS_CHRISTMAS:Boolean = false;
      
      public static var DISABLE_CRATES_ON_KONG:Boolean = false;
      
      public static var DISABLE_CT_ON_KONG:Boolean = false;
      
      public static var DISABLE_MVM_FRIENDS_ON_KONG:Boolean = false;
      
      public static var DISABLE_BOSS:Boolean = false;
      
      public static const SKU_URL_PRODUCTION:String = "https://static-api.ninjakiwi.com/nkapi/skusettings/99d5c454171a3f5027a0563eb784a366.json";
      
      public static const SKU_URL_STAGING:String = "https://static-api-staging.ninjakiwi.com/nkapi/skusettings/ad54b92380e3402116b068d24a0ea808.json";
      
      public static var SKU_URL:String = SKU_URL_PRODUCTION;
      
      public static var APPLE_STORE_BMC_URL:String = "https://newgam.es/bmctobmc";
      
      public static var ANDROID_STORE_BMC_URL:String = "https://newgam.es/bmctobmcdrd";
      
      public static var BASE_PATH:String = "./";
      
      public static var BTD_MODULE_URL:String;
      
      public static var NK_BAR_URL:String;
      
      public static var NK_LOGIN_URL:String;
      
      public static var NK_STORE_URL:String;
      
      public static var USER_INFORMATION_PATH_SERVICE:String;
      
      public static var VERSION_SERVICE:String;
      
      public static var SERVER_STATUS_URL:String;
      
      public static var MODIFIER_DATA_URL:String;
      
      public static var AUDIO_PATH:String;
      
      public static var KLOUD_HOST:String;
      
      public static var FRIENDS_LIST_API_URL:String;
      
      public static var PROFILE_URL_BASE:String;
      
      public static var NEWS_DATA_URL:String = "https://static-api.ninjakiwi.com/appdocs/7/appdocs/news_panel";
      
      public static var NEWS_DATA_STAGING_URL:String = "https://static-api-staging.ninjakiwi.com/appdocs/7/appdocs/news_panel";
      
      public static const LEVEL_URL:String = "btd/tracks";
      
      public static var USE_DEV_MAGIC:Boolean = false;
      
      public static const MAX_CITY_LEVEL:int = 40;
      
      public static var UNICORN:String = "Friendship is magic!!!";
      
      public static var PEGASYS:String = null;
      
      public static const SELECTABLE_BLOON_TYPE:Boolean = true;
      
      public static var ENABLE_REQUEST_LOGGING:Boolean = false;
      
      public static const DISABLE_CONTESTED_TERRITORY:Boolean = false;
      
      public static const PACIFIST_INTERVAL:int = 3 * 24 * 60 * 60 * 1000;
      
      public static const PACIFIST_HONOR_THRESHOLD:int = 1000;
      
      public static const USER_SERVICES_NK:String = "ninjakiwi";
      
      public static const USER_SERVICES_KONG:String = "kongregate";
      
      public static var USER_SERVICES:String = USER_SERVICES_NK;
      
      public static const NUMBER_OF_CITIES:int = 2;
      
      public static var MOD_TX:Boolean = false;
      
      public static const INVALID_ID:int = -1;
      
      public static const RED_ID:int = 0;
      
      public static const BLUE_ID:int = 1;
      
      public static const GREEN_ID:int = 2;
      
      public static const YELLOW_ID:int = 3;
      
      public static const PINK_ID:int = 4;
      
      public static const BLACK_ID:int = 5;
      
      public static const WHITE_ID:int = 6;
      
      public static const ZEBRA_ID:int = 7;
      
      public static const LEAD_ID:int = 8;
      
      public static const RAINBOW_ID:int = 9;
      
      public static const CERAMIC_ID:int = 10;
      
      public static const MOAB_ID:int = 11;
      
      public static const BFB_ID:int = 12;
      
      public static const BOSS_ID:int = 13;
      
      public static const BOSS_BLOONARIUS_ID:int = 15;
      
      public static const BOSS_VORTEX_ID:int = 16;
      
      public static const BOSS_BLASTAPOPOULOS_ID:int = 17;
      
      public static const BOSS_DREADBLOON_ID:int = 18;
      
      public static const MOAB_CLUSTER_ID:int = 14;
      
      public static const BFB_CLUSTER_ID:int = 15;
      
      public static const DDT_ID:int = 16;
      
      public static const DDT_ID_IN_MODULE:int = 14;
      
      public static const RED_BLOON:String = "RedBloon";
      
      public static const BLUE_BLOON:String = "BlueBloon";
      
      public static const GREEN_BLOON:String = "GreenBloon";
      
      public static const YELLOW_BLOON:String = "YellowBloon";
      
      public static const PINK_BLOON:String = "PinkBloon";
      
      public static const BLACK_BLOON:String = "BlackBloon";
      
      public static const WHITE_BLOON:String = "WhiteBloon";
      
      public static const ZEBRA_BLOON:String = "ZebraBloon";
      
      public static const LEAD_BLOON:String = "LeadBloon";
      
      public static const RAINBOW_BLOON:String = "RainbowBloon";
      
      public static const CERAMIC_BLOON:String = "CeramicBloon";
      
      public static const MOAB_BLOON:String = "MoabBloon";
      
      public static const BFB_BLOON:String = "BfbBloon";
      
      public static const BOSS_BLOON:String = "BossBloon";
      
      public static const MOAB_CLUSTER:String = "MOABCluster";
      
      public static const BFB_CLUSTER:String = "BFBCluster";
      
      public static const DDT_BLOON:String = "DDTBloon";
      
      public static const SPECIAL_MISSION_SYMBOL:String = "SpecialMissionSymbol";
      
      public static const CAMO:String = "camo";
      
      public static const REGEN:String = "regen";
      
      public static const CAMO_REGEN:String = "camo_regen";
      
      public static const WATTLE_TREES:String = "WattleTrees";
      
      public static const TRANQUIL_GLADE:String = "TranquilGlade";
      
      public static const GLACIER:String = "Glacier";
      
      public static const SHIPWRECK:String = "Shipwreck";
      
      public static const PHASE_CRYSTAL:String = "PhaseCrystal";
      
      public static const STICKY_SAP_PLANT:String = "StickySapPlant";
      
      public static const CONSECRATED_GROUND:String = "ConsecratedGround";
      
      public static const MOAB_GRAVEYARD:String = "MOABGraveyard";
      
      public static const TEST_PERFORMANCE:String = "TestPerformance";
      
      public static const EMPTY_ENDLESS:String = "EmptyEndless";
      
      public static const CAVES:String = "Caves";
      
      public static const RUINS:String = "RuinsTerrain";
      
      public static const DRY_AS_A_BONE:String = "DryAsABone";
      
      public static const SANDSTORM:String = "Sandstorm";
      
      public static const ZZZZOMG:String = "ZZZZOMG";
      
      public static const BOSS_VORTEX:String = "Vortex";
      
      public static const BOSS_BLOONARIUS:String = "Bloonarius";
      
      public static const BOSS_BLASTAPOPOULOS:String = "Blastapopoulos";
      
      public static const BOSS_DREADBLOON:String = "Dreadbloon";
      
      public static const CASH_PER_BLOONSTONE:int = 40;
      
      public static const BLOONTONIUM_PER_BLOONSTONE:int = 40;
      
      public static const DEMOLISH_REFUND:Number = 0.25;
      
      public static const PVB_CASH_PER_ROUND_MULTIPLIER:Number = 50;
      
      public static const ALL_BLOON_IDS:Array = [RED_ID,BLUE_ID,GREEN_ID,YELLOW_ID,PINK_ID,BLACK_ID,WHITE_ID,ZEBRA_ID,LEAD_ID,RAINBOW_ID,CERAMIC_ID,MOAB_ID,BFB_ID,BOSS_ID,DDT_ID];
      
      public static const ALL_BLOON_TYPES:Array = [RED_BLOON,BLUE_BLOON,GREEN_BLOON,YELLOW_BLOON,PINK_BLOON,BLACK_BLOON,WHITE_BLOON,ZEBRA_BLOON,LEAD_BLOON,RAINBOW_BLOON,CERAMIC_BLOON,MOAB_BLOON,BFB_BLOON,BOSS_BLOON,DDT_BLOON];
      
      public static const GAME_OVER:String = "gameOver";
      
      public static const GAME_WIN:String = "gameWin";
      
      public static const GAME_LOSE:String = "gameLose";
      
      public static const GAME_CANCELLED:String = "gameCancelled";
      
      public static const GAME_REQUEST_BLOONSTONES:String = "gameRequestBloonstones";
      
      public static const GAME_RETRY_WITH_BLOONSTONES:String = "gameRetryWithBloonstones";
      
      public static const GAME_OPEN_SHOP:String = "gameOpenShop";
      
      public static const GAME_TACTICS_ANALYTICS:String = "gameTacticsAnalytics";
      
      public static const CONSUME_MONKEY_BOOSTS:String = "consumeMonkeyBoosts";
      
      public static const CONSUME_RED_HOT_SPIKES:String = "consumeRedHotSpikes";
      
      public static const RED_HOT_SPIKES_BALANCE_CHANGED:String = "redHowSpikesBalanceChanged";
      
      public static const MONKEY_BOOSTS_BALANCE_CHANGED:String = "monkeyBoostsBalanceChanged";
      
      public static const CONSUME_ANTI_BOSS_ABILITY:String = "consumeAntiBossAbility";
      
      public static const TRACK_ANTI_BOSS_ABILITY:String = "trackConsumeAntiBossAbility";
      
      public static const CONSUME_ANTI_BOSS_ABILITY_BONUS:String = "consumeBonus";
      
      public static const CONSUME_ANTI_BOSS_ABILITY_BLOONSTONES:String = "consumeBloonstones";
      
      public static const SPACING_ULTRA_CLOSE:Number = 0.04;
      
      public static const SPACING_SUPER_CLOSE:Number = 0.1;
      
      public static const SPACING_CLOSE:Number = 0.2;
      
      public static const SPACING_NORMAL:Number = 0.6;
      
      public static const SPACING_LOOSE:Number = 1.2;
      
      public static const TOWER_DART:String = "DartMonkey";
      
      public static const TOWER_TACK:String = "TackTower";
      
      public static const TOWER_SNIPER:String = "SniperMonkey";
      
      public static const TOWER_BOOMERANG:String = "BoomerangThrower";
      
      public static const TOWER_NINJA:String = "NinjaMonkey";
      
      public static const TOWER_BOMB:String = "BombTower";
      
      public static const TOWER_ICE:String = "IceTower";
      
      public static const TOWER_GLUE:String = "GlueGunner";
      
      public static const TOWER_BUCCANEER:String = "MonkeyBuccaneer";
      
      public static const TOWER_PLANE:String = "MonkeyAce";
      
      public static const TOWER_HELICOPTER:String = "Helicopter";
      
      public static const TOWER_SUPER:String = "SuperMonkey";
      
      public static const TOWER_APPRENTICE:String = "MonkeyApprentice";
      
      public static const TOWER_MORTAR:String = "MortarTower";
      
      public static const TOWER_DARTLING:String = "DartlingGun";
      
      public static const TOWER_SPIKEFACTORY:String = "SpikeFactory";
      
      public static const TOWER_PINEAPPLE:String = "ExplodingPineapple";
      
      public static const TOWER_ROADSPIKE:String = "RoadSpikes";
      
      public static const TOWER_VILLAGE:String = "MonkeyVillage";
      
      public static const TOWER_FARM:String = "BananaFarm";
      
      public static const TOWER_REDHOTSPIKES:String = "RedHotSpikes";
      
      public static const TOWER_ENGINEER:String = "Engineer";
      
      public static const TOWER_CUDDLY_BEAR:String = "CuddlyBear";
      
      public static const TOWER_ANTI_CAMO_DUST:String = "AntiCamoDust";
      
      public static const TERRAIN_GRASS:String = "GrassTerrain";
      
      public static const TERRAIN_FOREST:String = "ForestTerrain";
      
      public static const TERRAIN_HEAVY_FOREST:String = "HeavyForestTerrain";
      
      public static const TERRAIN_HILLS:String = "HillsTerrain";
      
      public static const TERRAIN_MOUNTAINS:String = "MountainTerrain";
      
      public static const TERRAIN_VOLCANO:String = "VolcanoTerrain";
      
      public static const TERRAIN_SNOW:String = "SnowTerrain";
      
      public static const TERRAIN_LAKE:String = "LakeTerrain";
      
      public static const TERRAIN_DESERT:String = "DesertTerrain";
      
      public static const TERRAIN_DESERT_BADLANDS:String = "DesertBadlandsTerrain";
      
      public static const TERRAIN_DESERT_HIGHLANDS:String = "DesertHighlandsTerrain";
      
      public static const TERRAIN_DESERT_ARID_GRASSLANDS:String = "DesertAridGrasslandsTerrain";
      
      public static const TERRAIN_RIVER:String = "RiverTerrain";
      
      public static const TERRAIN_JUNGLE:String = "JungleTerrain";
      
      public static const TERRAIN_CAVE:String = CAVES;
      
      public static const TERRAIN_RUINS:String = RUINS;
      
      public static const TERRAIN_PHASE:String = PHASE_CRYSTAL;
      
      public static const TERRAIN_TRANQUIL:String = TRANQUIL_GLADE;
      
      public static const TERRAIN_SHIPWRECK:String = SHIPWRECK;
      
      public static const TERRAIN_WATTLE:String = WATTLE_TREES;
      
      public static const TERRAIN_STICKY:String = STICKY_SAP_PLANT;
      
      public static const TERRAIN_DRY_AS_A_BONE:String = DRY_AS_A_BONE;
      
      public static const TERRAIN_SANDSTORM:String = SANDSTORM;
      
      public static const TERRAIN_ZZZZOMG:String = ZZZZOMG;
      
      public static const WATER_EDGE:String = "WaterEdge";
      
      public static const TERRAIN_BOSS_VORTEX:String = BOSS_VORTEX;
      
      public static const TERRAIN_BOSS_BLOONARIUS:String = BOSS_BLOONARIUS;
      
      public static const TERRAIN_BOSS_BLASTAPOPOULOS:String = BOSS_BLASTAPOPOULOS;
      
      public static const TERRAIN_BOSS_DREADBLOON:String = BOSS_DREADBLOON;
      
      public static const TOWERS_BY_UPGRADES_ID:Object = {
         "SuperMonkeyUpgrades":TOWER_SUPER,
         "BoomerangThrowerUpgrades":TOWER_BOOMERANG,
         "AeroMonkeyUpgrades":TOWER_PLANE,
         "DartMonkeyUpgrades":TOWER_DART,
         "GlueMonkeyUpgrades":TOWER_GLUE,
         "BombTowerUpgrades":TOWER_BOMB,
         "AgriculturalUpgrades":TOWER_FARM,
         "NinjaMonkeyUpgrades":TOWER_NINJA,
         "DartlingGunUpgrades":TOWER_DARTLING,
         "BuccaneerUpgrades":TOWER_BUCCANEER,
         "WizardMonkeyUpgrades":TOWER_APPRENTICE,
         "SpikeFactoryUpgrades":TOWER_SPIKEFACTORY,
         "IceMonkeyUpgrades":TOWER_ICE,
         "SniperMonkeyUpgrades":TOWER_SNIPER,
         "MortarTowerUpgrades":TOWER_MORTAR,
         "TackShooterUpgrades":TOWER_TACK,
         "TownUpgrades":TOWER_VILLAGE,
         "EngineerUpgrades":TOWER_ENGINEER
      };
      
      public static const MONKEY_FARMER:String = "MonkeyFarmer";
      
      public static const MAD_SNOWMAN:String = "MadSnowman";
      
      public static const ANGRY_SQUIRREL:String = "AngrySquirrel";
      
      public static const SUPERMONKEYSTORM:String = "SuperMonkeyStorm";
      
      public static const WATERMELONSPLITTER:String = "WatermelonSplitter";
      
      public static const PONTOON:String = "Pontoon";
      
      public static const PORTABLELAKE:String = "PortableLake";
      
      public static const BEEKEEPER:String = "Beekeeper";
      
      public static const BLOONBERRYBUSH:String = "BloonberryBush";
      
      public static const TRIBALTURTLE:String = "TribalTurtle";
      
      public static const MEERKAT:String = "Meerkat";
      
      public static const UPGRADES_IDS_BY_TOWER:Object = {};
      
      public static const CLAN_SCORPIONS:String = "Scorpions";
      
      public static const CLAN_BLUE_WOLVES:String = "Blue Wolves";
      
      public static const CLAN_WHITE_TIGERS:String = "White Tigers";
      
      public static const CLAN_XIII:String = "XIII";
      
      public static const CLAN_SHINING_BLADE:String = "Shining Blade";
      
      public static const CLAN_IRON_PHOENIX:String = "Iron Phoenix";
      
      public static const CLAN_FALCONS:String = "Falcons";
      
      public static const CLAN_DARK_MATTER:String = "Dark Matter";
      
      public static const CLAN_THUNDERBOLTS:String = "Thunderbolts";
      
      public static const CLAN_BLACK_COBRAS:String = "Black Cobras";
      
      public static const CLAN_THE_WATCHERS:String = "The Watchers";
      
      public static const CLAN_RED_STORM:String = "Red Storm";
      
      public static const CLAN_NIGHT_JACKALS:String = "Night Jackals";
      
      private static var key:String;
      
      public static const MINIMUM_PVP_LEVEL:int = 9;
      
      public static const BS_COST_TO_GET_BONUS_STARTING_CASH:int = 10;
      
      public static const DIFFICULTY_VARIANCE_EASY_THRESHOLD:Number = 4;
      
      public static const MINIMUM_CAMO_TILE_DIFFICULTY:Number = 7;
      
      public static const MINIMUM_REGEN_TILE_DIFFICULTY:Number = 6;
      
      public static const DIFFICULTY_REQUIRED_BEFORE_REGEN:int = 8;
      
      public static const DIFFICULTY_REQUIRED_BEFORE_CAMO:int = 12;
      
      public static const NONE:int = 0;
      
      public static const NORMAL:int = 1;
      
      public static const LOTS:int = 2;
      
      public static const ENCHANTED_BOOMERANG_ID:String = "EnchantedBoomerang";
      
      public static const NINJASCROLLS_ID:String = "NinjaScrolls";
      
      public static const SHARD_OF_EVERFROST_ID:String = "ShardOfEverfrost";
      
      public static const EXTRA_STICKY_SUBSTANCE_ID:String = "ExtraStickySubstance";
      
      public static const CUDDLY_BEAR_ID:String = "CuddlyBear";
      
      public static const ANTI_CAMO_DUST_ID:String = "AntiCamoDust";
      
      public static const RED_HOT_SPIKES_ID:String = "RedHotSpikes";
      
      public static const MONKEY_BOOSTS_ID:String = "MonkeyBoosts";
      
      public static const BOSS_CHILL_ID:String = "BossChill";
      
      public static const BOSS_BANE_ID:String = "BossBane";
      
      public static const BOSS_BLAST_ID:String = "BossBlast";
      
      public static const BOSS_WEAKEN_ID:String = "BossWeaken";
      
      public static const COST_TO_MOVE_BUILDING:Number = 50;
      
      public static const PVP_DEFENSE_EXTRA_TIME_S:int = 60 * 60;
      
      public static const MINIMUM_SPECIAL_MISSION_DIFFICULTY:int = 20;
      
      public static const OPEN_STORE_SIGNAL:Signal = new Signal();
      
      public static const BLOONSTONES_CHANGED_SIGNAL:Signal = new Signal(int);
      
      public static const ENABLE_GAME_MODIFIERS:Boolean = false;
      
      public static var BYPASS_MAINTENANCE_MODE:Boolean = false;
      
      public static const ENABLE_ANTI_BOSS_ABILITIES:Boolean = true;
      
      public static const RELEASE_TEST:Boolean = false;
      
      public static const MIN_MYTRACK_LEVEL:int = 10;
      
      public static const HARDCORE_MODE_MODIFIER:Number = 2;
      
      public static const HARDCORE_MODE_MIN_LEVEL:int = 10;
      
      public static const SECOND_CITY_UNLOCK_LEVEL:Number = 15;
      
      public static const SECOND_CITY_DIFFICULTY_SCALAR:Number = 1.1;
      
      public static const ENGINEER_UNLOCK_LEVEL:int = 5;
      
      public static const BLOONSTONES_REWARD_SPECIAL_MISSIONS:int = 20;
      
      public static const CASH_REWARD_SPECIAL_MISSIONS:int = 5000;
      
      public static const SET_MILESTONE_GOAL:String = "setMilestoneGoal";
      
      public static const REVEAL_MILESTONES_REWARD_PANEL:String = "revealMilestonesRewardPanel";
      
      public static const MOUSE_WHEEL_SCROLL_SPEED:Number = 4000;
      
      public static const BLOON_BEACON_CASH_MODIFIER:INumber = DancingShadows.getOne(2);
      
      {
         for(key in TOWERS_BY_UPGRADES_ID)
         {
            UPGRADES_IDS_BY_TOWER[TOWERS_BY_UPGRADES_ID[key]] = key;
         }
         setTimeout(function():void
         {
            LocalisationUtil.language = "en";
         },0);
      }
      
      public function Constants()
      {
         super();
      }
   }
}
