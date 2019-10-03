package ninjakiwi.monkeyTown.town.buildings.customClasses
{
   import ninjakiwi.monkeyTown.town.buildings.saveDefinitions.BuildingSaveDefinition;
   import ninjakiwi.monkeyTown.town.buildings.saveDefinitions.UpgradeableBuildingSaveDefinition;
   import ninjakiwi.monkeyTown.town.city.City;
   import ninjakiwi.monkeyTown.town.data.definitions.MonkeyTownBuildingDefinition;
   import ninjakiwi.monkeyTown.town.ui.clock.ClockSaveDefinition;
   
   public class UpgradeableResourceGeneratingBuilding extends UpgradeableBuilding
   {
       
      
      public function UpgradeableResourceGeneratingBuilding(param1:MonkeyTownBuildingDefinition, param2:City = null)
      {
         super(param1,param2);
      }
      
      override public function populateFromSaveDefinition(param1:BuildingSaveDefinition) : void
      {
         var _loc3_:UpgradeableBuildingSaveDefinition = null;
         var _loc4_:ClockSaveDefinition = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         super.populateFromSaveDefinition(param1);
         var _loc2_:Number = _system.getSecureTime();
         if(!(param1 is UpgradeableBuildingSaveDefinition))
         {
            return;
         }
         _loc3_ = UpgradeableBuildingSaveDefinition(param1);
         tier = _loc3_.tier;
         if(_loc3_.upgradeClockSaveDefinition != null)
         {
            _loc4_ = _loc3_.upgradeClockSaveDefinition;
            _loc5_ = _loc4_.timeOfLastUpdate - _loc4_.timeElapsed;
            _loc6_ = _loc2_ - _loc5_;
            _loc7_ = getTimeToUpgrade() * 60000;
            if(_loc6_ > _loc7_)
            {
               _loc8_ = _loc5_ + _loc7_;
               this.catchUpToTime(_loc8_);
            }
            createUpgradeClock(_loc3_.upgradeClockSaveDefinition);
         }
         this.catchUpToTime(_loc2_);
      }
      
      public function catchUpToTime(param1:Number) : void
      {
      }
      
      override protected function recreateUpgradeClockFromSaveDefinition(param1:UpgradeableBuildingSaveDefinition) : void
      {
      }
   }
}
