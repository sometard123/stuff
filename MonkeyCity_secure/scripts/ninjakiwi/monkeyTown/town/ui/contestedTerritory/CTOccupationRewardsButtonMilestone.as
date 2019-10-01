package ninjakiwi.monkeyTown.town.ui.contestedTerritory
{
   import assets.ui.EventRewardsButtonOccupation;
   import flash.display.Sprite;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   
   public class CTOccupationRewardsButtonMilestone extends Sprite
   {
       
      
      private var _clip:EventRewardsButtonOccupation;
      
      private var _button:ButtonControllerBase;
      
      public function CTOccupationRewardsButtonMilestone()
      {
         this._clip = new EventRewardsButtonOccupation();
         this._button = new ButtonControllerBase(this._clip);
         super();
         addChild(this._clip);
         this._button.setClickFunction(this.onClick);
      }
      
      private function onClick() : void
      {
         PanelManager.getInstance().showFreePanel(TownUI.getInstance().gameEventsUIManager.ctOccupationRewardPanel);
      }
   }
}
