package ninjakiwi.monkeyTown.town.gameEvents.awarders
{
   import ninjakiwi.monkeyTown.data.ResourceStore;
   
   public class RedHotSpikesAwarder extends Awarder
   {
       
      
      public function RedHotSpikesAwarder(param1:Number)
      {
         super(param1);
      }
      
      override public function award() : void
      {
         ResourceStore.getInstance().redHotSpikes = ResourceStore.getInstance().redHotSpikes + _quantity.value;
      }
   }
}
