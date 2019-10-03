package ninjakiwi.monkeyTown.town.ui.slider
{
   import flash.display.MovieClip;
   import flash.display.Stage;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import org.osflash.signals.Signal;
   
   public class Slider
   {
      
      public static const HORIZONTAL:String = "horizontal";
      
      public static const VERTICAL:String = "vertical";
       
      
      public var sliderMode:String = "horizontal";
      
      protected var _sliderGuide:MovieClip;
      
      protected var _handle:MovieClip;
      
      private var _handleButtonController:ButtonControllerBase;
      
      private var _initialPosition:Point;
      
      private var _stage:Stage;
      
      private var _min:Number = 0;
      
      private var _max:Number = 1;
      
      protected var _lock:Boolean = false;
      
      public const dragUpdateSignal:Signal = new Signal();
      
      public function Slider(param1:MovieClip, param2:MovieClip, param3:Stage, param4:String = "horizontal")
      {
         super();
         this._sliderGuide = param1;
         this._handle = param2;
         this._stage = param3;
         this._initialPosition = new Point(param2.x,param2.y);
         this.setup();
      }
      
      public function setMin(param1:Number) : void
      {
         this._min = param1;
         this.clampHandle();
      }
      
      public function get min() : Number
      {
         return this._min;
      }
      
      public function setMax(param1:Number) : void
      {
         this._max = param1;
         this.clampHandle();
      }
      
      public function get max() : Number
      {
         return this._max;
      }
      
      private function setup() : void
      {
         this._handleButtonController = new ButtonControllerBase(this._handle);
         this._handle.addEventListener(MouseEvent.MOUSE_DOWN,this.startDrag);
         this.setPosition(0);
      }
      
      public function setPosition(param1:Number) : void
      {
         switch(this.sliderMode)
         {
            case VERTICAL:
               this._handle.x = this._initialPosition.x;
               this._handle.y = this._sliderGuide.y + param1 * this._sliderGuide.height;
               this.clampHandle();
               break;
            default:
               this._handle.x = this._sliderGuide.x + param1 * this._sliderGuide.width;
               this._handle.y = this._initialPosition.y;
               this.clampHandle();
         }
      }
      
      public function getPosition() : Number
      {
         var _loc1_:Number = 0;
         switch(this.sliderMode)
         {
            case VERTICAL:
               _loc1_ = (this._handle.y - this._sliderGuide.y) / this._sliderGuide.height;
               break;
            default:
               _loc1_ = (this._handle.x - this._sliderGuide.x) / this._sliderGuide.width;
         }
         return _loc1_;
      }
      
      private function startDrag(param1:MouseEvent) : void
      {
         if(this._lock == true)
         {
            return;
         }
         this._stage.addEventListener(MouseEvent.MOUSE_UP,this.endDrag);
         switch(this.sliderMode)
         {
            case VERTICAL:
               this._stage.addEventListener(MouseEvent.MOUSE_MOVE,this.updateVerticalDrag);
               break;
            default:
               this._stage.addEventListener(MouseEvent.MOUSE_MOVE,this.updateHorizontalDrag);
         }
      }
      
      protected function updateHorizontalDrag(param1:MouseEvent) : void
      {
         this._handle.x = this._sliderGuide.parent.mouseX;
         this._handle.y = this._initialPosition.y;
         this.clampHandle();
         this.dragUpdateSignal.dispatch();
      }
      
      protected function updateVerticalDrag(param1:MouseEvent) : void
      {
         this._handle.x = this._initialPosition.x;
         this._handle.y = this._sliderGuide.parent.mouseY;
         this.clampHandle();
         this.dragUpdateSignal.dispatch();
      }
      
      protected function clampHandle() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         switch(this.sliderMode)
         {
            case VERTICAL:
               _loc1_ = this._sliderGuide.y + this._min * this._sliderGuide.height;
               _loc2_ = this._sliderGuide.y + this._max * this._sliderGuide.height;
               if(this._handle.y < _loc1_)
               {
                  this._handle.y = _loc1_;
               }
               else if(this._handle.y > _loc2_)
               {
                  this._handle.y = _loc2_;
               }
               break;
            case HORIZONTAL:
            default:
               _loc1_ = this._sliderGuide.x + this._min * this._sliderGuide.width;
               _loc2_ = this._sliderGuide.x + this._max * this._sliderGuide.width;
               if(this._handle.x < _loc1_)
               {
                  this._handle.x = _loc1_;
               }
               else if(this._handle.x > _loc2_)
               {
                  this._handle.x = _loc2_;
               }
         }
      }
      
      private function endDrag(param1:MouseEvent) : void
      {
         if(this._stage.hasEventListener(MouseEvent.MOUSE_OUT))
         {
            this._stage.removeEventListener(MouseEvent.MOUSE_OUT,this.endDrag);
         }
         if(this._stage.hasEventListener(MouseEvent.MOUSE_UP))
         {
            this._stage.removeEventListener(MouseEvent.MOUSE_UP,this.endDrag);
         }
         if(this._stage.hasEventListener(MouseEvent.MOUSE_MOVE))
         {
            this._stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.updateVerticalDrag);
         }
         if(this._stage.hasEventListener(MouseEvent.MOUSE_MOVE))
         {
            this._stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.updateHorizontalDrag);
         }
      }
      
      public function lock() : void
      {
         this._lock = true;
      }
      
      public function removeHandleButton() : void
      {
         if(this._handleButtonController != null)
         {
            this._handleButtonController.destroy();
         }
      }
      
      public function unlock() : void
      {
         this._lock = false;
      }
   }
}
