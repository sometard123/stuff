package ninjakiwi.monkeyTown.achievements.tests
{
   import ninjakiwi.monkeyTown.achievements.AchievementsConfig;
   import ninjakiwi.monkeyTown.pvp.PvPSignals;
   
   public class RevengeAttackLaunchedTest extends AchievementTest
   {
       
      
      public function RevengeAttackLaunchedTest()
      {
         super();
         PvPSignals.revengeAttackLaunched.addWithPriority(this.test,LISTENER_PRIORITY);
      }
      
      public function test() : void
      {
         var _loc1_:int = _statsData.totalMvMRevengeAttacks.value;
         var _loc2_:Number = 100 * (_loc1_ / AchievementsConfig.SWEET_REVENGE_ATTACKS_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.SWEET_REVENGE,_loc2_);
         var _loc3_:Number = 100 * (_loc1_ / AchievementsConfig.BEST_SERVED_COLD_ATTACKS_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.BEST_SERVED_COLD,_loc3_);
      }
   }
}
