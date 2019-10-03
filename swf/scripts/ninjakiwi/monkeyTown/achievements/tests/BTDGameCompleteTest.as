package ninjakiwi.monkeyTown.achievements.tests
{
   import ninjakiwi.monkeyTown.achievements.AchievementsConfig;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   
   public class BTDGameCompleteTest extends AchievementTest
   {
       
      
      public function BTDGameCompleteTest()
      {
         super();
         GameSignals.BTD_GAME_COMPLETE_SIGNAL.addWithPriority(this.test,LISTENER_PRIORITY);
      }
      
      private function test(... rest) : void
      {
         var _loc2_:Number = 100 * (_statsData.moabsDestroyed.value / AchievementsConfig.MOAB_MAULER_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.MOAB_MAULER,_loc2_);
         var _loc3_:Number = 100 * (_statsData.moabsDestroyed.value / AchievementsConfig.MOAB_ASSASSIN_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.MOAB_ASSASSIN,_loc3_);
         var _loc4_:Number = 100 * (_statsData.ddtsDestroyed.value / AchievementsConfig.DDT_ERADICATOR_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.DDT_ERADICATOR,_loc4_);
         var _loc5_:Number = 100 * (_statsData.bfbsDestroyed.value / AchievementsConfig.BFB_SABOTEUR_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.BFB_SABOTEUR,_loc5_);
         var _loc6_:Number = 100 * (_statsData.zomgsDestroyed.value / AchievementsConfig.ZOMGINATOR_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.ZOMGINATOR,_loc6_);
         var _loc7_:Number = 100 * (_statsData.leadBloonsPopped.value / AchievementsConfig.STEELY_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.STEELEY,_loc7_);
         var _loc8_:Number = 100 * (_statsData.ceramicBloonsPopped.value / AchievementsConfig.HARD_BAKED_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.HARD_BAKED,_loc8_);
         var _loc9_:Number = 100 * (_statsData.camoBloonsPopped.value / AchievementsConfig.INFRARED_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.INFRARED,_loc9_);
         var _loc10_:Number = 100 * (_statsData.totalBloonsPopped.value / AchievementsConfig.IMPOPPABLE_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.IMPOPPABLE,_loc10_);
      }
   }
}
