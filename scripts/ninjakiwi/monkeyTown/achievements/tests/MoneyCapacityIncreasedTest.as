package ninjakiwi.monkeyTown.achievements.tests
{
   import ninjakiwi.monkeyTown.achievements.AchievementsConfig;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.town.city.ActiveCitySignals;
   
   public class MoneyCapacityIncreasedTest extends AchievementTest
   {
       
      
      public function MoneyCapacityIncreasedTest()
      {
         super();
         ActiveCitySignals.bankCapacityChangedSignal.addWithPriority(this.test,LISTENER_PRIORITY);
      }
      
      private function test() : void
      {
         var _loc1_:Number = ResourceStore.getInstance().bankCapacity;
         var _loc2_:Number = 100 * (_loc1_ / AchievementsConfig.BLING_WORTHY_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.BLING_WORTHY,_loc2_);
         var _loc3_:Number = 100 * (_loc1_ / AchievementsConfig.PHAT_STAX_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.PHAT_STAX,_loc3_);
      }
   }
}
