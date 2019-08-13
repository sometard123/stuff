package ninjakiwi.monkeyTown.town.ui.informationBar
{
   import assets.ui.BurstAnimation;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.StyleSheet;
   import flash.text.TextField;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   
   public class InformationNumber
   {
      
      private static const styleSheet:StyleSheet = new StyleSheet();
      
      private static const styleSheetString:String = ".yellow{ color: #FFCC33; }" + ".red{ color: #FF0000; }";
       
      
      protected var _burstClip:BurstAnimation;
      
      protected var _maxCapacity:int;
      
      protected var _symbol:String;
      
      protected var _prevValue:int;
      
      protected var _textField:TextField;
      
      private var _refillButton:MovieClip;
      
      private var _lock:Boolean = false;
      
      private var _queue:Vector.<int>;
      
      public function InformationNumber(param1:TextField, param2:BurstAnimation, param3:MovieClip, param4:int = -1, param5:Function = null, param6:String = "")
      {
         this._queue = new Vector.<int>();
         super();
         this._textField = param1;
         this._burstClip = param2;
         this._maxCapacity = param4;
         this._symbol = param6;
         styleSheet.parseCSS(styleSheetString);
         this._textField.styleSheet = styleSheet;
         this.hideBurstAnimation();
         this.initButton(param3,param5);
      }
      
      public function reset() : void
      {
         this._prevValue = 0;
         this._lock = false;
         this._queue = new Vector.<int>();
         this.disableRefillButton();
      }
      
      protected function addHint() : void
      {
      }
      
      protected function initButton(param1:MovieClip, param2:Function = null) : void
      {
         this._refillButton = param1;
         if(param1 == null)
         {
            return;
         }
         param1.buttonMode = true;
         param1.mouseChildren = false;
         param1.alpha = 0;
         if(param2 !== null)
         {
            param1.addEventListener(MouseEvent.CLICK,param2);
         }
         param1.addEventListener(MouseEvent.ROLL_OVER,this.buttonRolloverHandler);
         param1.addEventListener(MouseEvent.ROLL_OUT,this.refillButtonRolloutHandler);
         this.disableRefillButton();
      }
      
      public function enableRefillButton() : void
      {
         if(this._refillButton != null)
         {
            this._refillButton.visible = true;
         }
      }
      
      public function disableRefillButton() : void
      {
         if(this._refillButton != null)
         {
            this._refillButton.visible = false;
         }
      }
      
      public function lock() : void
      {
         this._lock = true;
      }
      
      public function unlock() : void
      {
         this._lock = false;
      }
      
      protected function buttonRolloverHandler(param1:Event) : void
      {
      }
      
      protected function refillButtonRolloutHandler(param1:Event) : void
      {
         TownUI.hideToolTipSignal.dispatch();
      }
      
      public function sync() : void
      {
      }
      
      public function addValueToDisplay(param1:int) : void
      {
         this.addValue(param1,true);
      }
      
      protected function addValue(param1:int, param2:Boolean = false) : void
      {
         if(this._lock && !param2)
         {
            this._queue.push(param1);
            return;
         }
         this.updateValue(this._prevValue + param1);
         if(param1 != 0)
         {
            this.showBurstAnimation(param1);
         }
      }
      
      protected function updateValue(param1:int) : void
      {
         if(param1 <= 0)
         {
            param1 = 0;
         }
         var _loc2_:Boolean = param1 > this._maxCapacity && this._maxCapacity != -1;
         var _loc3_:String = !!_loc2_?"<span class = \'yellow\'>" + this._symbol + param1 + "</span>":"" + this._symbol + param1;
         if(this._maxCapacity != -1)
         {
            _loc3_ = _loc3_ + (" / " + this._maxCapacity);
         }
         if(this._textField != null)
         {
            this._textField.htmlText = _loc3_;
         }
         this._prevValue = param1;
      }
      
      protected function setMaximum(param1:int) : void
      {
         this._maxCapacity = param1;
         this.updateValue(this._prevValue);
      }
      
      private function hideBurstAnimation() : void
      {
         if(this._burstClip == null)
         {
            return;
         }
         this._burstClip.burst.gotoAndStop(0);
         this._burstClip.visible = false;
      }
      
      protected function showBurstAnimation(param1:Number) : void
      {
         if(param1 == 0 || this._burstClip == null)
         {
            return;
         }
         if(this._burstClip.burst != null)
         {
            this._burstClip.burst.gotoAndPlay(1);
         }
         var _loc2_:String = "+";
         if(param1 < 0)
         {
            _loc2_ = "-";
         }
         if(this._burstClip.collectedTxt != null)
         {
            this._burstClip.collectedTxt.gotoAndPlay(1);
            if(this._burstClip.collectedTxt.txtContainer != null && this._burstClip.collectedTxt.txtContainer.changedValueTxt != null)
            {
               this._burstClip.collectedTxt.txtContainer.changedValueTxt.text = _loc2_ + Math.abs(param1);
            }
         }
         this._burstClip.visible = true;
      }
   }
}
