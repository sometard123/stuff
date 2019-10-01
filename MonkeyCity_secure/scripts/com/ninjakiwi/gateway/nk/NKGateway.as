package com.ninjakiwi.gateway.nk
{
   import com.codecatalyst.promise.Deferred;
   import com.codecatalyst.promise.Promise;
   import com.ninjakiwi.gateway.login.LoginInfo;
   import com.ninjakiwi.gateway.net.Api;
   import com.ninjakiwi.gateway.net.RemoteApiLoader;
   import flash.display.DisplayObject;
   import org.osflash.signals.Signal;
   
   public class NKGateway
   {
      
      public static const VERSION:String = "2.3.0";
      
      public static const container:NKBarContainer = new NKBarContainer();
      
      private static const loadResult:Deferred = new Deferred();
      
      private static var loader:RemoteApiLoader;
       
      
      public const checkedForExistingUserSignal:Signal = new Signal(Boolean);
      
      public const newUserStartedLoadingSignal:Signal = new Signal(LoginInfo);
      
      public const newUserFinishedLoadingSignal:Signal = new Signal(NKGatewayUser);
      
      private var _api:Api;
      
      public function NKGateway(param1:DisplayObject)
      {
         var nkBarSwf:DisplayObject = param1;
         super();
         this._api = new Api(nkBarSwf);
         this._api.call("checkedForExistingUserSignal.add",function checkedForExistingUser(param1:Boolean):void
         {
            checkedForExistingUserSignal.dispatch(param1);
         });
         with({})
         {
            
            newUserStartedLoading = function(param1:Object):void
            {
               newUserStartedLoadingSignal.dispatch(LoginInfo.importFromAnotherApplicationDomain(param1));
            };
         }
         this._api.call("newUserStartedLoadingSignal.add",function(param1:Object):void
         {
            newUserStartedLoadingSignal.dispatch(LoginInfo.importFromAnotherApplicationDomain(param1));
         });
         this._api.call("newUserFinishedLoadingSignal.add",function newUserArrived(param1:Object):void
         {
            newUserFinishedLoadingSignal.dispatch(new NKGatewayUser(param1));
         });
      }
      
      public static function load(param1:String, param2:Object = null, param3:Object = null) : Promise
      {
         var _loc8_:* = null;
         trace("NK Gateway v" + VERSION);
         param2 = !!param2?param2:{};
         param3 = !!param3?param3:{};
         var _loc4_:String = !!param2.barUrl?param2.barUrl:"http://ninjakiwi.com/nklogin/nkBar.swf";
         var _loc5_:String = !!param2.policyUrl?param2.policyUrl:"http://ninjakiwi.com/nklogin/crossdomain.xml";
         var _loc6_:Boolean = param2.cacheBust || param2.cachebust;
         var _loc7_:Object = {"gamename":param1};
         if(_loc6_)
         {
            _loc7_.cachebust = int(Math.random() * 10000).toString();
         }
         for(_loc8_ in param3)
         {
            _loc7_[_loc8_] = param3[_loc8_];
         }
         loader = new RemoteApiLoader(_loc4_,_loc7_,_loc5_);
         actuallyLoad();
         return loadResult.promise;
      }
      
      private static function actuallyLoad() : void
      {
         container.showStatus("loading");
         loader.load().then(function barLoaded(param1:DisplayObject):void
         {
            container.showStatus("none");
            container.addChild(param1);
            loadResult.resolve(new NKGateway(param1));
         },function barLoadFailed(param1:Object):void
         {
            container.showStatus("failed");
            container.retrySignal.addOnce(actuallyLoad);
            container.showErrorMessage("Couldn\'t connect to Ninja Kiwi (" + inspectError(param1) + ")");
         });
      }
      
      private static function inspectError(param1:Object) : String
      {
         var result:String = null;
         var stack:String = null;
         var firstLineEnd:int = 0;
         var secondLineEnd:int = 0;
         var firstLine:String = null;
         var secondLine:String = null;
         var codeStart:int = 0;
         var codeEnd:int = 0;
         var code:String = null;
         var funcNameStart:int = 0;
         var funcNameEnd:int = 0;
         var funcName:String = null;
         var lineNumStart:int = 0;
         var lineNumEnd:int = 0;
         var lineNum:String = null;
         var error:Object = param1;
         if(error is Error)
         {
            try
            {
               stack = (error as Error).getStackTrace();
               firstLineEnd = stack.indexOf("\n");
               secondLineEnd = stack.indexOf("\n",firstLineEnd + 1);
               firstLine = stack.substring(0,firstLineEnd);
               secondLine = stack.substring(firstLineEnd + 1,secondLineEnd);
               codeStart = firstLine.indexOf("#");
               codeEnd = firstLine.indexOf(":",codeStart);
               code = firstLine.substring(codeStart,codeEnd);
               funcNameStart = secondLine.indexOf("/") + 1;
               funcNameEnd = secondLine.indexOf(")",funcNameStart) + 1;
               funcName = secondLine.substring(funcNameStart,funcNameEnd);
               result = code + ", " + funcName;
               if(secondLine.charAt(funcNameEnd) == "[")
               {
                  lineNumStart = secondLine.lastIndexOf(":") + 1;
                  lineNumEnd = secondLine.indexOf("]",lineNumStart);
                  lineNum = secondLine.substring(lineNumStart,lineNumEnd);
                  result = result + (":" + lineNum);
               }
            }
            catch(err:Error)
            {
               result = (error as Error).name;
            }
         }
         else if("errorID" in error)
         {
            result = error.errorID;
         }
         else if("message" in error)
         {
            result = error.message;
         }
         else if("code" in error)
         {
            result = error.code;
         }
         else
         {
            result = error.toString();
         }
         return result;
      }
      
      public function get api() : Api
      {
         return this._api;
      }
      
      public function loginAsAlternateUser(param1:String, param2:String, param3:String, param4:String) : Promise
      {
         return Promise.when(this._api.call("loginAsAlternateUser",param1,param2,param3,param4));
      }
      
      public function forceLogOut() : void
      {
         Promise.when(this._api.call("forceLogOut"));
      }
      
      public function getServerTime() : Promise
      {
         return Promise.when(this._api.call("remoteGetServerTime"));
      }
      
      public function getVersion() : Promise
      {
         return Promise.when(this._api.call("getVersion"));
      }
      
      public function setUI(param1:String, param2:Object) : void
      {
         this._api.call("setUI",param1,param2);
      }
   }
}
