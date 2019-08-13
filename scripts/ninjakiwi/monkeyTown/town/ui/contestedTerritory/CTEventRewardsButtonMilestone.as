package ninjakiwi.monkeyTown.town.ui.contestedTerritory
{
   import assets.ui.EventRewardsButtonMilestone;
   import flash.display.Sprite;
   import ninjakiwi.monkeyTown.achievements.AchievementDefinition;
   import ninjakiwi.monkeyTown.town.gameEvents.ui.OccupationRewardInfoBox;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   
   public class CTEventRewardsButtonMilestone extends Sprite
   {
       
      
      private var _clip:EventRewardsButtonMilestone;
      
      private var _button:ButtonControllerBase;
      
      public function CTEventRewardsButtonMilestone()
      {
         this._clip = new EventRewardsButtonMilestone();
         this._button = new ButtonControllerBase(this._clip);
         super();
         addChild(this._clip);
         this._button.setClickFunction(this.onClick);
      }
      
      private function onClick() : void
      {
         PanelManager.getInstance().showFreePanel(TownUI.getInstance().gameEventsUIManager.ctMilestonesRewardPanel);
      }
   }
}
