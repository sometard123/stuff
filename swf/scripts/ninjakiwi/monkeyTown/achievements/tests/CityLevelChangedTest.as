package ninjakiwi.monkeyTown.achievements.tests
{
   import ninjakiwi.monkeyTown.achievements.AchievementsConfig;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.cityCommon.CityCommonDataManager;
   import ninjakiwi.monkeyTown.town.cityCommon.CityCommonDataSlot;
   
   public class CityLevelChangedTest extends AchievementTest
   {
       
      
      private var newFrontiersLastSubmitLevel:int = -1;
      
      private var cityDeveloperLastSubmitLevel:int = -1;
      
      private const _system:MonkeySystem = MonkeySystem.getInstance();
      
      public function CityLevelChangedTest()
      {
         super();
         ResourceStore.getInstance().townLevelChangedDiffSignal.addWithPriority(this.test,-10000);
      }
      
      private function test(... rest) : void
      {
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc2_:CityCommonDataManager = CityCommonDataManager.getInstance();
         var _loc3_:CityCommonDataSlot = _loc2_.getCitySlotClone(0);
         var _loc4_:CityCommonDataSlot = _loc2_.getCitySlotClone(1);
         var _loc5_:Number = _loc3_ !== null?Number(_loc3_.cityLevel):Number(0);
         var _loc6_:Number = _loc4_ !== null?Number(_loc4_.cityLevel):Number(0);
         var _loc7_:Number = 100 * (_loc5_ + _loc6_) / (Constants.MAX_CITY_LEVEL * 2);
         _achievementsManager.setAchievementProgress(_achievementsManager.MONKEY_CITY_KING,_loc7_);
         if(this._system.city.cityIndex === 1)
         {
            _loc8_ = ResourceStore.getInstance().townLevel;
            if(_loc8_ > this.newFrontiersLastSubmitLevel)
            {
               _loc9_ = 100 * (_loc8_ / AchievementsConfig.NEW_FRONTIERS_THRESHOLD);
               _achievementsManager.setAchievementProgress(_achievementsManager.NEW_FRONTIERS,_loc9_);
               this.newFrontiersLastSubmitLevel = _loc8_;
            }
            if(_loc8_ > this.cityDeveloperLastSubmitLevel)
            {
               _loc10_ = 100 * (_loc8_ / AchievementsConfig.CITY_DEVELOPER_THRESHOLD);
               _achievementsManager.setAchievementProgress(_achievementsManager.CITY_DEVELOPER,_loc10_);
               this.cityDeveloperLastSubmitLevel = _loc8_;
            }
         }
      }
   }
}
