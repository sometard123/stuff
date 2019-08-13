package ninjakiwi.monkeyTown.town.buildings.customClasses
{
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.buildings.saveDefinitions.BuildingSaveDefinition;
   import ninjakiwi.monkeyTown.town.buildings.saveDefinitions.UpgradeableBuildingSaveDefinition;
   import ninjakiwi.monkeyTown.town.city.City;
   import ninjakiwi.monkeyTown.town.data.GameMods;
   import ninjakiwi.monkeyTown.town.data.UpgradeData;
   import ninjakiwi.monkeyTown.town.data.definitions.BuildingUpgradeDefinition;
   import ninjakiwi.monkeyTown.town.data.definitions.MonkeyTownBuildingDefinition;
   import ninjakiwi.monkeyTown.town.ui.clock.ClockSaveDefinition;
   import ninjakiwi.monkeyTown.town.ui.clock.UpgradeBuildingWarmupClock;
   
   public class UpgradeableBuilding extends Building
   {
      
      protected static const MAX_UPGRADE_TIERS_DEFAULT:int = 2;
       
      
      public var tier:int = 1;
      
      public var upgradeDefinition:BuildingUpgradeDefinition;
      
      protected var _upgradeClock:UpgradeBuildingWarmupClock = null;
      
      protected const _upgradeData:UpgradeData = UpgradeData.getInstance();
      
      public function UpgradeableBuilding(param1:MonkeyTownBuildingDefinition, param2:City = null)
      {
         super(param1,param2);
         this.upgradeDefinition = this._upgradeData.getBuildingUpgradeByBuildingID(param1.id);
      }
      
      override public function getInformation() : String
      {
         var _loc1_:* = super.getInformation();
         var _loc2_:Boolean = this.canGetUpgrade();
         if(this.tier < this.maximumTiers)
         {
            _loc1_ = _loc1_ + ("Upgraded to level " + this.tier + "<br/>");
            _loc1_ = _loc1_ + ("Available Upgrade: " + this.upgradeDefinition.name + "<br/>");
            if(_loc2_ || this.upgradeIsWarmingUp)
            {
               _loc1_ = _loc1_ + "<span class = \"green\">";
            }
            else
            {
               _loc1_ = _loc1_ + "<span class = \"red\">";
            }
            if(this.upgradeIsWarmingUp)
            {
               _loc1_ = _loc1_ + "Upgrading now...<br/>";
            }
            else
            {
               if(_resourceStore.spendableMonkeyMoney < this.getUpgradeCostForTier(this.tier + 1))
               {
                  _loc1_ = _loc1_ + ("Upgrade Cost: $" + this.getUpgradeCostForTier(this.tier + 1) + " ( Can\'t Afford )<br/>");
               }
               else
               {
                  _loc1_ = _loc1_ + ("Upgrade Cost: $" + this.getUpgradeCostForTier(this.tier + 1) + "<br/>");
               }
               if(_resourceStore.townLevel < this.upgradeDefinition.requiredMTL)
               {
                  _loc1_ = _loc1_ + ("Required City Level:" + this.upgradeDefinition.requiredMTL + " ( Too Low )<br/>");
               }
               else
               {
                  _loc1_ = _loc1_ + ("Required City Level: " + this.upgradeDefinition.requiredMTL + "<br/>");
               }
            }
            _loc1_ = _loc1_ + "</span>";
         }
         else
         {
            _loc1_ = _loc1_ + ("Upgraded to level " + this.tier + ": " + this.upgradeDefinition.name + "<br/>");
         }
         return _loc1_;
      }
      
      public function canGetUpgrade() : Boolean
      {
         return this.upgradeDefinition != null && _resourceStore.spendableMonkeyMoney >= this.getUpgradeCostForTier(this.tier + 1) && _resourceStore.townLevel >= this.upgradeDefinition.requiredMTL && this.tier < this.maximumTiers && !this.isUpgrading;
      }
      
      override public function upgrade() : void
      {
         super.upgrade();
         this.startUpgradeWarmup();
         _resourceStore.monkeyMoney = _resourceStore.monkeyMoney - this.getUpgradeCostForTier(this.tier + 1);
         Tile.tileChangedSignal.dispatch(homeTile);
      }
      
      public function get isUpgrading() : Boolean
      {
         return this._upgradeClock !== null;
      }
      
      public function startUpgradeWarmup() : void
      {
         this.createUpgradeClock();
      }
      
      public function finaliseUpgrade(param1:Number = 0, param2:int = 2) : void
      {
         this._upgradeClock = null;
         this.tier++;
         if(this.tier > param2)
         {
            this.tier = param2;
         }
         var _loc3_:int = this.getXPAwardedForTier(this.tier);
         GameMods.awardXP(_loc3_);
         spawnXPSpam(_loc3_);
         setGraphicsState(this.tier - 1);
         GameSignals.BUILDING_UPGRADE_COMPLETE.dispatch(this);
      }
      
      public function get upgradeIsWarmingUp() : Boolean
      {
         return this._upgradeClock != null;
      }
      
      public function createUpgradeClock(param1:ClockSaveDefinition = null) : void
      {
         this._upgradeClock = new UpgradeBuildingWarmupClock(_city.upgradeBuildingWarmupClockManager,this.finaliseUpgrade,this,this.getTimeToUpgrade());
         if(param1)
         {
            this._upgradeClock.populateFromSaveDefinition(param1);
         }
      }
      
      public function get upgradeableValue() : int
      {
         if(!this.upgradeDefinition)
         {
            return 0;
         }
         switch(this.tier)
         {
            case 2:
               return this.upgradeDefinition.tier2;
            default:
               return this.upgradeDefinition.tier1;
         }
      }
      
      public function get nextUpgradeableValue() : int
      {
         return this.upgradeDefinition.tier2;
      }
      
      override public function getSaveDefinition() : BuildingSaveDefinition
      {
         var _loc1_:UpgradeableBuildingSaveDefinition = new UpgradeableBuildingSaveDefinition();
         this.populateSaveDefinition(_loc1_);
         return _loc1_;
      }
      
      override protected function populateSaveDefinition(param1:BuildingSaveDefinition) : void
      {
         super.populateSaveDefinition(param1);
         if(!(param1 is UpgradeableBuildingSaveDefinition))
         {
            return;
         }
         var _loc2_:UpgradeableBuildingSaveDefinition = UpgradeableBuildingSaveDefinition(param1);
         _loc2_.tier = this.tier;
         if(this._upgradeClock != null)
         {
            _loc2_.upgradeClockSaveDefinition = this._upgradeClock.getSaveDefinition();
         }
      }
      
      override public function populateFromSaveDefinition(param1:BuildingSaveDefinition) : void
      {
         if(!(param1 is UpgradeableBuildingSaveDefinition))
         {
            return;
         }
         var _loc2_:UpgradeableBuildingSaveDefinition = UpgradeableBuildingSaveDefinition(param1);
         this.tier = _loc2_.tier;
         super.populateFromSaveDefinition(param1);
         this.recreateUpgradeClockFromSaveDefinition(_loc2_);
         setGraphicsState(this.tier - 1);
      }
      
      protected function recreateUpgradeClockFromSaveDefinition(param1:UpgradeableBuildingSaveDefinition) : void
      {
         if(param1.upgradeClockSaveDefinition)
         {
            this.createUpgradeClock(param1.upgradeClockSaveDefinition);
         }
      }
      
      public function get maximumTiers() : int
      {
         return MAX_UPGRADE_TIERS_DEFAULT;
      }
      
      public function get upgradeClock() : UpgradeBuildingWarmupClock
      {
         return this._upgradeClock;
      }
      
      public function getUpgradeCostForTier(param1:int) : int
      {
         return this.upgradeDefinition.cost;
      }
      
      override protected function demolishRefund() : void
      {
         var _loc1_:int = this.getTotalCashInvestedInBuildingForTier(this.tier) * Constants.DEMOLISH_REFUND;
         _resourceStore.monkeyMoney = _resourceStore.monkeyMoney + _loc1_;
      }
      
      public function getTotalCashInvestedInBuildingForTier(param1:int) : int
      {
         var _loc2_:Number = definition.monkeyMoneyCost;
         if(param1 > 1)
         {
            _loc2_ = _loc2_ + this.upgradeDefinition.cost;
         }
         return _loc2_;
      }
      
      override public function getTotalXPEarned() : int
      {
         var _loc1_:int = definition.xpGivenForBuilding;
         if(this.tier > 1)
         {
            _loc1_ = _loc1_ + this.upgradeDefinition.xpGiven;
         }
         return _loc1_;
      }
      
      public function getUpgradeNameForTier(param1:int) : String
      {
         return definition.name + " - Level " + param1;
      }
      
      public function getRequiredTownLevelForTier(param1:int) : int
      {
         return this.upgradeDefinition.requiredMTL;
      }
      
      public function getXPAwardedForTier(param1:int) : int
      {
         return this.upgradeDefinition.xpGiven;
      }
      
      override public function hasActiveClock() : Boolean
      {
         var _loc1_:Boolean = super.hasActiveClock();
         return _loc1_ || this._upgradeClock !== null;
      }
      
      public function getTimeToUpgrade() : Number
      {
         return this.upgradeDefinition.timeToUpgrade;
      }
   }
}
