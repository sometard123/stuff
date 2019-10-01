package ninjakiwi.monkeyTown.town.gameEvents.awarders
{
   import ninjakiwi.monkeyTown.data.ResourceStore;
   
   public class BossBlastAwarder extends Awarder
   {
       
      
      public function BossBlastAwarder(param1:Number)
      {
         super(param1);
      }
      
      override public function award() : void
      {
         ResourceStore.getInstance().bossBlasts = ResourceStore.getInstance().bossBlasts + _quantity.value;
      }
   }
}
