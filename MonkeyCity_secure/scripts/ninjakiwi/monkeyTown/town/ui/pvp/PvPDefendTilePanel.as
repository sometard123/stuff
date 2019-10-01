package ninjakiwi.monkeyTown.town.ui.pvp
{
   import assets.ui.DefendPanelClip;
   import assets.ui.SortByDropdownClip;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.Event;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.common.LevelDefData;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.pvp.IncomingRaid;
   import ninjakiwi.monkeyTown.pvp.PvPSignals;
   import ninjakiwi.monkeyTown.pvp.PvPTimerManager;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.helpFromFriends.CrateManager;
   import ninjakiwi.monkeyTown.town.quests.QuestCounter;
   import ninjakiwi.monkeyTown.town.townMap.TrackData;
   import ninjakiwi.monkeyTown.town.townMap.TrackManager;
   import ninjakiwi.monkeyTown.town.ui.TerrainDetail;
   import ninjakiwi.monkeyTown.town.ui.attack.AttackPanelBase;
   import ninjakiwi.monkeyTown.town.ui.attack.crates.CratesTickBoxes;
   import ninjakiwi.monkeyTown.town.ui.avatar.AvatarModule;
   import ninjakiwi.monkeyTown.town.ui.myTrack.MyTrackThumbNailClip;
   import ninjakiwi.monkeyTown.town.ui.terrain.TerrainRestrictionModule;
   import ninjakiwi.monkeyTown.ui.bloonResearchLab.BloonResearchLabState;
   import ninjakiwi.monkeyTown.ui.buttons.TickBox;
   import ninjakiwi.monkeyTown.userServices.kong.Kong;
   import ninjakiwi.monkeyTown.utils.Formator;
   import org.osflash.signals.Signal;
   
   public class PvPDefendTilePanel extends AttackPanelBase
   {
       
      
      private const _clip:DefendPanelClip = new DefendPanelClip();
      
      private const _details:TerrainDetail = new TerrainDetail(this._clip.detailPosition,TerrainDetail.TERRAIN_INFO | TerrainDetail.DIFFICULTY | TerrainDetail.ASSAULT | TerrainDetail.STRONGEST | TerrainDetail.STARTING_CASH);
      
      private const _incomingAttack:Vector.<RaidElement> = new Vector.<RaidElement>();
      
      private const _resourceStore:ResourceStore = ResourceStore.getInstance();
      
      private const _avatarModule:AvatarModule = new AvatarModule(this._clip.avatarModule);
      
      private const _restriction:TerrainRestrictionModule = new TerrainRestrictionModule(this._clip.restrictions);
      
      private const _muteButton:TickBox = new TickBox(this._clip.messageMuteButton);
      
      private var _hardcoreModeTickbox:TickBox;
      
      private var _hardcoreGreyoutPanel:MovieClip;
      
      private var _hardcoreSkull:MovieClip;
      
      private const _crateTickboxes:CratesTickBoxes = new CratesTickBoxes(this._clip.crateTickBoxes);
      
      private var _currentIncomingAttack:RaidElement;
      
      private var _trackThumb:MyTrackThumbNailClip;
      
      public function PvPDefendTilePanel(param1:DisplayObjectContainer, param2:* = null)
      {
         var container:DisplayObjectContainer = param1;
         var mutexGroup:* = param2;
         super(container,this._clip.bonusCashClip,null,this._clip.earnRewardClip,this._clip.cancelButton,this._clip.defendButton);
         this._clip.x = 25;
         this._clip.y = 60;
         this._clip.addChild(this._avatarModule);
         enableDefaultOnResize(this._clip);
         this.addChild(this._clip);
         this._muteButton.changedSignal.add(this.onMessageMuteChanged);
         var isMute:Boolean = Boolean(QuestCounter.getInstance().getCustomValue("MVMMessageMute"));
         if(QuestCounter.getInstance().getCustomValue("MVMMessageMute") == null)
         {
            isMute = false;
         }
         this._muteButton.setTickedWithoutDispatching(isMute);
         PvPSignals.attackExpired.add(function(... rest):void
         {
            hide();
         });
         this._hardcoreModeTickbox = new TickBox(this._clip.hardcoreModeTickbox.tickBox);
         this._hardcoreGreyoutPanel = this._clip.hardcoreModeTickbox.locked;
         this._hardcoreSkull = this._clip.hardcoreModeTickbox.skull;
         this._clip.hardcoreModeTickbox.hardcoreIcons.gotoAndStop(1);
         this.setHardcoreEnabled(true);
         setAutoPlayStopClipsArray([this._clip.bonusCashClip.gem,this._hardcoreSkull]);
         this._hardcoreModeTickbox.changedSignal.add(this.tickBoxStateChangedSignal);
      }
      
      private function tickBoxStateChangedSignal(param1:Boolean) : void
      {
         _earns.setHardcoreState(param1);
      }
      
      private function setHardcoreEnabled(param1:Boolean) : void
      {
         this._hardcoreGreyoutPanel.visible = !param1;
      }
      
      override public function get isHardcore() : Boolean
      {
         return this._hardcoreModeTickbox.ticked;
      }
      
      public function syncToAttack(param1:IncomingRaid, param2:Boolean = false) : void
      {
         var _loc3_:RaidElement = new RaidElement(param1,param2);
         this._incomingAttack.push(_loc3_);
         if(param1.attack.isRevenge == true)
         {
            this._clip.revengeClip.visible = true;
         }
         else
         {
            this._clip.revengeClip.visible = false;
         }
      }
      
      override protected function onOptionChanged() : void
      {
         super.onOptionChanged();
         this._details.setStartingCash(this.getStartingCash(),this.getBonusStartingCash());
      }
      
      override public function reveal(param1:Number = 0.2) : void
      {
         var _loc7_:Object = null;
         var _loc8_:TrackData = null;
         var _loc9_:int = 0;
         if(this._incomingAttack.length <= 0)
         {
            return;
         }
         this.setHardcoreEnabled(ResourceStore.getInstance().townLevel >= Constants.HARDCORE_MODE_MIN_LEVEL);
         this._hardcoreModeTickbox.ticked = false;
         this._currentIncomingAttack = this._incomingAttack.shift();
         _startCashOption.reset();
         if(this._currentIncomingAttack.isIncoming)
         {
            this._clip.incomingTitle.visible = true;
            this._clip.defendTitle.visible = false;
         }
         else
         {
            this._clip.incomingTitle.visible = false;
            this._clip.defendTitle.visible = true;
         }
         var _loc2_:Boolean = QuestCounter.getInstance().getCustomValue("MVMMessageMute");
         if(QuestCounter.getInstance().getCustomValue("MVMMessageMute") == null)
         {
            _loc2_ = false;
         }
         this.updateMessage(_loc2_);
         var _loc3_:Tile = _system.map.tileAt(this._currentIncomingAttack.attack.linkedTile.x,this._currentIncomingAttack.attack.linkedTile.y);
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:int = _system.map.getPVPRank(this._currentIncomingAttack.attack.attack.difficulty,this._resourceStore.townLevel,this._currentIncomingAttack.attack.linkedTile.tile != null?this._currentIncomingAttack.attack.linkedTile.tile.type:"",this._currentIncomingAttack.attack.linkedTile.tile);
         this._restriction.syncTerrainRestrictions(_loc3_);
         if(this._currentIncomingAttack.attack.attack.moreCamos == Constants.LOTS)
         {
            _loc3_.isCamoTile = true;
         }
         else
         {
            _loc3_.isCamoTile = false;
         }
         if(this._currentIncomingAttack.attack.attack.moreRegens == Constants.LOTS)
         {
            _loc3_.isRegenTile = true;
         }
         else
         {
            _loc3_.isRegenTile = false;
         }
         this._details.setDetails(_loc3_,0,this.getStartingCash(),this.getBonusStartingCash());
         this._details.setDifficultyPips(_loc4_);
         this._details.setStrongest(this._currentIncomingAttack.attack.attack.strongestBloonType);
         this._avatarModule.syncPlayer(this._currentIncomingAttack.attack.userID.toString(),this._currentIncomingAttack.attack.cityLevel,this._currentIncomingAttack.attack.clan,this._currentIncomingAttack.attack.sender.honour);
         if(this._currentIncomingAttack.attack != null && this._currentIncomingAttack.attack.attack != null)
         {
            _loc9_ = this._currentIncomingAttack.attack.attack.difficulty;
            _earns.setMessage(_system.map,_loc3_,_loc9_,_system.map.getPVPRank(_loc9_,this._resourceStore.townLevel,_loc3_.type,_loc3_));
         }
         else
         {
            _earns.hideAll();
         }
         if(PvPTimerManager.getInstance().getTimer(this._currentIncomingAttack.attack.attackID) != null)
         {
            this._clip.timeLeftText.text = "( " + Formator.msToHrMin(PvPTimerManager.getInstance().getTimer(this._currentIncomingAttack.attack.attackID).timeLeft * 1000) + " Left )";
         }
         var _loc5_:int = MonkeySystem.getInstance().city.cityIndex;
         var _loc6_:Array = LevelDefData.getLevelDefNamesByTerrain(_loc3_.type,_loc5_);
         if(_loc6_ !== null)
         {
            _loc7_ = LevelDefData.selectRandomTrackByDifficultyBias(_loc6_,_loc3_.trackSelectionBias);
         }
         if(_loc3_.uniqueDataDefinition.trackID != -1 && _loc3_.uniqueDataDefinition.trackClassName != null)
         {
            _loc8_ = TrackManager.getInstance().findTrack(_loc3_.uniqueDataDefinition.trackClassName);
         }
         else
         {
            _loc8_ = TrackManager.getInstance().findTrackByDefName(_loc7_.def);
            _loc3_.uniqueDataDefinition.trackClassName = _loc8_.trackName;
            _loc3_.uniqueDataDefinition.trackID = _loc7_.index;
         }
         if(_loc7_ != null && _loc7_.def != null)
         {
            if(this._trackThumb != null)
            {
               if(this._clip.track_mc.contains(this._trackThumb))
               {
                  this._clip.track_mc.removeChild(this._trackThumb);
               }
               MyTrackThumbNailClip.recycleThumbNail(this._trackThumb);
            }
            this._trackThumb = MyTrackThumbNailClip.getThumbNail(_loc8_,true);
            this._trackThumb.scaleX = 0.9;
            this._trackThumb.scaleY = 0.9;
            if(this._trackThumb != null)
            {
               this._clip.track_mc.addChild(this._trackThumb);
            }
         }
         this.syncCrates();
         if(Kong.isOnKong() && Constants.DISABLE_CRATES_ON_KONG)
         {
            this._clip.crateTickBoxes.visible = false;
         }
         super.reveal(param1);
      }
      
      override protected function onRevealComplete() : void
      {
         super.onRevealComplete();
         PvPSignals.defendTileRevealed.dispatch();
      }
      
      override public function hide(param1:Number = 0.2) : void
      {
         super.hide(param1);
         this._currentIncomingAttack = null;
      }
      
      override public function get cratesTicked() : int
      {
         return this._crateTickboxes.cratesTicked;
      }
      
      override public function get cratesTickedArray() : Array
      {
         return this._crateTickboxes.cratesTickedArray;
      }
      
      private function getStartingCash() : int
      {
         return this._resourceStore.btdStartingMoney;
      }
      
      private function getBonusStartingCash() : int
      {
         return this._resourceStore.btdBonusStartingMoney + _startCashOption.bonusStartingCash;
      }
      
      private function onMessageMuteChanged(param1:Boolean) : void
      {
         QuestCounter.getInstance().setCustomValue("MVMMessageMute",param1);
         this.updateMessage(param1);
      }
      
      private function updateMessage(param1:Boolean) : void
      {
         if(this._currentIncomingAttack != null && this._currentIncomingAttack.attack != null && this._currentIncomingAttack.attack.attack != null)
         {
            if(this._currentIncomingAttack.attack.attack.messageToOpponent == "" || param1 == true)
            {
               this._clip.descriptionTxt.text = LocalisationConstants.STRING_PVP_INCOMING_RAID.split("<player name>").join(this._currentIncomingAttack.attack.name);
            }
            else
            {
               this._clip.descriptionTxt.text = this._currentIncomingAttack.attack.name + ": " + this._currentIncomingAttack.attack.attack.messageToOpponent;
            }
         }
      }
      
      private function syncCrates() : void
      {
         var _loc1_:CrateManager = CrateManager.getInstance();
         this._crateTickboxes.setCratesAvailable(_loc1_.cratesAvailable());
         this._crateTickboxes.setCratesTicked(0);
      }
   }
}

import ninjakiwi.monkeyTown.pvp.IncomingRaid;

class RaidElement
{
    
   
   public var attack:IncomingRaid;
   
   public var isIncoming:Boolean = false;
   
   function RaidElement(param1:IncomingRaid, param2:Boolean = false)
   {
      super();
      this.attack = param1;
      this.isIncoming = param2;
   }
}
