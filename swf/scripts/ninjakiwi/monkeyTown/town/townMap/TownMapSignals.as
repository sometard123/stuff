package ninjakiwi.monkeyTown.town.townMap
{
   import org.osflash.signals.Signal;
   
   public class TownMapSignals
   {
       
      
      public const populateFromSaveDefinitionComplete:Signal = new Signal();
      
      public const buildProgress:Signal = new Signal(Number);
      
      public const beginBuildingFromSaveDefinition:Signal = new Signal();
      
      public const territoryFlagsSet:Signal = new Signal();
      
      public const recaculateFog:Signal = new Signal();
      
      public function TownMapSignals()
      {
         super();
      }
   }
}
