package ninjakiwi.net
{
   import flash.utils.Dictionary;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.net.kloud.HandShake;
   import ninjakiwi.monkeyTown.saleEvents.SaleEventData;
   import ninjakiwi.monkeyTown.saleEvents.SaleEventItem;
   
   public class WebAction
   {
      
      private static var _webActions:Dictionary = new Dictionary();
      
      private static var _requestQueuer:RequestQueuer = new RequestQueuer();
      
      private static var _handShake:HandShake;
      
      public static var DISABLE_SAVE:Boolean = false;
       
      
      public var batchGroup:String = null;
      
      public var allowBatchCollapsing:Boolean = true;
      
      private var _sid = -1;
      
      private var _sessionID = -1;
      
      private var _nkApiID = -1;
      
      private var _tid:int = -1;
      
      public function WebAction()
      {
         super();
      }
      
      public static function authenticate(param1:String) : void
      {
         _handShake = new HandShake(param1);
      }
      
      public static function get hasSession() : Boolean
      {
         return _handShake.hasSession;
      }
      
      public static function initialiseSession(param1:*, param2:*, param3:*) : void
      {
         _handShake.initialiseSession(param1,param2,param3);
      }
      
      public static function invalidateSession() : void
      {
         _handShake.invalidateSession();
      }
      
      public static function getActionFor(param1:*) : WebAction
      {
         if(_webActions[param1] === undefined)
         {
            _webActions[param1] = new WebAction();
         }
         return _webActions[param1];
      }
      
      public static function releaseActionFor(param1:*) : void
      {
         delete _webActions[param1];
      }
      
      public static function get sid() : *
      {
         return _handShake.sID;
      }
      
      public static function get sessionID() : *
      {
         return _handShake.sessionID;
      }
      
      public static function get tid() : int
      {
         return _handShake.currentTransactionID;
      }
      
      public function load(param1:String, param2:Function = null, param3:Boolean = false, param4:Boolean = false) : JSONRequest
      {
         return this.loadWithPayload(param1,null,param2,param3,param4);
      }
      
      public function loadWithPayload(param1:String, param2:Object, param3:Function = null, param4:Boolean = false, param5:Boolean = false) : JSONRequest
      {
         var requestData:Object = null;
         var request:JSONRequest = null;
         var url:String = param1;
         var payload:Object = param2;
         var callback:Function = param3;
         var overwriteCallback:Boolean = param4;
         var addToFrontOfQueue:Boolean = param5;
         this._sid = _handShake.sID;
         this._sessionID = _handShake.sessionID;
         this._nkApiID = _handShake.nkApiID;
         try
         {
            requestData = {
               "action":"GET",
               "token":_handShake.token,
               "client":Constants.CLIENT_VERSION,
               "sid":this._sid,
               "sessionID":this._sessionID,
               "nkApiID":this._nkApiID
            };
            if(payload !== null)
            {
               requestData.payload = payload;
            }
            request = new JSONRequest(url,requestData,callback);
            request.allowBatchCollapsing = this.allowBatchCollapsing;
            _requestQueuer.queueRequest(request,addToFrontOfQueue);
            return request;
         }
         catch(e:Error)
         {
            return null;
         }
         return null;
      }
      
      public function save(param1:String, param2:Object, param3:Function = null, param4:Boolean = false, param5:Boolean = false) : void
      {
         var request:JSONRequest = null;
         var url:String = param1;
         var payload:Object = param2;
         var callback:Function = param3;
         var overwriteCallback:Boolean = param4;
         var addToFrontOfQueue:Boolean = param5;
         this._sid = _handShake.sID;
         this._sessionID = _handShake.sessionID;
         this._nkApiID = _handShake.nkApiID;
         this._tid = _handShake.nextTransactionID;
         var requestData:Object = {
            "action":"PUT",
            "token":_handShake.token,
            "client":Constants.CLIENT_VERSION,
            "sid":this._sid,
            "sessionID":this._sessionID,
            "nkApiID":this._nkApiID,
            "tid":this._tid,
            "payload":payload
         };
         try
         {
            request = new JSONRequest(url,requestData,callback);
            request.isSave = true;
            request.batchGroup = this.batchGroup;
            request.allowBatchCollapsing = this.allowBatchCollapsing;
            _requestQueuer.queueRequest(request,addToFrontOfQueue);
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      public function remove(param1:String, param2:Function = null) : void
      {
         this._sid = _handShake.sID;
         this._sessionID = _handShake.sessionID;
         this._tid = _handShake.nextTransactionID;
         this._nkApiID = _handShake.nkApiID;
         var _loc3_:Object = {
            "action":"DELETE",
            "token":_handShake.token,
            "client":Constants.CLIENT_VERSION,
            "sid":this._sid,
            "sessionID":this._sessionID,
            "tid":this._tid,
            "nkApiID":this._nkApiID
         };
         var _loc4_:JSONRequest = new JSONRequest(param1,_loc3_,param2);
         _requestQueuer.queueRequest(_loc4_);
      }
      
      public function get sid() : *
      {
         return this._sid;
      }
      
      public function get tid() : int
      {
         return this._tid;
      }
      
      public function get nkApiID() : *
      {
         return this._nkApiID;
      }
   }
}
