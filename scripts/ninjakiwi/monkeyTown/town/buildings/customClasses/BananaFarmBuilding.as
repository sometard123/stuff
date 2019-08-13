package ninjakiwi.monkeyTown.town.buildings.customClasses
{
   import com.greensock.TweenLite;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.buildings.BuildingManager;
   import ninjakiwi.monkeyTown.town.buildings.saveDefinitions.BananaFarmBuildingSaveDefinition;
   import ninjakiwi.monkeyTown.town.buildings.saveDefinitions.BuildingSaveDefinition;
   import ninjakiwi.monkeyTown.town.buildings.saveDefinitions.UpgradeableBuildingSaveDefinition;
   import ninjakiwi.monkeyTown.town.city.ActiveCity;
   import ninjakiwi.monkeyTown.town.city.City;
   import ninjakiwi.monkeyTown.town.data.BananaFarmData;
   import ninjakiwi.monkeyTown.town.data.definitions.MonkeyTownBuildingDefinition;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldView;
   import ninjakiwi.monkeyTown.town.tileProps.HoseWater;
   import ninjakiwi.monkeyTown.town.townMap.TownMap;
   import ninjakiwi.monkeyTown.town.ui.bananaFarm.BananaFarmStats;
   import ninjakiwi.monkeyTown.town.ui.clock.BananaFarmUpgradeBuildingWarmupClock;
   import ninjakiwi.monkeyTown.town.ui.clock.ClockSaveDefinition;
   import org.osflash.signals.Signal;
   
   public class BananaFarmBuilding extends UpgradeableResourceGeneratingBuilding
   {
      
      public static const requestUpgradeSignal:Signal = new Signal(UpgradeableBuilding);
       
      
      public var monkeyMoney:Number = 0;
      
      public var statsView:BananaFarmStats;
      
      public var waterTier4:HoseWater;
      
      public var waterTier5:HoseWater;
      
      public var waterTier5Left:HoseWater;
      
      public var waterFacadeTile:Tile = null;
      
      public function BananaFarmBuilding(param1:MonkeyTownBuildingDefinition, param2:City = null)
      {
         this.waterTier4 = new HoseWater();
         this.waterTier5 = new HoseWater();
         this.waterTier5Left = new HoseWater(true);
         playOnComplete = false;
         super(param1,param2);
      }
      
      override public function onBuildComplete(param1:Number, param2:Boolean = true) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         super.onBuildComplete(param1,param2);
         this.addStatsView();
         if(param1 > 0)
         {
            _loc3_ = _system.getSecureTime();
            _loc4_ = _loc3_ - param1;
            this.statsView.timeLastUpdated = _loc4_;
            this.catchUpToTime(_loc3_);
         }
      }
      
      private function addStatsView() : void
      {
         if(this.statsView != null)
         {
            return;
         }
         this.statsView = new BananaFarmStats(this);
         this.statsView.money = this.monkeyMoney;
         _city.bananaFarmStatsManager.register(this.statsView);
         this.statsView.requestUpgradeSignal.add(this.onStatsUpgradeSignal);
         if(_city is ActiveCity)
         {
            this.syncStatsViewPosition();
            this.statsView.alpha = 0;
            TweenLite.to(this.statsView,0.6,{
               "alpha":1,
               "delay":0.5
            });
            WorldView.addOverlayFlashItems(this.statsView);
         }
      }
      
      private function syncStatsViewPosition() : void
      {
         if(this.statsView === null)
         {
            return;
         }
         this.statsView.x = mapCoordinates.x * _system.TOWN_GRID_UNIT_SIZE + _system.TOWN_GRID_UNIT_SIZE;
         this.statsView.y = mapCoordinates.y * _system.TOWN_GRID_UNIT_SIZE + _system.TOWN_GRID_UNIT_SIZE - _system.TOWN_GRID_UNIT_SIZE * 0.2;
      }
      
      private function onStatsUpgradeSignal() : void
      {
         requestUpgradeSignal.dispatch(this);
      }
      
      public function spawnCoinAnimation(param1:int) : void
      {
         if(_city is ActiveCity)
         {
            homeTile.tileRB.addFacadeAnimation("assets.sfx.BananaFarmCoinSelectClip",true);
         }
      }
      
      override public function setGraphicsState(param1:int) : void
      {
         super.setGraphicsState(param1);
         this.syncWaterFacadesToState();
      }
      
      private function setUpWaterFacades() : void
      {
         if(homeTile !== null)
         {
            this.waterTier4.renderOffset.x = -26;
            this.waterTier4.renderOffset.y = -50;
            this.waterTier5.renderOffset.x = -29;
            this.waterTier5.renderOffset.y = -14;
            this.waterTier5Left.renderOffset.x = 15;
            this.waterTier5Left.renderOffset.y = -78;
            if(this.waterFacadeTile !== null)
            {
               this.waterFacadeTile.removeFacadeAnimation(this.waterTier4);
               this.waterFacadeTile.removeFacadeAnimation(this.waterTier5);
               this.waterFacadeTile.removeFacadeAnimation(this.waterTier5Left);
            }
            this.waterFacadeTile = homeTile.tileRB;
            this.waterFacadeTile.facadeAnimations.push(this.waterTier4);
            this.waterFacadeTile.facadeAnimations.push(this.waterTier5Left);
            this.waterFacadeTile.facadeAnimations.push(this.waterTier5);
            this.syncWaterFacadesToState();
         }
      }
      
      private function syncWaterFacadesToState() : void
      {
         switch(tier)
         {
            case 4:
               this.waterTier4.visible = true;
               this.waterTier5.visible = false;
               this.waterTier5Left.visible = false;
               break;
            case 5:
               this.waterTier4.visible = false;
               this.waterTier5.visible = true;
               this.waterTier5Left.visible = true;
               break;
            default:
               this.waterTier4.visible = false;
               this.waterTier5.visible = false;
               this.waterTier5Left.visible = false;
         }
      }
      
      override public function demolish(param1:Boolean = true, param2:Boolean = true) : void
      {
         super.demolish(param1,param2);
         if(this.waterFacadeTile !== null)
         {
            this.waterFacadeTile.removeFacadeAnimation(this.waterTier4);
            this.waterFacadeTile.removeFacadeAnimation(this.waterTier5);
            this.waterFacadeTile.removeFacadeAnimation(this.waterTier5Left);
            this.waterTier4 = null;
            this.waterTier5 = null;
            this.waterTier5Left = null;
         }
      }
      
      override public function tidy() : void
      {
         super.tidy();
         if(this.statsView)
         {
            this.statsView.tidy();
            WorldView.removeOverlayFlashItem(this.statsView);
            _system.city.bananaFarmStatsManager.deregister(this.statsView);
         }
      }
      
      override public function getSaveDefinition() : BuildingSaveDefinition
      {
         var _loc1_:BananaFarmBuildingSaveDefinition = new BananaFarmBuildingSaveDefinition();
         _loc1_.monkeyMoney = this.monkeyMoney;
         if(this.statsView == null)
         {
            _loc1_.statsTimeLastUpdated = -1;
         }
         else
         {
            _loc1_.statsTimeLastUpdated = this.statsView.timeLastUpdated;
         }
         populateSaveDefinition(_loc1_);
         return _loc1_;
      }
      
      override public function populateFromSaveDefinition(param1:BuildingSaveDefinition) : void
      {
         var _loc2_:BananaFarmBuildingSaveDefinition = BananaFarmBuildingSaveDefinition(param1);
         this.monkeyMoney = _loc2_.monkeyMoney;
         if(_loc2_.statsTimeLastUpdated != -1)
         {
            this.addStatsView();
            this.statsView.timeLastUpdated = _loc2_.statsTimeLastUpdated;
         }
         super.populateFromSaveDefinition(param1);
         if(this.statsView)
         {
            this.statsView.x = mapCoordinates.x * _system.TOWN_GRID_UNIT_SIZE + _system.TOWN_GRID_UNIT_SIZE;
            this.statsView.y = mapCoordinates.y * _system.TOWN_GRID_UNIT_SIZE + _system.TOWN_GRID_UNIT_SIZE - _system.TOWN_GRID_UNIT_SIZE * 0.2;
         }
      }
      
      override public function placeOnMap(param1:TownMap, param2:Boolean = true, param3:Boolean = true, param4:Boolean = false) : Building
      {
         super.placeOnMap(param1,param2,param3,param4);
         this.setUpWaterFacades();
         return this;
      }
      
      override public function catchUpToTime(param1:Number) : void
      {
         if(this.statsView)
         {
            this.statsView.update(param1);
         }
      }
      
      override public function setPlayStateOfAllClips(param1:Boolean, param2:int = -1, param3:Boolean = false) : Building
      {
         if(param2 != -1)
         {
            super.setPlayStateOfAllClips(false,param2);
         }
         else
         {
            super.setPlayStateOfAllClips(false);
         }
         return this;
      }
      
      override protected function recreateUpgradeClockFromSaveDefinition(param1:UpgradeableBuildingSaveDefinition) : void
      {
      }
      
      override public function startUpgradeWarmup() : void
      {
         super.startUpgradeWarmup();
         this.statsView.retrieveMoney();
      }
      
      override public function finaliseUpgrade(param1:Number = 0, param2:int = 5) : void
      {
         super.finaliseUpgrade(param1,BananaFarmData.MAX_UPGRADE_TIERS);
         this.statsView.catchUpEarningsAfterUpgrade(param1);
         this.statsView.activate();
         this.syncWaterFacadesToState();
      }
      
      override public function createUpgradeClock(param1:ClockSaveDefinition = null) : void
      {
         _upgradeClock = new BananaFarmUpgradeBuildingWarmupClock(_city.upgradeBuildingWarmupClockManager,this.finaliseUpgrade,this,this.getTimeToUpgrade());
         if(param1)
         {
            _upgradeClock.populateFromSaveDefinition(param1);
         }
         this.statsView.deactivate();
      }
      
      override public function beginMoving() : void
      {
         super.beginMoving();
         this.statsView.visible = false;
         this.waterTier4.visible = false;
         this.waterTier5.visible = false;
         this.waterTier5Left.visible = false;
      }
      
      override public function finishMoving() : void
      {
         super.finishMoving();
         this.syncStatsViewPosition();
         this.syncWaterFacadesToState();
         this.statsView.visible = true;
      }
      
      override public function isDemolishable() : Boolean
      {
         var _loc1_:BuildingManager = _system.city.buildingManager;
         if(_loc1_.getBuildingCount(definition.id) <= 1)
         {
            return false;
         }
         return true;
      }
      
      override public function canGetUpgrade() : Boolean
      {
         if(tier < BananaFarmData.MAX_UPGRADE_TIERS)
         {
            return tier < BananaFarmData.MAX_UPGRADE_TIERS && _resourceStore.spendableMonkeyMoney >= BananaFarmData.getCostForTier(tier + 1) && _resourceStore.townLevel >= BananaFarmData.getRequiredLevelForTier(tier + 1) && !isUpgrading;
         }
         return false;
      }
      
      override public function getTotalCashInvestedInBuildingForTier(param1:int) : int
      {
         var _loc2_:Number = definition.monkeyMoneyCost;
         var _loc3_:int = 1;
         while(_loc3_ <= param1)
         {
            _loc2_ = _loc2_ + BananaFarmData.getCostForTier(_loc3_);
            _loc3_++;
         }
         return _loc2_;
      }
      
      override public function getTotalXPEarned() : int
      {
         var _loc1_:int = definition.xpGivenForBuilding;
         var _loc2_:int = 1;
         while(_loc2_ <= tier)
         {
            _loc1_ = _loc1_ + BananaFarmData.getXPForTier(_loc2_);
            _loc2_++;
         }
         return _loc1_;
      }
      
      override public function getUpgradeCostForTier(param1:int) : int
      {
         return BananaFarmData.getCostForTier(param1);
      }
      
      override public function getXPAwardedForTier(param1:int) : int
      {
         return BananaFarmData.getXPForTier(param1);
      }
      
      override public function get upgradeableValue() : int
      {
         return BananaFarmData.getCapacityForTier(tier);
      }
      
      override public function get nextUpgradeableValue() : int
      {
         return BananaFarmData.getCapacityForTier(this.clampToTier(tier + 1));
      }
      
      override public function getUpgradeNameForTier(param1:int) : String
      {
         return BananaFarmData.getNameForTier(param1);
      }
      
      override public function get maximumTiers() : int
      {
         return BananaFarmData.MAX_UPGRADE_TIERS;
      }
      
      override public function getRequiredTownLevelForTier(param1:int) : int
      {
         return BananaFarmData.getRequiredLevelForTier(param1);
      }
      
      override public function getTimeToUpgrade() : Number
      {
         return BananaFarmData.getTimeForTier(this.clampToTier(tier + 1));
      }
      
      private function clampToTier(param1:int) : int
      {
         if(param1 < 1)
         {
            param1 = 1;
         }
         else if(param1 > BananaFarmData.MAX_UPGRADE_TIERS)
         {
            param1 = BananaFarmData.MAX_UPGRADE_TIERS;
         }
         return param1;
      }
   }
}
