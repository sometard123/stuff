package ninjakiwi.monkeyTown.mouseManager
{
   import com.lgrey.vectors.LGVector2D;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldViewSignals;
   
   public class MouseManager
   {
       
      
      private var _target:DisplayObject;
      
      private var _dragStartCameraPosition:LGVector2D;
      
      private var _dragStartMousePosition:LGVector2D;
      
      private var _mousePreviousPosition:LGVector2D;
      
      private var _dragging:Boolean = false;
      
      private var _dragIntertiaEnabled:Boolean = false;
      
      private var _dragIntertia:LGVector2D;
      
      private var _dragInertiaPreviousPosition:LGVector2D;
      
      private var _mouseDownStartPosition:LGVector2D;
      
      private var _locked:Boolean;
      
      public var currentMousePosition:LGVector2D;
      
      private var _draggable:Boolean;
      
      private var _state:Boolean = false;
      
      public var signals:MouseManagerSignals;
      
      public function MouseManager(param1:DisplayObject)
      {
         this._dragStartCameraPosition = new LGVector2D();
         this._dragStartMousePosition = new LGVector2D();
         this._mousePreviousPosition = new LGVector2D();
         this._dragIntertia = new LGVector2D();
         this._dragInertiaPreviousPosition = new LGVector2D();
         this._mouseDownStartPosition = new LGVector2D();
         this.currentMousePosition = new LGVector2D();
         this.signals = new MouseManagerSignals();
         super();
         this._target = param1;
         WorldViewSignals.buildWorldStartSignal.add(this.onReset);
         MonkeyCityMain.globalResetSignal.add(this.onReset);
      }
      
      private function onReset() : void
      {
         this.setMouseActive(true);
         this.endDrag(false);
         this.enableDrag();
         this.unlock();
      }
      
      public function setMouseActive(param1:Boolean) : void
      {
         if(this._locked)
         {
            return;
         }
         if(param1)
         {
            this.enableDrag();
            this.addMouseListeners();
         }
         else
         {
            this.disableDrag();
            this.removeMouseListeners();
         }
         this._state = param1;
      }
      
      public function lock() : void
      {
         this.endDrag(false);
         this._locked = true;
      }
      
      public function unlock() : void
      {
         this._locked = false;
      }
      
      public function tick() : void
      {
         if(this._dragging || this._dragIntertiaEnabled)
         {
            this.updateDrag();
         }
      }
      
      public function get draggable() : Boolean
      {
         return this._draggable;
      }
      
      public function enableDrag() : void
      {
         if(this._locked || this._draggable)
         {
            return;
         }
         this._target.addEventListener(MouseEvent.MOUSE_DOWN,this.dragMouseDownHandler);
         this._target.addEventListener(MouseEvent.MOUSE_UP,this.dragMouseUpHandler);
         this._target.addEventListener(MouseEvent.ROLL_OUT,this.dragMouseUpHandler);
         this._draggable = true;
      }
      
      public function disableDrag() : void
      {
         if(this._locked || !this._draggable)
         {
            return;
         }
         this.endDrag(false);
         this.endInertia();
         this._target.removeEventListener(MouseEvent.MOUSE_DOWN,this.dragMouseDownHandler);
         this._target.removeEventListener(MouseEvent.MOUSE_UP,this.dragMouseUpHandler);
         this._target.removeEventListener(MouseEvent.ROLL_OUT,this.dragMouseUpHandler);
         this._draggable = false;
      }
      
      private function addMouseListeners() : void
      {
         this._target.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownHandler);
         this._target.addEventListener(MouseEvent.MOUSE_MOVE,this.mouseMoveHandler);
         this._target.addEventListener(MouseEvent.MOUSE_UP,this.mouseUpHandler);
         this._target.addEventListener(MouseEvent.CLICK,this.mouseClickHandler);
      }
      
      private function removeMouseListeners() : void
      {
         this._target.removeEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownHandler);
         this._target.removeEventListener(MouseEvent.MOUSE_MOVE,this.mouseMoveHandler);
         this._target.removeEventListener(MouseEvent.MOUSE_UP,this.mouseUpHandler);
         this._target.removeEventListener(MouseEvent.CLICK,this.mouseClickHandler);
      }
      
      private function dragMouseDownHandler(param1:Event) : void
      {
         this._dragging = true;
         this._dragIntertiaEnabled = false;
         this._dragStartMousePosition.x = this._target.mouseX;
         this._dragStartMousePosition.y = this._target.mouseY;
         this.signals.dragStartSignal.dispatch(this._dragStartMousePosition.x,this._dragStartMousePosition.y);
      }
      
      private function dragMouseUpHandler(param1:Event) : void
      {
         if(!this._dragging)
         {
            return;
         }
         this.endDrag();
      }
      
      public function endDrag(param1:Boolean = true) : void
      {
         var _loc2_:Number = NaN;
         this._dragging = false;
         this._dragIntertiaEnabled = param1;
         this._dragIntertia.x = this._target.mouseX - Number(this._mousePreviousPosition.x);
         this._dragIntertia.y = this._target.mouseY - Number(this._mousePreviousPosition.y);
         if(param1)
         {
            _loc2_ = 50;
            if(this._dragIntertia.length > _loc2_)
            {
               this._dragIntertia.setLength(_loc2_);
            }
            this._dragInertiaPreviousPosition = this._mousePreviousPosition.clone();
         }
         else
         {
            this.endInertia();
         }
      }
      
      public function endInertia() : void
      {
         this._dragIntertiaEnabled = false;
         this.signals.dragEndSignal.dispatch(this._dragInertiaPreviousPosition.x,this._dragInertiaPreviousPosition.y);
      }
      
      private function mouseDownHandler(param1:MouseEvent) : void
      {
         this._mouseDownStartPosition.set(this._target.mouseX,this._target.mouseY);
      }
      
      private function mouseUpHandler(param1:MouseEvent) : void
      {
         var _loc2_:Number = new LGVector2D(this._target.mouseX,this._target.mouseY).minus(this._mouseDownStartPosition).length;
         if(_loc2_ < 2)
         {
            this.signals.validClickSignal.dispatch(this._target.mouseX,this._target.mouseY);
         }
      }
      
      private function mouseMoveHandler(param1:MouseEvent) : void
      {
         this.currentMousePosition.x = this._target.mouseX;
         this.currentMousePosition.y = this._target.mouseY;
         this.signals.mouseMoveSignal.dispatch(this._target.mouseX,this._target.mouseY);
      }
      
      private function mouseClickHandler(param1:MouseEvent) : void
      {
      }
      
      private function updateDrag() : void
      {
         var _loc1_:LGVector2D = null;
         _loc1_ = new LGVector2D();
         if(this._dragging)
         {
            _loc1_.x = this._target.mouseX - this._dragStartMousePosition.x;
            _loc1_.y = this._target.mouseY - this._dragStartMousePosition.y;
            this._mousePreviousPosition.x = this._target.mouseX;
            this._mousePreviousPosition.y = this._target.mouseY;
            this.signals.dragUpdateSignal.dispatch(_loc1_.x,_loc1_.y);
         }
         else if(this._dragIntertiaEnabled)
         {
            _loc1_.x = this._dragInertiaPreviousPosition.x - this._dragStartMousePosition.x;
            _loc1_.y = this._dragInertiaPreviousPosition.y - this._dragStartMousePosition.y;
            this._dragInertiaPreviousPosition.x = this._dragInertiaPreviousPosition.x + this._dragIntertia.x;
            this._dragInertiaPreviousPosition.y = this._dragInertiaPreviousPosition.y + this._dragIntertia.y;
            this._dragIntertia.setLength(this._dragIntertia.getLength() * 0.7);
            this.signals.dragUpdateSignal.dispatch(_loc1_.x,_loc1_.y);
            if(this._dragIntertia.getLength() < 1)
            {
               this._dragIntertiaEnabled = false;
               this.signals.dragEndSignal.dispatch(this._dragInertiaPreviousPosition.x,this._dragInertiaPreviousPosition.y);
            }
         }
      }
      
      public function get dragging() : Boolean
      {
         return this._dragging;
      }
      
      public function get dragIntertiaEnabled() : Boolean
      {
         return this._dragIntertiaEnabled;
      }
      
      public function get state() : Boolean
      {
         return this._state;
      }
      
      public function get isDragging() : Boolean
      {
         return this._dragging;
      }
   }
}
