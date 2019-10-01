package ninjakiwi.monkeyTown.town.tileProps
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import ninjakiwi.monkeyTown.display.bitClip.BitClipCustom;
   
   public class HoseWater extends BitClipCustom
   {
       
      
      public var renderOffset:Point;
      
      public function HoseWater(param1:Boolean = false)
      {
         this.renderOffset = new Point();
         var _loc2_:String = !!param1?"assets.tiles.BananaFarmHoseWaterLeft":"assets.tiles.BananaFarmHoseWaterClip";
         super(_loc2_,1);
      }
      
      override public function render(param1:BitmapData = null, param2:Rectangle = null, param3:Number = 0, param4:Number = 0, param5:Number = 0) : void
      {
         super.render(param1,param2,param3 + this.renderOffset.x,param4 + this.renderOffset.y,param5);
      }
   }
}
