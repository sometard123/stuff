package ninjakiwi.net
{
   import assets.ui.CTRewardsPanelClip;
   import assets.ui.ZomgRadioGroupClip;
   import com.ninjakiwi.gateway.login.LoginInfo;
   import com.ninjakiwi.gateway.net.Api;
   import com.ninjakiwi.gateway.nk.NKGatewayUser;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.getDefinitionByName;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import ninjakiwi.monkeyTown.net.MaintenanceChecker;
   import ninjakiwi.monkeyTown.sku.SkuSettingsLoader;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.ui.contestedTerritory.ContestedTerritoryPanel;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.EventsMenuButton;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.icons.KnowledgePackSaleIcon;
   import ninjakiwi.monkeyTown.ui.CountdownTimer;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.utils.ErrorReporter;
   import org.osflash.signals.Signal;
   
   public class RequestQueuer
   {
      
      public static const BATCH_SAVES:String = "saves";
      
      public static const executingSaveRequestSignal:Signal = new Signal();
      
      public static const endedSaveRequestSignal:Signal = new Signal();
      
      public static const unauthorisedSignal:Signal = new Signal();
      
      public static const shutDownSignal:Signal = new Signal();
      
      public static const statusOKSignal:Signal = new Signal();
      
      public static const resetSignal:Signal = new Signal(Function);
      
      public static const connectionLostSignal:Signal = new Signal(Function);
      
      public static const serverErrorSignal:Signal = new Signal(Function);
      
      public static const longTermConnectivityErrorSignal:Signal = new Signal();
      
      public static const underMaintainanceSignal:Signal = new Signal();
      
      public static const errorKickUserSignal:Signal = new Signal();
      
      public static const requestCompleteSignal:Signal = new Signal();
       
      
      private var _currentRequest:RequestBase = null;
      
      private var _cuedRequests:Array;
      
      private const MAX_TIME_FOR_WAITING_MS:int = 300000.0;
      
      private var _accSeconds:int = 0;
      
      private var _prevTime:int = 0;
      
      private const _timerObject:Sprite = new Sprite();
      
      private var _queueGateIsActive:Boolean = false;
      
      public function RequestQueuer()
      {
         this._cuedRequests = [];
         super();
         MonkeyCityMain.globalResetSignal.add(this.onReset);
      }
      
      private function onReset() : void
      {
         resetSignal.dispatch(this.tryReconnect);
         this.clear();
      }
      
      private function clear() : void
      {
         var _loc1_:RequestBase = null;
         this.removeListeners();
         this._currentRequest = null;
         var _loc2_:int = 0;
         while(_loc2_ < this._cuedRequests.length)
         {
            _loc1_ = this._cuedRequests[_loc2_];
            _loc1_.cancel();
            _loc2_++;
         }
         this._cuedRequests.length = 0;
      }
      
      public function queueRequest(param1:RequestBase, param2:Boolean = false) : void
      {
         if(param2)
         {
            this._cuedRequests.unshift(param1);
         }
         else
         {
            this._cuedRequests.push(param1);
         }
         if(this._currentRequest === null)
         {
            this.executeNextQueuedRequest();
         }
      }
      
      public function queueRequestWithParams(param1:String, param2:Object, param3:Function) : void
      {
         var _loc4_:JSONRequest = new JSONRequest(param1,param2,param3);
         this.queueRequest(_loc4_);
      }
      
      private function executeRequest(param1:RequestBase) : void
      {
         this._currentRequest = param1;
         param1.addEventListener(Event.COMPLETE,this.requestCompleteHandler);
         param1.addEventListener(JSONRequest.FAILED,this.requestFailedHandler);
         param1.addEventListener(JSONRequest.SERVER_ERROR,this.serverErrorHandler);
         param1.addEventListener(JSONRequest.UNAUTHORISED,this.unauthorisedHandler);
         param1.addEventListener(JSONRequest.STATUS_SHUT_DOWN,this.shutdownHandler);
         param1.addEventListener(JSONRequest.STATUS_OK,this.statusOKHandler);
         param1.go();
         if(param1.isSave)
         {
            executingSaveRequestSignal.dispatch();
         }
      }
      
      private function dispatchEndedRequest() : void
      {
         if(this._currentRequest && this._currentRequest.isSave)
         {
            endedSaveRequestSignal.dispatch();
         }
      }
      
      private function unauthorisedHandler(param1:Event) : void
      {
         this.dispatchEndedRequest();
         unauthorisedSignal.dispatch();
      }
      
      private function shutdownHandler(param1:Event) : void
      {
         shutDownSignal.dispatch();
      }
      
      private function statusOKHandler(param1:Event) : void
      {
         statusOKSignal.dispatch();
      }
      
      private function requestFailedHandler(param1:Event) : void
      {
         var e:Event = param1;
         this.dispatchEndedRequest();
         new MaintenanceChecker(function(param1:int, param2:String):void
         {
            if(param1 == MaintenanceChecker.RESULT_UNDER_MAINTENANCE)
            {
               underMaintainanceSignal.dispatch();
            }
            else
            {
               removeHandlers(_currentRequest);
               connectionLostSignal.dispatch(tryReconnect);
               if(!_timerObject.hasEventListener(Event.ENTER_FRAME))
               {
                  _accSeconds = 0;
                  _prevTime = getTimer();
                  _timerObject.addEventListener(Event.ENTER_FRAME,tick);
               }
            }
         }).checkStatus();
      }
      
      private function serverErrorHandler(param1:Event) : void
      {
         this.dispatchEndedRequest();
         serverErrorSignal.dispatch(this.tryReconnect);
      }
      
      private function tryReconnect() : void
      {
         if(this._currentRequest != null)
         {
            this._currentRequest.setRetry();
            this.executeRequest(this._currentRequest);
         }
         else
         {
            ErrorReporter.error("RequestQueuer::tryReconnect() - Current Request cannot be null");
            errorKickUserSignal.dispatch();
         }
      }
      
      private function tick(param1:Event) : void
      {
         var _loc2_:int = getTimer();
         this._accSeconds = this._accSeconds + (_loc2_ - this._prevTime);
         this._prevTime = _loc2_;
         if(this._accSeconds > this.MAX_TIME_FOR_WAITING_MS)
         {
            this.onTimer();
         }
      }
      
      private function onTimer() : void
      {
         this.removeListeners();
         this.removeHandlers(this._currentRequest);
         if(this._currentRequest && this._currentRequest.isSave)
         {
            endedSaveRequestSignal.dispatch();
         }
         this._currentRequest = null;
         RequestQueuer.longTermConnectivityErrorSignal.dispatch();
      }
      
      private function requestCompleteHandler(param1:Event) : void
      {
         this.removeListeners();
         requestCompleteSignal.dispatch();
         this.removeHandlers(this._currentRequest);
         if(this._currentRequest.isSave)
         {
            endedSaveRequestSignal.dispatch();
         }
         this._currentRequest = null;
         this.executeNextQueuedRequest();
      }
      
      private function removeListeners() : void
      {
         if(this._timerObject.hasEventListener(Event.ENTER_FRAME))
         {
            this._timerObject.removeEventListener(Event.ENTER_FRAME,this.tick);
         }
      }
      
      private function removeHandlers(param1:RequestBase) : void
      {
         if(param1 != null)
         {
            param1.removeEventListener(Event.COMPLETE,this.requestCompleteHandler);
            param1.removeEventListener(JSONRequest.FAILED,this.requestFailedHandler);
            param1.removeEventListener(JSONRequest.SERVER_ERROR,this.serverErrorHandler);
            param1.removeEventListener(JSONRequest.UNAUTHORISED,this.unauthorisedHandler);
            param1.removeEventListener(JSONRequest.STATUS_SHUT_DOWN,this.shutdownHandler);
            param1.removeEventListener(JSONRequest.STATUS_OK,this.statusOKHandler);
         }
      }
      
      private function executeNextQueuedRequest() : void
      {
         if(this._queueGateIsActive)
         {
            return;
         }
         this._queueGateIsActive = true;
         setTimeout(this.executeNextQueuedRequestAfterGate,1);
      }
      
      private function executeNextQueuedRequestAfterGate() : void
      {
         var _loc2_:RequestBase = null;
         this._queueGateIsActive = false;
         if(this._cuedRequests.length === 0)
         {
            return;
         }
         var _loc1_:RequestBase = this._cuedRequests[0];
         if(_loc1_.batchGroup !== null)
         {
            this.executeBatchRequest(_loc1_.batchGroup);
         }
         else
         {
            _loc2_ = this._cuedRequests.shift();
            this.executeRequest(_loc2_);
         }
      }
      
      private function executeBatchRequest(param1:String) : void
      {
         var _loc2_:RequestBase = null;
         var _loc6_:JSONRequest = null;
         var _loc7_:JSONRequest = null;
         var _loc8_:JSONRequest = null;
         var _loc10_:int = 0;
         var _loc3_:Array = [];
         var _loc4_:int = this._cuedRequests.length - 1;
         while(_loc4_ >= 0)
         {
            _loc2_ = this._cuedRequests[_loc4_];
            if(_loc2_.batchGroup !== null && _loc2_.batchGroup === param1)
            {
               _loc3_.push(_loc2_);
               this._cuedRequests.splice(_loc4_,1);
            }
            _loc4_--;
         }
         var _loc5_:Array = [];
         var _loc9_:int = 0;
         while(_loc9_ < _loc3_.length)
         {
            if(_loc3_[_loc9_] is JSONRequest)
            {
               _loc6_ = _loc3_[_loc9_];
               _loc8_ = _loc6_;
               if(_loc6_.allowBatchCollapsing)
               {
                  _loc10_ = _loc9_ + 1;
                  while(_loc10_ < _loc3_.length)
                  {
                     if(_loc3_[_loc10_] is JSONRequest)
                     {
                        _loc7_ = _loc3_[_loc10_];
                        if(_loc6_.url == _loc7_.url)
                        {
                           if(_loc7_.sequentialID > _loc6_.sequentialID)
                           {
                              _loc8_ = _loc7_;
                           }
                           _loc3_[_loc10_] = null;
                        }
                     }
                     _loc10_++;
                  }
               }
               _loc5_.push(_loc8_);
            }
            _loc9_++;
         }
         this.sendBatch(_loc5_);
      }
      
      private function sendBatch(param1:Array) : void
      {
         var _loc2_:BatchRequest = new BatchRequest(param1);
         _loc2_.isSave = true;
         this.executeRequest(_loc2_);
      }
   }
}
