package ninjakiwi.monkeyTown.display.tileSystem
{
   import ninjakiwi.monkeyTown.utils.IntPoint2D;
   
   public class TileDefinition
   {
       
      
      public var dimensions:IntPoint2D;
      
      public var groundVariants:Array;
      
      public var propVariants:Array;
      
      public function TileDefinition()
      {
         this.dimensions = new IntPoint2D(1,1);
         this.groundVariants = [];
         this.propVariants = [];
         super();
      }
      
      public function Dimensions(param1:IntPoint2D) : TileDefinition
      {
         this.dimensions = param1;
         return this;
      }
      
      public function GroundVariants(param1:Array) : TileDefinition
      {
         this.groundVariants = param1;
         return this;
      }
      
      public function PropVariants(param1:Array) : TileDefinition
      {
         this.propVariants = param1;
         return this;
      }
   }
}
