package ninjakiwi.monkeyTown.achievements.tests
{
   import ninjakiwi.monkeyTown.achievements.AchievementsConfig;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   
   public class HonorTest extends AchievementTest
   {
       
      
      public function HonorTest()
      {
         super();
         ResourceStore.getInstance().honourChangedDiffSignal.add(this.test);
      }
      
      private function test(... rest) : void
      {
         var _loc2_:int = ResourceStore.getInstance().honour;
         var _loc3_:Number = 100 * (_loc2_ / AchievementsConfig.RED_CITY_HONOR_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.RED_CITY_HONOR,_loc3_);
         var _loc4_:Number = 100 * (_loc2_ / AchievementsConfig.BLUE_CITY_HONOR_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.BLUE_CITY_HONOR,_loc4_);
         var _loc5_:Number = 100 * (_loc2_ / AchievementsConfig.GREEN_CITY_HONOR_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.GREEN_CITY_HONOR,_loc5_);
         var _loc6_:Number = 100 * (_loc2_ / AchievementsConfig.YELLOW_CITY_HONOR_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.YELLOW_CITY_HONOR,_loc6_);
         var _loc7_:Number = 100 * (_loc2_ / AchievementsConfig.PINK_CITY_HONOR_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.PINK_CITY_HONOR,_loc7_);
         var _loc8_:Number = 100 * (_loc2_ / AchievementsConfig.BLACK_CITY_HONOR_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.BLACK_CITY_HONOR,_loc8_);
         var _loc9_:Number = 100 * (_loc2_ / AchievementsConfig.WHITE_CITY_HONOR_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.WHITE_CITY_HONOR,_loc9_);
         var _loc10_:Number = 100 * (_loc2_ / AchievementsConfig.ZEBRA_CITY_HONOR_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.ZEBRA_CITY_HONOR,_loc10_);
         var _loc11_:Number = 100 * (_loc2_ / AchievementsConfig.RAINBOW_CITY_HONOR_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.RAINBOW_CITY_HONOR,_loc11_);
         var _loc12_:Number = 100 * (_loc2_ / AchievementsConfig.CERAMIC_CITY_HONOR_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.CERAMIC_CITY_HONOR,_loc12_);
         var _loc13_:Number = 100 * (_loc2_ / AchievementsConfig.MOAB_CITY_HONOR_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.MOAB_CITY_HONOR,_loc13_);
         var _loc14_:Number = 100 * (_loc2_ / AchievementsConfig.BFB_CITY_HONOR_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.BFB_CITY_HONOR,_loc14_);
         var _loc15_:Number = 100 * (_loc2_ / AchievementsConfig.ZOMG_CITY_HONOR_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.ZOMG_CITY_HONOR,_loc15_);
      }
   }
}
