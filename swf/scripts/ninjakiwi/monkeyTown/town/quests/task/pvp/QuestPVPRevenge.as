package ninjakiwi.monkeyTown.town.quests.task.pvp
{
   import flash.utils.getTimer;
   import ninjakiwi.monkeyTown.pvp.PvPSignals;
   import ninjakiwi.monkeyTown.town.quests.task.Quest;
   import ninjakiwi.monkeyTown.town.quests.task.QuestPVP;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   
   public class QuestPVPRevenge extends QuestPVP
   {
       
      
      public function QuestPVPRevenge()
      {
         super();
         PvPSignals.defendAttackComplete.addOnce(this.onDefendAttackComplete);
         AchieveSignal(PvPSignals.revengeAttackLaunched);
      }
      
      override protected function onReset() : void
      {
         super.onReset();
         PvPSignals.defendAttackComplete.remove(this.onDefendAttackComplete);
         PvPSignals.defendAttackComplete.addOnce(this.onDefendAttackComplete);
      }
      
      private function onDefendAttackComplete(... rest) : void
      {
         ExtraCondition(EXTRA_NONE);
         Quest.NEED_TO_REFRESH_LIST_SIGNAL.dispatch(this);
      }
   }
}
