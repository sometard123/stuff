package ninjakiwi.monkeyTown.town.upgrades
{
   import com.lgrey.signal.SignalHub;
   import flash.utils.Dictionary;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.buildings.UpgradeBuilding;
   import ninjakiwi.monkeyTown.town.data.BuildingData;
   import ninjakiwi.monkeyTown.town.data.GameModConstants;
   import ninjakiwi.monkeyTown.town.data.GameMods;
   import ninjakiwi.monkeyTown.town.data.UpgradeData;
   import ninjakiwi.monkeyTown.town.data.definitions.MonkeyTownBuildingDefinition;
   import ninjakiwi.monkeyTown.town.data.definitions.UpgradeDefinition;
   import ninjakiwi.monkeyTown.town.data.definitions.UpgradePathStateDefinition;
   import ninjakiwi.monkeyTown.town.data.definitions.UpgradeStateDefinition;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldViewSignals;
   
   public class UpgradeWarmupManager
   {
       
      
      private var _managed:Vector.<ManagedPath>;
      
      private var _managedIndexDict:Dictionary;
      
      private var _timeOfLastUpdate:Number = 0;
      
      private var _system:MonkeySystem;
      
      private var _hubUpgrades:SignalHub;
      
      private const UPDATE_RATE:int = 1000;
      
      private var _resourceStore:ResourceStore;
      
      private var _buildingData:BuildingData;
      
      private var _upgradeTree:UpgradeTree;
      
      public function UpgradeWarmupManager(param1:UpgradeTree)
      {
         this._managed = new Vector.<ManagedPath>();
         this._managedIndexDict = new Dictionary();
         this._system = MonkeySystem.getInstance();
         this._hubUpgrades = SignalHub.getHub("upgrades");
         this._resourceStore = ResourceStore.getInstance();
         this._buildingData = BuildingData.getInstance();
         super();
         this._upgradeTree = param1;
         MonkeyCityMain.globalResetSignal.add(this.onReset);
         UpgradeSignals.upgradePurchased.add(this.registerPath);
         UpgradeSignals.purchasedSkipPathWarmup.add(this.onPurchasedSkipPathWarmupSignal);
         WorldViewSignals.buildWorldEndSignal.add(this.addInnerUpgradeClockToAllBuildings);
      }
      
      private function onReset() : void
      {
         this._managed = new Vector.<ManagedPath>();
         this._managedIndexDict = new Dictionary();
      }
      
      public function registerPath(param1:UpgradePathStateDefinition) : void
      {
         this.addInnerUpgradeClockToBuilding(param1);
         if(this._managedIndexDict[param1])
         {
            return;
         }
         var _loc2_:ManagedPath = new ManagedPath(param1);
         this._managedIndexDict[param1] = this._managed.length;
         this._managed.push(_loc2_);
      }
      
      private function removePath(param1:UpgradePathStateDefinition) : void
      {
         var _loc2_:ManagedPath = null;
         var _loc3_:int = 0;
         while(_loc3_ < this._managed.length)
         {
            _loc2_ = this._managed[_loc3_];
            if(_loc2_.pathState == param1)
            {
               this._managed.splice(_loc3_,1);
            }
            _loc3_++;
         }
         delete this._managedIndexDict[param1];
      }
      
      public function addInnerUpgradeClockToAllBuildings() : void
      {
         var _loc1_:ManagedPath = null;
         var _loc2_:int = 0;
         while(_loc2_ < this._managed.length)
         {
            _loc1_ = this._managed[_loc2_];
            if(_loc1_.pathState.isWarmingUp)
            {
               this.addInnerUpgradeClockToBuilding(_loc1_.pathState);
            }
            _loc2_++;
         }
      }
      
      public function addInnerUpgradeClockToBuilding(param1:UpgradePathStateDefinition) : void
      {
         var _loc4_:Building = null;
         var _loc5_:UpgradeBuilding = null;
         var _loc2_:UpgradeDefinition = UpgradeData.getInstance().getUpgradeDefinitionByID(param1.upgradeID);
         var _loc3_:Array = this._system.city.buildingManager.getBuildingsOfType(_loc2_.building);
         if(_loc3_.length !== 1)
         {
         }
         if(_loc3_.length > 0)
         {
            _loc4_ = _loc3_[0];
            _loc5_ = _loc3_[0];
            _loc5_.addUpgradeSecondaryClock(param1,_loc2_);
         }
         if(_loc3_.length > 1)
         {
         }
      }
      
      public function tick() : void
      {
         var _loc1_:ManagedPath = null;
         var _loc3_:Number = NaN;
         var _loc2_:Number = this._system.getSecureTime();
         var _loc4_:Number = _loc2_ - this._timeOfLastUpdate;
         if(_loc4_ < this.UPDATE_RATE)
         {
            return;
         }
         this._timeOfLastUpdate = _loc2_;
         var _loc5_:int = this._managed.length - 1;
         while(_loc5_ >= 0)
         {
            _loc1_ = this._managed[_loc5_];
            _loc3_ = (_loc2_ - _loc1_.pathState.warmupStartTime) * GameMods.getModifier(GameModConstants.UPGRADE_SPEED_MOD);
            _loc1_.pathState.warmupProgress = _loc3_ / _loc1_.pathState.warmupDuration;
            _loc1_.pathState.getOnUpdateSignal().dispatch();
            if(_loc3_ > _loc1_.pathState.warmupDuration)
            {
               this.completeUpgradeWarmup(_loc1_.pathState);
            }
            _loc5_--;
         }
      }
      
      public function clear() : void
      {
         var _loc2_:ManagedPath = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._managed.length)
         {
            _loc2_ = this._managed[_loc1_];
            _loc2_.pathState.tidy();
            _loc1_++;
         }
         this._managed.length = 0;
         this._managedIndexDict.length = 0;
      }
      
      private function completeUpgradeWarmup(param1:UpgradePathStateDefinition) : void
      {
         var _loc5_:String = null;
         var _loc6_:UpgradeStateDefinition = null;
         GameMods.awardXP(param1.xpOnComplete);
         var _loc2_:SignalHub = SignalHub.getHub("maxUpgradeTierHub");
         param1.completeWarmup();
         this.removePath(param1);
         var _loc3_:MonkeyTownBuildingDefinition = this._buildingData.getBuildingDefinitionByID(param1.upgradeBuildingID);
         var _loc4_:Boolean = true;
         var _loc7_:int = 0;
         while(_loc7_ < _loc3_.upgrades.length)
         {
            _loc5_ = _loc3_.upgrades[_loc7_];
            if(_loc5_ == param1.upgradeID)
            {
               _loc6_ = this._upgradeTree.getUpgradeStateDefinition(_loc5_);
               if(_loc6_.path1.aquiredTo < UpgradeTree.MAX_TIERS || _loc6_.path2.aquiredTo < UpgradeTree.MAX_TIERS)
               {
                  _loc4_ = false;
                  break;
               }
            }
            _loc7_++;
         }
         if(_loc4_ || param1.aquiredTo == UpgradeTree.MAX_TIERS)
         {
            _loc2_.dispatch(param1.upgradeID,_loc4_);
         }
         UpgradeSignals.pathWarmupComplete.dispatch(param1);
      }
      
      private function onPurchasedSkipPathWarmupSignal(param1:UpgradePathStateDefinition, ... rest) : void
      {
         this.completeUpgradeWarmup(param1);
      }
   }
}

import ninjakiwi.monkeyTown.town.data.definitions.UpgradePathStateDefinition;

class ManagedPath
{
    
   
   public var pathState:UpgradePathStateDefinition;
   
   function ManagedPath(param1:UpgradePathStateDefinition)
   {
      super();
      this.pathState = param1;
   }
}
