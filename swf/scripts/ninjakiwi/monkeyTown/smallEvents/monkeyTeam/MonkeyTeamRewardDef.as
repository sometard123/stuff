package ninjakiwi.monkeyTown.smallEvents.monkeyTeam
{
   import assets.ui.GenericEventPopupPanelClip;
   import flash.display.DisplayObjectContainer;
   import flash.utils.Timer;
   import ninjakiwi.data.NKDefinition;
   import ninjakiwi.monkeyTown.town.helpFromFriends.CrateManager;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class MonkeyTeamRewardDef extends NKDefinition
   {
      
      protected static const _propertyNames:Array = ["uiRewardIndex","rewardAmount"];
       
      
      public var uiRewardIndex:int = -1;
      
      public var rewardAmount:int = 0;
      
      public function MonkeyTeamRewardDef()
      {
         super();
      }
      
      public function UiRewardIndex(param1:int) : MonkeyTeamRewardDef
      {
         this.uiRewardIndex = param1;
         return this;
      }
      
      public function RewardAmount(param1:int) : MonkeyTeamRewardDef
      {
         this.rewardAmount = param1;
         return this;
      }
   }
}
