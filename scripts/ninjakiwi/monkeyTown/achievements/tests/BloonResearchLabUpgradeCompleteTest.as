package ninjakiwi.monkeyTown.achievements.tests
{
   import ninjakiwi.monkeyTown.town.data.BloonResearchLabUpgrades;
   import ninjakiwi.monkeyTown.town.upgrades.UpgradeSignals;
   import ninjakiwi.monkeyTown.ui.bloonResearchLab.BloonResearchLabState;
   
   public class BloonResearchLabUpgradeCompleteTest extends AchievementTest
   {
       
      
      public function BloonResearchLabUpgradeCompleteTest()
      {
         super();
         UpgradeSignals.bloonResearchLabUpgradeComplete.addWithPriority(this.test,LISTENER_PRIORITY);
      }
      
      private function test() : void
      {
         var _loc1_:Number = 100 * (BloonResearchLabState.currentTier / BloonResearchLabState.TOTAL_TIERS);
         _achievementsManager.setAchievementProgress(_achievementsManager.BLOON_SCIENCE,_loc1_);
         var _loc2_:Boolean = BloonResearchLabState.hasUpgrade(BloonResearchLabUpgrades.DDTS.id);
         if(_loc2_)
         {
            _achievementsManager.setAchievementProgress(_achievementsManager.DARK_DIRIGIBLE_TITAN,101);
         }
      }
   }
}
