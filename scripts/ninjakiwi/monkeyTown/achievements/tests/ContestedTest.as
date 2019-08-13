package ninjakiwi.monkeyTown.achievements.tests
{
   import ninjakiwi.monkeyTown.achievements.AchievementsConfig;
   import ninjakiwi.monkeyTown.town.ui.contestedTerritory.ContestedTerritoryPanel;
   
   public class ContestedTest extends AchievementTest
   {
       
      
      public function ContestedTest()
      {
         super();
         ContestedTerritoryPanel.endContestSignal.add(this.testContestEnd);
         ContestedTerritoryPanel.winSignal.add(this.testContestWon);
      }
      
      private function testContestEnd(... rest) : void
      {
         var _loc2_:Number = 100 * (_statsData.contestedTerritoriesParticipated.value / AchievementsConfig.CONTESTANT_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.CONTESTANT,_loc2_);
      }
      
      private function testContestWon(... rest) : void
      {
         var _loc2_:Number = 100 * (_statsData.contestedTerritoriesWon.value / AchievementsConfig.VICTOR_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.VICTOR,_loc2_);
         var _loc3_:Number = 100 * (_statsData.contestedTerritoriesWon.value / AchievementsConfig.TERRITORY_BOSS_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.TERRITORY_BOSS,_loc3_);
         var _loc4_:Number = 100 * (_statsData.contestedTerritoriesWon.value / AchievementsConfig.TERRITORY_CONQUEROR_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.TERRITORY_CONQUEROR,_loc4_);
         var _loc5_:Number = 100 * (_statsData.contestedTerritoriesWon.value / AchievementsConfig.TERRITORY_KING_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.TERRITORY_KING,_loc5_);
      }
   }
}
