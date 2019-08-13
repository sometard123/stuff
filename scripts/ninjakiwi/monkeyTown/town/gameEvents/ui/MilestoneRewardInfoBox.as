package ninjakiwi.monkeyTown.town.gameEvents.ui
{
   import assets.ui.MilestoneRewardClip;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.net.JSONRequest;
   
   public class MilestoneRewardInfoBox extends RewardInfoBox
   {
       
      
      private var _clip:MilestoneRewardClip;
      
      public var achievedAtRound:int = 0;
      
      public function MilestoneRewardInfoBox()
      {
         this._clip = new MilestoneRewardClip();
         super(this._clip);
      }
      
      public function setRound(param1:int) : void
      {
         this.achievedAtRound = param1;
         this._clip.description.text = "Round " + param1.toString();
      }
      
      public function setData(param1:Object, param2:int, param3:int) : void
      {
         super.syncToData(param1.rewards);
         this.achievedAtRound = param2 + param1.roundOffset;
         this.setRound(this.achievedAtRound);
         setAchieved(param3 >= this.achievedAtRound);
      }
      
      public function setAsLastGoal() : void
      {
         this.setRound(100);
      }
   }
}
