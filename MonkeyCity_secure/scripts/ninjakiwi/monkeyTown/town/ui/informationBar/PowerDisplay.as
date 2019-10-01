package ninjakiwi.monkeyTown.town.ui.informationBar
{
   import assets.ui.BurstAnimation;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   
   public class PowerDisplay extends InformationNumber
   {
       
      
      private const _resourceStore:ResourceStore = ResourceStore.getInstance();
      
      public function PowerDisplay(param1:TextField, param2:BurstAnimation, param3:MovieClip)
      {
         super(param1,param2,param3,this._resourceStore.totalPower);
         GameSignals.POWER_CHANGED.add(setMaximum);
         GameSignals.POWER_USED_CHANGED_DIFF.add(this.addValue);
      }
      
      override protected function addValue(param1:int, param2:Boolean = false) : void
      {
         super.addValue(param1);
      }
      
      override public function sync() : void
      {
         updateValue(this._resourceStore.totalPowerUsed);
      }
      
      override protected function buttonRolloverHandler(param1:Event) : void
      {
         TownUI.showToolTipSignal.dispatch(LocalisationConstants.HINT_POWER.split("<power used>").join(String(this._resourceStore.totalPowerUsed)).split("<power generated>").join(String(this._resourceStore.totalPower)));
      }
   }
}
