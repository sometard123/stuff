package com.lgrey.utils
{
   public class RGBA#113
   {
       
      
      public var alpha:uint;
      
      public var red:uint;
      
      public var green:uint;
      
      public var blue:uint;
      
      public function RGBA#113()
      {
         super();
      }
      
      public function fromHex(param1:Number) : RGBA#113
      {
         var _loc2_:RGBA = new RGBA#113();
         this.alpha = param1 >> 24 & 255;
         this.red = param1 >> 16 & 255;
         this.green = param1 >> 8 & 255;
         this.blue = param1 & 255;
         return _loc2_;
      }
      
      public function toHex() : uint
      {
         return this.alpha << 24 | this.red << 16 | this.green << 8 | this.blue;
      }
   }
}
