package ninjakiwi.monkeyTown.btdModule.math
{
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   
   public class CubicBezier
   {
       
      
      public var a:Vector2;
      
      public var b:Vector2;
      
      public var c:Vector2;
      
      public var d:Vector2;
      
      public function CubicBezier()
      {
         super();
      }
      
      public function initialise(param1:CubicBezierDef) : void
      {
         this.a = param1.a;
         this.b = param1.b;
         this.c = param1.c;
         this.d = param1.d;
      }
      
      public function getValue(param1:Number, param2:Vector2) : Vector2
      {
         var _loc3_:Number = 1 - param1;
         param2.x = this.a.x * _loc3_ * _loc3_ * _loc3_ + this.b.x * 3 * param1 * _loc3_ * _loc3_ + this.c.x * 3 * param1 * param1 * _loc3_ + this.d.x * param1 * param1 * param1;
         param2.y = this.a.y * _loc3_ * _loc3_ * _loc3_ + this.b.y * 3 * param1 * _loc3_ * _loc3_ + this.c.y * 3 * param1 * param1 * _loc3_ + this.d.y * param1 * param1 * param1;
         return param2;
      }
      
      public function get length() : Number
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc1_:Vector2 = Pool.get(Vector2);
         var _loc2_:Vector2 = Pool.get(Vector2);
         var _loc3_:Number = 0;
         var _loc4_:int = 0;
         while(_loc4_ < 999)
         {
            this.getValue(_loc4_ / 1000,_loc1_);
            this.getValue((_loc4_ + 1) / 1000,_loc2_);
            _loc5_ = _loc2_.x - _loc1_.x;
            _loc6_ = _loc2_.y - _loc1_.y;
            _loc3_ = _loc3_ + Math.sqrt(_loc5_ * _loc5_ + _loc6_ * _loc6_);
            _loc4_++;
         }
         Pool.release(_loc1_);
         Pool.release(_loc2_);
         return _loc3_;
      }
   }
}
