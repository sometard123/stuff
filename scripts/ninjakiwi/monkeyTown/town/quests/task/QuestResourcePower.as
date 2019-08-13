package ninjakiwi.monkeyTown.town.quests.task
{
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   
   public class QuestResourcePower extends Quest
   {
       
      
      private var _targetPower:int;
      
      public function QuestResourcePower(param1:int)
      {
         super();
         this._targetPower = param1;
         symbolFrame = 11;
      }
      
      override public function activate() : void
      {
         super.activate();
         GameSignals.BUILDING_UPGRADE_COMPLETE.add(this.checkAchieveConditions);
         Building.buildingWasCompletedSignal.add(this.checkAchieveConditions);
      }
      
      override public function checkPreAchieved() : Boolean
      {
         if(ResourceStore.getInstance().totalPower >= this._targetPower)
         {
            return true;
         }
         return super.checkPreAchieved();
      }
      
      override public function deactivate() : void
      {
         super.deactivate();
         GameSignals.BUILDING_UPGRADE_COMPLETE.remove(this.checkAchieveConditions);
         Building.buildingWasCompletedSignal.remove(this.checkAchieveConditions);
      }
      
      override protected function checkAchieveConditions(... rest) : void
      {
         if(ResourceStore.getInstance().totalPower >= this._targetPower)
         {
            GameSignals.BUILDING_UPGRADE_COMPLETE.remove(this.checkAchieveConditions);
            Building.buildingWasCompletedSignal.remove(this.checkAchieveConditions);
            achieved();
         }
      }
   }
}
