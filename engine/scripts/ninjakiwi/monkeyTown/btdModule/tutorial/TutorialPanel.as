package ninjakiwi.monkeyTown.btdModule.tutorial
{
   import assets.btdmodule.tutoria.NextButtonClip;
   import assets.btdmodule.tutoria.OKButtonClip;
   import assets.btdmodule.tutoria.TutorialPanelClip;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import ninjakiwi.monkeyTown.ui.HideRevealViewSimple;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import org.osflash.signals.Signal;
   
   public class TutorialPanel extends HideRevealViewSimple
   {
      
      public static const BUTTON_TYPE_NONE:String = "none";
      
      public static const BUTTON_TYPE_NEXT:String = "next";
      
      public static const BUTTON_TYPE_OKAY:String = "ok";
       
      
      private var _panel:TutorialPanelClip;
      
      private var _okButtonClip:OKButtonClip;
      
      private var _nextButtonClip:NextButtonClip;
      
      private var _buttonContainer:Sprite;
      
      private var _messageField:TextField;
      
      private var _background:MovieClip;
      
      private var _okButton:ButtonControllerBase;
      
      private var _nextButton:ButtonControllerBase;
      
      private var _currentVisibleButtonClip:DisplayObject;
      
      public var okSignal:Signal;
      
      public var nextSignal:Signal;
      
      private var _additionalHeight:Number = 0;
      
      public function TutorialPanel(param1:DisplayObjectContainer)
      {
         this._panel = new TutorialPanelClip();
         this._okButtonClip = new OKButtonClip();
         this._nextButtonClip = new NextButtonClip();
         this._buttonContainer = new Sprite();
         this._messageField = this._panel.informationField;
         this._background = this._panel.background;
         this._okButton = new ButtonControllerBase(this._okButtonClip);
         this._nextButton = new ButtonControllerBase(this._nextButtonClip);
         this._currentVisibleButtonClip = this._okButtonClip;
         this.okSignal = new Signal();
         this.nextSignal = new Signal();
         super(param1);
         this.addChild(this._panel);
         this._buttonContainer.addChild(this._okButton.target);
         this._buttonContainer.addChild(this._nextButton.target);
         this.addChild(this._buttonContainer);
         this._buttonContainer.x = int(this._background.width * 0.5);
         this._okButton.setClickFunction(this.okButtonClicked);
         this._nextButton.setClickFunction(this.nextButtonClicked);
      }
      
      public function destroyPanel() : void
      {
         if(this._panel != null)
         {
            if(this.contains(this._panel))
            {
               this.removeChild(this._panel);
            }
            if(this.contains(this._buttonContainer))
            {
               this.removeChild(this._buttonContainer);
            }
         }
      }
      
      private function okButtonClicked() : void
      {
         hide();
         this.okSignal.dispatch();
      }
      
      private function nextButtonClicked() : void
      {
         this.nextSignal.dispatch();
      }
      
      public function setMessage(param1:String, param2:String = "ok", param3:int = 0, param4:int = 0) : void
      {
         this._messageField.text = param1;
         switch(param2)
         {
            case BUTTON_TYPE_NEXT:
               this._currentVisibleButtonClip = this._nextButtonClip;
               break;
            case BUTTON_TYPE_OKAY:
               this._currentVisibleButtonClip = this._okButtonClip;
               break;
            case BUTTON_TYPE_NONE:
            default:
               this._currentVisibleButtonClip = null;
         }
         this.layout(param3,param4);
      }
      
      private function layout(param1:int = 0, param2:int = 0) : void
      {
         this.hideButtons();
         var _loc3_:int = 35;
         this._messageField.height = this._messageField.textHeight + 10;
         if(this._currentVisibleButtonClip != null)
         {
            this._background.height = int(this._messageField.y + this._messageField.textHeight + _loc3_ * 2 + 5);
            this._currentVisibleButtonClip.visible = true;
         }
         else
         {
            this._background.height = int(this._messageField.y + this._messageField.textHeight + _loc3_ + 10);
         }
         this._buttonContainer.y = int(this._messageField.y + this._messageField.textHeight + _loc3_);
         this._background.height = this._background.height + this._additionalHeight;
         x = int(800 * 0.5 - width * 0.5 - 50 + param1) - 8;
         y = 170 + param2;
      }
      
      private function hideButtons() : void
      {
         this._nextButtonClip.visible = false;
         this._okButtonClip.visible = false;
      }
      
      public function setSymbol(param1:int, param2:int = 0) : void
      {
         this._additionalHeight = param2;
         if(this._panel != null)
         {
            this._panel.symbol.gotoAndStop(param1);
         }
      }
   }
}
