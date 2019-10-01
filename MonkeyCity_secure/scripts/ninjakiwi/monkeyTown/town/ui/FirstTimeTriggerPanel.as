package ninjakiwi.monkeyTown.town.ui
{
   import assets.town.NextButtonClip;
   import assets.town.OKButtonClip;
   import assets.ui.tutoria.TutorialPanelClip;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.town.data.definitions.FirstTimeTriggerDefinition;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   import org.osflash.signals.Signal;
   
   public class FirstTimeTriggerPanel extends HideRevealView
   {
       
      
      public const _clip:TutorialPanelClip = new TutorialPanelClip();
      
      protected const _messageField:TextField = this._clip.informationField;
      
      protected const _background:MovieClip = this._clip.background;
      
      private const _okButtonClip:OKButtonClip = new OKButtonClip();
      
      private const _okButton:ButtonControllerBase = new ButtonControllerBase(this._okButtonClip);
      
      private const _nextButtonClip:NextButtonClip = new NextButtonClip();
      
      private const _nextButton:ButtonControllerBase = new ButtonControllerBase(this._nextButtonClip);
      
      private const _buttonContainer:Sprite = new Sprite();
      
      private var _currentTriggerDefinition:FirstTimeTriggerDefinition;
      
      private var _triggerSequenceIndex:int;
      
      private var _messageOrignY:int;
      
      private const _waitButton:ButtonControllerBase = new ButtonControllerBase(this._clip.waitButton);
      
      private const _filltankButton:ButtonControllerBase = new ButtonControllerBase(this._clip.fillTankButton);
      
      private const _cancelButton:ButtonControllerBase = new ButtonControllerBase(this._clip.cancelButton);
      
      private const _attackButton:ButtonControllerBase = new ButtonControllerBase(this._clip.attackButton);
      
      public const OK_BUTTON:String = "ok";
      
      public const NEXT_BUTTON:String = "next";
      
      public const NO_BUTTON:String = "none";
      
      public const WAIT_AND_FILL_BUTTON:String = "wait/fill";
      
      public const CANCEL_AND_ATTACK_BUTTON:String = "cancel/attack";
      
      private var _currentVisibleButtonClip:DisplayObject;
      
      public const okSignal:Signal = new Signal();
      
      public const nextSignal:Signal = new Signal();
      
      public const nextInSequenceSignal:Signal = new Signal(FirstTimeTriggerDefinition,int);
      
      public const sequenceCompleteSignal:Signal = new Signal(FirstTimeTriggerDefinition);
      
      public var additionalX:int = 0;
      
      public var additionalY:int = 0;
      
      public function FirstTimeTriggerPanel(param1:DisplayObjectContainer)
      {
         this._currentVisibleButtonClip = this._okButtonClip;
         super(param1);
         addChild(this._clip);
         this.initButtons();
         isModal = false;
         this._messageOrignY = this._messageField.y;
         this.initCSS();
         this._clip.symbol.stop();
      }
      
      private function initCSS() : void
      {
         this._messageField.styleSheet = _system.styleSheet;
      }
      
      private function hideButtons() : void
      {
         this._nextButton.target.visible = false;
         this._okButton.target.visible = false;
         this._waitButton.target.visible = false;
         this._filltankButton.target.visible = false;
         this._cancelButton.target.visible = false;
         this._attackButton.target.visible = false;
      }
      
      public function setMessage(param1:String, param2:String = "ok") : void
      {
         this.hideButtons();
         switch(param2)
         {
            case this.NEXT_BUTTON:
               this._currentVisibleButtonClip = this._nextButtonClip;
               break;
            case this.OK_BUTTON:
               this._currentVisibleButtonClip = this._okButtonClip;
               break;
            case this.WAIT_AND_FILL_BUTTON:
               this._filltankButton.target.visible = true;
               this._currentVisibleButtonClip = this._filltankButton.target;
               break;
            case this.CANCEL_AND_ATTACK_BUTTON:
               this._cancelButton.target.visible = true;
               this._attackButton.target.visible = true;
               this._currentVisibleButtonClip = this._attackButton.target;
               break;
            default:
               this._currentVisibleButtonClip = null;
         }
         param1 = "<span class = \"bolded\">" + param1.split("<br/>").join("\n") + "</span>";
         this._messageField.htmlText = param1;
         this.layout();
      }
      
      public function setWelcome() : void
      {
         this._clip.welcomeClip.visible = true;
         this._clip.symbol.visible = false;
         this._clip.symbol.gotoAndStop(1);
         this._messageField.y = this._messageOrignY + 60;
         this.layout();
      }
      
      public function setSymbol(param1:int, param2:int = 0) : void
      {
         this._clip.welcomeClip.visible = false;
         this._clip.symbol.gotoAndStop(param1);
         this._clip.symbol.visible = true;
         this._messageField.y = this._messageOrignY;
         this.layout(param2);
      }
      
      private function initButtons() : void
      {
         this._buttonContainer.x = int(this._background.width * 0.5);
         this._clip.addChild(this._buttonContainer);
         this._buttonContainer.addChild(this._okButtonClip);
         this._buttonContainer.addChild(this._nextButtonClip);
         this._okButton.setClickFunction(this.okButtonClicked);
         this._nextButton.setClickFunction(this.nextButtonClicked);
         this._waitButton.setClickFunction(this.waitButtonClicked);
         this._filltankButton.setClickFunction(this.fillTankButtonClicked);
         this._cancelButton.setClickFunction(this.cancelButtonClicked);
         this._attackButton.setClickFunction(this.attackButtonClicked);
      }
      
      public function beginTrigger(param1:FirstTimeTriggerDefinition, param2:Boolean = false) : void
      {
         this._triggerSequenceIndex = 0;
         this._currentTriggerDefinition = param1;
         this.nextInSequence(param2);
      }
      
      private function nextInSequence(param1:Boolean = false) : void
      {
         var _loc2_:Boolean = false;
         if(this._currentTriggerDefinition != null)
         {
            _loc2_ = this._triggerSequenceIndex == this._currentTriggerDefinition.sequence.length?true:false;
            if(_loc2_)
            {
               this._currentTriggerDefinition = null;
               this.sequenceCompleteSignal.dispatch(this._currentTriggerDefinition);
               return;
            }
            this.hide();
            this.setMessage(this._currentTriggerDefinition.eventText[this._triggerSequenceIndex],this._currentTriggerDefinition.buttonTypes[this._triggerSequenceIndex]);
            this.nextInSequenceSignal.dispatch(this._currentTriggerDefinition,this._triggerSequenceIndex);
            if(this._currentTriggerDefinition.eventText[this._triggerSequenceIndex] != "")
            {
               if(param1)
               {
                  this.reveal();
               }
               else
               {
                  PanelManager.getInstance().showFreePanel(this);
               }
            }
            this._triggerSequenceIndex++;
         }
      }
      
      override public function reveal(param1:Number = 0.2) : void
      {
         super.reveal(0);
      }
      
      override public function hide(param1:Number = 0.2) : void
      {
         super.hide(0);
      }
      
      public function progressToNextStep() : void
      {
         this.nextInSequence();
      }
      
      public function goToStep(param1:int) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param1 >= this._currentTriggerDefinition.sequence.length)
         {
            param1 = this._currentTriggerDefinition.sequence.length - 1;
         }
         this._triggerSequenceIndex = param1;
         this.nextInSequence();
      }
      
      public function endSequence() : void
      {
         this._triggerSequenceIndex = this._currentTriggerDefinition.sequence.length;
         this.nextInSequence();
      }
      
      private function nextButtonClicked() : void
      {
         this.nextSignal.dispatch();
         this.nextInSequence();
      }
      
      private function okButtonClicked() : void
      {
         this.hide();
         this.okSignal.dispatch();
      }
      
      private function waitButtonClicked() : void
      {
         this.hide();
         this.okSignal.dispatch();
      }
      
      private function fillTankButtonClicked() : void
      {
         this.hide();
         this.okSignal.dispatch();
         var _loc1_:int = ResourceStore.getInstance().bloontoniumCapacity - (ResourceStore.getInstance().bloontonium + ResourceStore.getInstance().getTempOverage());
         if(_loc1_ > 0)
         {
            if(_loc1_ > 1000)
            {
               _loc1_ = 1000;
            }
            ResourceStore.getInstance().bloontonium = ResourceStore.getInstance().bloontonium + _loc1_;
         }
      }
      
      private function cancelButtonClicked() : void
      {
         this.hide();
         this.okSignal.dispatch();
      }
      
      private function attackButtonClicked() : void
      {
         this.hide();
         this.okSignal.dispatch();
      }
      
      public function hideButton() : void
      {
         this.hideButtons();
         this._currentVisibleButtonClip = null;
         this.layout();
      }
      
      private function layout(param1:int = 0, param2:int = 0) : void
      {
         var _loc3_:int = 35;
         this._messageField.height = this._messageField.textHeight + 10;
         if(this._currentVisibleButtonClip != null)
         {
            this._background.height = int(this._messageField.y + this._messageField.textHeight + _loc3_ * 2 + 5 + param1);
            this._currentVisibleButtonClip.visible = true;
         }
         else
         {
            this._background.height = int(this._messageField.y + this._messageField.textHeight + _loc3_ + 15 + param1);
         }
         if(this._currentVisibleButtonClip != null)
         {
            if(this._currentVisibleButtonClip == this._filltankButton.target)
            {
               this._waitButton.target.y = int(this._messageField.y + this._messageField.textHeight + _loc3_ + param1);
               this._filltankButton.target.y = int(this._messageField.y + this._messageField.textHeight + _loc3_ + param1);
            }
            else if(this._currentVisibleButtonClip == this._attackButton.target)
            {
               this._cancelButton.target.y = int(this._messageField.y + this._messageField.textHeight + _loc3_ + param1);
               this._attackButton.target.y = int(this._messageField.y + this._messageField.textHeight + _loc3_ + param1);
            }
            else
            {
               this._buttonContainer.y = int(this._messageField.y + this._messageField.textHeight + _loc3_ + param1);
            }
         }
         x = int(_system.RENDER_SURFACE_WIDTH * 0.5 - width * 0.5) + 15 + this.additionalX;
         y = 80 + param2;
      }
      
      override public function resize() : void
      {
         if(!this._clip)
         {
            return;
         }
         var _loc1_:int = this._clip.width * 0.5;
         var _loc2_:int = this._clip.height * 0.5;
         x = int(_system.flashStage.stageWidth * 0.5 - _loc1_) + 15 + this.additionalX;
         y = 80 + this.additionalY;
      }
   }
}
