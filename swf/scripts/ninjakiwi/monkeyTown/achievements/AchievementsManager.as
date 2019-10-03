package ninjakiwi.monkeyTown.achievements
{
   import com.ninjakiwi.gateway.nk.NKGatewayUser;
   import flash.display.MovieClip;
   import ninjakiwi.monkeyTown.achievements.tests.AttackWonTest;
   import ninjakiwi.monkeyTown.achievements.tests.BTDGameCompleteTest;
   import ninjakiwi.monkeyTown.achievements.tests.BloonResearchLabUpgradeCompleteTest;
   import ninjakiwi.monkeyTown.achievements.tests.BuildCompleteTest;
   import ninjakiwi.monkeyTown.achievements.tests.CashPillagedTest;
   import ninjakiwi.monkeyTown.achievements.tests.CityLevelChangedTest;
   import ninjakiwi.monkeyTown.achievements.tests.ContestedTest;
   import ninjakiwi.monkeyTown.achievements.tests.DefendAttackTest;
   import ninjakiwi.monkeyTown.achievements.tests.HonorTest;
   import ninjakiwi.monkeyTown.achievements.tests.MoneyCapacityIncreasedTest;
   import ninjakiwi.monkeyTown.achievements.tests.RevengeAttackLaunchedTest;
   import ninjakiwi.monkeyTown.achievements.tests.TileCapturedTest;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgeToken;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgeTree;
   import ninjakiwi.monkeyTown.pvp.PvPClient;
   import ninjakiwi.monkeyTown.pvp.PvPTimerManager;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.icons.KnowledgePackSaleIcon;
   import ninjakiwi.monkeyTown.town.ui.pvp.PvPPanel;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.MonkeyKnowledgeOpenPacksScreen;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.WildCardFront;
   import ninjakiwi.monkeyTown.utils.DefinitionPopulator;
   import ninjakiwi.mynk.save.TrafficGate;
   
   public class AchievementsManager
   {
      
      private static var instance:AchievementsManager;
       
      
      private var _data:Object = null;
      
      public const GIMME_THAT:AchievementDefinition = new AchievementDefinition().Id("GimmeThat");
      
      public const EXTORTIONIST:AchievementDefinition = new AchievementDefinition().Id("Extortionist");
      
      public const SWEET_REVENGE:AchievementDefinition = new AchievementDefinition().Id("SweetRevenge");
      
      public const BEST_SERVED_COLD:AchievementDefinition = new AchievementDefinition().Id("BestServedCold");
      
      public const BLOON_SCIENCE:AchievementDefinition = new AchievementDefinition().Id("BloonScience");
      
      public const GUARDIAN:AchievementDefinition = new AchievementDefinition().Id("Guardian");
      
      public const DEFENDER:AchievementDefinition = new AchievementDefinition().Id("Defender");
      
      public const EPIC_DEFENDER:AchievementDefinition = new AchievementDefinition().Id("EpicDefender");
      
      public const FLAWLESS_DEFENDER:AchievementDefinition = new AchievementDefinition().Id("FlawlessDefender");
      
      public const ATTACK_RUN:AchievementDefinition = new AchievementDefinition().Id("AttackRun");
      
      public const MONKEY_RAIDER:AchievementDefinition = new AchievementDefinition().Id("MonkeyRaider");
      
      public const YOU_SHALL_NOT_PASS:AchievementDefinition = new AchievementDefinition().Id("YouShallNotPass");
      
      public const LAND_SURVEYOR:AchievementDefinition = new AchievementDefinition().Id("LandSurveyor");
      
      public const LAND_AHOY:AchievementDefinition = new AchievementDefinition().Id("LandAhoy");
      
      public const MONKEY_LAND_TRUST:AchievementDefinition = new AchievementDefinition().Id("MonkeyLandTrust");
      
      public const MONKEY_LAND_CONSERVANCY:AchievementDefinition = new AchievementDefinition().Id("MonkeyLandConservancy");
      
      public const HERES_MY_WATER:AchievementDefinition = new AchievementDefinition().Id("HeresMyWater");
      
      public const HIGH_GROUND:AchievementDefinition = new AchievementDefinition().Id("HighGround");
      
      public const TREASURE_HUNTER:AchievementDefinition = new AchievementDefinition().Id("TreasureHunter");
      
      public const TREASURE_TROVE:AchievementDefinition = new AchievementDefinition().Id("TreasureTrove");
      
      public const EXTRA_SPECIAL:AchievementDefinition = new AchievementDefinition().Id("ExtraSpecial");
      
      public const FEEL_THE_POWER:AchievementDefinition = new AchievementDefinition().Id("FeelThePower");
      
      public const POWER_MAD:AchievementDefinition = new AchievementDefinition().Id("PowerMad");
      
      public const WHOLE_LOTTA_MONKEYS:AchievementDefinition = new AchievementDefinition().Id("WholeLottaMonkeys");
      
      public const CITY_WITH_EVERYTHING:AchievementDefinition = new AchievementDefinition().Id("CityWithEverything");
      
      public const BLING_WORTHY:AchievementDefinition = new AchievementDefinition().Id("BlingWorthy");
      
      public const PHAT_STAX:AchievementDefinition = new AchievementDefinition().Id("PhatStax");
      
      public const MOAB_MAULER:AchievementDefinition = new AchievementDefinition().Id("MOABMauler");
      
      public const MOAB_ASSASSIN:AchievementDefinition = new AchievementDefinition().Id("MOABAssassin");
      
      public const DDT_ERADICATOR:AchievementDefinition = new AchievementDefinition().Id("DDTEradicator");
      
      public const BFB_SABOTEUR:AchievementDefinition = new AchievementDefinition().Id("BFBSaboteur");
      
      public const ZOMGINATOR:AchievementDefinition = new AchievementDefinition().Id("ZOMGinator");
      
      public const STEELEY:AchievementDefinition = new AchievementDefinition().Id("Steeley");
      
      public const HARD_BAKED:AchievementDefinition = new AchievementDefinition().Id("HardBaked");
      
      public const INFRARED:AchievementDefinition = new AchievementDefinition().Id("Infrared");
      
      public const IMPOPPABLE:AchievementDefinition = new AchievementDefinition().Id("Impoppable");
      
      public const RED_CITY_HONOR:AchievementDefinition = new AchievementDefinition().Id("RedCityHonor");
      
      public const BLUE_CITY_HONOR:AchievementDefinition = new AchievementDefinition().Id("BlueCityHonor");
      
      public const GREEN_CITY_HONOR:AchievementDefinition = new AchievementDefinition().Id("GreenCityHonor");
      
      public const YELLOW_CITY_HONOR:AchievementDefinition = new AchievementDefinition().Id("YellowCityHonor");
      
      public const PINK_CITY_HONOR:AchievementDefinition = new AchievementDefinition().Id("PinkCityHonor");
      
      public const BLACK_CITY_HONOR:AchievementDefinition = new AchievementDefinition().Id("BlackCityHonor");
      
      public const WHITE_CITY_HONOR:AchievementDefinition = new AchievementDefinition().Id("WhiteCityHonor");
      
      public const ZEBRA_CITY_HONOR:AchievementDefinition = new AchievementDefinition().Id("ZebraCityHonor");
      
      public const RAINBOW_CITY_HONOR:AchievementDefinition = new AchievementDefinition().Id("RainbowCityHonor");
      
      public const CERAMIC_CITY_HONOR:AchievementDefinition = new AchievementDefinition().Id("CeramicCityHonor");
      
      public const MOAB_CITY_HONOR:AchievementDefinition = new AchievementDefinition().Id("MOABCityHonor");
      
      public const BFB_CITY_HONOR:AchievementDefinition = new AchievementDefinition().Id("BFBCityHonor");
      
      public const ZOMG_CITY_HONOR:AchievementDefinition = new AchievementDefinition().Id("ZOMGCityHonor");
      
      public const CONTESTANT:AchievementDefinition = new AchievementDefinition().Id("Contestant");
      
      public const VICTOR:AchievementDefinition = new AchievementDefinition().Id("Victor");
      
      public const TERRITORY_BOSS:AchievementDefinition = new AchievementDefinition().Id("TerritoryBoss");
      
      public const TERRITORY_CONQUEROR:AchievementDefinition = new AchievementDefinition().Id("TerritoryConqueror");
      
      public const TERRITORY_KING:AchievementDefinition = new AchievementDefinition().Id("TerritoryKing");
      
      public const NEW_FRONTIERS:AchievementDefinition = new AchievementDefinition().Id("NewFrontiers");
      
      public const CITY_DEVELOPER:AchievementDefinition = new AchievementDefinition().Id("CityDeveloper");
      
      public const DARK_DIRIGIBLE_TITAN:AchievementDefinition = new AchievementDefinition().Id("DarkDirigibleTitan");
      
      public const SANDSTORM:AchievementDefinition = new AchievementDefinition().Id("Sandstorm");
      
      public const DRY_AS_A_BONE:AchievementDefinition = new AchievementDefinition().Id("DryAsABone");
      
      public const ZZZZOMG:AchievementDefinition = new AchievementDefinition().Id("ZZZZOMG");
      
      public const MONKEY_CITY_KING:AchievementDefinition = new AchievementDefinition().Id("MonkeyCityKing");
      
      public const ARE_THERE_GOOD_LANDS:AchievementDefinition = new AchievementDefinition().Id("AreThereGoodLands");
      
      public const GRASS_LAND_EXPLORER:AchievementDefinition = new AchievementDefinition().Id("GrassLandExplorer");
      
      public const HIGHLAND_FLING:AchievementDefinition = new AchievementDefinition().Id("HighlandFling");
      
      public const TRACK_MASTER:AchievementDefinition = new AchievementDefinition().Id("TrackMaster");
      
      public const BLOONARIUS_LEVEL_1:AchievementDefinition = new AchievementDefinition().Id("Bloonarius Popper").NkAchievementIndex(690).AwesomeEarned(10);
      
      public const BLOONARIUS_LEVEL_10:AchievementDefinition = new AchievementDefinition().Id("Bloonarius Piercer").NkAchievementIndex(691).AwesomeEarned(25);
      
      public const BLOONARIUS_LEVEL_15:AchievementDefinition = new AchievementDefinition().Id("Bloonarius Render").NkAchievementIndex(692).AwesomeEarned(100);
      
      public const BLOONARIUS_LEVEL_20:AchievementDefinition = new AchievementDefinition().Id("Bloonarius Perforator").NkAchievementIndex(693).AwesomeEarned(200);
      
      public const BLOONARIUS_LEVEL_25:AchievementDefinition = new AchievementDefinition().Id("Bane of Bloonarius").NkAchievementIndex(694).AwesomeEarned(500);
      
      public const BLOONARIUS_75_TIMES:AchievementDefinition = new AchievementDefinition().Id("Swamp Thing Nemesis").NkAchievementIndex(695).AwesomeEarned(100);
      
      public const BOSS_ANY_75_TIMES:AchievementDefinition = new AchievementDefinition().Id("Boss Popper").NkAchievementIndex(696).AwesomeEarned(100);
      
      public const BOSS_ANY_150_TIMES:AchievementDefinition = new AchievementDefinition().Id("Boss Stomper").NkAchievementIndex(697).AwesomeEarned(200);
      
      public const VORTEX_LEVEL_1:AchievementDefinition = new AchievementDefinition().Id("Vortex Popper").NkAchievementIndex(698).AwesomeEarned(10);
      
      public const VORTEX_LEVEL_10:AchievementDefinition = new AchievementDefinition().Id("Vortex Piercer").NkAchievementIndex(699).AwesomeEarned(25);
      
      public const VORTEX_LEVEL_15:AchievementDefinition = new AchievementDefinition().Id("Vortex Render").NkAchievementIndex(700).AwesomeEarned(100);
      
      public const VORTEX_LEVEL_20:AchievementDefinition = new AchievementDefinition().Id("Vortex Perforator").NkAchievementIndex(701).AwesomeEarned(200);
      
      public const VORTEX_LEVEL_25:AchievementDefinition = new AchievementDefinition().Id("Bane of Vortex").NkAchievementIndex(702).AwesomeEarned(500);
      
      public const VORTEX_75_TIMES:AchievementDefinition = new AchievementDefinition().Id("Air Dervish Nemesis").NkAchievementIndex(703).AwesomeEarned(100);
      
      public const DREADBLOON_LEVEL_1:AchievementDefinition = new AchievementDefinition().Id("Dreadbloon Popper").NkAchievementIndex(712).AwesomeEarned(10);
      
      public const DREADBLOON_LEVEL_10:AchievementDefinition = new AchievementDefinition().Id("Dreadbloon Piercer").NkAchievementIndex(713).AwesomeEarned(25);
      
      public const DREADBLOON_LEVEL_15:AchievementDefinition = new AchievementDefinition().Id("Dreadbloon Render").NkAchievementIndex(714).AwesomeEarned(100);
      
      public const DREADBLOON_LEVEL_20:AchievementDefinition = new AchievementDefinition().Id("Dreadbloon Perforator").NkAchievementIndex(715).AwesomeEarned(200);
      
      public const DREADBLOON_LEVEL_25:AchievementDefinition = new AchievementDefinition().Id("Bane of Dreadbloon").NkAchievementIndex(716).AwesomeEarned(500);
      
      public const DREADBLOON_75_TIMES:AchievementDefinition = new AchievementDefinition().Id("Doom of The Armored Behemoth").NkAchievementIndex(717).AwesomeEarned(100);
      
      public const BLASTAPOPOULOS_LEVEL_1:AchievementDefinition = new AchievementDefinition().Id("Blastapopoulos Popper").NkAchievementIndex(718).AwesomeEarned(10);
      
      public const BLASTAPOPOULOS_LEVEL_10:AchievementDefinition = new AchievementDefinition().Id("Blastapopoulos Piercer").NkAchievementIndex(719).AwesomeEarned(25);
      
      public const BLASTAPOPOULOS_LEVEL_15:AchievementDefinition = new AchievementDefinition().Id("Blastapopoulos Render").NkAchievementIndex(720).AwesomeEarned(100);
      
      public const BLASTAPOPOULOS_LEVEL_20:AchievementDefinition = new AchievementDefinition().Id("Blastapopoulos Perforator").NkAchievementIndex(721).AwesomeEarned(200);
      
      public const BLASTAPOPOULOS_LEVEL_25:AchievementDefinition = new AchievementDefinition().Id("Bane of Blastapopoulos").NkAchievementIndex(722).AwesomeEarned(500);
      
      public const BLASTAPOPOULOS_75_TIMES:AchievementDefinition = new AchievementDefinition().Id("Blastapopoulos Sarcophagus").NkAchievementIndex(723).AwesomeEarned(100);
      
      private const _allAchievements:Array = [this.GIMME_THAT,this.EXTORTIONIST,this.SWEET_REVENGE,this.BEST_SERVED_COLD,this.BLOON_SCIENCE,this.GUARDIAN,this.EPIC_DEFENDER,this.FLAWLESS_DEFENDER,this.ATTACK_RUN,this.MONKEY_RAIDER,this.DEFENDER,this.YOU_SHALL_NOT_PASS,this.LAND_SURVEYOR,this.LAND_AHOY,this.MONKEY_LAND_TRUST,this.MONKEY_LAND_CONSERVANCY,this.HERES_MY_WATER,this.HIGH_GROUND,this.TREASURE_HUNTER,this.TREASURE_TROVE,this.EXTRA_SPECIAL,this.FEEL_THE_POWER,this.POWER_MAD,this.WHOLE_LOTTA_MONKEYS,this.CITY_WITH_EVERYTHING,this.BLING_WORTHY,this.PHAT_STAX,this.MOAB_MAULER,this.IMPOPPABLE,this.RED_CITY_HONOR,this.BLUE_CITY_HONOR,this.GREEN_CITY_HONOR,this.YELLOW_CITY_HONOR,this.MOAB_ASSASSIN,this.DDT_ERADICATOR,this.BFB_SABOTEUR,this.ZOMGINATOR,this.STEELEY,this.HARD_BAKED,this.INFRARED,this.PINK_CITY_HONOR,this.BLACK_CITY_HONOR,this.WHITE_CITY_HONOR,this.ZEBRA_CITY_HONOR,this.RAINBOW_CITY_HONOR,this.CERAMIC_CITY_HONOR,this.MOAB_CITY_HONOR,this.BFB_CITY_HONOR,this.ZOMG_CITY_HONOR,this.CONTESTANT,this.VICTOR,this.TERRITORY_BOSS,this.TERRITORY_CONQUEROR,this.TERRITORY_KING,this.NEW_FRONTIERS,this.CITY_DEVELOPER,this.DARK_DIRIGIBLE_TITAN,this.SANDSTORM,this.DRY_AS_A_BONE,this.ZZZZOMG,this.MONKEY_CITY_KING,this.ARE_THERE_GOOD_LANDS,this.GRASS_LAND_EXPLORER,this.HIGHLAND_FLING,this.TRACK_MASTER];
      
      private const _achievementsByID:Object = {};
      
      private var _state:Object;
      
      private var _cashPillagedTest:CashPillagedTest;
      
      private var _revengeAttackLaunchedTest:RevengeAttackLaunchedTest;
      
      private var _defendAttackTest:DefendAttackTest;
      
      private var _attackWonTest:AttackWonTest;
      
      private var _buildCompleteTest:BuildCompleteTest;
      
      private var _tileCapturedTest:TileCapturedTest;
      
      private var _moneyCapacityIncreasedTest:MoneyCapacityIncreasedTest;
      
      private var _btdGameCompleteTest:BTDGameCompleteTest;
      
      private var _bloonResearchLabUpgradeCompleteTest:BloonResearchLabUpgradeCompleteTest;
      
      private var _honorTest:HonorTest;
      
      private var _contestTest:ContestedTest;
      
      private var _cityLevelChangedTest:CityLevelChangedTest;
      
      private var _trafficGate:TrafficGate;
      
      public function AchievementsManager(param1:SingletonEnforcer#1327)
      {
         this._state = {};
         this._trafficGate = new TrafficGate();
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use AchievementsManager.getInstance() instead of new.");
         }
      }
      
      public static function getInstance() : AchievementsManager
      {
         if(instance == null)
         {
            instance = new AchievementsManager(new SingletonEnforcer#1327());
         }
         return instance;
      }
      
      public function initialiseWithData(param1:Object) : void
      {
         var _loc4_:AchievementDefinition = null;
         var _loc5_:Object = null;
         this._data = param1;
         var _loc2_:DefinitionPopulator = new DefinitionPopulator();
         var _loc3_:int = this._allAchievements.length;
         var _loc6_:int = 0;
         while(_loc6_ < this._allAchievements.length)
         {
            _loc4_ = this._allAchievements[_loc6_];
            _loc5_ = param1[_loc4_.id];
            if(_loc5_ !== null)
            {
               _loc2_.populateDefinitionFromObject(_loc4_,_loc5_);
               this._achievementsByID[_loc4_.id] = _loc4_;
            }
            _loc6_++;
         }
         this.init();
      }
      
      private function init() : void
      {
         this._cashPillagedTest = new CashPillagedTest();
         this._revengeAttackLaunchedTest = new RevengeAttackLaunchedTest();
         this._defendAttackTest = new DefendAttackTest();
         this._attackWonTest = new AttackWonTest();
         this._tileCapturedTest = new TileCapturedTest();
         this._buildCompleteTest = new BuildCompleteTest();
         this._moneyCapacityIncreasedTest = new MoneyCapacityIncreasedTest();
         this._btdGameCompleteTest = new BTDGameCompleteTest();
         this._bloonResearchLabUpgradeCompleteTest = new BloonResearchLabUpgradeCompleteTest();
         this._honorTest = new HonorTest();
         this._contestTest = new ContestedTest();
         this._cityLevelChangedTest = new CityLevelChangedTest();
         MonkeyCityMain.globalResetSignal.add(this.reset);
      }
      
      public function reset(... rest) : void
      {
         this._state = {};
      }
      
      public function setAchievementProgress(param1:AchievementDefinition, param2:Number = 100) : void
      {
         this._trafficGate.callFunctionForTarget(this.setAchievementProgressPostGate,param1,param1,param2);
      }
      
      private function setAchievementProgressPostGate(param1:AchievementDefinition, param2:Number = 100) : void
      {
         var nkGatewayUser:NKGatewayUser = null;
         var achievement:AchievementDefinition = param1;
         var progress:Number = param2;
         var currentProgress:Number = Number(this._state[achievement.id]) || Number(0);
         if(currentProgress < 100 && int(progress) > int(currentProgress))
         {
            nkGatewayUser = MonkeySystem.getInstance().nkGatewayUser;
            if(nkGatewayUser !== null)
            {
               nkGatewayUser.setAchievement(achievement.nkAchievementIndex,progress).then(function success(param1:Object):void
               {
               },function fail(param1:Object):void
               {
                  t.obj(param1);
               });
            }
         }
         this._state[achievement.id] = progress;
      }
   }
}

class SingletonEnforcer#1327
{
    
   
   function SingletonEnforcer#1327()
   {
      super();
   }
}
