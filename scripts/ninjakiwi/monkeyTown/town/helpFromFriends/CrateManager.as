package ninjakiwi.monkeyTown.town.helpFromFriends
{
   import flash.events.FocusEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.net.kloud.Kloud;
   import ninjakiwi.monkeyTown.pvp.Friend;
   import ninjakiwi.monkeyTown.smallEvents.bloonstoneSpendEvent.BloonstoneSpendMilestone;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.ui.helpFromFriends.CrateStruct;
   import ninjakiwi.monkeyTown.town.ui.pvp.PVPOpponentInfoBox;
   import ninjakiwi.monkeyTown.town.upgrades.UpgradeSignals;
   import org.osflash.signals.PrioritySignal;
   import org.osflash.signals.Signal;
   
   public class CrateManager
   {
      
      public static const NOTIFIED_USERS_COOKIE_STRING:String = "CratesNotifiedUsers";
      
      public static const MAX_CRATE_REQUESTS:int = 3;
      
      public static const MAX_CRATE_SENDS:int = 3;
      
      public static var DATA_REFRESH_RATE:int = 10 * 60 * 1000;
      
      public static const crateManagerDataSetSignal:Signal = new Signal();
      
      public static const startRefreshingDataSignal:Signal = new Signal();
      
      public static const endRefreshingDataSignal:Signal = new Signal();
      
      public static const dataChangedSignal:Signal = new Signal();
      
      private static const MS_PER_MINUTE:int = 1000 * 60;
      
      private static const MS_PER_DAY:int = MS_PER_MINUTE * 60 * 24;
      
      public static const BLOONSTONE_COST_FOR_EXTRA_SENDS:int = 50;
      
      public static const EXTRA_CRATES_PER_PURCHASE:int = 3;
      
      public static const newIncomingCratesSignal:Signal = new Signal(Array);
      
      private static var instance:CrateManager;
       
      
      private var _requested:Array = null;
      
      private var _pending:Array = null;
      
      private var _sent:Array = null;
      
      private var _received:Array = null;
      
      private var _ownedCrates:int = 0;
      
      private var _system:MonkeySystem;
      
      private var _serverTimeAtLastUpdate:Number = -1;
      
      private var _timeUntilMidnightAtLastUpdate:Number = -1;
      
      private var _crateSendsRemaining:int = 0;
      
      private var _crateRequestsRemaining:int = 0;
      
      private var updateTimer:Timer;
      
      private var _isInitialised:Boolean = false;
      
      private var testCounter:int = 0;
      
      public function CrateManager(param1:SingletonEnforcer#592)
      {
         this._system = MonkeySystem.getInstance();
         this.updateTimer = new Timer(DATA_REFRESH_RATE,0);
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use StatsData.getInstance() instead of new.");
         }
      }
      
      public static function getInstance() : CrateManager
      {
         if(instance == null)
         {
            instance = new CrateManager(new SingletonEnforcer#592());
         }
         return instance;
      }
      
      private function init() : void
      {
         this.startPeriodicUpdate();
         this._isInitialised = true;
      }
      
      public function setData(param1:Object) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:Array = this._received;
         if(!this._isInitialised)
         {
            this.init();
            _loc3_ = this.getNotifiedCratesFromCookie();
         }
         this._requested = this.getCrateStructArray(param1.requested);
         this._sent = this.getCrateStructArray(param1.sent);
         this._pending = this.getCrateStructArray(param1.pending);
         this._received = this.getCrateStructArray(param1.received);
         this._ownedCrates = param1.own;
         if(!param1.hasOwnProperty("remaining"))
         {
            param1.remaining = {
               "sends":MAX_CRATE_SENDS - this._sent.length,
               "requests":MAX_CRATE_REQUESTS - this._requested.length
            };
         }
         var _loc4_:Array = this.checkForNewCrates(_loc3_);
         if(_loc4_.length > 0)
         {
            newIncomingCratesSignal.dispatch(_loc4_);
         }
         this.saveNotifiedCratesToCookie(this._received);
         this._crateSendsRemaining = param1.remaining.sends;
         this._crateRequestsRemaining = param1.remaining.requests;
         CrateManager.crateManagerDataSetSignal.dispatch();
         CrateManager.dataChangedSignal.dispatch();
      }
      
      private function saveNotifiedCratesToCookie(param1:Array) : void
      {
         var _loc6_:Object = null;
         var _loc2_:Object = {};
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc6_ = param1[_loc3_];
            if(_loc6_.hasOwnProperty("id") != false)
            {
               _loc2_[_loc6_.id] = _loc6_;
            }
            _loc3_++;
         }
         var _loc4_:Vector.<String> = new Vector.<String>();
         _loc4_.push(Kloud.userID);
         var _loc5_:Vector.<Object> = new Vector.<Object>();
         _loc5_.push(_loc2_);
         Kloud.saveCookieFromObjects(NOTIFIED_USERS_COOKIE_STRING,_loc4_,_loc5_);
      }
      
      public function getNotifiedCratesFromCookie() : Array
      {
         var _loc3_:Object = null;
         var _loc1_:Object = Kloud.loadCookie(NOTIFIED_USERS_COOKIE_STRING).data;
         var _loc2_:Array = [];
         if(false == _loc1_.hasOwnProperty(Kloud.userID))
         {
            return _loc2_;
         }
         for each(_loc3_ in _loc1_[Kloud.userID])
         {
            _loc2_.push(_loc3_);
         }
         return _loc2_;
      }
      
      public function addNewCrates(param1:int) : void
      {
         var quantity:int = param1;
         Kloud.sendSelfCrates(quantity,function(param1:Object):void
         {
            if(param1.success)
            {
               _ownedCrates = _ownedCrates + quantity;
               CrateManager.endRefreshingDataSignal.dispatch();
               CrateManager.dataChangedSignal.dispatch();
            }
         });
      }
      
      private function checkForNewCrates(param1:Array) : Array
      {
         var _loc3_:CrateStruct = null;
         var _loc2_:Array = [];
         if(param1 === this._received)
         {
            return _loc2_;
         }
         var _loc4_:int = 0;
         while(_loc4_ < this._received.length)
         {
            _loc3_ = this._received[_loc4_];
            if(_loc3_.hasOwnProperty("id") != false)
            {
               if(!this.arrayContainsCrate(param1,_loc3_))
               {
                  _loc2_.push(_loc3_);
               }
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      private function arrayContainsCrate(param1:Array, param2:CrateStruct) : Boolean
      {
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_].id === param2.id)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      private function startPeriodicUpdate() : void
      {
         this.updateTimer.addEventListener(TimerEvent.TIMER,this.onUpdateTimerHandler);
         this.updateTimer.start();
      }
      
      private function onUpdateTimerHandler(param1:TimerEvent) : void
      {
         if(this._system.map.worldIsReady)
         {
            this.refreshData();
            this.updateTimer.reset();
            this.updateTimer.start();
         }
      }
      
      private function refreshData() : void
      {
         CrateManager.startRefreshingDataSignal.dispatch();
         Kloud.loadCrates(function crateManagerRefreshDataCallback(param1:Object):void
         {
            setData(param1.crates);
            CrateManager.endRefreshingDataSignal.dispatch();
            CrateManager.dataChangedSignal.dispatch();
         });
      }
      
      public function forceRefreshOfData() : void
      {
         this.refreshData();
      }
      
      private function getCrateStructArray(param1:Array) : Array
      {
         var _loc4_:Object = null;
         if(param1 === null)
         {
            return [];
         }
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = param1[_loc3_];
            if(!_loc4_.hasOwnProperty("senderName"))
            {
               _loc4_.senderName = "Your friend";
            }
            _loc2_[_loc3_] = new CrateStruct(param1[_loc3_]);
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function hasRequestedCrate(param1:String) : Boolean
      {
         var _loc2_:CrateStruct = null;
         var _loc3_:int = 0;
         while(_loc3_ < this._pending.length)
         {
            _loc2_ = this._pending[_loc3_];
            if(_loc2_.sender === param1)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      public function getCrates() : Array
      {
         return this._received;
      }
      
      public function getRequested() : Array
      {
         return this._requested;
      }
      
      public function getSent() : Array
      {
         return this._sent;
      }
      
      public function cratesAvailable() : int
      {
         return this._ownedCrates;
      }
      
      public function get crateSendsRemaining() : int
      {
         return Math.max(0,this._crateSendsRemaining);
      }
      
      public function get crateRequestsRemaining() : int
      {
         return Math.max(0,this._crateRequestsRemaining);
      }
      
      public function checkTimeUntilMidnight() : Boolean
      {
         return false;
      }
      
      public function requestCrates(param1:Array) : void
      {
         var crate:CrateStruct = null;
         var userIDs:Array = param1;
         if(userIDs.length < 1)
         {
            return;
         }
         var ownID:String = Kloud.userID;
         var i:int = 0;
         while(i < userIDs.length)
         {
            crate = new CrateStruct({
               "sender":userIDs[i],
               "receiver":ownID,
               "askTime":this._system.getSecureTime(),
               "sendTime":0,
               "useTime":0,
               "saveTime":0
            });
            this._requested.push(crate);
            i++;
         }
         this._crateRequestsRemaining = this._crateRequestsRemaining - userIDs.length;
         CrateManager.dataChangedSignal.dispatch();
         Kloud.requestCrates(userIDs,function(param1:Object):void
         {
            if(param1.success === false)
            {
            }
         });
      }
      
      public function sendCrates(param1:Array, param2:Function) : void
      {
         var crate:CrateStruct = null;
         var userIDs:Array = param1;
         var callback:Function = param2;
         var ownID:String = Kloud.userID;
         var i:int = 0;
         while(i < userIDs.length)
         {
            if(!(!(userIDs[i] is String) || userIDs[i] == "null"))
            {
               if(!(!(ownID is String) || ownID == "null"))
               {
                  crate = new CrateStruct({
                     "sender":ownID,
                     "receiver":userIDs[i],
                     "askTime":0,
                     "sendTime":this._system.getSecureTime(),
                     "useTime":0,
                     "saveTime":0
                  });
                  this._sent.push(crate);
               }
            }
            i++;
         }
         this._crateSendsRemaining = this._crateSendsRemaining - userIDs.length;
         CrateManager.dataChangedSignal.dispatch();
         Kloud.sendCrates(userIDs,function sendCratesCallback(param1:Object):void
         {
            callback(param1);
            if(param1.success === false)
            {
               returnSentCrates(userIDs.length,false);
               refreshData();
            }
         });
      }
      
      public function useCrate() : void
      {
         if(this._ownedCrates < 1)
         {
            return;
         }
         this._ownedCrates--;
         CrateManager.dataChangedSignal.dispatch();
         Kloud.useCrate(function(param1:Object):void
         {
            if(param1.success === false)
            {
               if(!param1.hasOwnProperty("bmc_code"))
               {
                  param1.bmc_code = "error";
               }
            }
         });
      }
      
      public function buyMoreCrateSends(param1:Function) : void
      {
         var resourceStore:ResourceStore = null;
         var callback:Function = param1;
         resourceStore = ResourceStore.getInstance();
         Kloud.buyMoreCrateSends(function(param1:Object):void
         {
            if(param1.success == true)
            {
               if(resourceStore.bloonstones >= BLOONSTONE_COST_FOR_EXTRA_SENDS)
               {
                  resourceStore.bloonstones = resourceStore.bloonstones - BLOONSTONE_COST_FOR_EXTRA_SENDS;
                  _crateSendsRemaining = _crateSendsRemaining + EXTRA_CRATES_PER_PURCHASE;
                  CrateManager.dataChangedSignal.dispatch();
               }
            }
            if(callback !== null)
            {
               callback(param1);
            }
         });
      }
      
      public function returnSentCrates(param1:int, param2:Boolean = true) : void
      {
         if(0 == param1)
         {
            return;
         }
         this._crateSendsRemaining = this._crateSendsRemaining + param1;
         if(param2)
         {
            CrateManager.dataChangedSignal.dispatch();
         }
      }
   }
}

class SingletonEnforcer#592
{
    
   
   function SingletonEnforcer#592()
   {
      super();
   }
}
