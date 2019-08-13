package ninjakiwi.monkeyTown.smallEvents.bloonstoneSpendEvent
{
   import ninjakiwi.data.NKDefinition;
   
   public class BloonstoneSpendRewardDef extends NKDefinition
   {
      
      protected static const _propertyNames:Array = ["bloonstones","cash","spikes","boosts","crates","knowledgePack","ancientKnowledgePack"];
       
      
      public var bloonstones:int = 0;
      
      public var cash:int = 0;
      
      public var spikes:int = 0;
      
      public var boosts:int = 0;
      
      public var crates:int = 0;
      
      public var knowledgePack:int = 0;
      
      public var ancientKnowledgePack:int = 0;
      
      public function BloonstoneSpendRewardDef()
      {
         super();
      }
      
      public function Bloonstones(param1:int) : BloonstoneSpendRewardDef
      {
         this.bloonstones = param1;
         return this;
      }
      
      public function Cash(param1:int) : BloonstoneSpendRewardDef
      {
         this.cash = param1;
         return this;
      }
      
      public function Spikes(param1:int) : BloonstoneSpendRewardDef
      {
         this.spikes = param1;
         return this;
      }
      
      public function Boosts(param1:int) : BloonstoneSpendRewardDef
      {
         this.boosts = param1;
         return this;
      }
      
      public function Crates(param1:int) : BloonstoneSpendRewardDef
      {
         this.crates = param1;
         return this;
      }
      
      public function KnowledgePack(param1:int) : BloonstoneSpendRewardDef
      {
         this.knowledgePack = param1;
         return this;
      }
      
      public function AncientKnowledgePack(param1:int) : BloonstoneSpendRewardDef
      {
         this.ancientKnowledgePack = param1;
         return this;
      }
   }
}
