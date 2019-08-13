package ninjakiwi.monkeyTown.ui
{
   import com.greensock.TweenLite;
   import com.lgrey.utils.LGMathUtil;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import ninjakiwi.monkeyTown.ui.button.HoldButtonController;
   import org.osflash.signals.Signal;
   
   public class ScrollBar
   {
       
      
      private var _clip;
      
      private var _contentContainer:DisplayObjectContainer;
      
      private var _contentContainerInitialPosition:Point;
      
      public var fitView:DisplayObject;
      
      public var fitViewPadding:int = 20;
      
      private var _handle:MovieClip;
      
      private var _background:MovieClip;
      
      private var _stage:Stage;
      
      private var _handleOffset:Point;
      
      private var _contentArea:DisplayObject;
      
      public var LGMath:LGMathUtil;
      
      public var extraHeight:int = 0;
      
      public const onScrollSignal:Signal = new Signal();
      
      private var _upScrollButton:HoldButtonController;
      
      private var _downScrollButton:HoldButtonController;
      
      private var _usingMouseWheel:Boolean = false;
      
      private var _mouseWheelSpeed:Number = 0;
      
      private var emptyMovieClip:MovieClip;
      
      public function ScrollBar(param1:*, param2:DisplayObjectContainer, param3:MovieClip, param4:Boolean = false, param5:Number = 1.0)
      {
         this._contentContainerInitialPosition = new Point();
         this._handleOffset = new Point();
         this.LGMath = LGMathUtil.getInstance();
         this.emptyMovieClip = new MovieClip();
         super();
         this._clip = param1;
         this._contentContainer = param2;
         this._contentContainerInitialPosition.x = this._contentContainer.x;
         this._contentContainerInitialPosition.x = this._contentContainer.y;
         this._background = this._clip.background;
         this._handle = this._clip.handle;
         this._usingMouseWheel = param4;
         this._mouseWheelSpeed = param5;
         this._handle.y = this._background.y;
         this._upScrollButton = new HoldButtonController(param1.arrowScrollUp,this.onScrollUp);
         this._downScrollButton = new HoldButtonController(param1.arrowScrollDown,this.onScrollDown);
         param1.arrowScrollUp.gotoAndStop(1);
         param1.arrowScrollDown.gotoAndStop(1);
         this.clampHandle();
         this._contentArea = param3;
         if(this._clip.stage)
         {
            this.onAddedToStage();
         }
         else
         {
            this._clip.addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage,false,0,true);
         }
      }
      
      public function destroy() : void
      {
         this._clip.removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this._handle.removeEventListener(MouseEvent.MOUSE_DOWN,this.handleMouseDownHandler);
         if(this._stage != null)
         {
            this._stage.removeEventListener(MouseEvent.MOUSE_WHEEL,this.handleMouseWheelHandler);
            this._stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.mouseMoveHandler);
            this._stage.removeEventListener(MouseEvent.MOUSE_UP,this.mouseUpHandler);
         }
         if(this._contentContainer.contains(this._clip))
         {
            this._contentContainer.removeChild(this._clip);
         }
         this._clip = null;
         this._contentContainer = null;
         this._contentContainerInitialPosition = null;
         this.fitView = null;
         this._handle = null;
         this._background = null;
         this._stage = null;
         this._upScrollButton.destroy();
         this._upScrollButton = null;
         this._downScrollButton.destroy();
         this._downScrollButton = null;
         this._contentArea = null;
         this.LGMath = null;
         this._handleOffset = null;
         this._contentArea = null;
         this._usingMouseWheel = false;
         this._mouseWheelSpeed = 1;
      }
      
      private function onAddedToStage(param1:Event = null) : void
      {
         this._clip.removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this._stage = this._clip.stage;
         this.enable();
      }
      
      public function enable() : void
      {
         this._handle.addEventListener(MouseEvent.MOUSE_DOWN,this.handleMouseDownHandler,false,0,true);
         if(this._usingMouseWheel)
         {
            this._stage.addEventListener(MouseEvent.MOUSE_WHEEL,this.handleMouseWheelHandler,false,0,true);
         }
      }
      
      private function handleMouseDownHandler(param1:MouseEvent) : void
      {
         this._handleOffset.x = this._handle.parent.mouseX - this._handle.x;
         this._handleOffset.y = this._handle.parent.mouseY - this._handle.y;
         this._stage.addEventListener(MouseEvent.MOUSE_MOVE,this.mouseMoveHandler,false,0,true);
         this._stage.addEventListener(MouseEvent.MOUSE_UP,this.mouseUpHandler,false,0,true);
      }
      
      private function handleMouseWheelHandler(param1:MouseEvent) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         _loc2_ = param1.delta;
         _loc3_ = this.getTrueHeight(this._contentContainer) - this._contentArea.height;
         var _loc4_:Number = _loc2_ * this._mouseWheelSpeed / _loc3_;
         if(_loc2_ != 0)
         {
            this._handle.y = this._handle.y - _loc4_;
            this.syncContentToScrollbar();
         }
      }
      
      private function mouseMoveHandler(param1:MouseEvent) : void
      {
         this._handle.y = this._handle.parent.mouseY - this._handleOffset.y;
         this.clampHandle();
         this.syncContentToScrollbar();
      }
      
      private function mouseUpHandler(param1:MouseEvent) : void
      {
         this._stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.mouseMoveHandler);
         this._stage.removeEventListener(MouseEvent.MOUSE_UP,this.mouseUpHandler);
      }
      
      public function syncContentToScrollbar() : void
      {
         this.clampHandle();
         var _loc1_:Number = (this._handle.y - this._background.y) / (this._background.height - this._handle.height);
         if(isNaN(_loc1_))
         {
            _loc1_ = 0;
         }
         var _loc2_:Number = this.getTrueHeight(this._contentContainer) - this._contentArea.height;
         this._contentContainer.y = int(-_loc2_ * _loc1_ + this._contentArea.y);
         this.onScrollSignal.dispatch();
      }
      
      public function syncScrollbarToContent() : void
      {
         if(this._contentContainer.height <= this._contentArea.height)
         {
            this.hide();
            return;
         }
         this.reveal();
         var _loc1_:Number = -(this._contentContainer.y - this._contentArea.y);
         var _loc2_:Number = this.LGMath.clamp(this.getTrueHeight(this._contentContainer) - this._contentArea.height,0.00001,this.getTrueHeight(this._contentContainer));
         var _loc3_:Number = 1 / _loc2_ * _loc1_;
         _loc3_ = this.LGMath.clamp(_loc3_,0,1);
         var _loc4_:Number = _loc3_ * (this._background.height - this._handle.height);
         this._handle.y = _loc4_;
         this.clampHandle();
      }
      
      private function getTrueHeight(param1:DisplayObjectContainer) : Number
      {
         var _loc2_:Rectangle = param1.getRect(param1);
         return _loc2_.height + _loc2_.y;
      }
      
      private function clampHandle() : void
      {
         var _loc1_:Number = this._background.y;
         var _loc2_:Number = this._background.y + this._background.height - this._handle.height;
         if(this._handle.y < _loc1_)
         {
            this._handle.y = _loc1_;
         }
         if(this._handle.y > _loc2_)
         {
            this._handle.y = _loc2_;
         }
      }
      
      public function reveal(param1:Number = 0.5) : void
      {
         this._clip.mouseEnabled = true;
         this._clip.mouseChildren = true;
         TweenLite.to(this._clip,param1,{"alpha":1});
      }
      
      public function hide(param1:Number = 0.2) : void
      {
         this._clip.mouseEnabled = false;
         this._clip.mouseChildren = false;
         TweenLite.to(this._clip,param1,{"alpha":0});
      }
      
      public function setToTop() : void
      {
         this._contentContainer.y = this._contentArea.y;
         this.fit();
         this._handle.y = -100000;
         this.clampHandle();
      }
      
      public function setToBottom() : void
      {
         this._contentContainer.y = this._contentArea.y - (this.getTrueHeight(this._contentContainer) - this._contentArea.height);
         this.fit();
         this._handle.y = 100000;
         this.clampHandle();
      }
      
      public function fit() : void
      {
         if(!this.fitView)
         {
            return;
         }
         this.syncScrollbarToContent();
         this.syncContentToScrollbar();
      }
      
      public function setScrollPosition(param1:int) : void
      {
         var _loc2_:Number = this.getTrueHeight(this._contentContainer);
         if(param1 > _loc2_ - this._contentArea.height)
         {
            param1 = _loc2_ - this._contentArea.height;
         }
         this._contentContainer.y = -param1 + this._contentArea.y;
         this.syncScrollbarToContent();
         this.onScrollSignal.dispatch();
      }
      
      private function get scrollAmount() : Number
      {
         var _loc1_:Number = (this._background.height - this._handle.height) * 0.9 * this._contentArea.height / this._contentContainer.height;
         return _loc1_;
      }
      
      private function onScrollUp() : void
      {
         this._handle.y = this._handle.y - this.scrollAmount;
         this.syncContentToScrollbar();
      }
      
      private function onScrollDown() : void
      {
         this._handle.y = this._handle.y + this.scrollAmount;
         this.syncContentToScrollbar();
      }
      
      public function get scrollPosition() : Number
      {
         return -(this._contentContainer.y - this._contentArea.y);
      }
   }
}
