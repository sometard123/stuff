package ninjakiwi.monkeyTown.town.gameEvents.awarders
{
   import ninjakiwi.monkeyTown.data.ResourceStore;
   
   public class BloonstonesAwarder extends Awarder
   {
       
      
      public function BloonstonesAwarder(param1:Number)
      {
         super(param1);
      }
      
      override public function award() : void
      {
         ResourceStore.getInstance().bloonstones = ResourceStore.getInstance().bloonstones + _quantity.value;
      }
   }
}
