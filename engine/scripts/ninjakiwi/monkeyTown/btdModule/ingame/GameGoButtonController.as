package ninjakiwi.monkeyTown.btdModule.ingame
{
   import assets.gui.GoButtonClip;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import org.osflash.signals.Signal;
   
   public class GameGoButtonController extends EventDispatcher
   {
      
      private static const IS_CONTINUOUS_BUTTON_STATE_ENABLED:Boolean = false;
      
      public static const THROTTLE_STATE_PAUSED:int = 0;
      
      public static const THROTTLE_STATE_NORMAL:int = 1;
      
      public static const THROTTLE_STATE_FAST_FORWARD:int = 2;
      
      public static const NEXT_THROTTLE_STATE:Array = [THROTTLE_STATE_NORMAL,THROTTLE_STATE_FAST_FORWARD,THROTTLE_STATE_NORMAL];
      
      public static const ENTER_PLAY_STATE:String = "EnterPlayState";
      
      public static const FAST_FORWARD_OFF:String = "FastForwardOff";
      
      public static const FAST_FORWARD_ON:String = "FastForwardOn";
      
      public static const OUTPUT_THROTTLE_STATES:Array = ["PAUSED","NORMAL","FAST_FORWARD"];
      
      public static const goButtonClickToPlaySignal:Signal = new Signal();
       
      
      private var _clip:GoButtonClip;
      
      private var _buttonController:ButtonControllerBase;
      
      private var _playButton:MovieClip;
      
      private var _fastFowardButton:MovieClip;
      
      private var _fastFowardOnButton:MovieClip;
      
      private var _throttleState:int = 0;
      
      private var _isEnabled:Boolean = true;
      
      public var isCancelEnabled:Boolean = true;
      
      private var isContinuousEnabled:Boolean = true;
      
      public function GameGoButtonController(param1:GoButtonClip)
      {
         super();
         this._clip = param1;
         this._clip.mouseChildren = false;
         this._playButton = this._clip.playButton;
         this._fastFowardButton = this._clip.fastFowardButton;
         this._fastFowardOnButton = this._clip.fastFowardOnButton;
         this._buttonController = new ButtonControllerBase(this._clip);
         this._buttonController.setOverFunction(this.mouseOver);
         this._buttonController.setOutFunction(this.mouseOut);
         InGameMenu.enableGoButtonSignal.add(this.setEnabled);
         this.reset();
      }
      
      public function reset() : void
      {
         this.setThrottleState(THROTTLE_STATE_PAUSED);
         this._buttonController.setClickFunction(this.onClick);
      }
      
      public function onClick() : void
      {
         if(!this._isEnabled)
         {
            return;
         }
         this.updateToNextThrottleState();
      }
      
      public function updateToNextThrottleState() : void
      {
         var _loc1_:int = NEXT_THROTTLE_STATE[this._throttleState];
         this.setThrottleState(_loc1_);
      }
      
      public function setThrottleState(param1:int) : void
      {
         if(param1 == this._throttleState)
         {
            return;
         }
         var _loc2_:int = this._throttleState;
         this._throttleState = param1;
         switch(param1)
         {
            case THROTTLE_STATE_PAUSED:
               this._playButton.visible = true;
               this._fastFowardButton.visible = false;
               this._fastFowardOnButton.visible = false;
               this.dispatchEvent(new Event(FAST_FORWARD_OFF));
               break;
            case THROTTLE_STATE_NORMAL:
               if(this._playButton.visible)
               {
                  goButtonClickToPlaySignal.dispatch();
               }
               this._playButton.visible = false;
               this._fastFowardButton.visible = true;
               this._fastFowardOnButton.visible = false;
               if(_loc2_ == THROTTLE_STATE_FAST_FORWARD)
               {
                  this.dispatchEvent(new Event(FAST_FORWARD_OFF));
               }
               else if(_loc2_ == THROTTLE_STATE_PAUSED)
               {
                  this.dispatchEvent(new Event(ENTER_PLAY_STATE));
               }
               break;
            case THROTTLE_STATE_FAST_FORWARD:
               this._playButton.visible = false;
               this._fastFowardButton.visible = false;
               this._fastFowardOnButton.visible = true;
               this.dispatchEvent(new Event(FAST_FORWARD_ON));
         }
      }
      
      public function setEnabled(param1:Boolean) : void
      {
         this._isEnabled = param1;
         this._clip.visible = param1;
      }
      
      private function mouseOver() : void
      {
         this._playButton.gotoAndStop("Over");
         this._fastFowardButton.gotoAndStop("Over");
         this._fastFowardOnButton.gotoAndStop("Over");
      }
      
      private function mouseOut() : void
      {
         this._playButton.gotoAndStop("Out");
         this._fastFowardButton.gotoAndStop("Out");
         this._fastFowardOnButton.gotoAndStop("Out");
      }
      
      public function setContinuousEnabled(param1:Boolean) : void
      {
         this.isContinuousEnabled = param1;
      }
      
      public function get throttleState() : int
      {
         return this._throttleState;
      }
   }
}
