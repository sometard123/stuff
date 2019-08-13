package ninjakiwi.monkeyTown.smallEvents.bloonstoneSpendEvent
{
   import ninjakiwi.data.NKDefinition;
   
   public class BloonstoneSpendMilestoneDef extends NKDefinition
   {
      
      protected static const _propertyNames:Array = ["spendAmountBase","rewards"];
       
      
      public var spendAmountBase:int = 0;
      
      public var rewards:BloonstoneSpendRewardDef = null;
      
      public function BloonstoneSpendMilestoneDef()
      {
         super();
      }
      
      public function SpendAmountBase(param1:int) : BloonstoneSpendMilestoneDef
      {
         this.spendAmountBase = param1;
         return this;
      }
      
      public function Rewards(param1:BloonstoneSpendRewardDef) : BloonstoneSpendMilestoneDef
      {
         this.rewards = param1;
         return this;
      }
   }
}
