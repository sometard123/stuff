package ninjakiwi.monkeyTown.common.btdModule.definitions
{
   public class TileUniqueDataDefinition
   {
       
      
      public var numberOfTimesAttacked:int = 0;
      
      public var trackID:int = -1;
      
      public var trackClassName:String = null;
      
      public function TileUniqueDataDefinition()
      {
         super();
      }
      
      public function TrackID(param1:int) : TileUniqueDataDefinition
      {
         this.trackID = param1;
         return this;
      }
   }
}
