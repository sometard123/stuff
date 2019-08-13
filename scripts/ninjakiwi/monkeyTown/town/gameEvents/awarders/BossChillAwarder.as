package ninjakiwi.monkeyTown.town.gameEvents.awarders
{
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.utils.setTimeout;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.data.GameMods;
   
   public class BossChillAwarder extends Awarder
   {
       
      
      public function BossChillAwarder(param1:Number)
      {
         super(param1);
      }
      
      override public function award() : void
      {
         ResourceStore.getInstance().bossChills = ResourceStore.getInstance().bossChills + _quantity.value;
      }
   }
}
