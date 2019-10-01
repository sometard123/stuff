package ninjakiwi.sharedFrameAnalyser
{
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import ninjakiwi.display.gfx.bitClip.PositionedBMD;
   
   public class FrameCacher
   {
      
      protected static const ALPHA_BITS:uint = 4278190080;
      
      protected static const ALPHA_ZERO:uint = 0;
      
      private static var _zeroDeg:Sprite = new Sprite();
      
      protected static var _zeroPoint:Point = new Point(0,0);
       
      
      public var totalFrames:uint;
      
      public var frames:Vector.<PositionedBMD>;
      
      public function FrameCacher(param1:MovieClip)
      {
         var _loc3_:Rectangle = null;
         var _loc4_:Rectangle = null;
         var _loc5_:BitmapData = null;
         super();
         var _loc2_:Number = 0;
         var _loc6_:Matrix = new Matrix();
         _zeroDeg.addChild(param1);
         this.totalFrames = param1.totalFrames;
         this.frames = new Vector.<PositionedBMD>(this.totalFrames);
         var _loc7_:uint = 1;
         while(_loc7_ <= this.frames.length)
         {
            param1.gotoAndStop(_loc7_);
            this.frames[_loc7_ - 1] = this.drawPBMD(param1,_zeroDeg,_loc7_);
            _loc7_++;
         }
         _zeroDeg.removeChild(param1);
      }
      
      protected function drawPBMD(param1:MovieClip, param2:Sprite, param3:uint) : PositionedBMD
      {
         var bmdOut:BitmapData = null;
         var pos:Point = null;
         var tempBMD:BitmapData = null;
         var clipPixRect:Rectangle = null;
         var clip:MovieClip = param1;
         var clipHolder:Sprite = param2;
         var frame:uint = param3;
         clip.gotoAndStop(frame);
         var clipRect:Rectangle = clip.getBounds(clipHolder);
         clipRect.x = Math.floor(clipRect.x);
         clipRect.y = Math.floor(clipRect.y);
         clipRect.width = Math.ceil(clipRect.width);
         clipRect.height = Math.ceil(clipRect.height);
         var drawXform:Matrix = new Matrix();
         drawXform.translate(-clipRect.x,-clipRect.y);
         try
         {
            tempBMD = new BitmapData(clipRect.width + 1,clipRect.height + 1,true,ALPHA_ZERO);
            tempBMD.draw(clip,drawXform);
            clipPixRect = tempBMD.getColorBoundsRect(ALPHA_BITS,ALPHA_ZERO,false);
            bmdOut = new BitmapData(clipPixRect.width + 1,clipPixRect.height + 1,true,ALPHA_ZERO);
            bmdOut.copyPixels(tempBMD,clipPixRect,_zeroPoint);
            pos = clipRect.topLeft.add(clipPixRect.topLeft);
            tempBMD.dispose();
         }
         catch(e:Error)
         {
         }
         var positionedBMDOut:PositionedBMD = new PositionedBMD();
         positionedBMDOut.data = bmdOut;
         positionedBMDOut.pos = pos;
         return positionedBMDOut;
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.frames.length)
         {
            this.frames[_loc1_].data.dispose();
            _loc1_++;
         }
         this.frames.length = 0;
      }
   }
}
