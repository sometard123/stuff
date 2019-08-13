package ninjakiwi.monkeyTown.smallEvents
{
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class BloontoniumRateModifier extends ModifierBase
   {
       
      
      public function BloontoniumRateModifier()
      {
         super();
      }
      
      override public function get typeID() : String
      {
         return "bloontoniumRateModifier";
      }
   }
}
