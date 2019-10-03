package ninjakiwi.monkeyTown.town.ui
{
   import assets.icons.BasicDartMonkeyAvatar;
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.system.LoaderContext;
   import ninjakiwi.monkeyTown.common.Constants;
   
   public class AvatarLoader extends Sprite
   {
      
      private static const _userCache:Object = {};
      
      private static const _avatarCache:Object = {};
       
      
      private var _url:String = null;
      
      private var _userID:String = null;
      
      private var _urlreq:URLRequest;
      
      private var _loader:URLLoader;
      
      private var _avatarLoader:Loader;
      
      private var _imageURLRequest:URLRequest;
      
      public function AvatarLoader(param1:String = null)
      {
         super();
         if(param1 === null)
         {
            return;
         }
         this._userID = param1;
         this.loadAvatar(param1);
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
         if(this._avatarLoader != null && this._avatarLoader.contentLoaderInfo != null)
         {
            if(this._avatarLoader.contentLoaderInfo.hasEventListener(SecurityErrorEvent.SECURITY_ERROR))
            {
               this._avatarLoader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.securityErrorHandler);
            }
         }
         if(this._avatarLoader != null && this._avatarLoader.contentLoaderInfo != null)
         {
            if(this._avatarLoader.contentLoaderInfo.hasEventListener(Event.COMPLETE))
            {
               this._avatarLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onLoadAvatar);
            }
         }
      }
      
      public function loadAvatar(param1:String) : void
      {
         this._userID = param1;
         if(_userCache.hasOwnProperty(param1))
         {
            this.loadAvatarGraphic(_userCache[param1]);
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
            addChild(new BasicDartMonkeyAvatar());
            return;
         }
         if(data === null || !data.avatar)
         {
            this.removeListeners();
            addChild(new BasicDartMonkeyAvatar());
            return;
         }
         this._url = data.avatar;
         this._url = this._url.replace("mega","small");
         this.loadAvatarGraphic(this._url);
      }
      
      private function loadAvatarGraphic(param1:String) : void
      {
         var _loc2_:Bitmap = null;
         var _loc3_:Bitmap = null;
         _userCache[this._userID] = param1;
         if(_avatarCache.hasOwnProperty(param1))
         {
            _loc2_ = _avatarCache[param1];
            _loc3_ = new Bitmap(_loc2_.bitmapData);
            addChild(_loc3_);
         }
         else
         {
            this._avatarLoader = new Loader();
            this._imageURLRequest = new URLRequest(param1);
            this._avatarLoader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.securityErrorHandler);
            this._avatarLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoadAvatar);
            this._avatarLoader.load(this._imageURLRequest,new LoaderContext(true));
            addChild(this._avatarLoader);
         }
      }
      
      private function onLoadAvatar(param1:Event) : void
      {
         this.removeListeners();
         _avatarCache[this._url] = this._avatarLoader.content;
         Bitmap(this._avatarLoader.content).smoothing = true;
      }
      
      private function securityErrorHandler(param1:SecurityErrorEvent) : void
      {
         t.obj(param1);
         this.removeListeners();
      }
      
      public function clear() : void
      {
         this.removeListeners();
         if(this.contains(this._avatarLoader))
         {
            this.removeChild(this._avatarLoader);
         }
         this._urlreq = null;
         this._loader = null;
         this._avatarLoader = null;
         this._imageURLRequest = null;
      }
   }
}
