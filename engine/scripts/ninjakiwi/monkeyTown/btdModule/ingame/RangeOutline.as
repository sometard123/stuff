package ninjakiwi.monkeyTown.btdModule.ingame
{
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   
   public class RangeOutline extends Entity
   {
       
      
      public var range:MovieClip;
      
      public var transform:Matrix;
      
      public var visible:Boolean = true;
      
      public var colorTransform:ColorTransform = null;
      
      public function RangeOutline()
      {
         this.range = new MovieClip();
         this.transform = new Matrix();
         super();
      }
      
      public function initialise(param1:TowerDef) : void
      {
         this.range.graphics.clear();
         if(param1 != null)
         {
            this.range.graphics.lineStyle(2,3355443,0.5);
            this.range.graphics.drawCircle(0,0,(param1.rangeOfVisibility < 1000?param1.rangeOfVisibility * Main.instance.scale:50 * Main.instance.scale) + 1);
         }
         z = 10;
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
      
      override public function draw(param1:BitmapData) : void
      {
         if(!this.visible)
         {
            return;
         }
         this.transform.identity();
         this.transform.translate(x * Main.instance.scale,y * Main.instance.scale);
         param1.draw(this.range,this.transform,this.colorTransform,null,null,true);
      }
   }
}
