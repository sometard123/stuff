package ninjakiwi.monkeyTown.town.buildings.customClasses
{
   import com.greensock.TweenLite;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.buildings.saveDefinitions.BloontoniumGeneratorSaveDefinition;
   import ninjakiwi.monkeyTown.town.buildings.saveDefinitions.BuildingSaveDefinition;
   import ninjakiwi.monkeyTown.town.city.ActiveCity;
   import ninjakiwi.monkeyTown.town.city.City;
   import ninjakiwi.monkeyTown.town.data.definitions.MonkeyTownBuildingDefinition;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldView;
   import ninjakiwi.monkeyTown.town.ui.bloontoniumGenerator.BloontoniumStats;
   import ninjakiwi.monkeyTown.town.ui.clock.ClockSaveDefinition;
   import org.osflash.signals.Signal;
   
   public class BloontoniumGenerator extends UpgradeableResourceGeneratingBuilding
   {
      
      public static const requestUpgradeSignal:Signal = new Signal(UpgradeableBuilding);
       
      
      public var bloontonium:Number = 0;
      
      public var statsView:BloontoniumStats;
      
      public function BloontoniumGenerator(param1:MonkeyTownBuildingDefinition, param2:City = null)
      {
         super(param1,param2);
         ResourceStore.getInstance().bloontoniumTanksAreFullSignal.add(this.displayTanksFullAnimation);
         MonkeyCityMain.globalResetSignal.add(this.tidy);
      }
      
      override public function onBuildComplete(param1:Number, param2:Boolean = true) : void
      {
         super.onBuildComplete(param1,param2);
         this.addStatsView();
      }
      
      private function addStatsView() : void
      {
         if(this.statsView != null)
         {
            return;
         }
         this.statsView = new BloontoniumStats(this);
         this.statsView.bloontonium = this.bloontonium;
         this.statsView.requestUpgradeSignal.add(this.onStatsUpgradeSignal);
         _city.bloontoniumStatsManager.register(this.statsView);
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
      
      override public function tidy() : void
      {
         super.tidy();
         ResourceStore.getInstance().bloontoniumTanksAreFullSignal.remove(this.displayTanksFullAnimation);
         MonkeyCityMain.globalResetSignal.remove(this.tidy);
         if(this.statsView)
         {
            this.statsView.tidy();
            WorldView.removeOverlayFlashItem(this.statsView);
            _system.city.bloontoniumStatsManager.deregister(this.statsView);
         }
      }
      
      private function onStatsUpgradeSignal() : void
      {
         requestUpgradeSignal.dispatch(this);
      }
      
      override public function getSaveDefinition() : BuildingSaveDefinition
      {
         var _loc1_:BloontoniumGeneratorSaveDefinition = new BloontoniumGeneratorSaveDefinition();
         _loc1_.bloontonium = this.bloontonium;
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
         var _loc2_:BloontoniumGeneratorSaveDefinition = BloontoniumGeneratorSaveDefinition(param1);
         this.bloontonium = _loc2_.bloontonium;
         if(_loc2_.statsTimeLastUpdated != -1)
         {
            this.addStatsView();
            this.statsView.timeLastUpdated = _loc2_.statsTimeLastUpdated;
         }
         super.populateFromSaveDefinition(param1);
         if(this.statsView)
         {
            this.syncStatsViewPosition();
         }
      }
      
      private function syncStatsViewPosition() : void
      {
         if(this.statsView === null)
         {
            return;
         }
         this.statsView.x = mapCoordinates.x * _system.TOWN_GRID_UNIT_SIZE + 10;
         this.statsView.y = mapCoordinates.y * _system.TOWN_GRID_UNIT_SIZE;
      }
      
      override public function catchUpToTime(param1:Number) : void
      {
         if(this.statsView)
         {
            this.statsView.update(param1);
         }
      }
      
      override public function startUpgradeWarmup() : void
      {
         super.startUpgradeWarmup();
         this.statsView.retrieveBloontonium();
      }
      
      override public function finaliseUpgrade(param1:Number = 0, param2:int = 2) : void
      {
         super.finaliseUpgrade(param1,param2);
         this.statsView.activate();
         setPlayStateOfAllClips(true);
      }
      
      override public function createUpgradeClock(param1:ClockSaveDefinition = null) : void
      {
         super.createUpgradeClock(param1);
         this.statsView.deactivate();
         setPlayStateOfAllClips(false);
      }
      
      private function displayTanksFullAnimation() : void
      {
         GameSignals.TANKS_FULL_ANIMATION.dispatch(this.x,this.y);
      }
      
      override public function beginMoving() : void
      {
         super.beginMoving();
         this.statsView.visible = false;
      }
      
      override public function finishMoving() : void
      {
         super.finishMoving();
         this.syncStatsViewPosition();
         this.statsView.visible = true;
      }
   }
}
