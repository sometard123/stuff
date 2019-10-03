package ninjakiwi.monkeyTown.town.buildings.saveDefinitions
{
   import ninjakiwi.monkeyTown.town.ui.clock.ClockSaveDefinition;
   
   public class UpgradeableBuildingSaveDefinition extends BuildingSaveDefinition
   {
       
      
      public var tier:int = 1;
      
      public var upgradeClockSaveDefinition:ClockSaveDefinition = null;
      
      public function UpgradeableBuildingSaveDefinition()
      {
         super();
      }
   }
}
