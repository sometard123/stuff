package ninjakiwi.monkeyTown.ui.buttons
{
   import com.greensock.TweenLite;
   import flash.display.MovieClip;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import org.osflash.signals.Signal;
   
   public class ButtonControllerBase extends EventDispatcher
   {
      
      public static const buttonWasClickedSignal:Signal = new Signal();
       
      
      public var data:Object;
      
      protected var _target:MovieClip;
      
      private var _sendControllerToClickFunction:Boolean;
      
      private var _sendControllerToOverFunction:Boolean;
      
      private var _sendControllerToOutFunction:Boolean;
      
      protected var _forwardEventToClickFunction:Boolean = true;
      
      protected var _forwardEventToOutFunction:Boolean = true;
      
      protected var _forwardEventToOverFunction:Boolean = true;
      
      private var _sendControllerToLockedClickFunction:Boolean;
      
      private var _sendControllerToLockedOverFunction:Boolean;
      
      private var _sendControllerToLockedOutFunction:Boolean;
      
      protected var _forwardEventToLockedClickFunction:Boolean = true;
      
      protected var _forwardEventToLockedOutFunction:Boolean = true;
      
      protected var _forwardEventToLockedOverFunction:Boolean = true;
      
      protected var _mouseClickFunction:Function = null;
      
      protected var _mouseOutFunction:Function = null;
      
      protected var _mouseOverFunction:Function = null;
      
      protected var _lockedMouseClickFunction:Function = null;
      
      protected var _lockedMouseOutFunction:Function = null;
      
      protected var _lockedMouseOverFunction:Function = null;
      
      protected var _locked:Boolean = false;
      
      public function ButtonControllerBase(param1:MovieClip)
      {
         super();
         this._target = param1;
         this._target.stop();
         this._target.mouseChildren = false;
         this._target.buttonMode = true;
         this._target.addEventListener(MouseEvent.MOUSE_OUT,this.mouseOutHandler,false,0,true);
         this._target.addEventListener(MouseEvent.MOUSE_OVER,this.mouseOverHandler,false,0,true);
         this._target.addEventListener(MouseEvent.CLICK,this.mouseClickHandler,false,0,true);
      }
      
      public function destroy() : void
      {
         this._target.buttonMode = false;
         if(this._target != null)
         {
            if(this._target.hasEventListener(MouseEvent.MOUSE_OVER))
            {
               this._target.removeEventListener(MouseEvent.MOUSE_OVER,this.mouseOverHandler,false);
            }
            if(this._target.hasEventListener(MouseEvent.MOUSE_OUT))
            {
               this._target.removeEventListener(MouseEvent.MOUSE_OUT,this.mouseOutHandler,false);
            }
            if(this._target.hasEventListener(MouseEvent.CLICK))
            {
               this._target.removeEventListener(MouseEvent.CLICK,this.mouseClickHandler,false);
            }
            this._target = null;
         }
         this.data = null;
         this._mouseClickFunction = null;
         this._mouseOutFunction = null;
         this._mouseOverFunction = null;
         this._lockedMouseClickFunction = null;
         this._lockedMouseOutFunction = null;
         this._lockedMouseOverFunction = null;
      }
      
      public function setClickFunction(param1:Function, param2:Boolean = false, param3:Boolean = false) : ButtonControllerBase
      {
         this._mouseClickFunction = param1;
         this._forwardEventToClickFunction = param2;
         this._sendControllerToClickFunction = param3;
         return this;
      }
      
      public function setOverFunction(param1:Function, param2:Boolean = false, param3:Boolean = false) : ButtonControllerBase
      {
         this._mouseOverFunction = param1;
         this._forwardEventToOverFunction = param2;
         this._sendControllerToOverFunction = param3;
         return this;
      }
      
      public function setOutFunction(param1:Function, param2:Boolean = false, param3:Boolean = false) : ButtonControllerBase
      {
         this._mouseOutFunction = param1;
         this._forwardEventToOutFunction = param2;
         this._sendControllerToOutFunction = param3;
         return this;
      }
      
      public function setLockedClickFunction(param1:Function, param2:Boolean = false, param3:Boolean = false) : ButtonControllerBase
      {
         this._lockedMouseClickFunction = param1;
         this._forwardEventToLockedClickFunction = param2;
         this._sendControllerToLockedClickFunction = param3;
         return this;
      }
      
      public function setLockedOverFunction(param1:Function, param2:Boolean = false, param3:Boolean = false) : ButtonControllerBase
      {
         this._lockedMouseOverFunction = param1;
         this._forwardEventToLockedOverFunction = param2;
         this._sendControllerToLockedOverFunction = param3;
         return this;
      }
      
      public function setLockedOutFunction(param1:Function, param2:Boolean = false, param3:Boolean = false) : ButtonControllerBase
      {
         this._lockedMouseOutFunction = param1;
         this._forwardEventToLockedOutFunction = param2;
         this._sendControllerToLockedOutFunction = param3;
         return this;
      }
      
      public function lock(param1:int = 1) : ButtonControllerBase
      {
         this.gotoAndStop(param1);
         this.locked = true;
         return this;
      }
      
      public function unlock(param1:int = 1) : ButtonControllerBase
      {
         this.gotoAndStop(param1);
         this.locked = false;
         return this;
      }
      
      public function get locked() : Boolean
      {
         return this._locked;
      }
      
      public function set locked(param1:Boolean) : void
      {
         this._locked = param1;
         this.target.useHandCursor = !this._locked;
      }
      
      protected function mouseOverHandler(param1:MouseEvent = null) : void
      {
         if(this._locked)
         {
            this.lockedMouseOverHandler(param1);
            return;
         }
         if(this._mouseOverFunction != null)
         {
            if(this._forwardEventToOverFunction)
            {
               this._mouseOverFunction(param1);
            }
            else if(this._sendControllerToOverFunction)
            {
               this._mouseOverFunction(this);
            }
            else
            {
               this._mouseOverFunction();
            }
         }
         this._target.gotoAndStop(2);
      }
      
      protected function mouseOutHandler(param1:MouseEvent = null) : void
      {
         if(this._locked)
         {
            this.lockedMouseOutHandler(param1);
            return;
         }
         if(this._mouseOutFunction != null)
         {
            if(this._forwardEventToOutFunction)
            {
               this._mouseOutFunction(param1);
            }
            else if(this._sendControllerToOutFunction)
            {
               this._mouseOutFunction(this);
            }
            else
            {
               this._mouseOutFunction();
            }
         }
         this._target.gotoAndStop(1);
      }
      
      public function simulateClick() : void
      {
         this.mouseClickHandler();
      }
      
      protected function mouseClickHandler(param1:MouseEvent = null) : void
      {
         if(this._locked)
         {
            this.lockedMouseClickHandler(param1);
            return;
         }
         if(this._mouseClickFunction != null)
         {
            buttonWasClickedSignal.dispatch();
            if(this._forwardEventToClickFunction)
            {
               this._mouseClickFunction(param1);
            }
            else if(this._sendControllerToClickFunction)
            {
               this._mouseClickFunction(this);
            }
            else
            {
               this._mouseClickFunction();
            }
         }
      }
      
      protected function lockedMouseOverHandler(param1:MouseEvent = null) : void
      {
         if(this._lockedMouseOverFunction != null)
         {
            if(this._forwardEventToLockedOverFunction)
            {
               this._lockedMouseOverFunction(param1);
            }
            else if(this._sendControllerToLockedOverFunction)
            {
               this._lockedMouseOverFunction(this);
            }
            else
            {
               this._lockedMouseOverFunction();
            }
         }
      }
      
      protected function lockedMouseOutHandler(param1:MouseEvent = null) : void
      {
         if(this._lockedMouseOutFunction != null)
         {
            if(this._forwardEventToLockedOutFunction)
            {
               this._lockedMouseOutFunction(param1);
            }
            else if(this._sendControllerToLockedOutFunction)
            {
               this._lockedMouseOutFunction(this);
            }
            else
            {
               this._lockedMouseOutFunction();
            }
         }
      }
      
      protected function lockedMouseClickHandler(param1:MouseEvent = null) : void
      {
         if(this._lockedMouseClickFunction != null)
         {
            if(this._forwardEventToLockedClickFunction)
            {
               this._lockedMouseClickFunction(param1);
            }
            else if(this._sendControllerToLockedClickFunction)
            {
               this._lockedMouseClickFunction(this);
            }
            else
            {
               this._lockedMouseClickFunction();
            }
         }
      }
      
      public function get target() : MovieClip
      {
         return this._target;
      }
      
      public function set target(param1:MovieClip) : void
      {
         this._target = param1;
      }
      
      public function gotoAndStop(param1:Object, param2:String = null) : void
      {
         this._target.gotoAndStop(param1,param2);
      }
      
      public function gotoAndPlay(param1:Object, param2:String = null) : void
      {
         this._target.gotoAndPlay(param1,param2);
      }
      
      public function stop() : void
      {
         this._target.stop();
      }
      
      public function play() : void
      {
         this._target.play();
      }
      
      public function fadeIn(param1:Number = 1) : void
      {
         this.target.visible = true;
         TweenLite.to(this.target,param1,{"alpha":1});
         this.target.mouseEnabled = true;
      }
      
      public function fadeOut(param1:Number = 1) : void
      {
         var time:Number = param1;
         TweenLite.to(this.target,time,{
            "alpha":0,
            "onComplete":function():void
            {
               target.visible = false;
            }
         });
         this.target.mouseEnabled = false;
      }
      
      public function disableMouseInteraction() : void
      {
         this.target.mouseEnabled = false;
         this.target.mouseChildren = false;
      }
      
      public function enableMouseInteraction() : void
      {
         this.target.mouseEnabled = true;
         this.target.mouseChildren = true;
      }
   }
}
