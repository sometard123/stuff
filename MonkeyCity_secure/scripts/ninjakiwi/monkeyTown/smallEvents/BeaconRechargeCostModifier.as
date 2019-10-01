package ninjakiwi.monkeyTown.smallEvents
{
   public class BeaconRechargeCostModifier extends ModifierBase
   {
       
      
      public function BeaconRechargeCostModifier()
      {
         super();
      }
      
      override public function get typeID() : String
      {
         return "beaconRechargeCostModifier";
      }
   }
}
