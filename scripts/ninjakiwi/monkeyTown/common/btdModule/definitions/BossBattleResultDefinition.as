package ninjakiwi.monkeyTown.common.btdModule.definitions
{
   import ninjakiwi.data.NKDefinition;
   
   public class BossBattleResultDefinition extends NKDefinition
   {
      
      protected static const _propertyNames:Array = ["remainingHP"];
       
      
      public var remainingHP:int = 0;
      
      public function BossBattleResultDefinition()
      {
         super();
      }
      
      public function RemainingHP(param1:int) : BossBattleResultDefinition
      {
         this.remainingHP = param1;
         return this;
      }
   }
}
