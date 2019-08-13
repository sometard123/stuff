package ninjakiwi.monkeyTown.town.quests.task
{
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.buildings.customClasses.UpgradeableBuilding;
   import ninjakiwi.monkeyTown.utils.ErrorReporter;
   
   public class QuestUpgradeBuilding extends Quest
   {
       
      
      private var _upgradeBuildingIDs:Vector.<String> = null;
      
      private var _tier:int = 1;
      
      public function QuestUpgradeBuilding(param1:Vector.<String> = null, param2:int = 1)
      {
         super();
         this._upgradeBuildingIDs = param1;
         this._tier = param2;
         symbolFrame = 2;
         AchieveSignal(GameSignals.BUILDING_UPGRADE_COMPLETE);
      }
      
      override public function checkPreAchieved() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:Vector.<Building> = null;
         var _loc3_:int = 0;
         if(this._upgradeBuildingIDs != null)
         {
            _loc1_ = 0;
            while(_loc1_ < this._upgradeBuildingIDs.length)
            {
               _loc2_ = MonkeySystem.getInstance().city.buildingManager.getCompletedBuilding(this._upgradeBuildingIDs[_loc1_]);
               _loc3_ = 0;
               while(_loc3_ < _loc2_.length)
               {
                  if(this._upgradeBuildingIDs[_loc1_] == (_loc2_[_loc3_] as UpgradeableBuilding).definition.id && (_loc2_[_loc3_] as UpgradeableBuilding).tier > this._tier)
                  {
                     return true;
                  }
                  _loc3_++;
               }
               _loc1_++;
            }
         }
         return super.checkPreAchieved();
      }
      
      override protected function checkAchieveConditions(... rest) : void
      {
         var _loc2_:UpgradeableBuilding = null;
         var _loc3_:int = 0;
         if(rest != null && rest.length > 0 && rest[0] != null)
         {
            _loc2_ = rest[0] as UpgradeableBuilding;
         }
         if(_loc2_ == null)
         {
            ErrorReporter.error("QuestUpgradeBuilding::checkAchieveConditions - building cannot be null");
         }
         if(this._upgradeBuildingIDs != null)
         {
            _loc3_ = 0;
            while(_loc3_ < this._upgradeBuildingIDs.length)
            {
               if(this._upgradeBuildingIDs[_loc3_] == _loc2_.definition.id && _loc2_.tier > this._tier)
               {
                  achieved();
                  break;
               }
               _loc3_++;
            }
         }
      }
   }
}
