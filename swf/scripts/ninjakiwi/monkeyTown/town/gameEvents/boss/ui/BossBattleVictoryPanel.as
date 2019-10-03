package ninjakiwi.monkeyTown.town.gameEvents.boss.ui
{
   import assets.town.MyTracksPanelClip;
   import assets.ui.BossBattleVictoryPanelClip;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.utils.setTimeout;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.gameEvents.boss.BossData;
   import ninjakiwi.monkeyTown.town.gameEvents.boss.BossEventManager;
   import ninjakiwi.monkeyTown.town.ui.attack.BossRewardsSubpanel;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.BloonBeaconEventMenuItem;
   import ninjakiwi.monkeyTown.town.ui.myTrack.MyTrackThumbNailClip;
   import ninjakiwi.monkeyTown.town.ui.myTrack.MyTracksPageView;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class BossBattleVictoryPanel extends HideRevealView
   {
       
      
      private var _clip:BossBattleVictoryPanelClip;
      
      private var _closeButton:ButtonControllerBase;
      
      private var _okButton:ButtonControllerBase;
      
      private var _goToBeaconButton:ButtonControllerBase;
      
      private var _bossRewardsSubpanel:BossRewardsSubpanel;
      
      private var _avatar:MovieClip = null;
      
      public function BossBattleVictoryPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         this._clip = new BossBattleVictoryPanelClip();
         this._closeButton = new ButtonControllerBase(this._clip.closeButton);
         this._okButton = new ButtonControllerBase(this._clip.okButton);
         this._goToBeaconButton = new ButtonControllerBase(this._clip.goToBeaconButton);
         this._bossRewardsSubpanel = new BossRewardsSubpanel(this._clip.rewardsSubPanel);
         super(param1,param2);
         addChild(this._clip);
         this.init();
      }
      
      private function init() : void
      {
         this._closeButton.setClickFunction(hide);
         this._okButton.setClickFunction(hide);
         this._goToBeaconButton.setClickFunction(this.goToBeacon);
      }
      
      private function goToBeacon() : void
      {
         setTimeout(function():void
         {
            var _loc1_:GameplayEvent = GameEventManager.getInstance().bloonBeaconSystem.eventManager.findCurrentEvent();
            var _loc2_:BloonBeaconEventMenuItem = new BloonBeaconEventMenuItem(_loc1_);
            _loc2_.onOpen();
         },200);
         hide();
      }
      
      override public function reveal(param1:Number = 0.4) : void
      {
         this.syncToEventData();
         super.reveal(param1);
      }
      
      public function syncToEventData() : void
      {
         var _loc1_:BossEventManager = GameEventManager.getInstance().bossEventManager;
         var _loc2_:Object = _loc1_.eventDataForCurrentAttack;
         var _loc3_:GameplayEvent = _loc1_.eventForCurrentAttack;
         var _loc4_:BTDGameRequest = _loc1_.btdGameRequestForCurrentAttack;
         this._bossRewardsSubpanel.build(_loc2_.rewards,_loc4_.bossAttack.bossLevel + 1);
         this._clip.bossLongNameField.text = String(_loc2_.longName).toUpperCase();
         this._clip.bossInfoPane.bossLevelField.text = "Level: " + _loc4_.bossAttack.bossLevel;
         this._clip.winningsPanel.cashRewardField.text = "$" + _loc1_.getCashRewardForLevel(_loc4_.bossAttack.bossLevel);
         this._clip.messageField.text = "Summon " + _loc2_.name + " level " + (_loc4_.bossAttack.bossLevel + 1) + " by taking the Bloon Beacon.";
         var _loc5_:Class = BossData.getInstance().getDeadAvatarClass(_loc3_.dataID);
         if(this._avatar === null || false === this._avatar is _loc5_)
         {
            this._avatar = new _loc5_();
            this._clip.bossInfoPane.avatar.removeChildren();
            this._clip.bossInfoPane.avatar.addChild(this._avatar);
         }
         this._clip.bossInfoPane.bossInfoPane.text = BossData.getInstance().getLosingStatement(_loc3_.dataID);
      }
   }
}
