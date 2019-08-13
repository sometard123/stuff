package ninjakiwi.monkeyTown.town.gameEvents
{
   import ninjakiwi.monkeyTown.data.KeyValueStore;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.signals.LoginSignals;
   import ninjakiwi.monkeyTown.sku.SkuSettingsLoader;
   import ninjakiwi.monkeyTown.smallEvents.BananaFarmRateModifier;
   import ninjakiwi.monkeyTown.smallEvents.BeaconModifiers;
   import ninjakiwi.monkeyTown.smallEvents.BeaconRechargeCostModifier;
   import ninjakiwi.monkeyTown.smallEvents.BeaconRechargeTimeModifier;
   import ninjakiwi.monkeyTown.smallEvents.BloontoniumRateModifier;
   import ninjakiwi.monkeyTown.smallEvents.CashBloonstoneExchangeRateModifier;
   import ninjakiwi.monkeyTown.smallEvents.MonkeyKnowledgeMadness;
   import ninjakiwi.monkeyTown.smallEvents.Warmonger;
   import ninjakiwi.monkeyTown.smallEvents.WildRare;
   import ninjakiwi.monkeyTown.smallEvents.bloonstoneSpendEvent.BloonstoneSpendEventTracker;
   import ninjakiwi.monkeyTown.smallEvents.miniLandGrab.MiniLandGrab;
   import ninjakiwi.monkeyTown.smallEvents.monkeyMerchant.MonkeyMerchant;
   import ninjakiwi.monkeyTown.smallEvents.monkeyTeam.MonkeyTeam;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.gameEvents.bloonBeacon.BloonBeaconSystem;
   import ninjakiwi.monkeyTown.town.gameEvents.boss.BossEventManager;
   import ninjakiwi.monkeyTown.town.gameEvents.ui.CTOccupationManager;
   import org.osflash.signals.Signal;
   
   public class GameEventManager
   {
      
      private static var _isInitialised:Boolean = false;
      
      public static var gameEventManagerReadySignal:Signal = new Signal();
      
      private static var _hasUserBeenLoggedOut:Boolean = false;
      
      private static var instance:GameEventManager;
       
      
      private var _data:Array;
      
      public const ctMilestonesManager:CTMilestonesManager = new CTMilestonesManager();
      
      public const ctOccupationManager:CTOccupationManager = new CTOccupationManager();
      
      public const bloonBeaconSystem:BloonBeaconSystem = BloonBeaconSystem.getInstance();
      
      public const monkeyTeam:MonkeyTeam = new MonkeyTeam();
      
      public const bloonstonesSpendTracker:BloonstoneSpendEventTracker = new BloonstoneSpendEventTracker();
      
      public const bananaFarmRateModifer:BananaFarmRateModifier = new BananaFarmRateModifier();
      
      public const warmonger:Warmonger = new Warmonger();
      
      public const bloontoniumRateModifier:BloontoniumRateModifier = new BloontoniumRateModifier();
      
      public const cashBloonstoneExchangeRateModifier:CashBloonstoneExchangeRateModifier = new CashBloonstoneExchangeRateModifier();
      
      public const miniLandGrab:MiniLandGrab = new MiniLandGrab();
      
      public const monkeyKnowledgeMadness:MonkeyKnowledgeMadness = new MonkeyKnowledgeMadness();
      
      public const monkeyMerchant:MonkeyMerchant = new MonkeyMerchant();
      
      public const bossEventManager:BossEventManager = new BossEventManager();
      
      public const beaconRechargeCostModifier:BeaconRechargeCostModifier = new BeaconRechargeCostModifier();
      
      public const beaconRechargeTimeModifier:BeaconRechargeTimeModifier = new BeaconRechargeTimeModifier();
      
      public const beaconModifiers:BeaconModifiers = new BeaconModifiers();
      
      public const wildRare:WildRare = new WildRare();
      
      private const _gameEventMonitor:GameEventMonitor = new GameEventMonitor();
      
      private var _subManagers:Vector.<GameEventSubManager>;
      
      public function GameEventManager(param1:SingletonEnforcer#722)
      {
         this._subManagers = new Vector.<GameEventSubManager>();
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use GameEventManager.getInstance() instead of new.");
         }
         this.initialise();
      }
      
      public static function findLevelTierIndex(param1:Array) : int
      {
         var _loc2_:int = -1;
         var _loc3_:int = ResourceStore.getInstance().townLevel;
         var _loc4_:int = 0;
         while(_loc4_ < param1.length)
         {
            if(_loc3_ < param1[_loc4_])
            {
               _loc2_ = _loc4_;
               break;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public static function getInstance() : GameEventManager
      {
         if(instance == null)
         {
            instance = new GameEventManager(new SingletonEnforcer#722());
         }
         if(_hasUserBeenLoggedOut && _isInitialised)
         {
            _hasUserBeenLoggedOut = false;
            gameEventManagerReadySignal.dispatch();
         }
         return instance;
      }
      
      public static function get isInitialised() : Boolean
      {
         return _isInitialised;
      }
      
      public function initialise() : void
      {
         SkuSettingsLoader.getGameEvents(this.onSkuSettingsLoaded);
         LoginSignals.userHasLoggedOut.add(this.onUserLoggedOut);
      }
      
      private function onUserLoggedOut() : void
      {
         _hasUserBeenLoggedOut = true;
      }
      
      public function onSkuSettingsLoaded(param1:Array) : void
      {
         var data:Array = param1;
         this._data = data;
         if(MonkeySystem.getInstance().serverTimeHasBeenInitialised)
         {
            this.processData();
         }
         else
         {
            MonkeySystem.getInstance().serverTimeHasBeenInitialisedSignal.addOnce(function():void
            {
               processData();
            });
         }
      }
      
      private function processData() : void
      {
         this.registerSubManager(this.ctMilestonesManager);
         this.registerSubManager(this.ctOccupationManager);
         this.registerSubManager(this.bloonBeaconSystem.eventManager);
         this.registerSubManager(this.monkeyTeam);
         this.registerSubManager(this.bloonstonesSpendTracker);
         this.registerSubManager(this.bananaFarmRateModifer);
         this.registerSubManager(this.bloontoniumRateModifier);
         this.registerSubManager(this.cashBloonstoneExchangeRateModifier);
         this.registerSubManager(this.warmonger);
         this.registerSubManager(this.miniLandGrab);
         this.registerSubManager(this.monkeyKnowledgeMadness);
         this.registerSubManager(this.monkeyMerchant);
         this.registerSubManager(this.bossEventManager);
         this.registerSubManager(this.beaconRechargeCostModifier);
         this.registerSubManager(this.beaconRechargeTimeModifier);
         this.registerSubManager(this.beaconModifiers);
         this.registerSubManager(this.wildRare);
         _isInitialised = true;
         gameEventManagerReadySignal.dispatch();
      }
      
      private function checkValidDate(param1:String) : Boolean
      {
         return !isNaN(new Date(param1).valueOf());
      }
      
      public function registerSubManager(param1:GameEventSubManager) : void
      {
         var _loc3_:Object = null;
         var _loc4_:GameplayEvent = null;
         var _loc2_:int = 0;
         while(_loc2_ < this._data.length)
         {
            _loc3_ = this._data[_loc2_];
            if(GameplayEvent.validateData(_loc3_))
            {
               if(!(_loc3_.hasOwnProperty("metadata") && _loc3_.metadata.hasOwnProperty("active") && false == _loc3_.metadata.active))
               {
                  if(_loc3_.type === param1.typeID)
                  {
                     _loc4_ = new GameplayEvent(_loc3_);
                     param1.addEvent(_loc4_);
                  }
               }
            }
            _loc2_++;
         }
         param1.persistentDataChangedSignal.add(this.save);
         this._gameEventMonitor.add(param1);
         this._subManagers.push(param1);
      }
      
      public function getActiveEvents(param1:String = null) : Array
      {
         var _loc4_:GameEventSubManager = null;
         var _loc5_:GameplayEvent = null;
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         while(_loc3_ < this._subManagers.length)
         {
            _loc4_ = this._subManagers[_loc3_];
            if(!(param1 !== null && _loc4_.typeID !== param1))
            {
               _loc5_ = _loc4_.findCurrentEvent();
               if(_loc5_ !== null && _loc5_.active)
               {
                  _loc2_.push(_loc5_);
               }
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function getDescriptionForCurrentTier(param1:Object) : String
      {
         if(false === param1.hasOwnProperty("levels") || false === param1.hasOwnProperty("descriptionList"))
         {
            return null;
         }
         var _loc2_:int = GameEventManager.findLevelTierIndex(param1.levels);
         var _loc3_:Array = param1.descriptionList;
         if(_loc2_ >= _loc3_.length)
         {
            _loc2_ = _loc3_.length - 1;
         }
         var _loc4_:String = null;
         var _loc5_:int = 0;
         while(_loc5_ <= _loc2_)
         {
            if(_loc3_[_loc5_] !== null)
            {
               _loc4_ = _loc3_[_loc5_];
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      public function getDescription(param1:String, param2:Function) : void
      {
         var currentEvent:GameplayEvent = null;
         var description:String = null;
         var typeID:String = param1;
         var callback:Function = param2;
         var activeEvents:Array = this.getActiveEvents(typeID);
         if(activeEvents.length == 0)
         {
            this.getDefaultDescription(typeID,callback);
            return;
         }
         currentEvent = activeEvents[0];
         if(currentEvent !== null)
         {
            SkuSettingsLoader.getGameEventDataByType(typeID,function(param1:Object):void
            {
               var _loc2_:Object = null;
               var _loc3_:String = null;
               if(param1.hasOwnProperty(currentEvent.dataID) && param1[currentEvent.dataID].hasOwnProperty("description"))
               {
                  description = param1[currentEvent.dataID].description;
               }
               else
               {
                  description = param1.defaultDescription || "No description found for " + typeID;
               }
               if(param1.hasOwnProperty(currentEvent.dataID))
               {
                  _loc2_ = param1[currentEvent.dataID];
                  if(_loc2_.hasOwnProperty("levels") && _loc2_.hasOwnProperty("descriptionList"))
                  {
                     _loc3_ = getDescriptionForCurrentTier(_loc2_);
                     if(_loc3_ !== null)
                     {
                        description = _loc3_;
                     }
                  }
               }
               callback(description);
            });
         }
      }
      
      private function getDefaultDescription(param1:String, param2:Function) : void
      {
         var typeID:String = param1;
         var callback:Function = param2;
         SkuSettingsLoader.getGameEventDataByType(typeID,function(param1:Object):void
         {
            var _loc2_:String = param1.defaultDescription || "No description found for " + typeID;
            callback(_loc2_);
         });
      }
      
      private function save() : void
      {
         KeyValueStore.getInstance().set("gameEventsManager",this.getPersistentData());
      }
      
      public function setPersistentData(param1:Object) : void
      {
         var _loc3_:GameEventSubManager = null;
         if(param1 == null)
         {
            param1 = {};
         }
         var _loc2_:int = 0;
         while(_loc2_ < this._subManagers.length)
         {
            _loc3_ = this._subManagers[_loc2_];
            if(param1.hasOwnProperty(_loc3_.typeID))
            {
               _loc3_.setPersistentData(param1[_loc3_.typeID]);
            }
            else
            {
               _loc3_.setPersistentData(null);
            }
            _loc2_++;
         }
      }
      
      public function getPersistentData() : Object
      {
         var _loc3_:GameEventSubManager = null;
         var _loc1_:Object = {};
         var _loc2_:int = 0;
         while(_loc2_ < this._subManagers.length)
         {
            _loc3_ = this._subManagers[_loc2_];
            _loc1_[_loc3_.typeID] = _loc3_.getPersistentData();
            _loc2_++;
         }
         return _loc1_;
      }
   }
}

class SingletonEnforcer#722
{
    
   
   function SingletonEnforcer#722()
   {
      super();
   }
}
