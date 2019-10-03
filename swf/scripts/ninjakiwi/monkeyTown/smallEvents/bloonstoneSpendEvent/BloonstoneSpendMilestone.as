package ninjakiwi.monkeyTown.smallEvents.bloonstoneSpendEvent
{
   import ninjakiwi.data.NKDefinition;
   
   public class BloonstoneSpendMilestone extends NKDefinition
   {
      
      protected static const _propertyNames:Array = ["bloonstoneSpendMilestoneDef","hasBeenRewarded","rewardIndex","iteration","spendAmount"];
       
      
      public var bloonstoneSpendMilestoneDef:Object = null;
      
      public var hasBeenRewarded:Boolean = false;
      
      public var rewardIndex:int = -1;
      
      public var iteration:int = 0;
      
      public var spendAmount:int = 0;
      
      public function BloonstoneSpendMilestone()
      {
         super();
      }
      
      public function BloonstoneSpendMilestoneDef(param1:Object) : BloonstoneSpendMilestone
      {
         this.bloonstoneSpendMilestoneDef = param1;
         return this;
      }
      
      public function HasBeenRewarded(param1:Boolean) : BloonstoneSpendMilestone
      {
         this.hasBeenRewarded = param1;
         return this;
      }
      
      public function RewardIndex(param1:int) : BloonstoneSpendMilestone
      {
         this.rewardIndex = param1;
         return this;
      }
      
      public function Iteration(param1:int) : BloonstoneSpendMilestone
      {
         this.iteration = param1;
         return this;
      }
      
      public function SpendAmount(param1:int) : BloonstoneSpendMilestone
      {
         this.spendAmount = param1;
         return this;
      }
   }
}
