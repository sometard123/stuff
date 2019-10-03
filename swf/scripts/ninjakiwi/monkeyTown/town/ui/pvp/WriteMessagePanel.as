package ninjakiwi.monkeyTown.town.ui.pvp
{
   import assets.ui.WriteMessagePanelClip;
   import flash.display.DisplayObjectContainer;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.smallEvents.bloonstoneSpendEvent.BloonstoneSpendRewardDef;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.ui.HideRevealViewPopup;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.utils.ProfanityFilter;
   
   public class WriteMessagePanel extends HideRevealViewPopup
   {
       
      
      private const _clip:WriteMessagePanelClip = new WriteMessagePanelClip();
      
      private const _okButton:ButtonControllerBase = new ButtonControllerBase(this._clip.okButton);
      
      private const _cancelButton:ButtonControllerBase = new ButtonControllerBase(this._clip.cancelButton);
      
      private var _message:String = "";
      
      public function WriteMessagePanel(param1:DisplayObjectContainer, param2:* = null)
      {
         super(param1,param2);
         this._okButton.setClickFunction(this.confirm);
         this._cancelButton.setClickFunction(this.hide);
         this._clip.messageTxt.maxChars = 60;
         this._clip.messageTxt.restrict = "a-zA-Z 0-9,.!?-_:)(;^\\\\\'";
         this.isModal = true;
         enableDefaultOnResize(this._clip);
         this.addChild(this._clip);
      }
      
      override public function reveal(param1:Number = 0.2) : void
      {
         if(this._message == "")
         {
            this._clip.messageTxt.text = LocalisationConstants.STRING_WRITE_MESSAGE_TO_OPPONENT;
            this._clip.messageTxt.addEventListener(FocusEvent.FOCUS_IN,this.onFocus);
         }
         else
         {
            this._clip.messageTxt.text = this._message;
         }
         MonkeySystem.getInstance().flashStage.addEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler);
         super.reveal(param1);
      }
      
      private function onFocus(param1:FocusEvent) : void
      {
         if(this._clip.messageTxt.hasEventListener(FocusEvent.FOCUS_IN))
         {
            this._clip.messageTxt.removeEventListener(FocusEvent.FOCUS_IN,this.onFocus);
         }
         this._clip.messageTxt.text = this._message;
         this._clip.messageTxt.addEventListener(FocusEvent.FOCUS_OUT,this.onFocusOut);
      }
      
      private function onFocusOut(param1:FocusEvent) : void
      {
         if(isRevealed)
         {
            MonkeySystem.getInstance().flashStage.focus = this._clip.messageTxt;
            this._clip.messageTxt.setSelection(this._clip.messageTxt.text.length,this._clip.messageTxt.text.length);
         }
      }
      
      public function resetMessage() : void
      {
         this._message = "";
      }
      
      private function confirm() : void
      {
         MonkeySystem.getInstance().flashStage.focus = null;
         if(this._clip.messageTxt.hasEventListener(FocusEvent.FOCUS_OUT))
         {
            this._clip.messageTxt.removeEventListener(FocusEvent.FOCUS_OUT,this.onFocusOut);
         }
         this._clip.messageTxt.text = this.sanitize(this._clip.messageTxt.text);
         if(ProfanityFilter.isProfane(this._clip.messageTxt.text))
         {
            this._clip.messageTxt.text = LocalisationConstants.STRING_WRITE_MESSAGE_INVALID;
            this._clip.messageTxt.addEventListener(FocusEvent.FOCUS_IN,this.onFocus);
         }
         else if(this._clip.messageTxt.text == LocalisationConstants.STRING_WRITE_MESSAGE_TO_OPPONENT || this._clip.messageTxt.text == LocalisationConstants.STRING_WRITE_MESSAGE_INVALID)
         {
            this.hide();
         }
         else
         {
            this._message = this._clip.messageTxt.text;
            this.hide();
         }
      }
      
      private function sanitize(param1:String) : String
      {
         return param1.replace(/\n/g," ").replace(/\r/g," ").replace(/\t/g," ");
      }
      
      public function getMessage() : String
      {
         return this._message;
      }
      
      override public function hide(param1:Number = 0.2) : void
      {
         if(this._clip.messageTxt.hasEventListener(FocusEvent.FOCUS_IN))
         {
            this._clip.messageTxt.removeEventListener(FocusEvent.FOCUS_IN,this.onFocus);
         }
         if(this._clip.messageTxt.hasEventListener(FocusEvent.FOCUS_OUT))
         {
            this._clip.messageTxt.removeEventListener(FocusEvent.FOCUS_OUT,this.onFocusOut);
         }
         if(MonkeySystem.getInstance().flashStage.hasEventListener(KeyboardEvent.KEY_DOWN))
         {
            MonkeySystem.getInstance().flashStage.removeEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler);
         }
         super.hide(param1);
      }
      
      private function keyDownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ENTER)
         {
            this.confirm();
         }
      }
   }
}
