package ninjakiwi.monkeyTown.btdModule.effects
{
   import com.lgrey.vectors.LGVector2D;
   import display.Clip;
   import flash.display.BitmapData;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   
   public class Spam extends Entity
   {
       
      
      public var waft:LGVector2D;
      
      protected var _previousFrameIndex:int = 0;
      
      protected var _clip:Clip;
      
      protected var _wasPooled:Boolean = false;
      
      public function Spam(param1:Class = null)
      {
         this.waft = new LGVector2D();
         super();
         if(param1 !== null)
         {
            this._clip = new Clip();
            this._clip.initialise(param1,1);
         }
      }
      
      public function initPooled() : void
      {
         this._wasPooled = true;
         this._clip.gotoAndPlay(0);
         Main.instance.game.addEntity(this);
      }
      
      override public function process(param1:Number) : void
      {
         super.process(param1);
      }
      
      override public function draw(param1:BitmapData) : void
      {
         this._clip.process();
         this.y = this.y + this.waft.y;
         this.x = this.x + this.waft.x;
         if(rotation !== 0)
         {
            this._clip.drawRotated(param1,x,y,rotation);
         }
         else
         {
            this._clip.quickDraw(param1,x,y);
         }
         if(this._clip.frameIndex === this._clip.frameCount - 1)
         {
            this.clean();
            return;
         }
         this._previousFrameIndex = this._clip.frameIndex;
      }
      
      protected function clean() : void
      {
         if(this._wasPooled)
         {
            this._wasPooled = false;
            this._clip.gotoAndStop(0);
            Pool.release(this);
         }
         else
         {
            this._clip = null;
         }
         Main.instance.game.cull(this);
      }
   }
}
