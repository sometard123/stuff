package ninjakiwi.monkeyTown.net
{
   import flash.events.Event;
   import flash.net.URLRequestMethod;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.utils.ErrorReporter;
   import ninjakiwi.net.JSONRequest;
   
   public class MaintenanceChecker
   {
      
      public static const STATUS_MAINTENANCE:String = "maintenance";
      
      public static const STATUS_PREMAINTENANCE:String = "premaintenance";
      
      public static const STATUS_FULL:String = "full";
      
      public static const STATUS_NORMAL:String = "none";
      
      public static const RESULT_NONE:int = 0;
      
      public static const RESULT_UNDER_MAINTENANCE:int = 1;
      
      public static const RESULT_NETWORK_ERROR:int = 2;
      
      public static const RESULT_SERVER_FULL:int = 3;
      
      public static const RESULT_SERVER_REFRESH:int = 4;
       
      
      protected var _callback:Function;
      
      protected var _request:JSONRequest;
      
      public function MaintenanceChecker(param1:Function)
      {
         super();
         this._callback = param1;
      }
      
      public function checkStatus() : void
      {
         this._request = new JSONRequest(Constants.SERVER_STATUS_URL,null,function(param1:Object):void
         {
            removeListeners();
            if(param1.clientVersion !== Constants.CLIENT_VERSION)
            {
               if(_callback != null)
               {
                  _callback(RESULT_SERVER_REFRESH,param1.message);
                  ErrorReporter.externalLog("Version number error.");
                  ErrorReporter.externalLog("Server: " + param1.clientVersion + " Client: " + Constants.CLIENT_VERSION);
               }
            }
            else if(param1.status == STATUS_MAINTENANCE)
            {
               if(_callback != null)
               {
                  _callback(RESULT_UNDER_MAINTENANCE,param1.message);
                  ErrorReporter.externalLog("In Maintenance: " + param1.message);
               }
            }
            else if(param1.status == STATUS_FULL)
            {
               if(_callback != null)
               {
                  _callback(RESULT_SERVER_FULL,param1.message);
                  ErrorReporter.externalLog("Server full error");
               }
            }
            else if(_callback != null)
            {
               _callback(RESULT_NONE,"");
            }
         },URLRequestMethod.GET);
         this._request.addEventListener(JSONRequest.FAILED,this.failureHandler);
         this._request.go();
      }
      
      protected function failureHandler(param1:Event) : void
      {
         this.removeListeners();
         if(this._callback != null)
         {
            this._callback(RESULT_NETWORK_ERROR,"Please check internet connection.");
         }
      }
      
      protected function removeListeners() : void
      {
         if(this._request != null)
         {
            if(this._request.hasEventListener(JSONRequest.FAILED))
            {
               this._request.removeEventListener(JSONRequest.FAILED,this.failureHandler);
            }
         }
      }
   }
}
