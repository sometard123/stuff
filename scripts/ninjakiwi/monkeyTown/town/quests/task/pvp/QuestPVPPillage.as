package ninjakiwi.monkeyTown.town.quests.task.pvp
{
   import ninjakiwi.monkeyTown.pvp.PvPSignals;
   import ninjakiwi.monkeyTown.sku.SkuSettingsLoader;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.quests.QuestCounter;
   import ninjakiwi.monkeyTown.town.quests.task.QuestPVP;
   
   public class QuestPVPPillage extends QuestPVP
   {
       
      
      private var _targetCash:int = 0;
      
      public function QuestPVPPillage(param1:int)
      {
         super();
         this._targetCash = param1;
         symbolFrame = 7;
         AchieveSignal(PvPSignals.attackRewards);
      }
      
      override public function checkPreAchieved() : Boolean
      {
         if(int(QuestCounter.getInstance().getCustomValue(QuestCounter.KEY_MVM_PILLAGED_CASH)) >= this._targetCash)
         {
            return true;
         }
         return super.checkPreAchieved();
      }
      
      override protected function checkAchieveConditions(... rest) : void
      {
         if(rest != null && rest.length > 0 && rest[0] != null)
         {
            if(int(QuestCounter.getInstance().getCustomValue(QuestCounter.KEY_MVM_PILLAGED_CASH)) >= this._targetCash)
            {
               achieved();
            }
         }
      }
   }
}
