package ninjakiwi.monkeyTown.utils
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.display.PixelSnapping;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class Flatten
   {
       
      
      public function Flatten()
      {
         super();
      }
      
      public static function flatten(param1:DisplayObjectContainer, param2:Boolean = true, param3:Number = -1, param4:Number = -1, param5:Number = 0, param6:Number = 0) : Bitmap
      {
         var _loc7_:BitmapData = null;
         var _loc8_:Bitmap = null;
         var _loc9_:Rectangle = param1.getRect(param1);
         var _loc10_:Matrix = new Matrix();
         _loc9_.x = _loc9_.x - param6;
         _loc9_.y = _loc9_.y - param6;
         _loc9_.width = _loc9_.width + param6 * 2;
         _loc9_.height = _loc9_.height + param6 * 2;
         _loc10_.translate(-_loc9_.x,-_loc9_.y);
         if(param3 != -1)
         {
            _loc9_.width = param3;
         }
         if(param4 != -1)
         {
            _loc9_.height = param4;
         }
         _loc7_ = new BitmapData(_loc9_.width,_loc9_.height,param2,param5);
         _loc7_.draw(param1,_loc10_,null,null);
         _loc8_ = new Bitmap(_loc7_,PixelSnapping.NEVER,true);
         _loc8_.smoothing = true;
         _loc8_.x = _loc9_.x;
         _loc8_.y = _loc9_.y;
         while(param1.numChildren > 0)
         {
            param1.removeChildAt(0);
         }
         param1.addChild(_loc8_);
         param1.filters = [];
         param1.transform.colorTransform = new ColorTransform();
         return _loc8_;
      }
   }
}
