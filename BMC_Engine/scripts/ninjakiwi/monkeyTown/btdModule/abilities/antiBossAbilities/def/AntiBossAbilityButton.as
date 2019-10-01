package ninjakiwi.monkeyTown.btdModule.abilities.antiBossAbilities.def
{
   import assets.btdmodule.ui.BloonstonesSymbol;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import org.osflash.signals.Signal;
   
   public class AntiBossAbilityButton
   {
      
      public static const BUTTON_STATE_OUT:int = 1;
      
      public static const BUTTON_STATE_OVER:int = 2;
      
      public static const BUTTON_STATE_COOLDOWN:int = 3;
      
      public static const BUTTON_STATE_DISABLED:int = 4;
      
      private static const _bsSymbol:BloonstonesSymbol = new BloonstonesSymbol();
       
      
      public var onButtonPressedSignal:Signal = null;
      
      private var _clip:MovieClip = null;
      
      private var _clickArea:MovieClip = null;
      
      private var _clipInner:MovieClip = null;
      
      private var _button:ButtonControllerBase = null;
      
      private var _quantityTextField:TextField = null;
      
      private var _bonusQuantityClip:MovieClip = null;
      
      private var _bonusQuantityTextField:TextField = null;
      
      private var _cooldownClip:MovieClip = null;
      
      private var _activationEffectClip:MovieClip = null;
      
      private var _readyEffectClip:MovieClip = null;
      
      private var _bloonstoneClip:MovieClip = null;
      
      private var _cost:int = 0;
      
      private var _tooltipName:String = "";
      
      private var _tooltipDescription:String = "";
      
      private var _isDisabled:Boolean = false;
      
      public function AntiBossAbilityButton(param1:Class, param2:DisplayObjectContainer, param3:Number, param4:Number, param5:int, param6:String, param7:String)
      {
         super();
         this._clip = new param1();
         this._clip.x = this._clip.x + param3;
         this._clip.y = this._clip.y + param4;
         this._clip.mouseEnabled = false;
         param2.addChild(this._clip);
         this._cost = param5;
         this._tooltipName = param6;
         this._tooltipDescription = param7;
         this._clickArea = this._clip.clickArea;
         this._clipInner = this._clip.graphic;
         this._clipInner.mouseEnabled = false;
         this._clipInner.mouseChildren = false;
         this._clickArea.alpha = 0;
         this._clickArea.mouseEnabled = true;
         this._button = new ButtonControllerBase(this._clickArea);
         this._button.setOverFunction(this.onOver);
         this._button.setOutFunction(this.onOut);
         this._button.setClickFunction(this.onPress);
         this._quantityTextField = this._clipInner.quantity;
         this._quantityTextField.mouseEnabled = false;
         this._bonusQuantityClip = this._clipInner.bonusQuantity;
         this._bonusQuantityClip.mouseEnabled = false;
         this._bonusQuantityTextField = this._bonusQuantityClip.counter;
         this._activationEffectClip = this._clipInner.activateEffect;
         this._activationEffectClip.mouseEnabled = false;
         this._readyEffectClip = this._clipInner.readyEffect;
         this._readyEffectClip.mouseEnabled = false;
         this._cooldownClip = this._clipInner.cooldownClip;
         this._cooldownClip.mouseEnabled = false;
         this._bloonstoneClip = this._clipInner.bloonstoneClip;
         this._bloonstoneClip.mouseEnabled = false;
         this.onButtonPressedSignal = new Signal();
         this.reset();
      }
      
      public function reset() : void
      {
         this._quantityTextField.visible = false;
         this._bonusQuantityClip.visible = false;
         this._activationEffectClip.visible = false;
         this._readyEffectClip.visible = false;
         this.setCooldownPercent(0);
         this._clipInner.gotoAndStop(BUTTON_STATE_OUT);
      }
      
      public function setCooldownPercent(param1:Number) : void
      {
         if(this._isDisabled)
         {
            return;
         }
         var _loc2_:int = 1 + this._cooldownClip.totalFrames * (1 - param1);
         this._cooldownClip.gotoAndStop(_loc2_);
         if(param1 > 0)
         {
            this._clipInner.gotoAndStop(BUTTON_STATE_COOLDOWN);
            this._button.disableMouseInteraction();
         }
         else
         {
            this._clipInner.gotoAndStop(BUTTON_STATE_OUT);
            this._button.enableMouseInteraction();
         }
      }
      
      public function setQuantity(param1:int) : void
      {
         this._quantityTextField.text = param1.toString();
         this._quantityTextField.visible = -1 != param1;
      }
      
      public function setBonusQuantity(param1:int) : void
      {
         this._bonusQuantityTextField.text = param1.toString();
         this._bonusQuantityClip.visible = param1 != 0;
         this._bloonstoneClip.visible = false == this._bonusQuantityClip.visible;
      }
      
      public function setIsDisabled(param1:Boolean) : void
      {
         if(param1)
         {
            this.setCooldownPercent(0);
            this._clipInner.gotoAndStop(BUTTON_STATE_DISABLED);
            this._button.disableMouseInteraction();
         }
         else
         {
            this._clipInner.gotoAndStop(BUTTON_STATE_OUT);
            this._button.enableMouseInteraction();
         }
         this._isDisabled = param1;
      }
      
      public function getIsOver() : Boolean
      {
         return BUTTON_STATE_OVER == this._clipInner.currentFrame;
      }
      
      private function onOver() : void
      {
         this._clipInner.gotoAndStop(BUTTON_STATE_OVER);
         this.showTooltip();
      }
      
      private function onOut() : void
      {
         this._clipInner.gotoAndStop(BUTTON_STATE_OUT);
         this.hideTooltip();
      }
      
      private function onPress() : void
      {
         this.onButtonPressedSignal.dispatch();
      }
      
      private function showTooltip() : void
      {
         var _loc1_:String = "";
         if("" != this._tooltipName)
         {
            _loc1_ = _loc1_ + ("<font color=\'#E0CDB6\' face=\'Oetztype\'>" + this._tooltipName + "</font>\n");
         }
         if(this._cost > 0)
         {
            _loc1_ = _loc1_ + ("<font color=\'#CFF1FE\' face=\'Oetztype\'>  " + this._cost.toString() + "</font>\n");
         }
         if(this._quantityTextField.visible)
         {
            _loc1_ = _loc1_ + ("<font color=\'#CFF1FE\' face=\'Oetztype\'>Uses Left: " + this._quantityTextField.text + "</font>\n");
         }
         if(this._quantityTextField.visible)
         {
            _loc1_ = _loc1_ + ("<font color=\'#CFF1FE\' face=\'Oetztype\'>Uses Left: " + this._quantityTextField.text + "</font>\n");
         }
         if("" != this._tooltipDescription)
         {
            _loc1_ = _loc1_ + this._tooltipDescription;
         }
         if("" != _loc1_)
         {
            Main.instance.tooltip.addSymbol(_bsSymbol,5,24);
            Main.instance.tooltip.tooltip = _loc1_;
            Main.instance.tooltip.show();
         }
      }
      
      private function hideTooltip() : void
      {
         Main.instance.tooltip.hide();
      }
      
      public function get button() : ButtonControllerBase
      {
         return this._button;
      }
      
      public function get clipInner() : MovieClip
      {
         return this._clipInner;
      }
      
      public function get readyEffectClip() : MovieClip
      {
         return this._readyEffectClip;
      }
   }
}
