package ninjakiwi.monkeyTown.dust
{
   import com.codecatalyst.promise.Promise;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.filters.BlurFilter;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class DustSurface extends MovieClip
   {
       
      
      private var _stage:Stage = null;
      
      public var _bitmapData:BitmapData;
      
      public var _bitmap:Bitmap;
      
      public var isOnStage:Boolean = false;
      
      private var _viewport:Rectangle;
      
      private var zeroPoint:Point;
      
      private var blur:BlurFilter;
      
      private var fadeRate:Number = 0.8;
      
      private var colorMatrix:ColorMatrixFilter;
      
      public var useStreams:Boolean = true;
      
      public function DustSurface()
      {
         this._viewport = new Rectangle(0,0,800,600);
         this.zeroPoint = new Point();
         super();
         addEventListener(Event.ADDED_TO_STAGE,this.addedToStageFirstTime);
         addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStage);
      }
      
      private function addedToStageFirstTime(param1:Event) : void
      {
         this.isOnStage = true;
         removeEventListener(Event.ADDED_TO_STAGE,this.addedToStageFirstTime);
         addEventListener(Event.ADDED_TO_STAGE,this.addedToStage);
         this.blur = new BlurFilter(3,3,3);
         this.colorMatrix = new ColorMatrixFilter([1,0,0,0,1,0,1,0,0,1,0,0,1,0,1,0,0,0,this.fadeRate]);
         this.init();
      }
      
      private function init() : void
      {
         this._stage = stage;
         this._stage.addEventListener(Event.RESIZE,this.resize);
         mouseChildren = false;
         mouseEnabled = false;
         parent.mouseChildren = false;
         parent.mouseEnabled = false;
         var _loc1_:Rectangle = new Rectangle(0,0,Math.min(Math.max(this._stage.stageWidth,800),2500),Math.min(Math.max(this._stage.stageHeight,620),2500));
         this._bitmapData = new BitmapData(_loc1_.width,_loc1_.height,true,0);
         this._bitmap = new Bitmap(this._bitmapData);
         addChild(this._bitmap);
      }
      
      public function clear() : void
      {
         if(this.useStreams)
         {
            this._bitmapData.applyFilter(this._bitmapData,this._bitmapData.rect,this.zeroPoint,this.colorMatrix);
         }
         else
         {
            this._bitmapData.fillRect(this._bitmapData.rect,0);
         }
      }
      
      public function updateParticles(param1:Vector.<Particle>) : void
      {
         var _loc2_:Particle = null;
         if(!this.isOnStage)
         {
            return;
         }
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = param1[_loc3_];
            _loc2_.x = _loc2_.x + _loc2_.velocity.x;
            _loc2_.y = _loc2_.y + _loc2_.velocity.y;
            _loc2_.render(this._bitmapData,this._viewport);
            _loc3_++;
         }
      }
      
      private function addedToStage(param1:Event) : void
      {
         this.isOnStage = true;
         this.resize();
      }
      
      private function removedFromStage(param1:Event) : void
      {
         this.isOnStage = false;
         this._bitmapData.dispose();
      }
      
      private function resize(param1:Event = null) : void
      {
         if(!this.isOnStage)
         {
            return;
         }
         var _loc2_:int = this._stage.stageWidth < 800?800:int(this._stage.stageWidth);
         var _loc3_:int = this._stage.stageHeight < 600?600:int(this._stage.stageHeight);
         if(_loc2_ > 2000)
         {
            _loc2_ = 2000;
         }
         if(_loc3_ > 2000)
         {
            _loc3_ = 2000;
         }
         this._bitmapData = new BitmapData(_loc2_,_loc3_,true,0);
         this._bitmap.bitmapData = this._bitmapData;
         this._bitmap.smoothing = false;
         this._viewport.width = this._stage.stageWidth;
         this._viewport.height = this._stage.stageHeight;
      }
   }
}
