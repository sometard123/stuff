package ninjakiwi.monkeyTown.ui.button
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class HoldButtonController extends ButtonControllerBase
   {
      
      private static const HOLD_THRESHOLD:int = 0.5 * 1000;
      
      private static const HOLD_TERM:int = 0.05 * 1000;
       
      
      private var _isMouseDown:Boolean = false;
      
      private var _prevTime:int = 0;
      
      private var _currTime:int = 0;
      
      private var _accTime:int = 0;
      
      private var _activeThreshold:int = 500.0;
      
      private var _callback:Function;
      
      public function HoldButtonController(param1:MovieClip, param2:Function = null)
      {
         super(param1);
         this._callback = param2;
         _target.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownHandler,false,0,true);
         _target.addEventListener(MouseEvent.MOUSE_UP,this.mouseUpHandler,false,0,true);
         _target.addEventListener(MouseEvent.MOUSE_OUT,this.mouseUpHandler,false,0,true);
         MonkeyCityMain.globalResetSignal.add(this.resetButton);
      }
      
      override public function destroy() : void
      {
         super.destroy();
         if(_target !== null)
         {
            _target.removeEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownHandler,false);
            _target.removeEventListener(MouseEvent.MOUSE_UP,this.mouseUpHandler,false);
            _target = null;
         }
         this._callback = null;
      }
      
      private function mouseDownHandler(param1:MouseEvent = null) : void
      {
         if(_locked)
         {
            return;
         }
         this._isMouseDown = true;
         this._accTime = 0;
         this._prevTime = getTimer();
         this._activeThreshold = HOLD_THRESHOLD;
         if(this._callback != null)
         {
            this._callback();
         }
         if(MonkeySystem.getInstance().flashStage != null)
         {
            MonkeySystem.getInstance().flashStage.addEventListener(Event.ENTER_FRAME,this.onEnter);
         }
      }
      
      private function mouseUpHandler(param1:MouseEvent = null) : void
      {
         if(_locked)
         {
            return;
         }
         this._isMouseDown = false;
         this.resetButton();
      }
      
      private function resetButton() : void
      {
         if(MonkeySystem.getInstance().flashStage != null)
         {
            MonkeySystem.getInstance().flashStage.removeEventListener(Event.ENTER_FRAME,this.onEnter);
         }
      }
      
      private function onEnter(param1:Event) : void
      {
         if(!this._isMouseDown)
         {
            return;
         }
         this._currTime = getTimer();
         this._accTime = this._accTime + (this._currTime - this._prevTime);
         if(this._accTime > this._activeThreshold)
         {
            this._activeThreshold = HOLD_TERM;
            this._accTime = 0;
            if(this._callback != null)
            {
               this._callback();
            }
         }
         this._prevTime = this._currTime;
      }
   }
}
