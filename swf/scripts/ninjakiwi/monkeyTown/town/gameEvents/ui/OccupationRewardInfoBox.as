package ninjakiwi.monkeyTown.town.gameEvents.ui
{
   import assets.ui.MilestoneRewardClip;
   import ninjakiwi.monkeyTown.pvp.Friend;
   import ninjakiwi.monkeyTown.town.ui.pvp.PVPOpponentInfoBox;
   
   public class OccupationRewardInfoBox extends RewardInfoBox
   {
      
      public static const TIME_IN_HOUR_UNIX:Number = 1000 * 60 * 60;
      
      public static const TIME_IN_DAY_UNIX:Number = TIME_IN_HOUR_UNIX * 24;
      
      public static const FIVE_DAYS_UNIX:Number = TIME_IN_DAY_UNIX * 5;
       
      
      private var _clip:MilestoneRewardClip;
      
      public var achievedAtTime:Number = 0;
      
      public function OccupationRewardInfoBox()
      {
         this._clip = new MilestoneRewardClip();
         super(this._clip);
      }
      
      public function setTime(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         this.achievedAtTime = param1;
         if(param1 >= TIME_IN_DAY_UNIX)
         {
            _loc2_ = param1 / TIME_IN_DAY_UNIX;
            this._clip.description.text = _loc2_.toString() + " day";
            if(_loc2_ != 1)
            {
               this._clip.description.text = this._clip.description.text + "s";
            }
         }
         else
         {
            _loc3_ = param1 / TIME_IN_HOUR_UNIX;
            this._clip.description.text = _loc3_.toString() + " hour";
            if(_loc3_ != 1)
            {
               this._clip.description.text = this._clip.description.text + "s";
            }
         }
      }
      
      public function setData(param1:Object, param2:Number, param3:Number) : void
      {
         this.achievedAtTime = param2;
         super.syncToData(param1.rewards);
         this.setTime(this.achievedAtTime);
         setAchieved(param3 >= this.achievedAtTime);
      }
      
      public function setAsLastGoal() : void
      {
         this.setTime(FIVE_DAYS_UNIX);
      }
   }
}
