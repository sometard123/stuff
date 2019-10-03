package ninjakiwi.monkeyTown.userServices.kong
{
   import com.codecatalyst.promise.Promise;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.errors.IOError;
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.system.Security;
   import flash.utils.getTimer;
   import ninjakiwi.monkeyTown.signals.LoginSignals;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import org.osflash.signals.Signal;
   
   public class Kong
   {
      
      private static var kongregate = null;
      
      private static const _system:MonkeySystem = MonkeySystem.getInstance();
      
      private static var gameID:String = "222987";
      
      private static var apiKey:String = "8728d962-dac3-4b5e-8f22-3a7eee671aff";
      
      private static var currentUser:String = null;
      
      private static var container:DisplayObjectContainer = null;
      
      public static const userChangedSignal:Signal = new Signal();
      
      private static var timeOfLastPoll:Number = 0;
       
      
      public function Kong()
      {
         super();
      }
      
      public static function initialise(param1:DisplayObjectContainer) : void
      {
         Kong.container = param1;
         var _loc2_:Object = LoaderInfo(param1.root.loaderInfo).parameters;
         var _loc3_:String = _loc2_.kongregate_api_path || "https://www.kongregate.com/flash/API_AS3_Local.swf";
         Security.allowInsecureDomain(_loc3_);
         t.obj(_loc2_);
         var _loc4_:URLRequest = new URLRequest(_loc3_);
         var _loc5_:Loader = new Loader();
         _loc5_.contentLoaderInfo.addEventListener(Event.COMPLETE,onKongregateAPILoaded);
         _loc5_.load(_loc4_);
         param1.addChild(_loc5_);
         submitStat("initialized",1);
      }
      
      private static function onKongregateAPILoaded(param1:Event) : void
      {
         kongregate = param1.target.content;
         kongServices.connect();
         matchNKBarLoginToKongLogin();
         startPollingForUserChange();
         userChangedSignal.add(matchNKBarLoginToKongLogin);
      }
      
      private static function get kongServices() : Object
      {
         return kongregate.services;
      }
      
      public static function matchNKBarLoginToKongLogin() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(!isGuest())
         {
            _loc1_ = getKongUsername();
            _loc2_ = getKongUserId();
            _loc3_ = getKongGameAuthToken();
            _system.nkGateway.loginAsAlternateUser("kong",_loc1_,_loc2_,_loc3_);
         }
         else
         {
            _system.nkGateway.forceLogOut();
            showSignInBox();
            LoginSignals.showLoginPrompt.dispatch();
         }
      }
      
      public static function getKongUsername() : String
      {
         return kongServices.getUsername();
      }
      
      public static function getKongUserId() : String
      {
         if(isGuest())
         {
            return null;
         }
         return kongServices.getUserId();
      }
      
      public static function getKongGameAuthToken() : String
      {
         if(isGuest())
         {
            return null;
         }
         return kongServices.getGameAuthToken();
      }
      
      public static function isGuest() : Boolean
      {
         if(kongregate == null)
         {
            return false;
         }
         return kongregate.services.isGuest();
      }
      
      public static function submitStat(param1:String, param2:int) : void
      {
         kongregate.stats.submit(param1,param2);
      }
      
      public static function purchaseItem(param1:int, param2:Function) : void
      {
         kongregate.mtx.purchaseItems([param1.toString()],param2);
      }
      
      public static function requestUserItemList(param1:Function) : void
      {
         kongregate.mtx.requestUserItemList(kongServices.getUsername(),param1);
      }
      
      public static function useItem(param1:Number, param2:Function) : void
      {
         var urlLoader:URLLoader = null;
         var itemInstanceID:Number = param1;
         var callback:Function = param2;
         var params:URLVariables = new URLVariables();
         params.api_key = apiKey;
         var gameAuthToken:String = kongServices.getGameAuthToken();
         params.game_auth_token = gameAuthToken;
         var userId:String = kongServices.getUserId();
         params.user_id = userId;
         params.id = itemInstanceID;
         var req:URLRequest = new URLRequest("https://api.kongregate.com/api/use_item.json");
         req.data = params;
         req.method = URLRequestMethod.POST;
         urlLoader = new URLLoader();
         urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
         urlLoader.addEventListener(Event.COMPLETE,function urlLoader_complete(param1:Event):void
         {
            var _loc2_:String = urlLoader.data;
            callback(JSON.parse(_loc2_));
         });
         urlLoader.load(req);
      }
      
      private static function swfIOErrorHandler(param1:IOError) : void
      {
      }
      
      private static function swfSecurityErrorHandler(param1:SecurityError) : void
      {
      }
      
      public static function startPollingForUserChange() : void
      {
         currentUser = getKongUserId();
         container.addEventListener(Event.ENTER_FRAME,pollForUserChange);
      }
      
      public static function isOnKong() : Boolean
      {
         var _loc1_:Object = MonkeySystem.getInstance().flashStage.root.loaderInfo.parameters;
         return _loc1_.userServices == "kong";
      }
      
      public static function showSignInBox() : void
      {
         kongregate.services.showSignInBox();
      }
      
      public static function getInventory(param1:Function) : void
      {
         kongregate.mtx.requestUserItemList(null,param1);
      }
      
      public static function purchaseItems(param1:Array, param2:Function) : void
      {
         kongregate.mtx.purchaseItems(param1,param2);
      }
      
      public static function loadFriends(param1:Function) : void
      {
         new UserDataLoader(param1);
      }
      
      public static function inviteUser(param1:String = null) : void
      {
         kongregate.services.showInvitationBox({
            "content":"Join me in Bloons Monkey City!",
            "filter":param1 || "not_played"
         });
      }
      
      private static function pollForUserChange(param1:Event) : void
      {
         if(getTimer() - timeOfLastPoll < 1000)
         {
            return;
         }
         var _loc2_:String = getKongUserId();
         if(_loc2_ != currentUser)
         {
            currentUser = _loc2_;
            userChangedSignal.dispatch();
         }
         timeOfLastPoll = getTimer();
      }
   }
}
