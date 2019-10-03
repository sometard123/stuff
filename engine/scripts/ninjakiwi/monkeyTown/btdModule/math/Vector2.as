package ninjakiwi.monkeyTown.btdModule.math
{
   import flash.geom.Matrix;
   
   public class Vector2
   {
       
      
      public var x:Number;
      
      public var y:Number;
      
      public function Vector2(param1:Number = 0, param2:Number = 0)
      {
         super();
         this.x = param1;
         this.y = param2;
      }
      
      public static function add(param1:Vector2, param2:Vector2, param3:Vector2) : Vector2
      {
         param3.x = param1.x + param2.x;
         param3.y = param1.y + param2.y;
         return param3;
      }
      
      public static function subtract(param1:Vector2, param2:Vector2, param3:Vector2) : Vector2
      {
         param3.x = param1.x - param2.x;
         param3.y = param1.y - param2.y;
         return param3;
      }
      
      public static function project(param1:Vector2, param2:Vector2, param3:Vector2) : Vector2
      {
         param3.x = param2.x;
         param3.y = param2.y;
         param3.scaleBy(param1.dot(param2) / param2.dot(param2));
         return param3;
      }
      
      public function X(param1:Number) : Vector2
      {
         this.x = param1;
         return this;
      }
      
      public function Y(param1:Number) : Vector2
      {
         this.y = param1;
         return this;
      }
      
      public function fromPolar(param1:Number, param2:Number) : void
      {
         this.x = Math.cos(param1) * param2;
         this.y = Math.sin(param1) * param2;
      }
      
      public function set rotation(param1:Number) : void
      {
         var _loc2_:Number = this.magnitude;
         this.x = _loc2_ * Math.cos(param1);
         this.y = _loc2_ * Math.sin(param1);
      }
      
      public function get rotation() : Number
      {
         return Math.atan2(this.y,this.x);
      }
      
      public function set magnitude(param1:Number) : void
      {
         if(this.x == 0 && this.y == 0)
         {
            this.x = 1;
            this.y = 0;
            this.scaleBy(param1);
         }
         else
         {
            this.scaleBy(param1 / this.magnitude);
         }
      }
      
      public function scaleBy(param1:Number) : void
      {
         this.x = this.x * param1;
         this.y = this.y * param1;
      }
      
      public function get magnitude() : Number
      {
         return Math.sqrt(this.x * this.x + this.y * this.y);
      }
      
      public function getMagnitudeSquared() : Number
      {
         return this.x * this.x + this.y * this.y;
      }
      
      public function dot(param1:Vector2) : Number
      {
         return param1.x * this.x + param1.y * this.y;
      }
      
      public function cross(param1:Vector2) : Number
      {
         return this.x * param1.y - this.y * param1.x;
      }
      
      public function rotateBy(param1:Number) : void
      {
         param1 = param1 + Math.atan2(this.y,this.x);
         var _loc2_:Number = Math.sqrt(this.x * this.x + this.y * this.y);
         this.x = Math.cos(param1) * _loc2_;
         this.y = Math.sin(param1) * _loc2_;
      }
      
      public function getPerpendicular() : Vector2
      {
         var _loc1_:Vector2 = new Vector2(-this.y,this.x);
         return _loc1_;
      }
      
      public function applyTransform(param1:Matrix) : Vector2
      {
         var _loc2_:Number = this.x;
         this.x = param1.a * _loc2_ + param1.c * this.y + param1.tx;
         this.y = param1.b * _loc2_ + param1.d * this.y + param1.ty;
         return this;
      }
      
      public function angleBetween(param1:Vector2) : Number
      {
         var _loc2_:Number = Math.acos(this.dot(param1) / (this.magnitude * param1.magnitude));
         var _loc3_:Vector2 = this.getPerpendicular();
         var _loc4_:* = _loc3_.dot(param1) > 0;
         if(!_loc4_)
         {
            _loc2_ = -_loc2_;
         }
         return _loc2_;
      }
      
      public function addVec(param1:Vector2) : void
      {
         this.x = this.x + param1.x;
         this.y = this.y + param1.y;
      }
      
      public function normalize(param1:Number = 1.0) : Vector2
      {
         var _loc2_:Number = Math.sqrt(this.x * this.x + this.y * this.y);
         if(_loc2_ == 0)
         {
            this.x = 0;
            this.y = param1;
            return this;
         }
         this.x = this.x / _loc2_ * param1;
         this.y = this.y / _loc2_ * param1;
         return this;
      }
   }
}
