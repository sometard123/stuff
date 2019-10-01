package ninjakiwi.monkeyTown.town.quests.task
{
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   
   public class QuestBuilding extends Quest
   {
       
      
      private var _buildingID:String = null;
      
      private var _buildingCount:int = 1;
      
      protected var _system:MonkeySystem;
      
      public function QuestBuilding(param1:String = null, param2:int = 1)
      {
         this._system = MonkeySystem.getInstance();
         super();
         this._buildingID = param1;
         this._buildingCount = param2;
         symbolFrame = 1;
         AchieveSignal(Building.buildingWasCompletedSignal);
      }
      
      override public function checkPreAchieved() : Boolean
      {
         if(this._system.city.buildingManager.getCompletedBuildingCount(this._buildingID).complete >= this._buildingCount)
         {
            return true;
         }
         return super.checkPreAchieved();
      }
      
      override protected function checkAchieveConditions(... rest) : void
      {
         if(rest != null && rest.length > 0 && rest[0] != null)
         {
            if(this._buildingID == null || Building(rest[0]).definition.id == this._buildingID && this._system.city.buildingManager.getCompletedBuildingCount(this._buildingID).complete >= this._buildingCount)
            {
               achieved();
            }
         }
      }
   }
}
