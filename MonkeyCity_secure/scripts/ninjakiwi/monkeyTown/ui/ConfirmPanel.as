package ninjakiwi.monkeyTown.ui
{
   import assets.ui.ConfirmPanelClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import org.osflash.signals.Signal;
   
   public class ConfirmPanel extends HideRevealViewPopup
   {
      
      private static const NONE:int = 0;
      
      public static const OK:int = 1;
      
      public static const CANCEL:int = 16;
      
      public static const YES:int = 256;
      
      public static const NO:int = 4096;
       
      
      private var _clip:ConfirmPanelClip;
      
      private var _yesButton:ButtonControllerBase;
      
      private var _noButton:ButtonControllerBase;
      
      private var _okButton:ButtonControllerBase;
      
      private var _cancelButton:ButtonControllerBase;
      
      private const PADDING:int = 20;
      
      private const BUTTON_PADDING:int = 100;
      
      private const FONT_HEIGHT:int = 32;
      
      private const _orignMessageY:Number = this._clip.messageField.y;
      
      public const okClicked:Signal = new Signal();
      
      public const cancelClicked:Signal = new Signal();
      
      public const yesClicked:Signal = new Signal();
      
      public const noClicked:Signal = new Signal();
      
      public const responseSignal:Signal = new Signal(Boolean);
      
      public function ConfirmPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         this._clip = new ConfirmPanelClip();
         this._yesButton = new ButtonControllerBase(this._clip.yesButton);
         this._noButton = new ButtonControllerBase(this._clip.noButton);
         this._okButton = new ButtonControllerBase(this._clip.okButton);
         this._cancelButton = new ButtonControllerBase(this._clip.cancelButton);
         super(param1,param2);
         this._yesButton.setClickFunction(this.onYes);
         this._okButton.setClickFunction(this.onOkay);
         this._noButton.setClickFunction(this.onNo);
         this._cancelButton.setClickFunction(this.onCancel);
         addChild(this._clip);
         isModal = true;
         enableDefaultOnResize(this._clip);
      }
      
      private function onOkay() : void
      {
         hide();
         this.okClicked.dispatch();
         this.responseSignal.dispatch(true);
      }
      
      private function onYes() : void
      {
         hide();
         this.yesClicked.dispatch();
         this.responseSignal.dispatch(true);
      }
      
      private function onNo() : void
      {
         hide();
         this.noClicked.dispatch();
         this.responseSignal.dispatch(false);
      }
      
      private function onCancel() : void
      {
         hide();
         this.cancelClicked.dispatch();
         this.responseSignal.dispatch(false);
      }
      
      private function setButtonGroup(param1:int, param2:Number) : void
      {
         this.hideButtons();
         var _loc3_:Vector.<ButtonControllerBase> = new Vector.<ButtonControllerBase>();
         if((param1 & CANCEL) == CANCEL)
         {
            this._cancelButton.target.visible = true;
            _loc3_.push(this._cancelButton);
         }
         if((param1 & NO) == NO)
         {
            this._noButton.target.visible = true;
            _loc3_.push(this._noButton);
         }
         if((param1 & YES) == YES)
         {
            this._yesButton.target.visible = true;
            _loc3_.push(this._yesButton);
         }
         if((param1 & OK) == OK)
         {
            this._okButton.target.visible = true;
            _loc3_.push(this._okButton);
         }
         var _loc4_:int = _loc3_.length - 1;
         if(_loc4_ < 0)
         {
            _loc4_ = 0;
         }
         var _loc5_:Number = this._clip.width * 0.5 - _loc4_ * this.BUTTON_PADDING * 0.5 - 10;
         var _loc6_:int = 0;
         while(_loc6_ < _loc3_.length)
         {
            _loc3_[_loc6_].target.x = _loc5_ + this.BUTTON_PADDING * _loc6_;
            _loc3_[_loc6_].target.y = param2;
            _loc6_++;
         }
      }
      
      private function hideButtons() : void
      {
         this._yesButton.target.visible = false;
         this._okButton.target.visible = false;
         this._noButton.target.visible = false;
         this._cancelButton.target.visible = false;
      }
      
      public function setMessage(param1:int = 0, param2:String = "", param3:String = "") : void
      {
         this._clip.titleText.text = param2;
         if(param2 == "")
         {
            this._clip.messageField.y = this._clip.titleText.y + this._clip.titleText.textHeight + 15;
         }
         else
         {
            this._clip.messageField.y = this._orignMessageY;
         }
         this._clip.messageField.htmlText = param3;
         this._clip.messageField.height = this._clip.messageField.numLines * this.FONT_HEIGHT;
         this._clip.background.height = this._clip.messageField.textHeight + this.PADDING * 3 + 5;
         if(param2 != "")
         {
            this._clip.background.height = this._clip.background.height + 30;
         }
         this.setButtonGroup(param1,this._clip.messageField.y + this._clip.messageField.textHeight + 25);
      }
   }
}
