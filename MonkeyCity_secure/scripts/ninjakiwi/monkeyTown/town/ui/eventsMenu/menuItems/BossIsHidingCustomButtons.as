package ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems
{
   import assets.ui.BossIsHidingCustomButtonsClip;
   import flash.utils.setTimeout;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.gameEvents.boss.ui.BossMilestonesRewardPanel;
   import ninjakiwi.monkeyTown.town.gameEvents.ui.GenericEventPopupPanel;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   
   public class BossIsHidingCustomButtons
   {
       
      
      private var _clip:BossIsHidingCustomButtonsClip;
      
      private var _goToBeaconButton:ButtonControllerBase;
      
      private var _rewardsButton:ButtonControllerBase;
      
      public function BossIsHidingCustomButtons()
      {
         this._clip = new BossIsHidingCustomButtonsClip();
         this._goToBeaconButton = new ButtonControllerBase(this._clip.goToBeaconButton);
         this._rewardsButton = new ButtonControllerBase(this._clip.bossRewardsButton);
         super();
         this._goToBeaconButton.setClickFunction(this.onGoToBeaconClicked);
         this._rewardsButton.setClickFunction(this.onRewardsButtonClicked);
      }
      
      private function onRewardsButtonClicked() : void
      {
         var _loc1_:BossMilestonesRewardPanel = TownUI.getInstance().gameEventsUIManager.bossMilestonesPanel;
         PanelManager.getInstance().showFreePanel(_loc1_);
         var _loc2_:GenericEventPopupPanel = TownUI.getInstance().genericEventPopupPanel;
         _loc2_.hide();
      }
      
      private function onGoToBeaconClicked() : void
      {
         var panel:GenericEventPopupPanel = TownUI.getInstance().genericEventPopupPanel;
         panel.hide();
         setTimeout(function():void
         {
            var _loc1_:GameplayEvent = GameEventManager.getInstance().bloonBeaconSystem.eventManager.findCurrentEvent();
            var _loc2_:BloonBeaconEventMenuItem = new BloonBeaconEventMenuItem(_loc1_);
            _loc2_.onOpen();
         },200);
      }
      
      public function get clip() : BossIsHidingCustomButtonsClip
      {
         return this._clip;
      }
   }
}
