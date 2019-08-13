package ninjakiwi.monkeyTown.town.specialItems.definition
{
   public class SpecialItemSaveDefinition
   {
       
      
      public var definitionID:String;
      
      public var inStockCount:int;
      
      public function SpecialItemSaveDefinition()
      {
         super();
      }
      
      public function DefinitionID(param1:String) : SpecialItemSaveDefinition
      {
         this.definitionID = param1;
         return this;
      }
      
      public function InStockCount(param1:int) : SpecialItemSaveDefinition
      {
         this.inStockCount = param1;
         return this;
      }
   }
}
