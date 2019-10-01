package ninjakiwi.monkeyTown.btdModule.levels.tiles
{
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class StraightTile extends Tile
   {
       
      
      private var startPoint:Vector2;
      
      private var endPoint:Vector2;
      
      public function StraightTile()
      {
         super();
      }
      
      public function ini_startPoint(param1:Vector2) : StraightTile
      {
         this.startPoint = param1;
         return this;
      }
      
      public function ini_endPoint(param1:Vector2) : StraightTile
      {
         this.endPoint = param1;
         return this;
      }
      
      override public function initialise(param1:Vector.<Tile>) : void
      {
         super.initialise(param1);
         var _loc2_:Number = this.endPoint.x - this.startPoint.x;
         var _loc3_:Number = this.endPoint.y - this.startPoint.y;
         sectionLength = tileLength = Math.sqrt(_loc2_ * _loc2_ + _loc3_ * _loc3_);
         wayPoints = Vector.<Vector2>([this.startPoint,this.endPoint]);
      }
      
      override public function get endAngle() : Number
      {
         return Math.atan2(this.endPoint.y - this.startPoint.y,this.endPoint.x - this.startPoint.x);
      }
      
      override public function get startAngle() : Number
      {
         return Math.atan2(this.startPoint.y - this.endPoint.y,this.startPoint.x - this.endPoint.x);
      }
      
      override public function get startX() : Number
      {
         return this.startPoint.x;
      }
      
      override public function get startY() : Number
      {
         return this.startPoint.y;
      }
      
      override public function get endX() : Number
      {
         return this.endPoint.x;
      }
      
      override public function get endY() : Number
      {
         return this.endPoint.y;
      }
   }
}
