package ninjakiwi.monkeyTown.utils
{
   public class IntPoint2D
   {
       
      
      public var x:int;
      
      public var y:int;
      
      public function IntPoint2D(param1:int = 0, param2:int = 0)
      {
         super();
         this.x = param1;
         this.y = param2;
      }
      
      public function set(param1:int = 0, param2:int = 0) : void
      {
         this.x = param1;
         this.y = param2;
      }
      
      public function copy(param1:IntPoint2D) : void
      {
         this.x = param1.x;
         this.y = param1.y;
      }
      
      public function addPoint(param1:IntPoint2D) : void
      {
         this.x = this.x + param1.x;
         this.y = this.y + param1.y;
      }
      
      public function isSameAs(param1:IntPoint2D) : Boolean
      {
         return this.x == param1.x && this.y == param1.y;
      }
      
      public function toString() : String
      {
         return "[ " + this.x + "," + this.y + " ]";
      }
      
      public function clone() : IntPoint2D
      {
         return new IntPoint2D(this.x,this.y);
      }
   }
}
