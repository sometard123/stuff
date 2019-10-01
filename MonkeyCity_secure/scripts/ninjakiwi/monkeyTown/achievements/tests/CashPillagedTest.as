package ninjakiwi.monkeyTown.achievements.tests
{
   import ninjakiwi.monkeyTown.achievements.AchievementsConfig;
   import ninjakiwi.monkeyTown.pvp.PvPSignals;
   
   public class CashPillagedTest extends AchievementTest
   {
       
      
      public function CashPillagedTest()
      {
         super();
         PvPSignals.attackRewards.addWithPriority(this.test,LISTENER_PRIORITY);
      }
      
      public function test(param1:Object) : void
      {
         var _loc2_:int = _statsData.totalCashPillaged.value;
         var _loc3_:Number = 100 * (_loc2_ / AchievementsConfig.GIMME_THAT_CASH_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.GIMME_THAT,_loc3_);
         var _loc4_:Number = 100 * (_loc2_ / AchievementsConfig.EXTORTIONIST_CASH_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.EXTORTIONIST,_loc4_);
      }
   }
}
