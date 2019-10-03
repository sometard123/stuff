package ninjakiwi.net
{
   import com.adobe.crypto.MD5;
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestHeader;
   import flash.net.URLRequestMethod;
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.Main;
   import ninjakiwi.monkeyTown.analytics.AnalyticsUtil;
   import ninjakiwi.monkeyTown.analytics.ErrorMessageTracking;
   import ninjakiwi.monkeyTown.btd.definitions.TileAttackDefinition;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.gameEvents.ui.GenericEventPopupPanel;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.quests.QuestCounter;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.BossIsHidingCustomButtons;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   import ninjakiwi.monkeyTown.utils.ErrorReporter;
   import org.osflash.signals.Signal;
   
   public class JSONRequest extends RequestBase
   {
      
      public static const FAILED:String = "failed";
      
      public static const UNAUTHORISED:String = "unauthorised";
      
      public static const SERVER_ERROR:String = "serverError";
      
      public static const STATUS_SHUT_DOWN:String = "shutdown";
      
      public static const STATUS_OK:String = "ok";
      
      public static const ERROR_UNAUTHORISED:String = "bmc_unauthorised";
      
      public static const ERROR_VERSION:String = "bmc_version";
      
      public static const ERROR_GAME:String = "bmc_game";
      
      public static const SHOW_USAGE:Boolean = false;
      
      public static var TIMEOUT_SECONDS:Number = 60;
      
      public static const BYTES_TOTAL:Object = {};
      
      public static var RECORD_REQUESTS:Boolean = false;
      
      public static const RECORDED_REQUESTS:Array = [];
      
      public static var VERBOSE_ANALYTICS_REPORTING:Boolean = true;
      
      public static var logRequests:Boolean = false;
      
      public static var lastTIDForError:Number = -1;
      
      private static var UNIQUE_ID_COUNTER:uint = 0;
      
      public static const canForceRetrySignal:Signal = new Signal();
       
      
      private var _loader:URLLoader;
      
      private var _request:URLRequest;
      
      private var _callback:Function = null;
      
      private var _hasBeenUsed:Boolean = false;
      
      private var _hasResolved:Boolean = false;
      
      private var _timeoutID:uint = 0;
      
      private var _recordData:Object;
      
      private var _requestData:Object = null;
      
      private var _sequentialID:uint = 0;
      
      public function JSONRequest(param1:String, param2:Object = null, param3:Function = null, param4:String = null, param5:String = null, param6:String = null)
      {
         this._loader = new URLLoader();
         this._request = new URLRequest();
         super();
         var _loc7_:* = param2 != null;
         param2 = param2 || {};
         this._requestData = param2;
         this._callback = param3;
         this._request.method = param4 || URLRequestMethod.POST;
         this._loader.dataFormat = param5 || URLLoaderDataFormat.TEXT;
         this._request.url = param1;
         this._request.contentType = param6 || "application/json";
         var _loc8_:String = com.maccherone.json.JSON.encode(param2);
         this._request.data = _loc8_;
         if(_loc7_)
         {
            this._request.requestHeaders.push(new URLRequestHeader("sig",MD5.hash(_loc8_ + Constants.UNICORN)));
         }
         BYTES_TOTAL[param1] = int(BYTES_TOTAL[param1]);
         BYTES_TOTAL["_total"] = int(BYTES_TOTAL["_total"]);
         if(this._request.data && this._request.data.hasOwnProperty("length"))
         {
            BYTES_TOTAL[param1] = BYTES_TOTAL[param1] + this._request.data.length;
            BYTES_TOTAL["_total"] = BYTES_TOTAL["_total"] + this._request.data.length;
         }
         if(SHOW_USAGE)
         {
            t.obj(BYTES_TOTAL);
         }
         UNIQUE_ID_COUNTER = Number(UNIQUE_ID_COUNTER) + 1;
         this._sequentialID = Number(UNIQUE_ID_COUNTER);
         if(JSONRequest.logRequests)
         {
            this.logData({
               "url":param1,
               "data":param2
            });
         }
      }
      
      private function logData(param1:Object) : void
      {
         var _loc2_:Boolean = t.DoNotTrace;
         t.DoNotTrace = true;
         var _loc3_:String = t.obj(param1);
         ErrorReporter.externalLog(_loc3_);
         t.DoNotTrace = _loc2_;
      }
      
      override public function cancel() : void
      {
         super.cancel();
         this._loader = null;
         this._request = null;
         this._callback = null;
         this._recordData = null;
         this._hasResolved = true;
      }
      
      public function get url() : String
      {
         return this._request.url;
      }
      
      public function get data() : String
      {
         return String(this._request.data);
      }
      
      public function set method(param1:String) : void
      {
         this._request.method = param1;
      }
      
      public function get sequentialID() : uint
      {
         return this._sequentialID;
      }
      
      override public function setRetry() : void
      {
         this._hasBeenUsed = false;
         this._hasResolved = false;
      }
      
      override public function go() : void
      {
         if(this._hasBeenUsed)
         {
            throw new Error("JSONRequests are single use only!");
         }
         this._hasBeenUsed = true;
         this.addHandlers(this._loader);
         this._loader.load(this._request);
         this.beginTimeout();
      }
      
      private function beginTimeout() : void
      {
         this.cancelTimeout();
         this._timeoutID = setTimeout(this.onTimeout,TIMEOUT_SECONDS * 1000);
      }
      
      private function cancelTimeout() : void
      {
         clearTimeout(this._timeoutID);
      }
      
      private function onTimeout() : void
      {
         ErrorReporter.externalLog("JSONRequest::onTimeout()");
         this.handleFail("TimeoutError","The request timed out. No progress for " + TIMEOUT_SECONDS + " seconds.");
      }
      
      private function markAsResolved() : Boolean
      {
         var _loc1_:Boolean = this._hasResolved;
         this._hasResolved = true;
         this.cancelTimeout();
         return _loc1_;
      }
      
      private function handleFail(param1:*, param2:String) : void
      {
         if(this.markAsResolved())
         {
            return;
         }
         ErrorReporter.externalLog("JSONFAIL: " + this._request.url + ", " + param1 + ", " + param2);
         this.removeHandlers(this._loader);
         var _loc3_:Object = {
            "error":param1,
            "message":param2
         };
         this.dispatchEvent(new Event(FAILED));
      }
      
      private function requestCompleteHandler(param1:Event) : void
      {
         this.end();
      }
      
      override public function end(param1:Object = null) : void
      {
         var response:Object = null;
         var information:Object = null;
         var informationJSON:String = null;
         var serverError:Event = null;
         var forceRetry:Boolean = false;
         var requestResponse:Object = param1;
         if(this.markAsResolved())
         {
            return;
         }
         this.removeHandlers(this._loader);
         if(requestResponse === null)
         {
            try
            {
               response = com.maccherone.json.JSON.decode(this._loader.data);
            }
            catch(e:Error)
            {
               response = {
                  "error":"invalid JSON",
                  "responseString":_loader.data
               };
            }
         }
         else
         {
            response = requestResponse;
         }
         if(JSONRequest.logRequests)
         {
            try
            {
               ErrorReporter.externalLog("Log Response");
               this.logData(response);
            }
            catch(e:Error)
            {
            }
         }
         var isInShutdown:Boolean = false;
         if(response.hasOwnProperty("status"))
         {
            if(response.status === STATUS_SHUT_DOWN)
            {
               isInShutdown = true;
               this.dispatchEvent(new Event(STATUS_SHUT_DOWN));
            }
            else if(response.status === STATUS_OK)
            {
               this.dispatchEvent(new Event(STATUS_OK));
            }
         }
         var hasError:Boolean = response.hasOwnProperty("error");
         if(hasError && isInShutdown === false)
         {
            ErrorReporter.externalLog("JSONRequest, error -",response.error,"-",response.reason," for url: ",this.url);
            information = {
               "url":this.url,
               "time":new Date().toDateString(),
               "reason":response.reason,
               "request":{},
               "response":response
            };
            if(this._requestData !== null && this._requestData.hasOwnProperty("action") && this._requestData.action === "PUT")
            {
               information.request.sid = this._requestData.sid;
               information.request.tid = this._requestData.tid;
            }
            if(VERBOSE_ANALYTICS_REPORTING)
            {
               if(this._requestData !== null && this._requestData.hasOwnProperty("payload"))
               {
                  information.request.payload = this._requestData.payload;
               }
            }
            informationJSON = com.maccherone.json.JSON.encode(information,false).substr(0,150);
            this._requestData = null;
            this.trackError(response);
            if(response.error === ERROR_UNAUTHORISED)
            {
               AnalyticsUtil.track("error_" + ERROR_UNAUTHORISED,informationJSON);
               this.dispatchEvent(new Event(UNAUTHORISED));
               return;
            }
            if(response.error === ERROR_VERSION)
            {
               AnalyticsUtil.track("error_" + ERROR_VERSION);
               ErrorReporter.externalLog("Server responded with error_bmc_version");
               Main.instance.returnToHomeScreenAndRequireRefresh();
               return;
            }
            if(response.error === ERROR_GAME)
            {
               AnalyticsUtil.track("error_" + ERROR_GAME,response.reason,-1,informationJSON);
            }
            else
            {
               AnalyticsUtil.track("error_catchall",response.error,-1,informationJSON);
               serverError = new Event(SERVER_ERROR);
               forceRetry = this.canForceRetry(information);
               if(forceRetry)
               {
                  canForceRetrySignal.dispatch();
               }
               this.dispatchEvent(serverError);
               return;
            }
         }
         var callbackError:Error = null;
         if(this._callback !== null && this._callback is Function)
         {
            try
            {
               this._callback(response);
            }
            catch(e:Error)
            {
               callbackError = e;
            }
            this._callback = null;
         }
         var url:String = this._request.url;
         BYTES_TOTAL[url] = int(BYTES_TOTAL[url]) + this._loader.data.length;
         BYTES_TOTAL["_total"] = int(BYTES_TOTAL["_total"]) + this._loader.data.length;
         if(SHOW_USAGE)
         {
            t.obj(BYTES_TOTAL);
         }
         this.dispatchEvent(new Event(Event.COMPLETE));
      }
      
      private function canForceRetry(param1:Object) : Boolean
      {
         if(false == param1.request.hasOwnProperty("tid"))
         {
            return false;
         }
         var _loc2_:* = lastTIDForError != param1.request.tid;
         if(_loc2_)
         {
            lastTIDForError = param1.request.tid;
         }
         if(param1.response.bmc_code != "error" || param1.response.bmc_errno != 4 || param1.response.reason != "Un-resolved cache conflict for key some key" || param1.response.error != "bmc_tech")
         {
            _loc2_ = false;
         }
         return _loc2_;
      }
      
      private function trackError(param1:Object) : void
      {
         ErrorReporter.externalLog("JSONREQUEST: ERRROR -",param1.error);
         ErrorMessageTracking.errorTrackingSignal.dispatch(ErrorMessageTracking.ERROR_SERVER_ERROR_CODE,ErrorMessageTracking.ERROR_SERVER_ERROR_HEADING,new String(param1.error + " - " + param1.reason).substr(0,150));
      }
      
      private function addHandlers(param1:URLLoader) : void
      {
         param1.addEventListener(Event.COMPLETE,this.requestCompleteHandler);
         param1.addEventListener(HTTPStatusEvent.HTTP_STATUS,this.httpStatusEventHandler);
         param1.addEventListener(IOErrorEvent.IO_ERROR,this.ioErrorEventHandler);
         param1.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.securityEventHandler);
         param1.addEventListener(ProgressEvent.PROGRESS,this.progressEventHandler);
      }
      
      private function removeHandlers(param1:URLLoader) : void
      {
         if(param1.hasEventListener(Event.COMPLETE))
         {
            param1.removeEventListener(Event.COMPLETE,this.requestCompleteHandler);
         }
         if(param1.hasEventListener(HTTPStatusEvent.HTTP_STATUS))
         {
            param1.removeEventListener(HTTPStatusEvent.HTTP_STATUS,this.httpStatusEventHandler);
         }
         if(param1.hasEventListener(SecurityErrorEvent.SECURITY_ERROR))
         {
            param1.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.securityEventHandler);
         }
         if(param1.hasEventListener(ProgressEvent.PROGRESS))
         {
            param1.removeEventListener(ProgressEvent.PROGRESS,this.progressEventHandler);
         }
      }
      
      private function httpStatusEventHandler(param1:HTTPStatusEvent) : void
      {
      }
      
      private function ioErrorEventHandler(param1:IOErrorEvent) : void
      {
         if(this._loader != null && this._loader.hasEventListener(IOErrorEvent.IO_ERROR))
         {
            this._loader.removeEventListener(IOErrorEvent.IO_ERROR,this.ioErrorEventHandler);
         }
         this.handleFail(param1.errorID,"An IOErrorEvent occurred.");
      }
      
      private function securityEventHandler(param1:SecurityErrorEvent) : void
      {
         this.handleFail(param1.errorID,"A SecurityErrorEvent occurred.");
      }
      
      private function progressEventHandler(param1:ProgressEvent) : void
      {
         this.beginTimeout();
      }
   }
}
