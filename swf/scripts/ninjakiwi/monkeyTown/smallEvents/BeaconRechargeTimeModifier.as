package ninjakiwi.monkeyTown.smallEvents
{
   public class BeaconRechargeTimeModifier extends ModifierBase
   {
       
      
      public function BeaconRechargeTimeModifier()
      {
         super();
      }
      
      override public function get typeID() : String
      {
         return "beaconRechargeTimeModifier";
      }
   }
}
