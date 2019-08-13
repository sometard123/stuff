package ninjakiwi.monkeyTown.town.quests.task.building
{
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.town.quests.task.QuestBuilding;
   
   public class QuestBuildingPower extends QuestBuilding
   {
       
      
      private var _targetPower:int = 0;
      
      public function QuestBuildingPower(param1:int)
      {
         super();
         this._targetPower = param1;
      }
      
      override public function checkPreAchieved() : Boolean
      {
         if(ResourceStore.getInstance().totalPower >= this._targetPower)
         {
            return true;
         }
         return super.checkPreAchieved();
      }
      
      override protected function checkAchieveConditions(... rest) : void
      {
         if(ResourceStore.getInstance().totalPower >= this._targetPower)
         {
            achieved();
         }
      }
   }
}
