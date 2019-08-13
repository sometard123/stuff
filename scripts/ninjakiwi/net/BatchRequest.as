package ninjakiwi.net
{
   import flash.events.Event;
   import flash.utils.getTimer;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.cityCommon.CityCommonDataManager;
   
   public class BatchRequest extends RequestBase
   {
      
      private static var timeOfLastBatch:Number = 0;
       
      
      private var _callback:Function;
      
      private var _requestsCompleted:int = 0;
      
      private var _totalRequests:int = 0;
      
      private var _failedRequests:Array;
      
      private var _requests:Array;
      
      private var _isServerError:Boolean = false;
      
      private var _encounteredUnauthorised:Boolean = false;
      
      public function BatchRequest(param1:Array, param2:Function = null)
      {
         this._failedRequests = [];
         super();
         this._callback = param2;
         this._requests = param1;
      }
      
      override public function go() : void
      {
         this.sendBatchedRequest(this._requests);
         this._requests.length = 0;
      }
      
      override public function end(param1:Object = null) : void
      {
      }
      
      private function sendBatchedRequest(param1:Array) : void
      {
         var _loc2_:JSONRequest = null;
         this._requestsCompleted = 0;
         this._totalRequests = param1.length;
         var _loc3_:Number = MonkeySystem.getInstance().getSecureTime();
         var _loc4_:Number = _loc3_ - timeOfLastBatch;
         timeOfLastBatch = _loc3_;
         var _loc5_:Date = new Date();
         _loc5_.setTime(_loc3_);
         var _loc6_:int = 0;
         while(_loc6_ < this._totalRequests)
         {
            _loc2_ = param1[_loc6_];
            this.addListeners(_loc2_);
            _loc2_.go();
            _loc6_++;
         }
      }
      
      private function addListeners(param1:JSONRequest) : void
      {
         param1.addEventListener(Event.COMPLETE,this.requestCompleteHandler);
         param1.addEventListener(JSONRequest.FAILED,this.requestFailedHandler);
         param1.addEventListener(JSONRequest.SERVER_ERROR,this.serverErrorHandler);
         param1.addEventListener(JSONRequest.UNAUTHORISED,this.unauthorisedHandler);
      }
      
      private function removeListeners(param1:JSONRequest) : void
      {
         param1.removeEventListener(Event.COMPLETE,this.requestCompleteHandler);
         param1.removeEventListener(JSONRequest.FAILED,this.requestFailedHandler);
         param1.removeEventListener(JSONRequest.UNAUTHORISED,this.unauthorisedHandler);
         param1.removeEventListener(JSONRequest.SERVER_ERROR,this.serverErrorHandler);
      }
      
      private function serverErrorHandler(param1:Event) : void
      {
         this._isServerError = true;
         this.requestFailedHandler(param1);
      }
      
      private function unauthorisedHandler(param1:Event) : void
      {
         this._encounteredUnauthorised = true;
         this.requestFailedHandler(param1);
      }
      
      private function checkForCompletion() : Boolean
      {
         if(this._requestsCompleted === this._totalRequests)
         {
            if(this._failedRequests.length > 0)
            {
               t.obj(this._failedRequests);
               if(this._callback !== null)
               {
                  this._callback({
                     "success":false,
                     "batch":this,
                     "reason":this._failedRequests.length + " request(s) failed."
                  });
               }
               if(this._encounteredUnauthorised)
               {
                  this._encounteredUnauthorised = false;
                  this.dispatchEvent(new Event(JSONRequest.UNAUTHORISED));
               }
               else if(this._isServerError)
               {
                  this._isServerError = false;
                  this.dispatchEvent(new Event(JSONRequest.SERVER_ERROR));
               }
               else
               {
                  this.dispatchEvent(new Event(JSONRequest.FAILED));
               }
            }
            else
            {
               if(this._callback !== null)
               {
                  this._callback({
                     "success":true,
                     "batch":this
                  });
               }
               this.dispatchEvent(new Event(Event.COMPLETE));
               this._failedRequests = null;
            }
            this._requests = null;
            return true;
         }
         return false;
      }
      
      private function requestCompleteHandler(param1:Event) : void
      {
         var _loc2_:JSONRequest = JSONRequest(param1.currentTarget);
         this.removeListeners(_loc2_);
         this._requestsCompleted++;
         this.checkForCompletion();
      }
      
      private function requestFailedHandler(param1:Event) : void
      {
         var _loc2_:JSONRequest = JSONRequest(param1.currentTarget);
         this.removeListeners(_loc2_);
         this._failedRequests.push(_loc2_);
         this._requestsCompleted++;
         this.checkForCompletion();
      }
      
      override public function setRetry() : void
      {
         var _loc1_:JSONRequest = null;
         var _loc2_:int = 0;
         while(_loc2_ < this._failedRequests.length)
         {
            _loc1_ = this._failedRequests[_loc2_];
            _loc1_.setRetry();
            _loc2_++;
         }
         this._requests = this._failedRequests.slice(0);
         this._failedRequests.length = 0;
      }
      
      public function get failedRequests() : Array
      {
         return this._failedRequests;
      }
   }
}
