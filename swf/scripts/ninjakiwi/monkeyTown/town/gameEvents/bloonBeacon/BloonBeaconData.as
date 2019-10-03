package ninjakiwi.monkeyTown.town.gameEvents.bloonBeacon
{
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.pvp.PvPClientAutoSender;
   import ninjakiwi.monkeyTown.sku.SkuSettingsLoader;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import org.osflash.signals.Signal;
   
   public class BloonBeaconData
   {
       
      
      public const readySignal:Signal = new Signal();
      
      private var _data:Object = null;
      
      public function BloonBeaconData()
      {
         super();
         SkuSettingsLoader.getGameEventDataByType("monkeyBeacon",this.onSKUSettingsLoaded);
      }
      
      private function onSKUSettingsLoaded(param1:Object) : void
      {
         this._data = param1;
         this.readySignal.dispatch();
      }
      
      public function getDataSet(param1:String) : Object
      {
         if(this._data.hasOwnProperty(param1))
         {
            return this._data[param1];
         }
         return null;
      }
   }
}
