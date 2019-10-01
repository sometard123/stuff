package ninjakiwi.monkeyTown.town.data
{
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.utils.setTimeout;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.sound.MCSound;
   import org.osflash.signals.Signal;
   
   public class GameMods
   {
      
      private static var _data:Object = null;
      
      private static var _message:String = "";
      
      private static var _title:String = "";
      
      private static var _modifiers:Object = null;
      
      private static var _retryAttemptsLeft:int = 3;
      
      public static const broadcastBonusMessageSignal:Signal = new Signal(String,String);
      
      public static const dataIsReadySignal:Signal = new Signal();
       
      
      public function GameMods()
      {
         super();
      }
      
      public static function init() : void
      {
         loadData();
         GameModConstants.requestHasModifierSignal.add(onRequestHasModifierSignal);
      }
      
      public static function loadData() : void
      {
         if(false == Constants.ENABLE_GAME_MODIFIERS)
         {
            return;
         }
         var _loc1_:URLLoader = new URLLoader();
         _loc1_.addEventListener(Event.COMPLETE,onDataLoaded);
         _loc1_.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
         _loc1_.dataFormat = URLLoaderDataFormat.TEXT;
         var _loc2_:URLRequest = new URLRequest();
         _loc2_.url = Constants.MODIFIER_DATA_URL;
         _loc2_.contentType = "application/json";
         _loc1_.load(_loc2_);
         _retryAttemptsLeft--;
      }
      
      private static function onDataLoaded(param1:Event) : void
      {
         var e:Event = param1;
         _data = JSON.parse(e.currentTarget.data);
         _title = _data.title;
         _message = _data.message;
         _modifiers = _data.modifiers;
         if(_message !== "")
         {
            setTimeout(function():void
            {
               broadcastBonusMessageSignal.dispatch(_title,_message);
            },1000);
         }
         if(Constants.ENABLE_GAME_MODIFIERS)
         {
            GameModConstants.dataIsReadySignal.dispatch();
         }
      }
      
      private static function onIOError(param1:IOErrorEvent) : void
      {
         param1.currentTarget.removeEventListener(IOErrorEvent.IO_ERROR,onIOError);
         if(_retryAttemptsLeft > 0)
         {
            loadData();
         }
      }
      
      public static function getModifier(param1:String) : Number
      {
         if(Constants.ENABLE_GAME_MODIFIERS)
         {
            if(_modifiers !== null && _modifiers.hasOwnProperty(param1) && _modifiers[param1] is Number)
            {
               return _modifiers[param1];
            }
         }
         return 1;
      }
      
      public static function hasModifier(param1:String) : Boolean
      {
         if(_modifiers !== null && _modifiers.hasOwnProperty(param1) && _modifiers[param1] is Number)
         {
            return _modifiers[param1] > 1;
         }
         return false;
      }
      
      private static function onRequestHasModifierSignal(param1:String, param2:Function) : void
      {
         param2(hasModifier(param1));
      }
      
      public static function awardCash(param1:Number) : Number
      {
         param1 = param1 * getModifier(GameModConstants.CASH_EARNED_MOD);
         ResourceStore.getInstance().monkeyMoney = ResourceStore.getInstance().monkeyMoney + param1;
         return param1;
      }
      
      public static function awardBloonstones(param1:Number) : Number
      {
         param1 = param1 * getModifier(GameModConstants.BLOONSTONES_EARN_MOD);
         ResourceStore.getInstance().bloonstones = ResourceStore.getInstance().bloonstones + param1;
         return param1;
      }
      
      public static function awardXP(param1:Number) : Number
      {
         param1 = param1 * getModifier(GameModConstants.XP_EARN_MOD);
         ResourceStore.getInstance().xp = ResourceStore.getInstance().xp + param1;
         MCSound.getInstance().playDelayedSound(MCSound.EARN_XP,0.5);
         return param1;
      }
      
      public static function awardBloontonium(param1:Number) : Number
      {
         param1 = param1 * getModifier(GameModConstants.BLOONTONIUM_EARN_MOD);
         ResourceStore.getInstance().bloontonium = ResourceStore.getInstance().bloontonium + param1;
         return param1;
      }
   }
}
