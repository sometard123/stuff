package ninjakiwi.monkeyTown.achievements.tests
{
   import ninjakiwi.monkeyTown.achievements.AchievementsManager;
   import ninjakiwi.monkeyTown.analytics.StatsData;
   
   public class AchievementTest
   {
      
      public static const LISTENER_PRIORITY:int = 9999;
       
      
      protected var _achievementsManager:AchievementsManager = null;
      
      protected var _statsData:StatsData;
      
      public function AchievementTest()
      {
         super();
         this._achievementsManager = AchievementsManager.getInstance();
         this._statsData = StatsData.getInstance();
      }
   }
}
