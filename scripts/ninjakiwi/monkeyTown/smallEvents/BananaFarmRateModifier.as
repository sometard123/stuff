package ninjakiwi.monkeyTown.smallEvents
{
   import assets.ui.CTMilestonesIconClip;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   
   public class BananaFarmRateModifier extends ModifierBase
   {
       
      
      public function BananaFarmRateModifier()
      {
         super();
      }
      
      override public function get typeID() : String
      {
         return "bananaFarmRateModifier";
      }
   }
}
