package ninjakiwi.utils
{
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.events.ContextMenuEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.system.System;
   import flash.ui.ContextMenu;
   import flash.ui.ContextMenuItem;
   import flash.utils.ByteArray;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.sku.SkuSettingsLoader;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.save.Base64;
   import ninjakiwi.utils.version.DateStamp;
   
   public class StandardStuff
   {
      
      private static var _ed:EventDispatcher = new EventDispatcher();
      
      private static var _onSplashEnd:Function;
      
      private static var _kode:StandardKode;
      
      private static var _kodeTarget:DisplayObjectContainer;
      
      private static var _kodeWidth:Number;
      
      private static var _kodeDomain:ApplicationDomain;
      
      private static var _kodeLoader:Loader;
      
      private static const KodeKodeData:Class = StandardStuff_KodeKodeData;
      
      private static const _kodeKode:String = new KodeKodeData();
      
      private static var queuedUpdateFuncs:Array = [];
      
      private static var queuedClickFuncs:Array = [];
       
      
      public function StandardStuff()
      {
         super();
      }
      
      public static function showSplash(param1:DisplayObjectContainer, param2:Function, param3:Number = 0) : void
      {
         if(param1 == null)
         {
            throw new UninitializedError("don\'t give this null shit!",666);
         }
         _onSplashEnd = param2;
         _ed.addEventListener(Event.INIT,splash);
         getKode(param1,param3);
      }
      
      public static function setContextMenu(param1:DisplayObjectContainer = null) : ContextMenu
      {
         var forObject:DisplayObjectContainer = param1;
         var myMenu:ContextMenu = new ContextMenu();
         var ourgame:ContextMenuItem = new ContextMenuItem(Settings.GAME_NAME + " by Ninja Kiwi");
         var copyrightNotice:ContextMenuItem = new ContextMenuItem("© " + Settings.PUBLISH_YEAR + " Kaiparasoft Ltd");
         var version:ContextMenuItem = new ContextMenuItem("Build: " + Constants.BUILD_DATE,true);
         var help:ContextMenuItem = new ContextMenuItem("(click to copy)");
         help.enabled = false;
         version.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,function(param1:ContextMenuEvent):void
         {
            try
            {
               System.setClipboard(DateStamp.getDateStamp());
               return;
            }
            catch(e:Error)
            {
               return;
            }
         });
         myMenu.hideBuiltInItems();
         myMenu.customItems.push(ourgame,copyrightNotice,version,help);
         if(forObject != null)
         {
            forObject.contextMenu = myMenu;
         }
         return myMenu;
      }
      
      public static function setUpdate(param1:Function, param2:Boolean = true) : void
      {
         var update:Function = param1;
         var add:Boolean = param2;
         if(_kode != null)
         {
            _kode.setUpdate(update,add);
         }
         else
         {
            queuedUpdateFuncs.push(function():void
            {
               _kode.setUpdate(update,add);
            });
         }
      }
      
      public static function setClick(param1:EventDispatcher, param2:Function, param3:Boolean = true) : void
      {
         var symbol:EventDispatcher = param1;
         var onClick:Function = param2;
         var add:Boolean = param3;
         if(_kode != null)
         {
            _kode.setClick(symbol,onClick,add);
         }
         else
         {
            queuedClickFuncs.push(function():void
            {
               _kode.setClick(symbol,onClick,add);
            });
         }
      }
      
      private static function splash(param1:Event) : void
      {
         _ed.removeEventListener(Event.INIT,splash);
         _kode.addEventListener(Event.COMPLETE,splashed);
         if(Settings.SHOW_SPLASH)
         {
            _kode.showSplash();
         }
         else
         {
            _kode.dispatchEvent(new Event(Event.COMPLETE));
         }
      }
      
      private static function splashed(param1:Event) : void
      {
         _kode.removeEventListener(Event.COMPLETE,splashed);
         if(_onSplashEnd != null)
         {
            _onSplashEnd();
         }
      }
      
      private static function getKode(param1:DisplayObjectContainer, param2:Number = 0) : void
      {
         var _loc3_:ByteArray = null;
         var _loc4_:LoaderContext = null;
         if(_kode != null && _kodeTarget == param1)
         {
            _ed.dispatchEvent(new Event(Event.INIT));
         }
         else
         {
            _kodeTarget = param1;
            _kodeTarget.root.addEventListener("allComplete",interceptEvilEvent);
            _kodeWidth = param2;
            _loc3_ = Base64.decodeToByteArray(_kodeKode);
            _loc3_.uncompress();
            _kodeDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
            _kodeLoader = new Loader();
            _kodeLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,kodeLoaded);
            _kodeLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,kodeNotLoaded);
            _loc4_ = new LoaderContext(false,_kodeDomain);
            _kodeLoader.loadBytes(_loc3_,_loc4_);
         }
      }
      
      private static function kodeLoaded(param1:Event) : void
      {
         var _loc3_:Function = null;
         var _loc2_:Class = _kodeDomain.getDefinition("ninjakiwi.utils.NinjaKode") as Class;
         if(_kodeWidth > 0)
         {
            _kode = new _loc2_(_kodeTarget,_kodeWidth);
         }
         else
         {
            _kode = new _loc2_(_kodeTarget);
         }
         for each(_loc3_ in queuedUpdateFuncs.concat(queuedClickFuncs))
         {
            _loc3_();
         }
         _ed.dispatchEvent(new Event(Event.INIT));
      }
      
      private static function kodeNotLoaded(param1:IOErrorEvent) : void
      {
         throw param1;
      }
      
      private static function interceptEvilEvent(param1:Event) : void
      {
      }
      
      public static function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         _ed.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public static function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         _ed.removeEventListener(param1,param2,param3);
      }
      
      public static function gotoNinjaKiwi(param1:Event = null) : void
      {
         var _loc2_:URLRequest = new URLRequest("https://www.ninjakiwi.com/");
         navigateToURL(_loc2_,"_blank");
      }
   }
}
