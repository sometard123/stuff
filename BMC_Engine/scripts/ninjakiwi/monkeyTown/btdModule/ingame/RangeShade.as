package ninjakiwi.monkeyTown.btdModule.ingame
{
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.towers.RangeMovieClip;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   
   public class RangeShade extends Entity
   {
       
      
      public var range:RangeMovieClip;
      
      public var transform:Matrix;
      
      public var visible:Boolean = true;
      
      public var colorTransform:ColorTransform = null;
      
      public function RangeShade()
      {
         this.range = new RangeMovieClip();
         this.transform = new Matrix();
         super();
      }
      
      public function initialise(param1:TowerDef) : void
      {
         this.range.initialise(param1);
         z = 0.6;
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
