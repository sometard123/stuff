package ninjakiwi.monkeyTown.town.ui.informationBar
{
   import assets.ui.BurstAnimation;
   import assets.ui.HonourIconClip;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.town.ui.HonourDisplayModule;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   
   public class HonourDisplay extends InformationNumber
   {
       
      
      private var _honourModule:HonourDisplayModule;
      
      public function HonourDisplay(param1:HonourIconClip, param2:TextField, param3:BurstAnimation, param4:MovieClip)
      {
         super(param2,param3,param4);
         this._honourModule = new HonourDisplayModule(param1);
         ResourceStore.getInstance().honourPlayEffectSignal.add(this.updateHonourDisplay);
      }
      
      override protected function initButton(param1:MovieClip, param2:Function = null) : void
      {
         super.initButton(param1,param2);
         param1.addEventListener(MouseEvent.CLICK,this.refillButtonClick);
      }
      
      private function updateHonourDisplay(param1:int, param2:int, param3:Boolean = true) : void
      {
         if(param3)
         {
            addValue(param2);
         }
         else
         {
            updateValue(param1);
         }
      }
      
      override public function sync() : void
      {
         updateValue(ResourceStore.getInstance().honour);
      }
      
      override protected function buttonRolloverHandler(param1:Event) : void
      {
         TownUI.showToolTipSignal.dispatch(LocalisationConstants.HINT_HONOR);
      }
      
      private function refillButtonClick(param1:MouseEvent) : void
      {
         TownUI.getInstance().bottomUI.pvpButtonClickedSignal.dispatch();
      }
      
      override public function reset() : void
      {
         super.reset();
         this._honourModule.setHonour(0);
      }
   }
}
