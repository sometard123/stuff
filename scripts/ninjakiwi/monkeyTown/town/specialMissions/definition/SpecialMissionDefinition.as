package ninjakiwi.monkeyTown.town.specialMissions.definition
{
   import ninjakiwi.data.NKDefinition;
   
   public class SpecialMissionDefinition extends NKDefinition
   {
      
      protected static const _propertyNames:Array = ["id","name","description","rewardXP","rewardCash","rewardSpecialItemId","rewardSpecialAgentId","rewardBloonstones","rewardBloontoniums"];
       
      
      public var id:String = "";
      
      public var name:String = "";
      
      public var description:String = "";
      
      public var rewardXP:int = 0;
      
      public var rewardCash:int = 0;
      
      public var rewardSpecialItemId:String = null;
      
      public var rewardSpecialAgentId:String = null;
      
      public var rewardBloonstones:int = 0;
      
      public var rewardBloontoniums:int = 0;
      
      public function SpecialMissionDefinition()
      {
         super();
      }
      
      public function Id(param1:String) : SpecialMissionDefinition
      {
         this.id = param1;
         return this;
      }
      
      public function Name(param1:String) : SpecialMissionDefinition
      {
         this.name = param1;
         return this;
      }
      
      public function Description(param1:String) : SpecialMissionDefinition
      {
         this.description = param1;
         return this;
      }
      
      public function RewardXP(param1:int) : SpecialMissionDefinition
      {
         this.rewardXP = param1;
         return this;
      }
      
      public function RewardCash(param1:int) : SpecialMissionDefinition
      {
         this.rewardCash = param1;
         return this;
      }
      
      public function RewardSpecialItemId(param1:String) : SpecialMissionDefinition
      {
         this.rewardSpecialItemId = param1;
         return this;
      }
      
      public function RewardSpecialAgentId(param1:String) : SpecialMissionDefinition
      {
         this.rewardSpecialAgentId = param1;
         return this;
      }
      
      public function RewardBloonstones(param1:int) : SpecialMissionDefinition
      {
         this.rewardBloonstones = param1;
         return this;
      }
      
      public function RewardBloontoniums(param1:int) : SpecialMissionDefinition
      {
         this.rewardBloontoniums = param1;
         return this;
      }
   }
}
