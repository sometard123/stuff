package ninjakiwi.monkeyTown.btdModule.levels.terrain
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.display.MovieClip;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class TerrainType
   {
      
      public static const STANDARD_PRECISION_SCALE:Number = 0.25;
       
      
      private var xScale:Number = 0.25;
      
      private var yScale:Number = 0.25;
      
      public var testMap:BitmapData;
      
      public var inverseTestMap:BitmapData;
      
      private var resultData:BitmapData;
      
      public function TerrainType(param1:MovieClip)
      {
         super();
         this.testMap = new BitmapData(Math.ceil(Main.mapArea.width * STANDARD_PRECISION_SCALE),Math.ceil(Main.mapArea.height * STANDARD_PRECISION_SCALE),true,0);
         this.xScale = this.testMap.width / Main.mapArea.width;
         this.yScale = this.testMap.height / Main.mapArea.height;
         var _loc2_:Matrix = new Matrix();
         _loc2_.translate(param1.x,param1.y);
         _loc2_.scale(this.xScale,this.yScale);
         this.testMap.fillRect(new Rectangle(0,0,this.testMap.width,this.testMap.height),16777215);
         this.testMap.draw(param1,_loc2_);
         this.inverseTestMap = new BitmapData(this.testMap.width,this.testMap.height);
         this.inverseTestMap.fillRect(new Rectangle(0,0,this.testMap.width,this.testMap.height),4294967295);
         this.inverseTestMap.draw(new Bitmap(this.testMap),null,null,BlendMode.ERASE);
         this.resultData = new BitmapData(this.testMap.width,this.testMap.height);
      }
      
      public function isWithin(param1:MovieClip) : Boolean
      {
         var _loc2_:Rectangle = new Rectangle(0,0,this.resultData.width,this.resultData.height);
         this.resultData.fillRect(_loc2_,0);
         var _loc3_:Matrix = new Matrix();
         _loc3_.translate(param1.x,param1.y);
         _loc3_.scale(this.xScale,this.yScale);
         this.resultData.draw(param1,_loc3_);
         var _loc4_:Point = new Point(0,0);
         return !this.inverseTestMap.hitTest(_loc4_,1,this.resultData,_loc4_,1);
      }
      
      public function isOutside(param1:MovieClip) : Boolean
      {
         var _loc2_:Rectangle = new Rectangle(0,0,this.resultData.width,this.resultData.height);
         this.resultData.fillRect(_loc2_,0);
         var _loc3_:Matrix = new Matrix();
         _loc3_.translate(param1.x,param1.y);
         _loc3_.scale(this.xScale,this.yScale);
         this.resultData.draw(param1,_loc3_);
         var _loc4_:Point = new Point(0,0);
         return !this.testMap.hitTest(_loc4_,1,this.resultData,_loc4_,1);
      }
   }
}
