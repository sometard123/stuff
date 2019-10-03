package ninjakiwi.monkeyTown.town.gameEvents.boss
{
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.RewardSetBoss;
   
   public class BossMilestoneAwarder
   {
       
      
      private var _rewardSets:Vector.<RewardSetBoss>;
      
      public function BossMilestoneAwarder(param1:Array)
      {
         var _loc3_:Object = null;
         var _loc4_:int = 0;
         var _loc5_:RewardSetBoss = null;
         this._rewardSets = new Vector.<RewardSetBoss>();
         super();
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = param1[_loc2_].rewards;
            _loc4_ = param1[_loc2_].tier;
            _loc5_ = new RewardSetBoss(_loc3_,_loc4_);
            this._rewardSets.push(_loc5_);
            _loc2_++;
         }
      }
      
      public function awardForTier(param1:int) : Boolean
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._rewardSets.length)
         {
            if(this._rewardSets[_loc2_].tier === param1)
            {
               this._rewardSets[_loc2_].award();
               return true;
            }
            _loc2_++;
         }
         return false;
      }
   }
}
