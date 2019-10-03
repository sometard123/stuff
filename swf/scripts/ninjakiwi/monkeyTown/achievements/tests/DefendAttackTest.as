package ninjakiwi.monkeyTown.achievements.tests
{
   import ninjakiwi.monkeyTown.achievements.AchievementsConfig;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.GameResultDefinition;
   import ninjakiwi.monkeyTown.data.KeyValueStore;
   import ninjakiwi.monkeyTown.pvp.PvPSignals;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   
   public class DefendAttackTest extends AchievementTest
   {
       
      
      public function DefendAttackTest()
      {
         super();
         PvPSignals.defendAttackComplete.addWithPriority(this.test,LISTENER_PRIORITY);
      }
      
      private function test(... rest) : void
      {
         var otherCityIndex:int = 0;
         var arguments:Array = rest;
         var gameResult:GameResultDefinition = arguments[0];
         if(!gameResult.success)
         {
            return;
         }
         if(0 == MonkeySystem.getInstance().city.cityIndex)
         {
            otherCityIndex = 1;
         }
         else if(1 == MonkeySystem.getInstance().city.cityIndex)
         {
            otherCityIndex = 0;
         }
         var keyValueStoreString:String = "totalMvMDefensiveWinsCity" + otherCityIndex.toString();
         KeyValueStore.getInstance().get(keyValueStoreString,function(param1:int):void
         {
            var _loc2_:int = param1 + _statsData.totalMvMDefensiveWins.value;
            var _loc3_:Number = 100 * (_loc2_ / AchievementsConfig.GUARDIAN_DEFENSIVE_WINS_THRESHOLD);
            _achievementsManager.setAchievementProgress(_achievementsManager.GUARDIAN,_loc3_);
            var _loc4_:Number = 100 * (_loc2_ / AchievementsConfig.EPIC_DEFENDER_DEFENSIVE_WINS_THRESHOLD);
            _achievementsManager.setAchievementProgress(_achievementsManager.EPIC_DEFENDER,_loc4_);
         });
         var youShallNotPassProgress:Number = 100 * (_statsData.quickMatchDefensiveWinChain.value / AchievementsConfig.YOU_SHALL_NOT_PASS_DEFENSIVE_WINS_CHAIN);
         _achievementsManager.setAchievementProgress(_achievementsManager.YOU_SHALL_NOT_PASS,youShallNotPassProgress);
         var defenderProgress:Number = 100 * (_statsData.quickMatchDefensiveWinChain.value / AchievementsConfig.DEFENDER_DEFENSIVE_WINS_CHAIN);
         _achievementsManager.setAchievementProgress(_achievementsManager.DEFENDER,defenderProgress);
      }
   }
}
