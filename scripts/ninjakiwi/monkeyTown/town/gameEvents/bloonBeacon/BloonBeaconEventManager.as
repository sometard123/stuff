package ninjakiwi.monkeyTown.town.gameEvents.bloonBeacon
{
   import assets.ui.DebugDataEntryWindowClip;
   import flash.display.DisplayObjectContainer;
   import flash.geom.Point;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledge;
   import ninjakiwi.monkeyTown.pvp.PvPSignals;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventSubManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.MonkeyKnowledgePack;
   import ninjakiwi.monkeyTown.utils.DeepMixin;
   
   public class BloonBeaconEventManager extends GameEventSubManager
   {
      
      public static const UNLOCK_LEVEL:int = 12;
       
      
      private var _persistentData:Object = null;
      
      public function BloonBeaconEventManager()
      {
         super();
      }
      
      override public function get typeID() : String
      {
         return "bloonBeacon";
      }
      
      override public function setPersistentData(param1:Object) : void
      {
         if(param1 == null)
         {
            param1 = {};
         }
         param1 = DeepMixin.mix(this.getDefaultData(),param1);
         this._persistentData = param1;
      }
      
      override public function getPersistentData() : Object
      {
         return this._persistentData;
      }
      
      override public function findCurrentEvent() : GameplayEvent
      {
         var _loc1_:GameplayEvent = new GameplayEvent({
            "type":"bloonBeacon",
            "start":0,
            "end":MonkeySystem.getInstance().getSecureTime() * 2,
            "id":"defaultData",
            "requiredLevel":UNLOCK_LEVEL,
            "metadata":{
               "active":true,
               "dataID":"bloonBeacon_data"
            }
         });
         return _loc1_;
      }
      
      public function get beaconPosition() : Point
      {
         var _loc1_:Object = this.getDataForCurrentCity();
         if(_loc1_.beaconPosition == null)
         {
            return null;
         }
         var _loc2_:Point = new Point(_loc1_.beaconPosition.x,_loc1_.beaconPosition.y);
         return _loc2_;
      }
      
      public function set beaconPosition(param1:Point) : void
      {
         var _loc2_:Object = this.getDataForCurrentCity();
         if(param1 == null)
         {
            _loc2_.beaconPosition = null;
         }
         else
         {
            _loc2_.beaconPosition = {
               "x":param1.x,
               "y":param1.y
            };
         }
         save();
      }
      
      public function get beaconIsActive() : Boolean
      {
         var _loc1_:Object = this.getDataForCurrentCity();
         return _loc1_.isActive;
      }
      
      public function set beaconIsActive(param1:Boolean) : void
      {
         var _loc2_:Object = this.getDataForCurrentCity();
         _loc2_.isActive = param1;
         save();
      }
      
      public function get beaconLastCaptureTime() : Number
      {
         var _loc1_:Object = this.getDataForCurrentCity();
         return _loc1_.beaconLastCaptureTime;
      }
      
      public function set beaconLastCaptureTime(param1:Number) : void
      {
         var _loc2_:Object = this.getDataForCurrentCity();
         _loc2_.beaconLastCaptureTime = param1;
         save();
      }
      
      private function getDefaultData() : Object
      {
         var _loc1_:Object = {"perCityData":[]};
         var _loc2_:int = 0;
         while(_loc2_ < Constants.NUMBER_OF_CITIES)
         {
            _loc1_.perCityData[_loc2_] = this.getDefaultPerCityData();
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function getDefaultPerCityData() : Object
      {
         return {
            "isActive":false,
            "beaconLastCaptureTime":-1,
            "beaconPosition":null
         };
      }
      
      private function getDataForCurrentCity() : Object
      {
         var _loc1_:int = MonkeySystem.getInstance().city.cityIndex;
         return this._persistentData.perCityData[_loc1_];
      }
   }
}
