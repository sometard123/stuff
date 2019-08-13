package ninjakiwi.monkeyTown.town.gameEvents.awarders
{
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.pvp.PvPClient;
   
   public class MonkeyBoostAwarder extends Awarder
   {
       
      
      public function MonkeyBoostAwarder(param1:Number)
      {
         super(param1);
      }
      
      override public function award() : void
      {
         ResourceStore.getInstance().monkeyBoosts = ResourceStore.getInstance().monkeyBoosts + _quantity.value;
      }
   }
}
