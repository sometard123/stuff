package ninjakiwi.monkeyTown.btdModule.BSSpecialAbility
{
   import assets.btdmodule.ui.BloonstonesSymbol;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.Event;
   import ninjakiwi.dancingShadows.DancingShadows;
   import ninjakiwi.dancingShadows.INumber;
   import ninjakiwi.monkeyTown.btdModule.game.Game;
   import ninjakiwi.monkeyTown.btdModule.utils.GameInRoundTimer;
   import ninjakiwi.monkeyTown.btdModule.utils.GameSpeedTimer;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import org.osflash.signals.Signal;
   
   public class BSSpecialAbility
   {
      
      private static const _bsSymbol:BloonstonesSymbol = new BloonstonesSymbol();
       
      
      protected var _container:DisplayObjectContainer;
      
      protected var _button:ButtonControllerBase;
      
      protected var _bloonstonesCost:INumber;
      
      public const moreBloonstonesNeeded:Signal = new Signal(int);
      
      public var timer:GameInRoundTimer;
      
      public var clip:MovieClip;
      
      private var _name:String = "";
      
      private var _id:String = "";
      
      private var _description:String = "";
      
      private var _tooltipString:String = "";
      
      public const bloonstonesSpent:Signal = new Signal(BSSpecialAbility);
      
      protected var _bonusCount:INumber;
      
      public function BSSpecialAbility(param1:DisplayObjectContainer, param2:MovieClip = null, param3:String = "", param4:String = "", param5:int = 5)
      {
         this._bloonstonesCost = DancingShadows.getOne();
         this._bonusCount = DancingShadows.getOne();
         super();
         this._container = param1;
         this._button = new ButtonControllerBase(param2);
         this._button.setClickFunction(this.buttonClicked);
         this._button.setOverFunction(this.showTooltip);
         this._button.setOutFunction(this.hideTooltip);
         this.clip = param2;
         this._bloonstonesCost.value = param5;
         this._name = param3;
         this._description = param4;
         this._tooltipString = "<font color=\'#E0CDB6\' face=\'Oetztype\'>" + this._name + "</font>\n<font color=\'#CFF1FE\' face=\'Oetztype\'>  " + this._bloonstonesCost.value + "</font>\n" + this._description;
         this._id = param3.replace(" ","");
         if(this._container != null)
         {
            if(this._button != null)
            {
               this._container.addChild(this._button.target);
            }
         }
      }
      
      public function init() : void
      {
      }
      
      public function reset() : void
      {
         if(this.timer != null)
         {
            this.removeTimerListener();
            this.timer.stop();
         }
         this.ready();
      }
      
      public function destroy() : void
      {
      }
      
      protected function buttonClicked() : void
      {
         this.attemptConsume();
      }
      
      protected function attemptConsume() : void
      {
         if(this._bonusCount.value > 0)
         {
            this.consumeBonus();
            return;
         }
         this.spendBloonstones();
      }
      
      private function showTooltip() : void
      {
         Main.instance.tooltip.tooltip = this._tooltipString;
         Main.instance.tooltip.addSymbol(_bsSymbol,5,24);
         Main.instance.tooltip.show();
      }
      
      private function hideTooltip() : void
      {
         Main.instance.tooltip.hide();
      }
      
      protected function spendBloonstones() : void
      {
         Game.GAME_REQUEST_BLOONSTONES_SIGNAL.dispatch(this._bloonstonesCost.value,this.onBloonstonesCharged,true);
      }
      
      protected function onBloonstonesCharged(param1:Boolean, param2:int) : void
      {
         if(param1)
         {
            this.bloonstonesSpent.dispatch(this);
            this.action();
         }
         else
         {
            this.moreBloonstonesNeeded.dispatch(this._bloonstonesCost.value - param2);
         }
      }
      
      protected function consumeBonus() : void
      {
         if(this._bonusCount.value > 0)
         {
            this.setBonusCount(this._bonusCount.value - 1);
            this.action();
         }
      }
      
      protected function action() : void
      {
         if(this.timer != null)
         {
            this.timer.reset();
            this.timer.addEventListener(GameSpeedTimer.COMPLETE,this.onTimer);
            if(this._button != null)
            {
               this._button.lock(3);
            }
         }
      }
      
      protected function ready() : void
      {
         if(this._button != null)
         {
            this._button.unlock();
         }
      }
      
      private function onTimer(param1:Event) : void
      {
         this.removeTimerListener();
         this.ready();
      }
      
      private function removeTimerListener() : void
      {
         if(this.timer != null)
         {
            if(this.timer.hasEventListener(GameSpeedTimer.COMPLETE) == true)
            {
               this.timer.removeEventListener(GameSpeedTimer.COMPLETE,this.onTimer);
            }
         }
      }
      
      public function get isAvailable() : Boolean
      {
         return true;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function get button() : ButtonControllerBase
      {
         return this._button;
      }
      
      public function setBonusCount(param1:int) : void
      {
         this._bonusCount.value = param1;
      }
   }
}
