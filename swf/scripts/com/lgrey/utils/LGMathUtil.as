package com.lgrey.utils
{
   import com.lgrey.vectors.LGVector2D;
   
   public class LGMathUtil
   {
      
      private static var _instance:LGMathUtil;
       
      
      public function LGMathUtil(param1:SingletonEnforcer#1691)
      {
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use LGMathUtil.getInstance() instead of new.");
         }
      }
      
      public static function getInstance() : LGMathUtil
      {
         if(_instance == null)
         {
            _instance = new LGMathUtil(new SingletonEnforcer#1691());
         }
         return _instance;
      }
      
      public function randomMinMax(param1:Number, param2:Number) : Number
      {
         return Math.random() * (param2 - param1) + param1;
      }
      
      public function randomRange(param1:Number, param2:Number) : Number
      {
         return Math.random() * (param2 - param1) + param1;
      }
      
      public function clamp(param1:Number, param2:Number = 0, param3:Number = 1) : Number
      {
         if(param1 < param2)
         {
            param1 = param2;
         }
         if(param1 > param3)
         {
            param1 = param3;
         }
         return param1;
      }
      
      public function isEven(param1:Number) : Boolean
      {
         return !(param1 & 1);
      }
      
      public function thresholdCeil(param1:Number, param2:Number) : Number
      {
         if(param1 % 1 > param2)
         {
            param1 = Math.ceil(param1);
         }
         return param1;
      }
      
      public function upperPowerOfTwo(param1:uint) : uint
      {
         param1--;
         param1 = param1 | param1 >> 1;
         param1 = param1 | param1 >> 2;
         param1 = param1 | param1 >> 4;
         param1 = param1 | param1 >> 8;
         param1 = param1 | param1 >> 16;
         param1++;
         return param1;
      }
      
      public function remapValueToRange(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : Number
      {
         return (param1 - param2) * (param5 - param4) / (param3 - param2) + param4;
      }
      
      public function removeNonNumericChars(param1:String) : String
      {
         var _loc4_:Number = NaN;
         var _loc2_:String = "";
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = param1.charCodeAt(_loc3_);
            if(_loc4_ >= 48 && _loc4_ <= 57 || _loc4_ == 46)
            {
               _loc2_ = _loc2_ + param1.charAt(_loc3_);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function stringToNumber(param1:String) : Number
      {
         return Number(this.removeNonNumericChars(param1));
      }
      
      public function lineIntersectCircleHit(param1:LGVector2D, param2:Number, param3:LGVector2D, param4:LGVector2D) : Hit
      {
         var _loc9_:Number = NaN;
         var _loc10_:Hit = null;
         var _loc5_:Number = (param4.x - param3.x) * (param4.x - param3.x) + (param4.y - param3.y) * (param4.y - param3.y);
         var _loc6_:Number = 2 * ((param4.x - param3.x) * (param3.x - param1.x) + (param4.y - param3.y) * (param3.y - param1.y));
         var _loc7_:Number = param1.x * param1.x + param1.y * param1.y + param3.x * param3.x + param3.y * param3.y - 2 * (param1.x * param3.x + param1.y * param3.y) - param2 * param2;
         var _loc8_:Number = _loc6_ * _loc6_ - 4 * _loc5_ * _loc7_;
         if(_loc8_ < 0)
         {
            return null;
         }
         _loc10_ = new Hit();
         if(_loc8_ == 0)
         {
            _loc9_ = -_loc6_ / (2 * _loc5_);
         }
         else
         {
            _loc9_ = (-_loc6_ - Math.sqrt(_loc6_ * _loc6_ - 4 * _loc5_ * _loc7_)) / (2 * _loc5_);
         }
         _loc10_.x = param3.x + _loc9_ * (param4.x - param3.x);
         _loc10_.y = param3.y + _loc9_ * (param4.y - param3.y);
         _loc10_.d = _loc9_;
         return _loc10_;
      }
   }
}

class SingletonEnforcer#1691
{
    
   
   function SingletonEnforcer#1691()
   {
      super();
   }
}
