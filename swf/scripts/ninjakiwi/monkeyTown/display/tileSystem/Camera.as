package ninjakiwi.monkeyTown.display.tileSystem
{
   import com.lgrey.utils.LGMathUtil;
   import flash.geom.Rectangle;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   
   public class Camera extends Rectangle
   {
       
      
      private const _system:MonkeySystem = MonkeySystem.getInstance();
      
      private const LGMath:LGMathUtil = LGMathUtil.getInstance();
      
      public function Camera()
      {
         super();
      }
      
      public function clamp() : void
      {
         x = int(this.LGMath.clamp(x,0,this._system.TOWN_MAP_PIXEL_WIDTH - this._system.RENDER_SURFACE_WIDTH));
         y = int(this.LGMath.clamp(y,-this._system.HORIZON_HEIGHT,this._system.TOWN_MAP_PIXEL_HEIGHT - this._system.RENDER_SURFACE_HEIGHT + this._system.CLIFFS_HEIGHT));
      }
   }
}
