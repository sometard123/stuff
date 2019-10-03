package ninjakiwi.monkeyTown.btdModule.tutorial
{
   public class InGameTutorialDefinition
   {
       
      
      public var id:String = "";
      
      public var description:String = "";
      
      public var buttonType:String = "none";
      
      public var symbolName:String = "";
      
      public function InGameTutorialDefinition()
      {
         super();
      }
      
      public function Id(param1:String) : InGameTutorialDefinition
      {
         this.id = param1;
         return this;
      }
      
      public function Description(param1:String) : InGameTutorialDefinition
      {
         this.description = param1;
         return this;
      }
      
      public function ButtonType(param1:String) : InGameTutorialDefinition
      {
         this.buttonType = param1;
         return this;
      }
      
      public function SymbolName(param1:String) : InGameTutorialDefinition
      {
         this.symbolName = param1;
         return this;
      }
   }
}
