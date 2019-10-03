package ninjakiwi.monkeyTown.town.data.definitions
{
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.data.UpgradeData;
   import ninjakiwi.monkeyTown.town.upgrades.UpgradeTree;
   import org.osflash.signals.Signal;
   
   public class UpgradePathStateDefinition
   {
       
      
      public var aquiredTo:uint = 0;
      
      public var unlockedTo:uint = 1;
      
      public var isWarmingUp:Boolean = false;
      
      public var warmupStartTime:Number = -1;
      
      public var warmupDuration:Number = 0;
      
      public var warmupProgress:Number = 0;
      
      public var xpOnComplete:int = 0;
      
      public var upgradeBuildingID:String;
      
      public var upgradeID:String = null;
      
      public var pathNumber:int = -1;
      
      private const _system:MonkeySystem = MonkeySystem.getInstance();
      
      private var _onUpdateSignal:Signal;
      
      private var _onCompleteSignal:Signal;
      
      public function UpgradePathStateDefinition()
      {
         this._onUpdateSignal = new Signal();
         this._onCompleteSignal = new Signal();
         super();
      }
      
      public function startWarmupForNextTier(param1:Number, param2:int, param3:MonkeyTownBuildingDefinition) : void
      {
         this.warmupDuration = param1 * 60 * 1000;
         this.warmupStartTime = this._system.getSecureTime();
         this.warmupProgress = 0;
         this.isWarmingUp = true;
         this.xpOnComplete = param2;
         this.upgradeBuildingID = param3.id;
      }
      
      public function tidy() : void
      {
         this._onUpdateSignal.removeAll();
         this._onCompleteSignal.removeAll();
      }
      
      public function completeWarmup() : void
      {
         this.isWarmingUp = false;
         this.warmupStartTime = -1;
         this.warmupDuration = 0;
         this.warmupProgress = 1;
         this.xpOnComplete = 0;
         if(this.unlockedTo < UpgradeTree.MAX_TIERS)
         {
            this.unlockedTo++;
         }
         this.aquiredTo++;
         this._onCompleteSignal.dispatch();
         GameSignals.UPGRADE_WARMUP_COMPLETE.dispatch(this.getUpgradePathTierDefinitionAtTier(this.aquiredTo),this);
      }
      
      public function getTimeRemaining() : Number
      {
         var _loc1_:Number = this._system.getSecureTime();
         var _loc2_:Number = _loc1_ - this.warmupStartTime;
         return this.warmupDuration - _loc2_;
      }
      
      public function getBloonstonesRequiredToSkip() : Number
      {
         var _loc6_:Number = NaN;
         var _loc1_:Number = this._system.getSecureTime();
         var _loc2_:Number = _loc1_ - this.warmupStartTime;
         var _loc3_:Number = this.warmupDuration - _loc2_;
         var _loc4_:Number = _loc3_ / 1000 / 60;
         var _loc5_:Number = 30;
         if(_loc4_ < _loc5_)
         {
            _loc6_ = _loc4_;
         }
         else
         {
            _loc6_ = _loc5_ + (_loc4_ - _loc5_) / 2;
         }
         _loc6_ = Math.ceil(_loc6_);
         if(_loc6_ < 0)
         {
            _loc6_ = 0;
         }
         return _loc6_;
      }
      
      public function getUpgradePathTierDefinitionAtTier(param1:int) : UpgradePathTierDefinition
      {
         var _loc3_:UpgradePathDefinition = null;
         if(this.upgradeID === null)
         {
         }
         var _loc2_:UpgradeDefinition = UpgradeData.getInstance().getUpgradeDefinitionByID(this.upgradeID);
         if(this.pathNumber === 1)
         {
            _loc3_ = _loc2_.path1;
         }
         else
         {
            if(this.pathNumber != 2)
            {
            }
            _loc3_ = _loc2_.path2;
         }
         var _loc4_:UpgradePathTierDefinition = _loc3_.tier1;
         switch(param1)
         {
            case 2:
               _loc4_ = _loc3_.tier2;
               break;
            case 3:
               _loc4_ = _loc3_.tier3;
               break;
            case 4:
               _loc4_ = _loc3_.tier4;
         }
         return _loc4_;
      }
      
      public function getOnUpdateSignal() : Signal
      {
         return this._onUpdateSignal;
      }
      
      public function getOnCompleteSignal() : Signal
      {
         return this._onCompleteSignal;
      }
   }
}
