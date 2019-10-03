package ninjakiwi.monkeyTown.btdModule.math
{
   public class Intersection
   {
      
      public static var t1:Number = 0;
      
      public static var t2:Number = 0;
       
      
      public function Intersection()
      {
         super();
      }
      
      public static function testCircleCircle(param1:Vector2, param2:Number, param3:Vector2, param4:Number) : Boolean
      {
         var _loc5_:Number = param1.x - param3.x;
         var _loc6_:Number = param1.y - param3.y;
         var _loc7_:Number = _loc5_ * _loc5_ + _loc6_ * _loc6_;
         var _loc8_:Number = param2 + param4;
         return _loc7_ <= _loc8_ * _loc8_;
      }
      
      public static function testLineLine(param1:Vector2, param2:Vector2, param3:Vector2, param4:Vector2) : Boolean
      {
         var _loc5_:Vector2 = Vector2.subtract(param2,param1,new Vector2());
         var _loc6_:Vector2 = Vector2.subtract(param4,param3,new Vector2());
         var _loc7_:Vector2 = Vector2.subtract(param3,param1,new Vector2());
         var _loc8_:Number = _loc5_.cross(_loc6_);
         if(_loc8_ == 0)
         {
            return false;
         }
         t1 = _loc7_.cross(_loc6_) / _loc8_;
         t2 = _loc7_.cross(_loc5_) / _loc8_;
         return t1 >= 0 && t1 <= 1 && t2 >= 0 && t2 <= 1;
      }
      
      public static function testCircleLine(param1:Vector2, param2:Vector2, param3:Vector2, param4:Number) : Boolean
      {
         var _loc5_:Vector2 = param2;
         var _loc6_:Vector2 = Vector2.subtract(param1,param3,new Vector2());
         var _loc7_:Number = _loc5_.dot(_loc5_);
         var _loc8_:Number = 2 * _loc6_.dot(_loc5_);
         var _loc9_:Number = _loc6_.dot(_loc6_) - param4 * param4;
         var _loc10_:Number = _loc8_ * _loc8_ - 4 * _loc7_ * _loc9_;
         if(_loc10_ < 0)
         {
            return false;
         }
         _loc10_ = Math.sqrt(_loc10_);
         t1 = (-_loc8_ + _loc10_) / (2 * _loc7_);
         t2 = (-_loc8_ - _loc10_) / (2 * _loc7_);
         if(t1 * t2 < 0 || t1 >= 0 && t1 <= 1 || t2 >= 0 && t2 <= 1)
         {
            return true;
         }
         return false;
      }
      
      public static function pointInCircle(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : Boolean
      {
         return (param1 - param3) * (param1 - param3) + (param2 - param4) * (param2 - param4) <= param5 * param5;
      }
      
      public static function testCircleAABB(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number) : Boolean
      {
         var _loc8_:Number = Math.abs(param1 - param4 - param6 >> 1);
         var _loc9_:Number = param6 >> 1 + param3;
         if(_loc8_ > _loc9_)
         {
            return false;
         }
         var _loc10_:Number = Math.abs(param2 - param5 - param7 >> 1);
         var _loc11_:Number = param7 >> 1 + param3;
         if(_loc10_ > _loc11_)
         {
            return false;
         }
         if(_loc8_ <= param6 >> 1 || param2 <= param7 >> 1)
         {
            return true;
         }
         var _loc12_:Number = _loc8_ - param6 >> 1;
         var _loc13_:Number = _loc10_ - param7 >> 1;
         return _loc12_ * _loc12_ + _loc13_ * _loc13_ <= param3 * param3;
      }
   }
}
