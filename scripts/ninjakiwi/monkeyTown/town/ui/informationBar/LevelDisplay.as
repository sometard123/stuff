package ninjakiwi.monkeyTown.town.ui.informationBar
{
   import assets.ui.BurstAnimation;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.data.MonkeyTownXPLevelData;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   
   public class LevelDisplay extends InformationNumber
   {
       
      
      public function LevelDisplay(param1:TextField, param2:BurstAnimation, param3:MovieClip)
      {
         super(param1,param2,param3);
         ResourceStore.getInstance().townLevelChangedDiffSignal.add(this.addValue);
         XPDisplay.xpDisplayChanged.add(this.xpDisplayChanged);
      }
      
      override protected function addValue(param1:int, param2:Boolean = false) : void
      {
         if(_prevValue == 0)
         {
            this.sync();
         }
      }
      
      private function xpDisplayChanged(param1:int) : void
      {
         var _loc2_:int = MonkeyTownXPLevelData.getInstance().getTownLevelFromXP(param1);
         updateValue(_loc2_);
      }
      
      override public function sync() : void
      {
         updateValue(ResourceStore.getInstance().townLevel);
      }
      
      override protected function buttonRolloverHandler(param1:Event) : void
      {
         TownUI.showToolTipSignal.dispatch(LocalisationConstants.HINT_LEVEL.split("<count>").join(String(MonkeySystem.getInstance().map.totalCapturedCount())).split("<cityname>").join(MonkeySystem.getInstance().city.name));
      }
   }
}
