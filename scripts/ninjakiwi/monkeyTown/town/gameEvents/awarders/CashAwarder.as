package ninjakiwi.monkeyTown.town.gameEvents.awarders
{
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.ui.MapBottomUI;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   
   public class CashAwarder extends Awarder
   {
       
      
      public function CashAwarder(param1:Number)
      {
         super(param1);
      }
      
      override public function award() : void
      {
         ResourceStore.getInstance().monkeyMoney = ResourceStore.getInstance().monkeyMoney + _quantity.value;
      }
   }
}
