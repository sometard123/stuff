package ninjakiwi.monkeyTown.ui.bloonResearchLab
{
   import flash.events.MouseEvent;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.data.GameModConstants;
   import ninjakiwi.monkeyTown.town.data.GameMods;
   import ninjakiwi.monkeyTown.town.data.definitions.BloonResearchLabUpgrade;
   import ninjakiwi.monkeyTown.town.ui.clock.Clock;
   import ninjakiwi.monkeyTown.town.ui.clock.ClockManager;
   import ninjakiwi.monkeyTown.town.upgrades.UpgradeSignals;
   
   public class BloonResearchLabUpgradeClock extends Clock
   {
       
      
      public var upgrade:BloonResearchLabUpgrade;
      
      public function BloonResearchLabUpgradeClock(param1:ClockManager, param2:Function, param3:Building, param4:int, param5:BloonResearchLabUpgrade)
      {
         super(param1,param2,param3,param4);
         this.addEventListener(MouseEvent.CLICK,this.onClicked);
      }
      
      override public function syncPositionToTarget() : void
      {
      }
      
      override public function update(param1:Number, param2:Number = 1.0) : void
      {
         super.update(param1,GameMods.getModifier(GameModConstants.UPGRADE_SPEED_MOD));
      }
      
      private function onClicked(param1:MouseEvent) : void
      {
         if(isLocked())
         {
            return;
         }
         this.offerSkip();
      }
      
      public function offerSkip() : void
      {
         var _loc1_:int = getBloonstonesRequiredToSkip();
         UpgradeSignals.requestBloonResearchLabSkip.dispatch(BloonResearchLabState.currentWarmingUpgrade,_loc1_);
      }
      
      override protected function onRollover(param1:MouseEvent) : void
      {
         if(isLocked())
         {
            return;
         }
         super.onRollover(param1);
         setSkipCostText(getBloonstonesRequiredToSkip());
      }
   }
}
