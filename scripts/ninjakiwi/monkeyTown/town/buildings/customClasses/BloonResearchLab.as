package ninjakiwi.monkeyTown.town.buildings.customClasses
{
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.city.City;
   import ninjakiwi.monkeyTown.town.data.definitions.MonkeyTownBuildingDefinition;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldView;
   import ninjakiwi.monkeyTown.town.townMap.TownMap;
   import ninjakiwi.monkeyTown.town.ui.clock.PassiveBloonResearchLabUpgradeClock;
   import ninjakiwi.monkeyTown.town.upgrades.UpgradeSignals;
   import ninjakiwi.monkeyTown.ui.bloonResearchLab.BloonResearchLabState;
   import ninjakiwi.monkeyTown.ui.bloonResearchLab.BloonResearchLabUpgradeClock;
   import org.osflash.signals.Signal;
   
   public class BloonResearchLab extends Building
   {
      
      public static const labPlacedSignal:Signal = new Signal();
       
      
      public function BloonResearchLab(param1:MonkeyTownBuildingDefinition, param2:City = null)
      {
         super(param1,param2);
         UpgradeSignals.bloonResearchLabUpgradeComplete.add(this.syncToResearchTier);
         this.syncToResearchTier();
      }
      
      private function syncToResearchTier(... rest) : void
      {
         setGraphicsState(BloonResearchLabState.currentTier);
      }
      
      override public function placeOnMap(param1:TownMap, param2:Boolean = true, param3:Boolean = true, param4:Boolean = false) : Building
      {
         if(param1 === null)
         {
            return this;
         }
         super.placeOnMap(param1,param2,param3,param4);
         labPlacedSignal.dispatch(this);
         return this;
      }
      
      public function addUpgradeSecondaryClock(param1:BloonResearchLabUpgradeClock) : void
      {
         var _loc2_:PassiveBloonResearchLabUpgradeClock = new PassiveBloonResearchLabUpgradeClock(param1);
         _loc2_.dieOnRemoveFromStage = false;
         _loc2_.x = int(this.homeTile.x + _system.TOWN_GRID_UNIT_SIZE / 2) * definition.width;
         _loc2_.y = int(this.homeTile.y + _system.TOWN_GRID_UNIT_SIZE / 2) * definition.height - 16;
         WorldView.addOverlayFlashItems(_loc2_);
      }
   }
}
