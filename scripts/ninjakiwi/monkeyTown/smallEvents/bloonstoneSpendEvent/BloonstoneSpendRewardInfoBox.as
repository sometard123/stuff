package ninjakiwi.monkeyTown.smallEvents.bloonstoneSpendEvent
{
   import assets.ui.MilestoneRewardClip;
   import ninjakiwi.monkeyTown.town.gameEvents.ui.RewardInfoBox;
   
   public class BloonstoneSpendRewardInfoBox extends RewardInfoBox
   {
       
      
      private var _clip:MilestoneRewardClip;
      
      private var _requiredBloonstones:int = 0;
      
      public function BloonstoneSpendRewardInfoBox()
      {
         this._clip = new MilestoneRewardClip();
         super(this._clip);
      }
      
      public function setData(param1:Object, param2:Number, param3:Boolean) : void
      {
         this.requiredBloonstones = param2;
         super.syncToData(param1);
         setAchieved(param3);
      }
      
      public function get requiredBloonstones() : int
      {
         return this._requiredBloonstones;
      }
      
      public function set requiredBloonstones(param1:int) : void
      {
         this._requiredBloonstones = param1;
         this._clip.description.text = param1.toString();
      }
   }
}
