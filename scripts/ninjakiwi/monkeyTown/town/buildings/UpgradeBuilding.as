package ninjakiwi.monkeyTown.town.buildings
{
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import flash.utils.setTimeout;
   import ninjakiwi.monkeyTown.town.city.City;
   import ninjakiwi.monkeyTown.town.data.definitions.MonkeyTownBuildingDefinition;
   import ninjakiwi.monkeyTown.town.data.definitions.UpgradeDefinition;
   import ninjakiwi.monkeyTown.town.data.definitions.UpgradePathStateDefinition;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldView;
   import ninjakiwi.monkeyTown.town.ui.clock.PassiveUpgradeBuildingWarmupClock;
   import ninjakiwi.monkeyTown.town.upgrades.UpgradeSignals;
   
   public class UpgradeBuilding extends Building
   {
       
      
      private var _passiveUpgradeClockDataByPath:Dictionary;
      
      private var _passiveUpgradeClockDataByClock:Dictionary;
      
      public function UpgradeBuilding(param1:MonkeyTownBuildingDefinition, param2:City = null)
      {
         this._passiveUpgradeClockDataByPath = new Dictionary();
         this._passiveUpgradeClockDataByClock = new Dictionary();
         super(param1,param2);
         UpgradeSignals.pathWarmupComplete.add(this.onPathWarmupCompleteSignal);
         this.syncGraphicToTechLevel();
      }
      
      private function syncGraphicToTechLevel() : void
      {
         var upgradeTechLevel:int = 0;
         upgradeTechLevel = _city.upgradeTree.getHighestTierLevelForUpgrades(definition.upgrades);
         if(this.definition.id === "MonkeyTownHall")
         {
            setTimeout(function():void
            {
               setGraphicsState(upgradeTechLevel);
            },1);
         }
         else
         {
            setGraphicsState(upgradeTechLevel);
         }
      }
      
      public function addUpgradeSecondaryClock(param1:UpgradePathStateDefinition, param2:UpgradeDefinition) : void
      {
         var _loc3_:PassiveUpgradeBuildingWarmupClock = null;
         _loc3_ = new PassiveUpgradeBuildingWarmupClock(param1);
         _loc3_.dieOnRemoveFromStage = false;
         _loc3_.x = int(this.homeTile.x + _system.TOWN_GRID_UNIT_SIZE / 2 * definition.width);
         _loc3_.y = int(this.homeTile.y + _system.TOWN_GRID_UNIT_SIZE / 2 * definition.height) - 16;
         var _loc4_:ClockData = new ClockData(_loc3_,param1);
         this._passiveUpgradeClockDataByPath[param1] = _loc4_;
         this._passiveUpgradeClockDataByClock[_loc3_] = _loc4_;
         this.showShortestClock();
      }
      
      private function onPathWarmupCompleteSignal(param1:UpgradePathStateDefinition) : void
      {
         if(param1.upgradeBuildingID != definition.id)
         {
            return;
         }
         if(param1.aquiredTo > currentState)
         {
            setGraphicsState(param1.aquiredTo);
         }
         var _loc2_:ClockData = this._passiveUpgradeClockDataByPath[param1];
         if(_loc2_ === null)
         {
            return;
         }
         var _loc3_:PassiveUpgradeBuildingWarmupClock = _loc2_.clock;
         if(_loc3_ !== null)
         {
            this.upgradeComplete(_loc3_);
         }
      }
      
      override public function tidy() : void
      {
         super.tidy();
         UpgradeSignals.pathWarmupComplete.remove(this.onPathWarmupCompleteSignal);
         this.destroyPassiveClocks();
      }
      
      private function destroyPassiveClocks() : void
      {
         var _loc1_:PassiveUpgradeBuildingWarmupClock = null;
         var _loc2_:* = null;
         var _loc3_:ClockData = null;
         for(_loc2_ in this._passiveUpgradeClockDataByPath)
         {
            _loc3_ = this._passiveUpgradeClockDataByPath[_loc2_];
            _loc1_ = _loc3_.clock;
            _loc1_.tidy();
            WorldView.removeOverlayFlashItem(_loc1_);
         }
         this._passiveUpgradeClockDataByPath = new Dictionary();
         this._passiveUpgradeClockDataByClock = new Dictionary();
      }
      
      private function showShortestClock() : void
      {
         this.removeClocksFromOverlay();
         var _loc1_:PassiveUpgradeBuildingWarmupClock = this.findShortestClock();
         if(_loc1_)
         {
            WorldView.addOverlayFlashItems(_loc1_);
         }
      }
      
      private function removeClocksFromOverlay() : void
      {
         var _loc1_:PassiveUpgradeBuildingWarmupClock = null;
         var _loc2_:* = null;
         var _loc3_:ClockData = null;
         for(_loc2_ in this._passiveUpgradeClockDataByPath)
         {
            _loc3_ = this._passiveUpgradeClockDataByPath[_loc2_];
            _loc1_ = _loc3_.clock;
            WorldView.removeOverlayFlashItem(_loc1_);
         }
      }
      
      private function findShortestClock() : PassiveUpgradeBuildingWarmupClock
      {
         var _loc1_:PassiveUpgradeBuildingWarmupClock = null;
         var _loc4_:Number = NaN;
         var _loc5_:ClockData = null;
         var _loc6_:* = null;
         var _loc2_:PassiveUpgradeBuildingWarmupClock = null;
         var _loc3_:Number = Number.MAX_VALUE;
         for(_loc6_ in this._passiveUpgradeClockDataByPath)
         {
            _loc5_ = this._passiveUpgradeClockDataByPath[_loc6_];
            _loc1_ = _loc5_.clock;
            _loc4_ = _loc5_.path.getTimeRemaining();
            if(_loc4_ < _loc3_)
            {
               _loc2_ = _loc1_;
               _loc3_ = _loc4_;
            }
         }
         return _loc2_;
      }
      
      private function clickedWarmupClockHandler(param1:MouseEvent) : void
      {
         var _loc2_:UpgradePathStateDefinition = param1.currentTarget.targetPath;
         if(!_loc2_)
         {
            return;
         }
         UpgradeSignals.requestSkipPathWarmup.dispatch(_loc2_);
      }
      
      private function upgradeComplete(param1:PassiveUpgradeBuildingWarmupClock) : void
      {
         param1.removeEventListener(MouseEvent.CLICK,this.clickedWarmupClockHandler);
         var _loc2_:ClockData = this._passiveUpgradeClockDataByClock[param1];
         if(param1 === null || _loc2_.path === null)
         {
         }
         delete this._passiveUpgradeClockDataByClock[param1];
         delete this._passiveUpgradeClockDataByPath[_loc2_.path];
         this.showShortestClock();
         spawnXPSpam(param1.xpOnComplete);
      }
      
      override public function hasActiveClock() : Boolean
      {
         var _loc1_:Boolean = super.hasActiveClock();
         return _loc1_ || this.getDictionaryCount(this._passiveUpgradeClockDataByPath) > 0;
      }
      
      private function isEmptyDictionary(param1:Dictionary) : Boolean
      {
         var _loc2_:* = null;
         for(_loc2_ in param1)
         {
            return false;
         }
         return true;
      }
      
      private function getDictionaryCount(param1:Dictionary) : int
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         for(_loc3_ in param1)
         {
            _loc2_++;
         }
         return _loc2_;
      }
   }
}

import ninjakiwi.monkeyTown.town.data.definitions.UpgradePathStateDefinition;
import ninjakiwi.monkeyTown.town.ui.clock.PassiveUpgradeBuildingWarmupClock;

class ClockData
{
    
   
   public var clock:PassiveUpgradeBuildingWarmupClock;
   
   public var path:UpgradePathStateDefinition;
   
   function ClockData(param1:PassiveUpgradeBuildingWarmupClock, param2:UpgradePathStateDefinition)
   {
      super();
      this.clock = param1;
      this.path = param2;
      if(param1 === null || param2 === null)
      {
      }
   }
}
