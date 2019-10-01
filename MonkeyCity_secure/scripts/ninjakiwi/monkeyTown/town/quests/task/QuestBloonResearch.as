package ninjakiwi.monkeyTown.town.quests.task
{
   import ninjakiwi.monkeyTown.town.upgrades.UpgradeSignals;
   import ninjakiwi.monkeyTown.ui.bloonResearchLab.BloonResearchLabState;
   
   public class QuestBloonResearch extends Quest
   {
       
      
      private var _researchID:String;
      
      public function QuestBloonResearch(param1:String)
      {
         super();
         this._researchID = param1;
         symbolFrame = 10;
         AchieveSignal(UpgradeSignals.bloonResearchLabUpgradeComplete);
      }
      
      override public function checkPreAchieved() : Boolean
      {
         if(BloonResearchLabState.hasUpgrade(this._researchID))
         {
            return true;
         }
         return super.checkPreAchieved();
      }
      
      override protected function checkAchieveConditions(... rest) : void
      {
         if(BloonResearchLabState.hasUpgrade(this._researchID))
         {
            achieved();
         }
      }
   }
}
