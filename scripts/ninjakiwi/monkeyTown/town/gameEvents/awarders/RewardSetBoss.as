package ninjakiwi.monkeyTown.town.gameEvents.awarders
{
   public class RewardSetBoss extends RewardSet
   {
       
      
      public var tier:int = -1;
      
      public function RewardSetBoss(param1:Object, param2:int)
      {
         super(param1);
         this.tier = param2;
      }
   }
}
