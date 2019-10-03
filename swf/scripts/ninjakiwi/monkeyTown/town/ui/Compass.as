package ninjakiwi.monkeyTown.town.ui
{
   import com.lgrey.vectors.LGVector2D;
   import flash.display.MovieClip;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import ninjakiwi.monkeyTown.display.tileSystem.Camera;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import org.osflash.signals.Signal;
   
   public class Compass
   {
      
      public static const COMPASS_CLICKED:Signal = new Signal();
       
      
      private var _clip:MovieClip;
      
      private var _system:MonkeySystem;
      
      private var _camera:Camera;
      
      private var _compassPosition:LGVector2D;
      
      private var _hallOffset:LGVector2D;
      
      private var _inertia:Number = 0;
      
      private var _lastRotation:Number = 0;
      
      private var _targetRotation:Number = 0;
      
      private var _stage:Stage;
      
      private var _offset:Point;
      
      public function Compass(param1:MovieClip, param2:Camera)
      {
         var clip:MovieClip = param1;
         var camera:Camera = param2;
         this._system = MonkeySystem.getInstance();
         this._compassPosition = new LGVector2D();
         this._hallOffset = new LGVector2D();
         this._offset = new Point();
         super();
         this._clip = clip;
         this._camera = camera;
         this._compassPosition.set(this._clip.x,this._clip.y);
         this._hallOffset.set(this._system.TOWN_GRID_UNIT_SIZE,0);
         if(this._clip.stage)
         {
            this.onAddedToStage();
         }
         else
         {
            this._clip.addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         }
         this._clip.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):void
         {
            COMPASS_CLICKED.dispatch();
         });
      }
      
      private function onAddedToStage(param1:Event = null) : void
      {
         this._clip.removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this._stage = this._clip.stage;
         this._offset.x = int(this._stage.stageWidth - this._clip.x);
         this._offset.y = int(this._clip.y);
         this._stage.addEventListener(Event.RESIZE,this.resize);
         this.resize();
      }
      
      private function resize(param1:Event = null) : void
      {
         this._clip.x = this._stage.stageWidth - 87;
         if(this._stage.stageWidth > 1000)
         {
            this._clip.y = 10;
         }
         else
         {
            this._clip.y = this._offset.y;
         }
         this._compassPosition.set(this._clip.x,this._clip.y);
      }
      
      public function tick() : void
      {
         var _loc1_:LGVector2D = new LGVector2D();
         _loc1_.set(this._system.TOWN_MAP_PIXEL_WIDTH * 0.5 - this._hallOffset.x - this._camera.x,this._system.TOWN_MAP_PIXEL_HEIGHT * 0.5 - this._hallOffset.y - this._camera.y);
         var _loc2_:LGVector2D = _loc1_.minus(this._compassPosition);
         var _loc3_:LGVector2D = new LGVector2D(0,1);
         _loc3_.setAngleDeg(this._clip.needle.rotation);
         this._inertia = this._inertia + _loc3_.angleTo(_loc2_) * 0.05;
         _loc3_.rotateBy(this._inertia);
         this._inertia = this._inertia * 0.85;
         this._clip.needle.rotation = _loc3_.getAngleDeg();
      }
   }
}
