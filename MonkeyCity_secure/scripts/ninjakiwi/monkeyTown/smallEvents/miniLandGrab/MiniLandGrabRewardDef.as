package ninjakiwi.monkeyTown.smallEvents.miniLandGrab
{
   import ninjakiwi.data.NKDefinition;
   
   public class MiniLandGrabRewardDef extends NKDefinition
   {
      
      protected static const _propertyNames:Array = ["uiRewardIndex","rewardAmount"];
       
      
      public var uiRewardIndex:int = -1;
      
      public var rewardAmount:int = 0;
      
      public function MiniLandGrabRewardDef()
      {
         super();
      }
      
      public function UiRewardIndex(param1:int) : MiniLandGrabRewardDef
      {
         this.uiRewardIndex = param1;
         return this;
      }
      
      public function RewardAmount(param1:int) : MiniLandGrabRewardDef
      {
         this.rewardAmount = param1;
         return this;
      }
   }
}
