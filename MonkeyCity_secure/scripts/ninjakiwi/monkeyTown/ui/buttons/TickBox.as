package ninjakiwi.monkeyTown.ui.buttons
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.osflash.signals.Signal;
   
   public class TickBox
   {
       
      
      private var _clip:MovieClip;
      
      private var _ticked:Boolean = false;
      
      private var _mouseIsOver:Boolean = false;
      
      private var _enabled:Boolean = true;
      
      public const changedSignal:Signal = new Signal(Boolean);
      
      public const clickedSignal:Signal = new Signal(TickBox);
      
      public function TickBox(param1:MovieClip)
      {
         super();
         this._clip = param1;
         this.setup();
      }
      
      public function destroy() : void
      {
         this.disableMouseInteraction();
         this._clip = null;
      }
      
      public function reset() : void
      {
         this._clip.gotoAndStop(1);
         this._ticked = false;
         this._mouseIsOver = false;
         this._enabled = true;
      }
      
      private function setup() : void
      {
         this._clip.gotoAndStop(1);
         this.enableMouseInteraction();
      }
      
      private function enableMouseInteraction() : void
      {
         this._clip.addEventListener(MouseEvent.CLICK,this.onClick);
         this._clip.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this._clip.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      }
      
      private function disableMouseInteraction() : void
      {
         if(this._clip.hasEventListener(MouseEvent.CLICK))
         {
            this._clip.removeEventListener(MouseEvent.CLICK,this.onClick);
         }
         if(this._clip.hasEventListener(MouseEvent.MOUSE_OVER))
         {
            this._clip.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         }
         if(this._clip.hasEventListener(MouseEvent.MOUSE_OUT))
         {
            this._clip.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         }
      }
      
      private function onMouseOut(param1:MouseEvent) : void
      {
         this._mouseIsOver = false;
         this.sync();
      }
      
      private function onMouseOver(param1:MouseEvent) : void
      {
         this._mouseIsOver = true;
         this.sync();
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         this.toggle();
         this.clickedSignal.dispatch(this);
      }
      
      private function toggle() : void
      {
         this.ticked = !this._ticked;
      }
      
      private function sync() : void
      {
         if(this._ticked)
         {
            this._clip.gotoAndStop(3 + int(this._mouseIsOver));
         }
         else
         {
            this._clip.gotoAndStop(1 + int(this._mouseIsOver));
         }
      }
      
      public function get target() : MovieClip
      {
         return this._clip;
      }
      
      public function get ticked() : Boolean
      {
         return this._ticked;
      }
      
      public function set ticked(param1:Boolean) : void
      {
         this._ticked = param1;
         this.sync();
         this.changedSignal.dispatch(this._ticked);
      }
      
      public function setTickedWithoutDispatching(param1:Boolean) : void
      {
         this._ticked = param1;
         this.sync();
      }
      
      public function get enabled() : Boolean
      {
         return this._enabled;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         this._enabled = param1;
         if(this._enabled)
         {
            this.enableMouseInteraction();
            this.sync();
         }
         else
         {
            this.disableMouseInteraction();
            this._clip.gotoAndStop(5);
            this._ticked = false;
         }
      }
   }
}
