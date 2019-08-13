package ninjakiwi.monkeyTown.sku
{
   import com.codecatalyst.promise.Promise;
   import flash.events.Event;
   import flash.external.ExternalInterface;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import ninjakiwi.data.DGData;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.smallEvents.bloonstoneSpendEvent.BloonstoneSpendMilestone;
   import ninjakiwi.monkeyTown.smallEvents.bloonstoneSpendEvent.BloonstoneSpendMilestoneDef;
   import ninjakiwi.monkeyTown.utils.DeepMixin;
   import org.osflash.signals.Signal;
   
   public class SkuSettingsLoader
   {
      
      private static var _hasLoadedSKU:Boolean = false;
      
      private static var _skuData:Object = null;
      
      private static var _queuedMethods:Array = [];
      
      public static const skuSettingsLoadedSignal:Signal = new Signal();
       
      
      public function SkuSettingsLoader()
      {
         super();
      }
      
      public static function loadSettings() : void
      {
         var urlLoader:URLLoader = null;
         var request:URLRequest = null;
         urlLoader = new URLLoader();
         var onLoaded:Function = function(param1:Event):void
         {
            var stuffObject:Object = null;
            var e:Event = param1;
            var bytes:ByteArray = urlLoader.data;
            var stuff:String = DGData.decrypt(bytes);
            try
            {
               stuffObject = JSON.parse(stuff);
               _skuData = JSON.parse(stuffObject.data);
            }
            catch(e:Error)
            {
            }
            _hasLoadedSKU = true;
            skuSettingsLoadedSignal.dispatch();
            processQueuedItems();
         };
         urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
         urlLoader.addEventListener(Event.COMPLETE,onLoaded);
         request = new URLRequest(Constants.SKU_URL);
         urlLoader.load(request);
      }
      
      private static function processQueuedItems() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < _queuedMethods.length)
         {
            _queuedMethods[_loc1_].execute();
            _loc1_++;
         }
         _queuedMethods.length = 0;
      }
      
      public static function get hasLoadedSKU() : Boolean
      {
         return _hasLoadedSKU;
      }
      
      public static function getActiveGameEvents(param1:Function) : void
      {
         if(!_hasLoadedSKU)
         {
            _queuedMethods.push(new QueuedItem(getGameEvents,[param1]));
            return;
         }
         param1(_skuData.settings.events);
      }
      
      public static function getGameEvents(param1:Function) : void
      {
         if(!_hasLoadedSKU)
         {
            _queuedMethods.push(new QueuedItem(getGameEvents,[param1]));
            return;
         }
         param1(_skuData.settings.events);
      }
      
      public static function getGameEventsByType(param1:String, param2:Function) : void
      {
         if(!_hasLoadedSKU)
         {
            _queuedMethods.push(new QueuedItem(getGameEventsByType,[param1,param2]));
            return;
         }
         var _loc3_:Array = _skuData.settings.events;
         var _loc4_:Array = [];
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_.length)
         {
            if(_loc3_[_loc5_].type == param1)
            {
               _loc4_.push(_loc3_[_loc5_]);
            }
            _loc5_++;
         }
         param2(_loc4_);
      }
      
      public static function getGameEventDataByType(param1:String, param2:Function) : void
      {
         if(!_hasLoadedSKU)
         {
            _queuedMethods.push(new QueuedItem(getGameEventDataByType,[param1,param2]));
            return;
         }
         param2(_skuData.settings.gameEvents[param1]);
      }
      
      public static function getGameEventDataByID(param1:String, param2:String, param3:Function) : void
      {
         if(!_hasLoadedSKU)
         {
            _queuedMethods.push(new QueuedItem(getGameEventDataByID,[param1,param2,param3]));
            return;
         }
         if(false == _skuData.settings.gameEvents.hasOwnProperty(param1))
         {
            param3(null);
         }
         param3(_skuData.settings.gameEvents[param1][param2]);
      }
      
      public static function findGameEventDataByID(param1:String, param2:String) : Object
      {
         if(!_hasLoadedSKU || false == _skuData.settings.gameEvents.hasOwnProperty(param1))
         {
            return null;
         }
         return _skuData.settings.gameEvents[param1][param2];
      }
      
      public static function getPromoData(param1:Function) : void
      {
         if(!_hasLoadedSKU)
         {
            _queuedMethods.push(new QueuedItem(getPromoData,[param1]));
            return;
         }
         param1(_skuData.settings.promos);
      }
      
      private static function getDefaultEventMetaData() : Object
      {
         return {
            "newsImage":null,
            "priority":1,
            "onClick":null
         };
      }
      
      public static function getMetaDataForEvent(param1:String, param2:String) : Object
      {
         if(!_hasLoadedSKU)
         {
            return null;
         }
         if(false === _skuData.settings.gameEvents.hasOwnProperty(param1))
         {
            return null;
         }
         var _loc3_:Object = getDefaultEventMetaData();
         var _loc4_:Object = _skuData.settings.gameEvents[param1];
         if(_loc4_.hasOwnProperty("meta"))
         {
            DeepMixin.mix(_loc3_,_loc4_.meta);
         }
         if(_loc4_.hasOwnProperty(param2) && _loc4_[param2].hasOwnProperty("meta"))
         {
            DeepMixin.mix(_loc3_,_loc4_[param2].meta);
         }
         _loc3_.newsImage = expandImageURL(_loc3_.newsImage);
         return _loc3_;
      }
      
      public static function expandImageURL(param1:String) : String
      {
         if(param1 === null)
         {
            return null;
         }
         if(param1.substr(0,4) === "http")
         {
            return param1;
         }
         return _skuData.settings.config.imageBase + param1;
      }
      
      public static function getNewsItems() : Array
      {
         return _skuData.settings.newsItems;
      }
   }
}

class QueuedItem
{
    
   
   public var callMethod:Function;
   
   public var args:Array = null;
   
   function QueuedItem(param1:Function, param2:Array = null)
   {
      super();
      this.callMethod = param1;
      this.args = param2;
   }
   
   public function execute() : void
   {
      if(this.args !== null)
      {
         this.callMethod.apply(null,this.args);
      }
      else
      {
         this.callMethod();
      }
   }
}
