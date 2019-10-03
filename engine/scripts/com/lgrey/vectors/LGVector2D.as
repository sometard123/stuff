package com.lgrey.vectors
{
   import flash.geom.Point;
   
   public class LGVector2D
   {
       
      
      public var x:Number = 0;
      
      public var y:Number = 0;
      
      public function LGVector2D(param1:Number = 0, param2:Number = 0)
      {
         super();
         this.x = param1;
         this.y = param2;
      }
      
      public function initFromPoint(param1:Point) : LGVector2D
      {
         this.x = param1.x;
         this.y = param1.y;
         return this;
      }
      
      public function toPoint(param1:Point) : Point
      {
         return new Point(this.x,this.y);
      }
      
      public function set(param1:Number = 0, param2:Number = 0) : LGVector2D
      {
         this.x = param1;
         this.y = param2;
         return this;
      }
      
      public function reset() : LGVector2D
      {
         this.x = 0;
         this.y = 0;
         return this;
      }
      
      public function add(param1:*) : LGVector2D
      {
         this.x = this.x + param1.x;
         this.y = this.y + param1.y;
         return this;
      }
      
      public function subtract(param1:*) : LGVector2D
      {
         this.x = this.x - param1.x;
         this.y = this.y - param1.y;
         return this;
      }
      
      public function multiply(param1:*) : LGVector2D
      {
         this.x = this.x * param1.x;
         this.y = this.y * param1.y;
         return this;
      }
      
      public function scale(param1:Number) : LGVector2D
      {
         this.x = this.x * param1;
         this.y = this.y * param1;
         return this;
      }
      
      public function multiplyLength(param1:*) : LGVector2D
      {
         this.x = this.x * param1;
         this.y = this.y * param1;
         return this;
      }
      
      public function divideLength(param1:Number) : LGVector2D
      {
         this.x = this.x / param1;
         this.y = this.y / param1;
         return this;
      }
      
      public function give(param1:*) : LGVector2D
      {
         param1.x = this.x;
         param1.y = this.y;
         return this;
      }
      
      public function copy(param1:*) : LGVector2D
      {
         this.x = param1.x;
         this.y = param1.y;
         return this;
      }
      
      public function set angle(param1:Number) : void
      {
         var _loc2_:Number = Math.sqrt(this.x * this.x + this.y * this.y);
         this.x = Math.cos(param1) * _loc2_;
         this.y = Math.sin(param1) * _loc2_;
      }
      
      public function set angleDeg(param1:Number) : void
      {
         var _loc2_:Number = Math.sqrt(this.x * this.x + this.y * this.y);
         param1 = param1 * 0.0174532925;
         this.x = Math.cos(param1) * _loc2_;
         this.y = Math.sin(param1) * _loc2_;
      }
      
      public function setAngle(param1:Number) : LGVector2D
      {
         var _loc2_:Number = Math.sqrt(this.x * this.x + this.y * this.y);
         this.x = Math.cos(param1) * _loc2_;
         this.y = Math.sin(param1) * _loc2_;
         return this;
      }
      
      public function setAngleDeg(param1:Number) : LGVector2D
      {
         var _loc2_:Number = Math.sqrt(this.x * this.x + this.y * this.y);
         param1 = param1 * 0.0174532925;
         this.x = Math.cos(param1) * _loc2_;
         this.y = Math.sin(param1) * _loc2_;
         return this;
      }
      
      public function angleTo(param1:LGVector2D) : Number
      {
         var _loc2_:Number = Math.sqrt(this.x * this.x + this.y * this.y);
         var _loc3_:Number = Math.sqrt(param1.x * param1.x + param1.y * param1.y);
         if(_loc2_ < 1.0e-8 || _loc3_ < 1.0e-8)
         {
            return 0;
         }
         var _loc4_:Number = (this.x * param1.x + this.y * param1.y) / (_loc2_ * _loc3_);
         _loc4_ = _loc4_ > 1?Number(1):Number(_loc4_);
         _loc4_ = _loc4_ < -1?Number(-1):Number(_loc4_);
         var _loc5_:Number = Math.acos(_loc4_);
         var _loc6_:LGVector2D = new LGVector2D(-this.y,this.x);
         var _loc7_:* = _loc6_.x * param1.x + _loc6_.y * param1.y > 0;
         if(!_loc7_)
         {
            _loc5_ = -_loc5_;
         }
         return _loc5_;
      }
      
      public function rotateTowardVector(param1:LGVector2D, param2:Number) : void
      {
         var _loc3_:Number = this.angleTo(param1);
         if(Math.abs(_loc3_) > param2)
         {
            _loc3_ = param2 * (_loc3_ > 0?1:-1);
         }
         this.rotateBy(_loc3_);
      }
      
      public function rotateTowardAngle(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = Math.atan2(this.y,this.x);
         var _loc4_:Number = Math.atan2(Math.sin(param1 - _loc3_),Math.cos(param1 - _loc3_));
         if(Math.abs(_loc4_) > param2)
         {
            _loc4_ = param2 * (_loc4_ > 0?1:-1);
         }
         this.setAngle(_loc3_ + _loc4_);
      }
      
      public function rotateTowardAngleDeg(param1:Number, param2:Number) : void
      {
         param1 = param1 * 0.0174532925;
         param2 = param2 * 0.0174532925;
         var _loc3_:Number = this.getAngle();
         var _loc4_:Number = Math.atan2(Math.sin(param1 - _loc3_),Math.cos(param1 - _loc3_));
         if(Math.abs(_loc4_) > param2)
         {
            _loc4_ = param2 * (_loc4_ > 0?1:-1);
         }
         this.setAngle(_loc3_ + _loc4_);
      }
      
      public function getPerpendicular() : LGVector2D
      {
         return new LGVector2D(-this.y,this.x);
      }
      
      public function rotateBy(param1:Number) : LGVector2D
      {
         var _loc2_:Number = this.getAngle();
         var _loc3_:Number = Math.sqrt(this.x * this.x + this.y * this.y);
         Math.sqrt(this.x * this.x + this.y * this.y);
         this.x = Math.cos(param1 + _loc2_) * _loc3_;
         this.y = Math.sin(param1 + _loc2_) * _loc3_;
         return this;
      }
      
      public function rotateByDeg(param1:Number) : LGVector2D
      {
         param1 = param1 * 0.0174532925;
         this.rotateBy(param1);
         return this;
      }
      
      public function normalise(param1:Number = 1.0) : LGVector2D
      {
         this.normalize(param1);
         return this;
      }
      
      public function normalize(param1:Number = 1.0) : LGVector2D
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
      
      public function get length() : Number
      {
         return Math.sqrt(this.x * this.x + this.y * this.y);
      }
      
      public function getLength() : Number
      {
         return Math.sqrt(this.x * this.x + this.y * this.y);
      }
      
      public function getLengthSquared() : Number
      {
         return this.x * this.x + this.y * this.y;
      }
      
      public function set length(param1:Number) : void
      {
         this.normalize(1);
         this.x = this.x * param1;
         this.y = this.y * param1;
      }
      
      public function setLength(param1:Number) : LGVector2D
      {
         this.normalize(1);
         this.x = this.x * param1;
         this.y = this.y * param1;
         return this;
      }
      
      public function getAngle() : Number
      {
         return Math.atan2(this.y,this.x);
      }
      
      public function getAngleDeg() : Number
      {
         return Math.atan2(this.y,this.x) * 57.2957;
      }
      
      public function dot(param1:*) : Number
      {
         return this.x * param1.x + this.y * param1.y;
      }
      
      public function clone() : LGVector2D
      {
         return new LGVector2D(this.x,this.y);
      }
      
      public function zero() : LGVector2D
      {
         this.x = 0;
         this.y = 0;
         return this;
      }
      
      public function lookAt(param1:*) : LGVector2D
      {
         var _loc2_:LGVector2D = new LGVector2D(param1.x - this.x,param1.y - this.y);
         this.setAngle(_loc2_.getAngle());
         return this;
      }
      
      public function minus(param1:*) : LGVector2D
      {
         return new LGVector2D(this.x - param1.x,this.y - param1.y);
      }
      
      public function times(param1:Number) : LGVector2D
      {
         return new LGVector2D(this.x * param1,this.y * param1);
      }
      
      public function plus(param1:*) : LGVector2D
      {
         return new LGVector2D(this.x + param1.x,this.y + param1.y);
      }
      
      public function isValid() : Boolean
      {
         if(!this.x == this.x || !this.y == this.y)
         {
            return false;
         }
         return true;
      }
      
      public function invert() : LGVector2D
      {
         this.x = -this.x;
         this.y = -this.y;
         return this;
      }
      
      public function toString() : String
      {
         return "[" + this.x + "," + this.y + "]";
      }
   }
}
