package ninjakiwi.monkeyTown.town.quests.task
{
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.buildings.BuildingManager;
   
   public class QuestTotalMonkeys extends Quest
   {
       
      
      protected var _targetTotalMonkeysCount:int;
      
      public function QuestTotalMonkeys(param1:int)
      {
         super();
         this._targetTotalMonkeysCount = param1;
      }
      
      override public function checkPreAchieved() : Boolean
      {
         var _loc1_:BuildingManager = MonkeySystem.getInstance().city.buildingManager;
         var _loc2_:int = _loc1_.getCompletedBaseBuildingCount();
         return _loc2_ >= this._targetTotalMonkeysCount;
      }
      
      override protected function checkAchieveConditions(... rest) : void
      {
         var _loc2_:BuildingManager = MonkeySystem.getInstance().city.buildingManager;
         var _loc3_:int = _loc2_.getCompletedBaseBuildingCount();
         if(_loc3_ >= this._targetTotalMonkeysCount)
         {
            super.checkAchieveConditions();
         }
      }
   }
}
