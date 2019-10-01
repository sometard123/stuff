package ninjakiwi.monkeyTown.btdModule.ingame
{
   import assets.ui.MilestonesUIModuleClip;
   import com.lgrey.events.LGDataEvent;
   import flash.events.Event;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class CTMilestonesUIModule
   {
       
      
      private var _clip:MilestonesUIModuleClip;
      
      private var _rewardsPanelButton:ButtonControllerBase;
      
      private var _milestoneRewardsButton:ButtonControllerBase;
      
      public function CTMilestonesUIModule(param1:MilestonesUIModuleClip)
      {
         super();
         this._clip = param1;
      }
      
      private function init() : void
      {
         this._milestoneRewardsButton = new ButtonControllerBase(this._clip.milestoneRewardsButton);
      }
      
      private function onRewardsButtonClicked() : void
      {
         Main.instance.eventBridge.dispatchEvent(new Event(Constants.REVEAL_MILESTONES_REWARD_PANEL));
      }
      
      private function onSetMilestoneGoal(param1:LGDataEvent) : void
      {
         var _loc2_:int = param1.data.goal;
         this._clip.milestonesGoal.text = _loc2_.toString();
      }
      
      public function set visible(param1:Boolean) : void
      {
         this._clip.visible = param1;
      }
   }
}
