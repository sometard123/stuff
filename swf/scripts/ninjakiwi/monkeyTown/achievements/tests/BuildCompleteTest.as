package ninjakiwi.monkeyTown.achievements.tests
{
   import ninjakiwi.monkeyTown.achievements.AchievementsConfig;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.buildings.BuildingManager;
   import ninjakiwi.monkeyTown.town.data.BuildingData;
   import ninjakiwi.monkeyTown.town.data.definitions.MonkeyTownBuildingDefinition;
   
   public class BuildCompleteTest extends AchievementTest
   {
       
      
      private var _allBuildingsData:Vector.<MonkeyTownBuildingDefinition>;
      
      public function BuildCompleteTest()
      {
         this._allBuildingsData = new Vector.<MonkeyTownBuildingDefinition>();
         super();
         this.initData();
         Building.buildingWasCompletedSignal.addWithPriority(this.onBuildingCompleted,LISTENER_PRIORITY);
         GameSignals.POWER_CHANGED.add(this.onBuildingCompleted);
      }
      
      private function initData() : void
      {
         var _loc2_:MonkeyTownBuildingDefinition = null;
         var _loc1_:BuildingData = BuildingData.getInstance();
         var _loc3_:Object = {};
         var _loc4_:Array = _loc1_.baseBuildingDefinitions.concat(_loc1_.resourceBuildingDefinitions).concat(_loc1_.upgradeBuildingDefinitions).concat(_loc1_.specialBuildingDefinitions).concat(_loc1_.pvpBuildingDefinitions);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc2_ = _loc4_[_loc5_];
            if(!_loc3_.hasOwnProperty(_loc2_.id))
            {
               this._allBuildingsData.push(_loc2_);
               _loc3_[_loc2_.id] = 1;
            }
            _loc5_++;
         }
      }
      
      private function onBuildingCompleted(... rest) : void
      {
         var _loc11_:MonkeyTownBuildingDefinition = null;
         if(!MonkeySystem.getInstance().map.worldIsReady)
         {
            return;
         }
         var _loc2_:ResourceStore = ResourceStore.getInstance();
         var _loc3_:MonkeySystem = MonkeySystem.getInstance();
         var _loc4_:BuildingManager = _loc3_.city.buildingManager;
         var _loc5_:int = _loc4_.getCompletedBaseBuildingCount();
         var _loc6_:Number = 100 * (_loc2_.totalPower / AchievementsConfig.FEEL_THE_POWER_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.FEEL_THE_POWER,_loc6_);
         var _loc7_:Number = 100 * (_loc2_.totalPower / AchievementsConfig.POWER_MAD_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.POWER_MAD,_loc7_);
         var _loc8_:Number = 100 * (_loc5_ / AchievementsConfig.WHOLE_LOTTA_MONKEYS_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.WHOLE_LOTTA_MONKEYS,_loc8_);
         var _loc9_:Object = _loc4_.buildingCounts;
         var _loc10_:int = 0;
         var _loc12_:int = 0;
         while(_loc12_ < this._allBuildingsData.length)
         {
            _loc11_ = this._allBuildingsData[_loc12_];
            if(_loc9_.hasOwnProperty(_loc11_.id) && _loc9_[_loc11_.id] > 0)
            {
               _loc10_++;
            }
            _loc12_++;
         }
         var _loc13_:Number = 100 * (_loc10_ / this._allBuildingsData.length);
         _achievementsManager.setAchievementProgress(_achievementsManager.CITY_WITH_EVERYTHING,_loc13_);
      }
   }
}
