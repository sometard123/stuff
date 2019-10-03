package ninjakiwi.monkeyTown.utils.widgets
{
   import flash.geom.Point;
   
   public class Wafter
   {
       
      
      private var _counter:Number;
      
      private var _xFactor:Number;
      
      private var _yFactor:Number;
      
      private var _speed:Number = 1;
      
      private var _speedCallibration:Number = 0.025;
      
      private var _increment:Number;
      
      private const _zeroPoint:Point = new Point(0,0);
      
      public var rangeX:Number = 10;
      
      public var rangeY:Number = 10;
      
      public function Wafter()
      {
         this._increment = this._speed * this._speedCallibration;
         super();
         this._counter = Math.random() * int.MAX_VALUE;
         this._xFactor = 0.43 + Math.random() * 0.2;
         this._yFactor = 1.5 + Math.random() * 0.2;
      }
      
      public function update() : void
      {
         this._counter = this._counter + this._increment;
      }
      
      public function waftTarget(param1:*, param2:Point = null, param3:* = null) : void
      {
         if(param3 == null)
         {
            param3 = this._zeroPoint;
         }
         if(param2 == null)
         {
            param2 = this._zeroPoint;
         }
         param1.x = Math.sin(this._counter + param2.x * this._xFactor) * this.rangeX + param3.x;
         param1.y = Math.cos(this._counter + param2.y * this._yFactor) * this.rangeY + param3.y;
      }
      
      public function get speed() : Number
      {
         return this._speed;
      }
      
      public function set speed(param1:Number) : void
      {
         this._speed = param1;
         this._increment = this._speed * this._speedCallibration;
      }
   }
}
