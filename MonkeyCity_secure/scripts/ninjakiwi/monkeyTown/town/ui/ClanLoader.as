package ninjakiwi.monkeyTown.town.ui
{
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.ui.UIConstants;
   
   public class ClanLoader extends Sprite
   {
      
      private static const _userCache:Object = {};
      
      private static const _clanCache:Object = {};
       
      
      private var _userID:String = null;
      
      private var _urlreq:URLRequest;
      
      private var _loader:URLLoader;
      
      private var _clanLoader:Loader;
      
      public function ClanLoader(param1:String)
      {
         super();
         this._userID = param1;
         this.loadClanName(param1);
      }
      
      private function removeListeners() : void
      {
         if(this._loader != null)
         {
            if(this._loader.hasEventListener(Event.COMPLETE))
            {
               this._loader.addEventListener(Event.COMPLETE,this.onLoadURL);
            }
         }
      }
      
      public function loadClanName(param1:String) : void
      {
         this._userID = param1;
         if(_userCache.hasOwnProperty(param1))
         {
            this.assignClanImage(_userCache[param1]);
            return;
         }
         this._urlreq = new URLRequest(Constants.USER_INFORMATION_PATH_SERVICE + param1);
         this._urlreq.method = URLRequestMethod.GET;
         this._loader = new URLLoader(this._urlreq);
         this._loader.dataFormat = URLLoaderDataFormat.TEXT;
         this._loader.addEventListener(IOErrorEvent.IO_ERROR,this.onIOError,false,0,true);
         this._loader.addEventListener(Event.COMPLETE,this.onLoadURL,false,0,true);
         this._loader.load(this._urlreq);
      }
      
      private function onIOError(param1:IOErrorEvent) : void
      {
         this.removeListeners();
      }
      
      private function onLoadURL(param1:Event) : void
      {
         var data:Object = null;
         var e:Event = param1;
         try
         {
            data = JSON.parse(this._loader.data);
         }
         catch(e:Error)
         {
            removeListeners();
            assignClanImage("kong");
            return;
         }
         if(data === null || !data.clan_name)
         {
            this.assignClanImage("kong");
            this.removeListeners();
            return;
         }
         _userCache[this._userID] = data.clan_name;
         this.assignClanImage(data.clan_name);
      }
      
      public function assignClanImage(param1:String) : void
      {
         this.addChild(UIConstants.getClanIconSmall(param1));
      }
      
      public function clear() : void
      {
         this.removeListeners();
         if(this.contains(this._clanLoader))
         {
            this.removeChild(this._clanLoader);
         }
         this._urlreq = null;
         this._loader = null;
         this._clanLoader = null;
      }
   }
}
