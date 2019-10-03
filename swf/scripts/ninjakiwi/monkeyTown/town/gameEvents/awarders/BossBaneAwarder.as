package ninjakiwi.monkeyTown.town.gameEvents.awarders
{
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.EventsMenuButton;
   
   public class BossBaneAwarder extends Awarder
   {
       
      
      public function BossBaneAwarder(param1:Number)
      {
         super(param1);
      }
      
      override public function award() : void
      {
         ResourceStore.getInstance().bossBanes = ResourceStore.getInstance().bossBanes + _quantity.value;
      }
   }
}
