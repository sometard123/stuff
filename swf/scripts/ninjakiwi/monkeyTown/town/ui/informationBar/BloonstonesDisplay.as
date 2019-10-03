package ninjakiwi.monkeyTown.town.ui.informationBar
{
   import assets.ui.BurstAnimation;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.premiums.Premium;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   
   public class BloonstonesDisplay extends InformationNumber
   {
       
      
      public function BloonstonesDisplay(param1:TextField, param2:BurstAnimation, param3:MovieClip)
      {
         super(param1,param2,param3,-1,this.onRequestBloonstones);
         ResourceStore.getInstance().bloonstonesChangedDiffSignal.add(this.addValue);
      }
      
      override public function sync() : void
      {
         updateValue(ResourceStore.getInstance().bloonstones);
      }
      
      private function onRequestBloonstones(param1:MouseEvent) : void
      {
         Premium.getInstance().showStoreForBloonstones();
      }
      
      override protected function buttonRolloverHandler(param1:Event) : void
      {
         TownUI.showToolTipSignal.dispatch(LocalisationConstants.HINT_BLOONSTONES);
      }
      
      override protected function addValue(param1:int, param2:Boolean = false) : void
      {
         super.addValue(param1,param2);
      }
   }
}
