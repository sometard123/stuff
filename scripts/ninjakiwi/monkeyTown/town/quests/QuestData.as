package ninjakiwi.monkeyTown.town.quests
{
   import flash.events.Event;
   import flash.events.TimerEvent;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledge;
   import ninjakiwi.monkeyTown.pvp.PvPSignals;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.data.BloonResearchLabUpgrades;
   import ninjakiwi.monkeyTown.town.data.BuildingData;
   import ninjakiwi.monkeyTown.town.data.UpgradeData;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.quests.task.Quest;
   import ninjakiwi.monkeyTown.town.quests.task.QuestBloonResearch;
   import ninjakiwi.monkeyTown.town.quests.task.QuestBuilding;
   import ninjakiwi.monkeyTown.town.quests.task.QuestCapture;
   import ninjakiwi.monkeyTown.town.quests.task.QuestGatherSupplies;
   import ninjakiwi.monkeyTown.town.quests.task.QuestMorePreparation;
   import ninjakiwi.monkeyTown.town.quests.task.QuestResourcePower;
   import ninjakiwi.monkeyTown.town.quests.task.QuestSpecialItem;
   import ninjakiwi.monkeyTown.town.quests.task.QuestTotalMonkeys;
   import ninjakiwi.monkeyTown.town.quests.task.QuestUpgrade;
   import ninjakiwi.monkeyTown.town.quests.task.QuestUpgradeBuilding;
   import ninjakiwi.monkeyTown.town.quests.task.building.QuestBuildingPower;
   import ninjakiwi.monkeyTown.town.quests.task.capture.QuestCaptureDifficulty;
   import ninjakiwi.monkeyTown.town.quests.task.capture.QuestCaptureSpecialTerrain;
   import ninjakiwi.monkeyTown.town.quests.task.capture.QuestHunter;
   import ninjakiwi.monkeyTown.town.quests.task.pvp.QuestPVPPillage;
   import ninjakiwi.monkeyTown.town.quests.task.pvp.QuestPVPRevenge;
   import ninjakiwi.monkeyTown.town.quests.task.upgrade.QuestUpgradeTier;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.MKPTester;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.MonkeyKnowledgeTutorialPanel;
   
   public class QuestData
   {
      
      public static const QUEST_LONG_RANGE_DARTS:Quest = Quest(new QuestUpgrade(1,1,UpgradeData.getInstance().DART_MONKEY_UPGRADES.path1.tier1.id,UpgradeData.getInstance().DART_MONKEY_UPGRADES).ExtraCondition(Quest.EXTRA_HAVE_MONKEY_ACADEMY).Id("questID4"));
      
      public static const QUEST_BOMBS_AWAY:Quest = Quest(new QuestBuilding(BuildingData.getInstance().BOMB_RANGE.id,1).Id("questID5"));
      
      public static const QUEST_TREASURE_CHEST:Quest = Quest(new QuestSpecialItem(null,1).ExtraCondition(Quest.EXTRA_TREASURE_VISIBLE).Id("questID6"));
      
      public static const QUEST_GET_HARD:Quest = Quest(new QuestCaptureDifficulty(QuestCaptureDifficulty.HIGHER_THAN,3).Id("questID7"));
      
      public static const QUEST_BUILD_A_WATERMILL:Quest = Quest(new QuestBuilding(BuildingData.getInstance().WATERMILL.id,1).Id("questID9"));
      
      public static const QUEST_MORE_MONEY:Quest = Quest(new QuestBuilding(BuildingData.getInstance().BANANA_FARM.id,2).Id("questID11"));
      
      public static const QUEST_CAMO_COUNTERMEASURES:Quest = Quest(new QuestBuilding(BuildingData.getInstance().CENTER_OF_CAMO_COUNTERMEASURES.id,1).Id("questID13"));
      
      public static const QUEST_MONKEY_VS_MONKEY:Quest = Quest(new QuestBuilding(BuildingData.getInstance().BLOON_INFLATION_AND_DEPLOYMENT_FACTORY.id,1).Id("questID14"));
      
      public static const QUEST_STORE_MORE:Quest = Quest(new QuestBuilding(BuildingData.getInstance().MONKEY_BANK.id,2).Id("questID15"));
      
      public static const QUEST_SPECIAL_TERRAIN:Quest = Quest(new QuestCaptureSpecialTerrain().Id("questID16"));
      
      public static const QUEST_MORE_MONKEYS_NEEDED:Quest = Quest(new QuestBuilding(BuildingData.getInstance().MONKEY_DART_HALL.id,6).Id("questID17"));
      
      public static const QUEST_PRECIOUS_BLOONTONIUM:Quest = Quest(new QuestBuilding(BuildingData.getInstance().BLOONTONIUM_GENERATOR.id,1).Id("questID18"));
      
      public static const QUEST_STORE_BLOONTONIUM:Quest = Quest(new QuestBuilding(BuildingData.getInstance().BLOONTONIUM_STORAGE_TANK.id,1).Id("questID19"));
      
      public static const QUEST_RAID_SOMEONE:Quest = Quest(new Quest().AchieveSignal(PvPSignals.sendMVMAttackSucceeded).SymbolFrame(7).Id("questID20"));
      
      public static const QUEST_PILLAGE:Quest = Quest(new QuestPVPPillage(1000).Id("questID21"));
      
      public static const QUEST_LAND_GRAB_1:Quest = Quest(new QuestCapture(40).Id("questID22"));
      
      public static const QUEST_LAND_GRAB_2:Quest = Quest(new QuestCapture(70).Id("questID23"));
      
      public static const QUEST_LAND_GRAB_3:Quest = Quest(new QuestCapture(150).Id("questID24"));
      
      public static const QUEST_TREASURE_RAIDER:Quest = Quest(new QuestSpecialItem(null,3).Id("questID25"));
      
      public static const QUEST_REVENGE:Quest = Quest(new QuestPVPRevenge().ExtraCondition(Quest.EXTRA_DEFENDING_FINISHED).SymbolFrame(7).Id("questID26"));
      
      public static const QUEST_REAL_POWER:Quest = Quest(new QuestUpgradeTier(4).Id("questID27"));
      
      public static const QUEST_HATE_MOABS:Quest = Quest(new QuestBuilding(BuildingData.getInstance().ANTI_MOAB_RESEARCH_LAB.id,1).Id("questID28"));
      
      public static const QUEST_SUPER:Quest = Quest(new QuestBuilding(BuildingData.getInstance().SUPER_MONKEY_VILLA.id,1).Id("questID29"));
      
      public static const QUEST_ANCIENT_PORTAL_KNOWLEDGE:Quest = Quest(new Quest().AchieveSignal(GameSignals.FIND_PORTAL_SIGNAL).SymbolFrame(4).Id("questID30"));
      
      public static const QUEST_RESETTLEMENT:Quest = Quest(new Quest().AchieveSignal(GameSignals.CREATED_SECONDARY_CITY).SymbolFrame(4).Id("questID31"));
      
      public static const QUEST_THRID_FARM:Quest = Quest(new QuestBuilding(BuildingData.getInstance().BANANA_FARM.id,3).Id("questID32"));
      
      public static const QUEST_BETTER_BOOMERANGS:Quest = Quest(new QuestUpgrade(1,1,UpgradeData.getInstance().BOOMERANG_THROWER_UPGRADES.path1.tier1.id,UpgradeData.getInstance().BOOMERANG_THROWER_UPGRADES).ExtraCondition(Quest.EXTRA_HAVE_MONKEY_ACADEMY_AND_BOOMERANG_HUT).Id("questID34"));
      
      public static const QUEST_SWITCHED_ON:Quest = Quest(new QuestBuilding(BuildingData.getInstance().WINDMILL.id,2).Id("questID36"));
      
      public static const QUEST_JUICED:Quest = Quest(new QuestBuildingPower(250).Id("questID37"));
      
      public static const QUEST_POWER_SPIKE:Quest = Quest(new QuestUpgradeBuilding(Vector.<String>([BuildingData.getInstance().WINDMILL.id,BuildingData.getInstance().WATERMILL.id])).Id("questID38"));
      
      public static const QUEST_MEGAVOLT:Quest = Quest(new QuestResourcePower(1000).Id("questID39"));
      
      public static const QUEST_BIG_BLOON_HUNTER:Quest = Quest(new QuestHunter(1,Vector.<int>([Constants.MOAB_ID])).Id("questID41"));
      
      public static const QUEST_BIGGER_BLOON_HUNTER:Quest = Quest(new QuestHunter(1,Vector.<int>([Constants.BFB_ID])).Id("questID42"));
      
      public static const QUEST_BIGGEST_BLOON_HUNTER:Quest = Quest(new QuestHunter(1,Vector.<int>([Constants.BOSS_ID])).Id("questID43"));
      
      public static const QUEST_BIG_FARMS:Quest = Quest(new QuestUpgradeBuilding(Vector.<String>([BuildingData.getInstance().BANANA_FARM.id])).Id("questID44"));
      
      public static const QUEST_BIG_VAULTS:Quest = Quest(new QuestUpgradeBuilding(Vector.<String>([BuildingData.getInstance().MONKEY_BANK.id])).Id("questID45"));
      
      public static const QUEST_BLOON_RESEARCH:Quest = Quest(new QuestBuilding(BuildingData.getInstance().BLOON_RESEARCH_LAB.id).Id("questID46"));
      
      public static const QUEST_FAST_BLOONS:Quest = Quest(new QuestBloonResearch(BloonResearchLabUpgrades.FAST_BLOONS.id).Id("questID47"));
      
      public static const QUEST_LEAD_BLOONS:Quest = Quest(new QuestBloonResearch(BloonResearchLabUpgrades.HEAVY_BLOON_ARMOUR.id).Id("questID48"));
      
      public static const QUEST_CERAMIC_BLOONS:Quest = Quest(new QuestBloonResearch(BloonResearchLabUpgrades.CERAMIC_BLOON_CONSTRUCTION.id).Id("questID49"));
      
      public static const QUEST_ARMY_OF_DARTNESS:Quest = Quest(new QuestBuilding(BuildingData.getInstance().MONKEY_DART_HALL.id,10).Id("questID50"));
      
      public static const QUEST_MOAB_MAULER:Quest = Quest(new QuestUpgrade(2,3,UpgradeData.getInstance().BOMB_TOWER_UPGRADES.path2.tier3.id,UpgradeData.getInstance().BOMB_TOWER_UPGRADES).Id("questID51"));
      
      public static const QUEST_TARGET_ACQUIRED:Quest = Quest(new QuestBuilding(BuildingData.getInstance().SNIPERS_RECLUSE.id,1).Id("questID52"));
      
      public static const QUEST_TACK_ATTACK:Quest = Quest(new QuestBuilding(BuildingData.getInstance().TACK_SHOOTER_STORAGE_FACILITY.id,1).Id("questID53"));
      
      public static const QUEST_MAY_THE_4S_BE_WITH_YOU:Quest = Quest(new QuestUpgradeTier(4,5).Id("questID54"));
      
      public static const QUEST_THE_BIGGER_THEY_ARE:Quest = Quest(new QuestHunter(10,Vector.<int>([Constants.BOSS_ID])).Id("questID55"));
      
      public static const QUEST_DARK_DIRIGIBLE_TITAN:Quest = Quest(new QuestHunter(1,Vector.<int>([Constants.DDT_ID_IN_MODULE])).Id("questID56"));
      
      public static const QUEST_GAME_OF_FARMS:Quest = Quest(new QuestBuilding(BuildingData.getInstance().MICRO_AGRICULTURAL_DEVELOPMENT_BUILDING.id,1).Id("questID57"));
      
      public static const QUEST_PREPARE_TO_EXPAND:Quest = Quest(new QuestTotalMonkeys(20).AchieveSignal(Building.buildingWasCompletedSignal).Id("questID58"));
      
      public static const QUEST_MORE_PREPARATION:Quest = Quest(new QuestMorePreparation(3).AchieveSignal(GameSignals.TILE_CAPTURED_SIGNAL).Id("questID59"));
      
      public static const QUEST_GATHER_SUPPLIES:Quest = Quest(new QuestGatherSupplies(4).AchieveSignal(GameSignals.TILE_CAPTURED_SIGNAL).Id("questID60"));
      
      public static const QUESTS:Vector.<Quest> = Vector.<Quest>([QUEST_LONG_RANGE_DARTS,QUEST_BOMBS_AWAY,QUEST_TREASURE_CHEST,QUEST_GET_HARD,QUEST_BUILD_A_WATERMILL,QUEST_MORE_MONEY,QUEST_CAMO_COUNTERMEASURES,QUEST_MONKEY_VS_MONKEY,QUEST_STORE_MORE,QUEST_SPECIAL_TERRAIN,QUEST_MORE_MONKEYS_NEEDED,QUEST_PRECIOUS_BLOONTONIUM,QUEST_STORE_BLOONTONIUM,QUEST_RAID_SOMEONE,QUEST_PILLAGE,QUEST_LAND_GRAB_1,QUEST_LAND_GRAB_2,QUEST_LAND_GRAB_3,QUEST_TREASURE_RAIDER,QUEST_REVENGE,QUEST_REAL_POWER,QUEST_HATE_MOABS,QUEST_SUPER,QUEST_THRID_FARM,QUEST_BETTER_BOOMERANGS,QUEST_SWITCHED_ON,QUEST_JUICED,QUEST_POWER_SPIKE,QUEST_MEGAVOLT,QUEST_BIG_BLOON_HUNTER,QUEST_BIGGER_BLOON_HUNTER,QUEST_BIGGEST_BLOON_HUNTER,QUEST_BIG_FARMS,QUEST_BIG_VAULTS,QUEST_BLOON_RESEARCH,QUEST_FAST_BLOONS,QUEST_LEAD_BLOONS,QUEST_CERAMIC_BLOONS,QUEST_ARMY_OF_DARTNESS,QUEST_MOAB_MAULER,QUEST_TARGET_ACQUIRED,QUEST_TACK_ATTACK,QUEST_MAY_THE_4S_BE_WITH_YOU,QUEST_THE_BIGGER_THEY_ARE,QUEST_DARK_DIRIGIBLE_TITAN,QUEST_GAME_OF_FARMS,QUEST_PREPARE_TO_EXPAND,QUEST_MORE_PREPARATION,QUEST_GATHER_SUPPLIES]);
      
      public static var questsByID:Object = {};
      
      {
         function():void
         {
            var _loc1_:* = 0;
            while(_loc1_ < QUESTS.length)
            {
               questsByID[QUESTS[_loc1_].id] = QUESTS[_loc1_];
               _loc1_++;
            }
         }();
      }
      
      public function QuestData()
      {
         super();
      }
      
      public static function findQuest(param1:String) : Quest
      {
         return questsByID[param1];
      }
   }
}
