package ninjakiwi.monkeyTown.town.ui
{
   import assets.ui.PvPWinInfoPanelClip;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import ninjakiwi.monkeyTown.pvp.Friend;
   import ninjakiwi.monkeyTown.pvp.IncomingRaid;
   import ninjakiwi.monkeyTown.pvp.PvPMain;
   import ninjakiwi.monkeyTown.pvp.PvPSignals;
   import ninjakiwi.monkeyTown.smallEvents.miniLandGrab.MiniLandGrab;
   import ninjakiwi.monkeyTown.smallEvents.miniLandGrab.MiniLandGrabRewardDef;
   import ninjakiwi.monkeyTown.smallEvents.monkeyTeam.MonkeyTeam;
   import ninjakiwi.monkeyTown.smallEvents.monkeyTeam.MonkeyTeamRewardDef;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.ui.avatar.AvatarModule;
   import ninjakiwi.monkeyTown.ui.HideRevealViewPopup;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class PvPWinInfoPanel extends HideRevealViewPopup
   {
       
      
      private var _clip:PvPWinInfoPanelClip;
      
      private var _cancelButton:ButtonControllerBase;
      
      private var _revengeButton:ButtonControllerBase;
      
      private var _incomingRaid:IncomingRaid;
      
      private const _avatarModule:AvatarModule = new AvatarModule(this._clip.avatarModule);
      
      private var _honorModule:HonourDisplayModule;
      
      private var _currentMonkey:MovieClip;
      
      private var _opponent:Friend;
      
      private var _miniLandGrabClip:MovieClip;
      
      private var _miniLandGrabClipRewardIcon:MovieClip;
      
      private var _miniLandGrabClipRewardText:TextField;
      
      private var _monkeyTeamsClip:MovieClip;
      
      private var _monkeyTeamsClipRewardIcon:MovieClip;
      
      private var _monkeyTeamsClipRewardText:TextField;
      
      public function PvPWinInfoPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         this._clip = new PvPWinInfoPanelClip();
         this._cancelButton = new ButtonControllerBase(this._clip.cancelButton);
         this._revengeButton = new ButtonControllerBase(this._clip.revengeButton);
         this._currentMonkey = this._clip.monkeySalute;
         this._miniLandGrabClip = this._clip.miniLandGrab;
         this._miniLandGrabClipRewardIcon = this._miniLandGrabClip.icons0;
         this._miniLandGrabClipRewardText = this._miniLandGrabClip.rewardsTxt;
         this._monkeyTeamsClip = this._clip.monkeyTeams;
         this._monkeyTeamsClipRewardIcon = this._monkeyTeamsClip.icons0;
         this._monkeyTeamsClipRewardText = this._monkeyTeamsClip.rewardsTxt;
         super(param1,param2);
         this._clip.addChild(this._avatarModule);
         this._honorModule = new HonourDisplayModule(this._clip.honourSymbol,this._clip.honourField);
         addChild(this._clip);
         isModal = true;
         this._cancelButton.setClickFunction(this.onCancelButtonClicked);
         this._revengeButton.setClickFunction(this.onRevengeButtonClicked);
         setAutoPlayStopClipsArray([this._clip.monkeySalute,this._clip.shoutingMonkey,this._clip.noLivesLostBonus.gem]);
      }
      
      private function onCancelButtonClicked() : void
      {
         hide();
         PvPSignals.revengeOpportunityNotTaken.dispatch();
      }
      
      private function onRevengeButtonClicked() : void
      {
         PvPSignals.requestRevengeAttack.dispatch(this._opponent,this._incomingRaid.attack.attackerCityIndex);
         hide();
      }
      
      public function setSalvagedBloontonium(param1:int = -1, param2:Boolean = true) : void
      {
         this._clip.bloontonium_txt.text = param1 == -1?"":int(param1).toString();
         if(param2)
         {
            this._revengeButton.unlock(1);
         }
         else
         {
            this._revengeButton.lock(3);
         }
      }
      
      public function setHonor(param1:int) : void
      {
         this._honorModule.setHonour(param1);
      }
      
      public function syncOpponent(param1:Friend, param2:IncomingRaid) : void
      {
         this._opponent = param1;
         var _loc3_:int = param2.cityLevel;
         var _loc4_:Object = PvPMain.getMatchingCity(param1.cities,this._incomingRaid.attack.attackerCityIndex);
         var _loc5_:int = _loc4_.honour;
         this._avatarModule.syncPlayer(param1.userID,_loc4_.level,param1.clan,_loc5_);
      }
      
      public function gamePlayComplete(param1:IncomingRaid, param2:Object) : void
      {
         var _loc4_:MiniLandGrab = null;
         var _loc6_:MonkeyTeam = null;
         var _loc7_:MonkeyTeamRewardDef = null;
         this._incomingRaid = param1;
         var _loc3_:Object = param2.monkeyKnowledgeRewards;
         this._clip.pvpDescriptionTxt.text = "Your defenses crushed " + param1.name + "\'s pitiful Bloons!";
         this._clip.revengeText.text = "Attack " + param1.name + " back, and get your revenge!";
         if(int(param2["bloonstonesEarned"]) <= 0)
         {
            this._clip.noLivesLostBonus.visible = false;
         }
         else
         {
            this._clip.noLivesLostBonus.visible = true;
            this.setTextFieldWithValue(this._clip.noLivesLostBonus.bloonStoneBonusTxt,param2["bloonstonesEarned"]);
         }
         this.setTextFieldWithValue(this._clip.victoryBonusPart.moneyBonusTxt,"$" + param2["cashEarned"]);
         this.setTextFieldWithValue(this._clip.victoryBonusPart.xpRewardTxt,param2["xpEarned"]);
         if(param2["didPlayerLoseALife"] != null && param2["didPlayerLoseALife"] == false)
         {
            this._currentMonkey = this._clip.shoutingMonkey;
         }
         else
         {
            this._currentMonkey = this._clip.monkeySalute;
         }
         if(_loc3_ !== null && _loc3_.packs > 0)
         {
            this._clip.monkeyKnowledge.visible = true;
         }
         else
         {
            this._clip.monkeyKnowledge.visible = false;
         }
         _loc4_ = GameEventManager.getInstance().miniLandGrab;
         _loc4_.onTileCaptured();
         var _loc5_:MiniLandGrabRewardDef = _loc4_.givePendingReward(param2);
         if(MiniLandGrab.UI_REWARD_INDEX_NONE == _loc5_.uiRewardIndex || 0 == _loc5_.rewardAmount)
         {
            this._miniLandGrabClip.visible = false;
         }
         else
         {
            this._miniLandGrabClipRewardIcon.gotoAndStop(_loc5_.uiRewardIndex);
            this._miniLandGrabClipRewardText.text = _loc5_.rewardAmount.toString();
            this._miniLandGrabClip.visible = true;
         }
         this._monkeyTeamsClip.visible = false;
         if(param2.canHaveMonkeyTeamReward)
         {
            _loc6_ = GameEventManager.getInstance().monkeyTeam;
            _loc7_ = _loc6_.giveReward(param2);
            if(_loc7_.rewardAmount != 0 && _loc7_.uiRewardIndex != -1)
            {
               this._monkeyTeamsClip.visible = true;
               this._monkeyTeamsClipRewardIcon.gotoAndStop(_loc7_.uiRewardIndex);
               this._monkeyTeamsClipRewardText.text = _loc7_.rewardAmount.toString();
            }
         }
      }
      
      private function setTextFieldWithValue(param1:TextField, param2:String) : void
      {
         if(param1 != null)
         {
            if(param2 != null)
            {
               param1.text = param2;
            }
            else
            {
               param1.text = "0";
            }
         }
      }
      
      override public function reveal(param1:Number = 0.2) : void
      {
         if(this._currentMonkey == null)
         {
            this._currentMonkey = this._clip.monkeySalute;
         }
         if(this._currentMonkey == this._clip.monkeySalute)
         {
            this._clip.monkeySalute.visible = true;
            this._clip.shoutingMonkey.visible = false;
            this._clip.monkeySalute.gotoAndPlay(1);
         }
         else
         {
            this._clip.monkeySalute.visible = false;
            this._clip.shoutingMonkey.visible = true;
            this._clip.shoutingMonkey.gotoAndPlay(1);
         }
         this._currentMonkey = null;
         super.reveal(param1);
      }
   }
}
