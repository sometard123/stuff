package ninjakiwi.monkeyTown.common.btdModule.definitions
{
   public class BloonWeightsDefinition
   {
       
      
      public var strongestBloonType:String = "";
      
      public var strongestBloonID:int = -1;
      
      public function BloonWeightsDefinition()
      {
         super();
      }
      
      public function StrongestBloonType(param1:String) : BloonWeightsDefinition
      {
         this.strongestBloonType = param1;
         return this;
      }
      
      public function StrongestBloonID(param1:int) : BloonWeightsDefinition
      {
         this.strongestBloonID = param1;
         return this;
      }
   }
}
