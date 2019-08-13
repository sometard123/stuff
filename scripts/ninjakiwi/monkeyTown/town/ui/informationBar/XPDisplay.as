package ninjakiwi.monkeyTown.town.ui.informationBar
{
   import assets.ui.BurstAnimation;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.town.data.MonkeyTownXPLevelData;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.utils.CSSUtil;
   import org.osflash.signals.Signal;
   
   public class XPDisplay extends InformationNumber
   {
      
      public static const xpDisplayChanged:Signal = new Signal();
       
      
      private var _xpToGo:int = 0;
      
      private var _xpProgressBar:MovieClip;
      
      public function XPDisplay(param1:TextField, param2:BurstAnimation, param3:MovieClip, param4:MovieClip)
      {
         super(param1,param2,param3);
         this._xpProgressBar = param4;
         ResourceStore.getInstance().xpChangedDiffSignal.add(addValue);
         ResourceStore.getInstance().xpDebtChangedSignal.add(this.sync);
      }
      
      override public function reset() : void
      {
         super.reset();
         this._xpToGo = 0;
      }
      
      override protected function updateValue(param1:int) : void
      {
         if(_textField == null)
         {
            return;
         }
         if(ResourceStore.getInstance().xpDebt > 0)
         {
            _textField.htmlText = "<b>" + CSSUtil.wrapInRed("XP: " + param1) + "</b>";
         }
         else
         {
            _textField.htmlText = "<b>XP: " + param1 + "</b>";
         }
         this.syncXPProgressBar(param1);
         _prevValue = param1;
      }
      
      private function syncXPProgressBar(param1:Number) : void
      {
         var _loc2_:int = MonkeyTownXPLevelData.getInstance().xpNeededCumulative[ResourceStore.getInstance().townLevel];
         var _loc3_:int = MonkeyTownXPLevelData.getInstance().xpNeededCumulative[ResourceStore.getInstance().townLevel - 1];
         var _loc4_:Number = _loc2_ - _loc3_;
         this.setXPProgress((param1 - _loc3_) / _loc4_);
         this._xpToGo = _loc2_ - param1;
         xpDisplayChanged.dispatch(param1);
      }
      
      private function setXPProgress(param1:Number) : void
      {
         if(this._xpProgressBar == null)
         {
            return;
         }
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param1 > 1)
         {
            param1 = 1;
         }
         this._xpProgressBar.scaleX = param1;
      }
      
      private function onXPDebtChanged() : void
      {
         this.sync();
      }
      
      override public function sync() : void
      {
         this.updateValue(ResourceStore.getInstance().xp);
      }
      
      override protected function buttonRolloverHandler(param1:Event) : void
      {
         if(ResourceStore.getInstance().townLevel >= Constants.MAX_CITY_LEVEL)
         {
            TownUI.showToolTipSignal.dispatch("Maximum city level");
            return;
         }
         if(ResourceStore.getInstance().xpDebt > 0)
         {
            TownUI.showToolTipSignal.dispatch(LocalisationConstants.HINT_XP_DEBT.split("<debt>").join(String(ResourceStore.getInstance().xpDebt)));
         }
         else
         {
            TownUI.showToolTipSignal.dispatch(LocalisationConstants.HINT_XP.split("<xp to go>").join(String(this._xpToGo)));
         }
      }
   }
}
