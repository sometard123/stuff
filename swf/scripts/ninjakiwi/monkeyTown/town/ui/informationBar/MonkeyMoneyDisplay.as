package ninjakiwi.monkeyTown.town.ui.informationBar
{
   import assets.ui.BurstAnimation;
   import com.lgrey.signal.SignalHub;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.town.city.ActiveCitySignals;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import org.osflash.signals.Signal;
   
   public class MonkeyMoneyDisplay extends InformationNumber
   {
       
      
      private const requestBloonstonesToCashExchangeSignal:Signal = SignalHub.getHub("ui").defineSignal("requestBloonstonesToCashExchange");
      
      public function MonkeyMoneyDisplay(param1:TextField, param2:BurstAnimation, param3:MovieClip)
      {
         super(param1,param2,param3,ResourceStore.getInstance().bankCapacity,this.moreCashButtonClickHandler,LocalisationConstants.MONEY_SYMBOL);
         ActiveCitySignals.monkeyMoneyChangedDiffSignal.add(this.onMonkeyMonkeyChanged);
         ActiveCitySignals.bankCapacityChangedSignal.add(this.onBankCapacityChangeSignal);
      }
      
      private function onMonkeyMonkeyChanged(param1:int, param2:Boolean = true) : void
      {
         if(false == param2)
         {
            return;
         }
         this.addValue(param1);
      }
      
      override protected function addValue(param1:int, param2:Boolean = false) : void
      {
         super.addValue(param1,param2);
      }
      
      private function onBankCapacityChangeSignal() : void
      {
         var _loc1_:Number = ResourceStore.getInstance().bankCapacity;
         this.setMaximum(_loc1_);
         this.updateValue(ResourceStore.getInstance().monkeyMoney);
      }
      
      override public function sync() : void
      {
         this.updateValue(ResourceStore.getInstance().monkeyMoney);
      }
      
      private function moreCashButtonClickHandler(param1:MouseEvent) : void
      {
         this.requestBloonstonesToCashExchangeSignal.dispatch();
      }
      
      override protected function buttonRolloverHandler(param1:Event) : void
      {
         TownUI.showToolTipSignal.dispatch(LocalisationConstants.HINT_GET_MORE_CASH);
      }
      
      override protected function setMaximum(param1:int) : void
      {
         super.setMaximum(param1);
      }
      
      override protected function updateValue(param1:int) : void
      {
         if(param1 <= 0)
         {
            param1 = 0;
         }
         var _loc2_:Boolean = param1 > _maxCapacity && _maxCapacity != -1;
         var _loc3_:String = !!_loc2_?"<span class = \'yellow\'>" + _symbol + param1 + "</span>":"" + _symbol + param1;
         if(_maxCapacity != -1)
         {
            _loc3_ = _loc3_ + (" / " + this.getCapacityString());
         }
         if(_textField != null)
         {
            _textField.htmlText = _loc3_;
         }
         _prevValue = param1;
      }
      
      protected function getCapacityString() : String
      {
         var _loc1_:String = null;
         if(_maxCapacity >= 100000)
         {
            _loc1_ = _maxCapacity.toString();
            return _loc1_.substring(0,_loc1_.length - 3) + "k";
         }
         return _maxCapacity.toString();
      }
   }
}
