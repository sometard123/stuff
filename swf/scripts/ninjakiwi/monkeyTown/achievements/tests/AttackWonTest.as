package ninjakiwi.monkeyTown.achievements.tests
{
   import ninjakiwi.monkeyTown.achievements.AchievementsConfig;
   import ninjakiwi.monkeyTown.pvp.PvPSignals;
   
   public class AttackWonTest extends AchievementTest
   {
       
      
      public function AttackWonTest()
      {
         super();
         PvPSignals.attackWon.addWithPriority(this.onPvPAttackWon,LISTENER_PRIORITY);
      }
      
      private function onPvPAttackWon() : void
      {
         var _loc1_:int = _statsData.quickMatchOffensiveWinChain.value;
         var _loc2_:Number = 100 * (_loc1_ / AchievementsConfig.ATTACK_RUN_CHAIN);
         _achievementsManager.setAchievementProgress(_achievementsManager.ATTACK_RUN,_loc2_);
      }
   }
}
