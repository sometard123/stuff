package ninjakiwi.monkeyTown.ui
{
   import assets.town.ToolTipClip;
   import com.greensock.TweenLite;
   import flash.display.MovieClip;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   
   public class ToolTip extends MovieClip
   {
       
      
      private var _clip:ToolTipClip;
      
      private var _stage:Stage;
      
      public var positionOffset:Point;
      
      private var _system:MonkeySystem;
      
      public var scaleWidthByTextWidth:Boolean = false;
      
      public function ToolTip()
      {
         this._clip = new ToolTipClip();
         this.positionOffset = new Point(10,0);
         this._system = MonkeySystem.getInstance();
         super();
         if(stage)
         {
            this.onAddedToStage();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         }
      }
      
      private function onAddedToStage(param1:Event = null) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this._stage = stage;
         this.init();
      }
      
      private function init() : void
      {
         this._clip.message.styleSheet = this._system.styleSheet;
         this._clip.alpha = 0;
         this.mouseEnabled = false;
         this.mouseChildren = false;
      }
      
      public function destroy() : void
      {
         this.deactivateMouseFollow();
         if(this.contains(this._clip))
         {
            removeChild(this.clip);
         }
         this._clip = null;
         this._stage = null;
         this._system = null;
      }
      
      public function set message(param1:String) : void
      {
         if(param1 == null)
         {
            param1 = "...";
         }
         this._clip.message.htmlText = param1;
         this._clip.background.height = int(this._clip.message.textHeight + this._clip.message.y * 2);
         if(this.scaleWidthByTextWidth)
         {
            this._clip.background.width = int(this._clip.message.textWidth + this._clip.message.x * 2.5);
         }
      }
      
      override public function set width(param1:Number) : void
      {
         this._clip.background.width = param1;
         this._clip.message.width = param1 - this._clip.message.y * 2;
         this.message = this._clip.message.htmlText;
      }
      
      public function set stage(param1:Stage) : void
      {
         this._stage = param1;
      }
      
      public function get clip() : ToolTipClip
      {
         return this._clip;
      }
      
      public function activateMouseFollow() : void
      {
         this._stage.addEventListener(MouseEvent.MOUSE_MOVE,this.mouseFollowMouseMoveHandler);
         this.placeOnMouse();
      }
      
      public function deactivateMouseFollow() : void
      {
         if(this._stage != null)
         {
            this._stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.mouseFollowMouseMoveHandler);
         }
      }
      
      private function mouseFollowMouseMoveHandler(param1:MouseEvent) : void
      {
         this.placeOnMouse();
      }
      
      private function placeOnMouse() : void
      {
         if(this._stage.mouseX < this._stage.stageWidth * 0.5)
         {
            this._clip.x = int(mouseX + this.positionOffset.x);
         }
         else
         {
            this._clip.x = int(mouseX - (this._clip.background.width + this.positionOffset.x));
         }
         this._clip.y = int(mouseY + this.positionOffset.y);
         var _loc1_:int = this._stage.stageHeight - this._clip.background.height - this.positionOffset.x;
         if(this._clip.y > _loc1_)
         {
            this._clip.y = _loc1_;
         }
      }
      
      public function hide(param1:Number = 0.5) : void
      {
         var localthis:ToolTip = null;
         var time:Number = param1;
         localthis = this;
         TweenLite.killTweensOf(this._clip);
         TweenLite.to(this._clip,time,{
            "alpha":0,
            "onComplete":function():void
            {
               if(localthis.contains(_clip))
               {
                  localthis.removeChild(_clip);
               }
            }
         });
      }
      
      public function reveal(param1:Number = 0.5) : void
      {
         addChild(this._clip);
         TweenLite.killTweensOf(this._clip);
         TweenLite.to(this._clip,param1,{"alpha":1});
      }
      
      public function setStage(param1:Stage) : void
      {
         this._stage = param1;
      }
   }
}
