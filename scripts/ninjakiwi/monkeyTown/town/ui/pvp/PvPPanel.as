package ninjakiwi.monkeyTown.town.ui.pvp
{
   import assets.town.PVPPanelClip;
   import assets.ui.MVMAttackFailedPanelClip;
   import com.greensock.TweenLite;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.friends.FriendsManager;
   import ninjakiwi.monkeyTown.pvp.Friend;
   import ninjakiwi.monkeyTown.pvp.IncomingRaid;
   import ninjakiwi.monkeyTown.pvp.OutgoingAttack;
   import ninjakiwi.monkeyTown.pvp.PvPClient;
   import ninjakiwi.monkeyTown.pvp.PvPMain;
   import ninjakiwi.monkeyTown.pvp.PvPSignals;
   import ninjakiwi.monkeyTown.pvp.PvPTimerManager;
   import ninjakiwi.monkeyTown.sound.MCSound;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.data.load.UserDataLoader;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldViewSignals;
   import ninjakiwi.monkeyTown.town.ui.HonourDisplayModule;
   import ninjakiwi.monkeyTown.town.ui.InfoBoxBase;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.town.ui.avatar.AvatarModule;
   import ninjakiwi.monkeyTown.ui.HideRevealViewBottomUIPanel;
   import ninjakiwi.monkeyTown.ui.PvPNoMatchedOpponentFoundPanel;
   import ninjakiwi.monkeyTown.ui.ScrollBar;
   import ninjakiwi.monkeyTown.ui.ToolTip;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   import ninjakiwi.monkeyTown.userServices.kong.Kong;
   import ninjakiwi.monkeyTown.utils.Formator;
   import ninjakiwi.sharedFrameAnalyser.AnimationSharedFramesMap;
   import org.osflash.signals.Signal;
   
   public class PvPPanel extends HideRevealViewBottomUIPanel
   {
      
      private static const Y_STEP:int = 50;
      
      public static var lastQuickmatchOpponentID:String = null;
       
      
      private var _clip:PVPPanelClip;
      
      private var _playerMask:MovieClip;
      
      private var _raidMask:MovieClip;
      
      private var _opponentContainer:Sprite;
      
      private var _raidContainer:Sprite;
      
      private var _friends:Array;
      
      private var _friendsWithCities:Array;
      
      private var _friendsWithoutCities:Array;
      
      private var _incomingRaids:Array;
      
      protected var _infoBoxes:Array;
      
      private var _opponentScrollBar:ScrollBar;
      
      private var _raidsScrollBar:ScrollBar;
      
      private var _sortByDropdown:SortByDropdown;
      
      private const _smallQuickPlayButton:ButtonControllerBase = new ButtonControllerBase(this._clip.quickMatchSmallButton);
      
      private const _quickPlayButton:ButtonControllerBase = new ButtonControllerBase(this._clip.quickMatchDisplayClip.quickPlayButton);
      
      private const _attackFriendButton:ButtonControllerBase = new ButtonControllerBase(this._clip.quickMatchDisplayClip.attackFriendButton);
      
      private var _attackButton:ButtonControllerBase;
      
      private var _defendButton:ButtonControllerBase;
      
      private var _refreshButton:ButtonControllerBase;
      
      private var _pendingOutgoingAttacksButton:ButtonControllerBase;
      
      private var _pendingIncomingAttacksButton:ButtonControllerBase;
      
      private var _battleHistoryButton:ButtonControllerBase;
      
      private var _currentOpponentView:Array;
      
      private var _currentPendingAttackTypeView:Array;
      
      private var _battleHistoryPanel:BattleHistoryPanel;
      
      private var _currentSortType:String = "Name";
      
      private var boxDataLoader:UserDataLoader;
      
      private const _resourceStore:ResourceStore = ResourceStore.getInstance();
      
      public const attackTargetSelectedSignal:Signal = new Signal(Friend);
      
      public const incomingRaidSelectedSignal:Signal = new Signal(IncomingRaid);
      
      public const battleHistoryRequestedSignal:Signal = new Signal();
      
      public const raidSignal:Signal = new Signal();
      
      private var _tooltip:ToolTip;
      
      private var _pvpNoMatchedOpponentFoundPanel:PvPNoMatchedOpponentFoundPanel;
      
      private var _dataHasBeenInitialised:Boolean = false;
      
      private var _scrollTimeout:uint = 0;
      
      private var _quickMatchAttempts:int = 0;
      
      private var _quickMatchAttemptTimestamp:Number = 0;
      
      private const MAX_QUICKMATCH_TIME:Number = 0;
      
      private const MIN_QUICKMATCH_ATTEMPTS:Number = 0;
      
      private var _isBroadQuickMatchSearch:Boolean = false;
      
      private var _selectedRaidPlayername:String = null;
      
      private var _selectedOpponentPlayername:String = null;
      
      private var _friendsListIsVisible:Boolean = false;
      
      private var _timeOfLastReveal:Number = 0;
      
      public function PvPPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         this._clip = new PVPPanelClip();
         this._playerMask = this._clip.playerMask;
         this._raidMask = this._clip.raidMask;
         this._opponentContainer = new Sprite();
         this._raidContainer = new Sprite();
         this._friends = [];
         this._friendsWithCities = [];
         this._friendsWithoutCities = [];
         this._incomingRaids = [];
         this._infoBoxes = [];
         this._sortByDropdown = new SortByDropdown(this._clip.sortByDropdown);
         this._attackButton = new ButtonControllerBase(this._clip.attackButton);
         this._defendButton = new ButtonControllerBase(this._clip.defendButton);
         this._refreshButton = new ButtonControllerBase(this._clip.refreshButton);
         this._pendingOutgoingAttacksButton = new ButtonControllerBase(this._clip.pendingOutgoingAttacksButton);
         this._pendingIncomingAttacksButton = new ButtonControllerBase(this._clip.pendingIncomingAttacksButton);
         this._battleHistoryButton = new ButtonControllerBase(this._clip.battleHistoryButton);
         this._currentOpponentView = this._friends;
         this._currentPendingAttackTypeView = [];
         this.boxDataLoader = UserDataLoader.getInstance();
         super(param1,param2);
         addChild(this._clip);
         isModal = true;
         this.setup();
      }
      
      private function setup() : void
      {
         this._clip.viewRegion.visible = false;
         this._opponentContainer.x = this._playerMask.x;
         this._opponentContainer.y = this._playerMask.y;
         this._opponentContainer.mask = this._playerMask;
         this._clip.listContainer.addChild(this._opponentContainer);
         this._raidContainer.x = this._raidMask.x;
         this._raidContainer.y = this._raidMask.y;
         this._raidContainer.mask = this._raidMask;
         this._clip.listContainer.addChild(this._raidContainer);
         this._clip.pacifistModeIcon.gotoAndStop(2);
         PvPSignals.updatePacifistModeUI.add(this.onPacifistModeChanged);
         this._battleHistoryPanel = new BattleHistoryPanel(this);
         if(!Constants.USE_DEV_MAGIC)
         {
            this._clip.refreshButton.visible = false;
         }
         else
         {
            this._refreshButton.setClickFunction(PvPSignals.requestRefeshPvPData.dispatch);
         }
         InfoBoxBase.selectionMadeSignal.add(this.onInfoBoxSelectionMadeSignal);
         WorldViewSignals.buildWorldStartSignal.add(this.clear);
         enableDefaultOnResize(this._clip);
         enableCloseButton(this._clip.closeButton);
         this._opponentScrollBar = new ScrollBar(this._clip.opponentScrollbar,this._opponentContainer,this._playerMask,true,Constants.MOUSE_WHEEL_SCROLL_SPEED);
         this._raidsScrollBar = new ScrollBar(this._clip.raidScrollbar,this._raidContainer,this._raidMask,true,15);
         this._opponentScrollBar.onScrollSignal.add(this.onOpponentScrollSignal);
         this._pendingIncomingAttacksButton.target.visible = false;
         this._pendingOutgoingAttacksButton.target.visible = false;
         this._pendingIncomingAttacksButton.setClickFunction(this.onShowPendingIncomingButtonClicked,false,false);
         this._pendingOutgoingAttacksButton.setClickFunction(this.onShowPendingOutgoingButtonClicked,false,false);
         this._sortByDropdown.sortBySignal.add(this.onSortBySignal);
         this._attackButton.setClickFunction(this.onAttackButtonClicked);
         this._defendButton.setClickFunction(this.onDefendButtonClicked);
         this._battleHistoryButton.setClickFunction(this.onBattleHistoryButtonClick);
         this._attackFriendButton.setClickFunction(this.onAttackFriend);
         this.clearSelections();
         this._pendingIncomingAttacksButton.lock(3);
         PvPSignals.pvpDataUpdatedSignal.add(this.onPvPDataUpdatedSignal);
         this._smallQuickPlayButton.setClickFunction(this.onQuickMatchButtonClicked);
         this._quickPlayButton.setClickFunction(this.onQuickMatchButtonClicked);
         this.setUpTooltip();
         this._pvpNoMatchedOpponentFoundPanel = new PvPNoMatchedOpponentFoundPanel(this._clip.noMatchedOpponentFound,this._clip);
         this._pvpNoMatchedOpponentFoundPanel.hide(0);
         this._clip.loadingMessage.alpha = 0;
         this.toggleView(true);
      }
      
      private function onOpponentScrollSignal() : void
      {
         clearTimeout(this._scrollTimeout);
         this._scrollTimeout = setTimeout(this.checkForUnloadedInfoPanels,1000);
      }
      
      private function checkForUnloadedInfoPanels() : void
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:PVPOpponentInfoBox = null;
         var _loc1_:Array = [];
         var _loc4_:int = this._clip.viewRegion.height;
         var _loc5_:int = this._opponentScrollBar.scrollPosition;
         var _loc6_:int = 0;
         while(_loc6_ < this._opponentContainer.numChildren)
         {
            _loc2_ = this._opponentContainer.getChildAt(_loc6_);
            if(_loc2_ is PVPOpponentInfoBox)
            {
               _loc3_ = PVPOpponentInfoBox(_loc2_);
               _loc3_.isInitialised = false;
               if(_loc3_.y + _loc3_.height > _loc5_ && _loc3_.y < _loc5_ + _loc4_)
               {
                  _loc1_.push(_loc3_);
                  _loc3_.setState(PvPMain.STATE_LOADING);
               }
            }
            _loc6_++;
         }
         this.boxDataLoader.addBoxSet(_loc1_);
      }
      
      private function setUpTooltip() : void
      {
         this._tooltip = new ToolTip();
         this._tooltip.setStage(MonkeySystem.getInstance().flashStage);
         this._tooltip.scaleWidthByTextWidth = true;
         addChild(this._tooltip);
         this._tooltip.activateMouseFollow();
         this._tooltip.hide(0);
         this._pendingIncomingAttacksButton.target.addEventListener(MouseEvent.ROLL_OVER,function(param1:MouseEvent):void
         {
            _tooltip.message = "Incoming attacks";
            _tooltip.reveal();
         });
         this._pendingOutgoingAttacksButton.target.addEventListener(MouseEvent.ROLL_OVER,function(param1:MouseEvent):void
         {
            _tooltip.message = "Outgoing attacks";
            _tooltip.reveal();
         });
         this._pendingIncomingAttacksButton.target.addEventListener(MouseEvent.ROLL_OUT,this.tooltipInvokingButtonRollout);
         this._pendingOutgoingAttacksButton.target.addEventListener(MouseEvent.ROLL_OUT,this.tooltipInvokingButtonRollout);
         this._clip.pacifistModeIcon.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverPacifist);
         this._clip.pacifistModeIcon.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutPacifist);
      }
      
      private function tooltipInvokingButtonRollout(param1:MouseEvent) : void
      {
         this._tooltip.hide();
      }
      
      private function onAttackFriend() : void
      {
         this.toggleView(false);
      }
      
      private function onQuickMatchButtonClicked() : void
      {
         if(TownUI.getInstance().pvpAttackPanel.canSendAttack())
         {
            this._quickMatchAttempts = 0;
            this._isBroadQuickMatchSearch = false;
            this._quickMatchAttemptTimestamp = getTimer();
            this.launchQuickMatch();
         }
      }
      
      private function delayLaunchQuickMatch() : void
      {
         this.showLoadingBlocker();
         PvPTimerManager.getInstance().registerTimer("DelayLaunchQuickMatch",1,this.startSearch);
      }
      
      private function launchQuickMatch() : void
      {
         this.showLoadingBlocker();
         this.startSearch();
      }
      
      private function startSearch() : void
      {
         PvPTimerManager.getInstance().deleteTimer("DelayLaunchQuickMatch");
         var _loc1_:PvPPanel = this;
         PvPClient.getQuickMatch(_system.city.cityIndex,this._isBroadQuickMatchSearch,this.getQuickMatchCallback);
         this._quickMatchAttempts++;
      }
      
      private function getQuickMatchCallback(param1:Object) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Boolean = false;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:OutgoingAttack = null;
         var _loc7_:Array = null;
         var _loc8_:int = 0;
         var _loc9_:Friend = null;
         if(!isRevealed)
         {
            this.hideLoadingBlocker();
            return;
         }
         if(param1.success === false)
         {
            this.onQuickmatchFailedToFindOpponent();
         }
         else
         {
            _loc2_ = param1.matchedOpponent;
            _loc3_ = false;
            _loc4_ = PvPMain.instance.getOutgoingAttacks();
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length)
            {
               _loc6_ = _loc4_[_loc5_];
               if(_loc2_.userID == _loc6_.attack.defenderID)
               {
                  _loc3_ = true;
                  break;
               }
               _loc5_++;
            }
            if(_loc3_)
            {
               this.onQuickmatchFailedToFindOpponent();
            }
            else
            {
               this.hideLoadingBlocker();
               this.hide();
               _loc7_ = [];
               _loc8_ = 0;
               while(_loc8_ <= _loc2_.city.cityIndex)
               {
                  _loc7_.push(_loc2_.city);
                  _loc8_++;
               }
               _loc9_ = new Friend({
                  "userID":_loc2_.userID,
                  "name":_loc2_.name,
                  "cityLevel":_loc2_.city.level,
                  "clan":_loc2_.clan,
                  "cities":_loc7_,
                  "honour":_loc2_.honour,
                  "quickMatchID":_loc2_.quickMatchID
               });
               lastQuickmatchOpponentID = _loc2_.userID;
               this.attackTargetSelectedSignal.dispatch(_loc9_,_loc2_.city.cityIndex);
            }
         }
      }
      
      private function onQuickmatchFailedToFindOpponent() : void
      {
         var _loc1_:Number = getTimer() - this._quickMatchAttemptTimestamp;
         if(_loc1_ < this.MAX_QUICKMATCH_TIME || this._quickMatchAttempts <= this.MIN_QUICKMATCH_ATTEMPTS)
         {
            this.delayLaunchQuickMatch();
         }
         else if(this._isBroadQuickMatchSearch)
         {
            this.hideLoadingBlocker();
            this._pvpNoMatchedOpponentFoundPanel.reveal();
            PanelManager.getInstance().showFreePanel(this._pvpNoMatchedOpponentFoundPanel);
         }
         else
         {
            this._isBroadQuickMatchSearch = true;
            this._quickMatchAttempts = 0;
            this._quickMatchAttemptTimestamp = getTimer();
            this.delayLaunchQuickMatch();
         }
      }
      
      private function showLoadingBlocker() : void
      {
         this._clip.loadingMessage.visible = true;
         this._clip.loadingMessage.mouseEnabled = true;
         this._clip.loadingMessage.mouseChildren = true;
         TweenLite.killTweensOf(this._clip.loadingMessage);
         TweenLite.to(this._clip.loadingMessage,0.4,{"alpha":1});
      }
      
      private function hideLoadingBlocker(param1:Number = 0.4) : void
      {
         var time:Number = param1;
         this._clip.loadingMessage.mouseEnabled = false;
         this._clip.loadingMessage.mouseChildren = false;
         TweenLite.killTweensOf(this._clip.loadingMessage);
         TweenLite.to(this._clip.loadingMessage,time,{
            "alpha":0,
            "onComplete":function():void
            {
               _clip.loadingMessage.visible = false;
            }
         });
      }
      
      private function onBattleHistoryButtonClick() : void
      {
         PanelManager.getInstance().showPanelOverlay(this._battleHistoryPanel);
      }
      
      private function onPvPDataUpdatedSignal(param1:Object, param2:Object, param3:Object) : void
      {
         var data:Object = param1;
         var requestData:Object = param2;
         var responseData:Object = param3;
         this.clear();
         if(!this._dataHasBeenInitialised)
         {
            TweenLite.to(this._clip.loadingMessage,0.4,{
               "alpha":0,
               "onComplete":function():void
               {
                  _clip.loadingMessage.visible = false;
               }
            });
            this._clip.loadingMessage.mouseEnabled = false;
            this._clip.loadingMessage.mouseChildren = false;
         }
         this._dataHasBeenInitialised = true;
         this.initialiseFriendsList();
         this._incomingRaids = data.incomingRaids || this._incomingRaids;
         this.onShowPendingIncomingButtonClicked();
         this.syncToData();
      }
      
      private function initialiseFriendsList() : void
      {
         FriendsManager.getInstance().loadFriendsList(this.onLoadFriendsList);
      }
      
      private function onLoadFriendsList(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Friend = null;
         this._friendsWithCities.length = 0;
         this._friendsWithoutCities.length = 0;
         var _loc2_:int = this._resourceStore.townLevel;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = param1[_loc3_];
            if(_loc4_.cities !== null && _loc4_.cities.length > 0)
            {
               this._friendsWithCities.push(_loc4_);
            }
            else
            {
               this._friendsWithoutCities.push(_loc4_);
            }
            _loc3_++;
         }
         this.setupDividedFriendsArray();
         this.syncToData();
      }
      
      private function setupDividedFriendsArray() : void
      {
         this._friends = this._friendsWithCities.concat(this._friendsWithoutCities);
         this._currentOpponentView = this._friends;
      }
      
      private function onAttackButtonClicked() : void
      {
         this.attack();
      }
      
      private function attack() : void
      {
         var _loc1_:PVPOpponentInfoBox = PVPOpponentInfoBox(InfoBoxBase.getSelected(PVPOpponentInfoBox.selectionGroup));
         this.attackTargetSelectedSignal.dispatch(_loc1_.friend,_loc1_.cityIndex);
      }
      
      private function onDefendButtonClicked() : void
      {
         var _loc1_:PVPIncomingRaidInfoBox = PVPIncomingRaidInfoBox(InfoBoxBase.getSelected(PVPIncomingRaidInfoBox.selectionGroup));
         this.incomingRaidSelectedSignal.dispatch(_loc1_.incomingRaid);
      }
      
      private function onShowOpponentViewButtonClicked(param1:ButtonControllerBase) : void
      {
         this.unlockOpponentTypeButtons();
      }
      
      private function unlockPendingAttackTypeButtons() : void
      {
         this._pendingOutgoingAttacksButton.unlock(1);
         this._pendingIncomingAttacksButton.unlock(1);
      }
      
      private function onShowPendingIncomingButtonClicked() : void
      {
         this.unlockPendingAttackTypeButtons();
         this._pendingIncomingAttacksButton.lock(3);
         this._currentPendingAttackTypeView = this._incomingRaids;
      }
      
      private function onShowPendingOutgoingButtonClicked() : void
      {
         this.unlockPendingAttackTypeButtons();
         this._pendingOutgoingAttacksButton.lock(3);
         this._currentPendingAttackTypeView = [];
      }
      
      private function unlockOpponentTypeButtons() : void
      {
      }
      
      private function clear() : void
      {
         this.removeAllChildren(this._opponentContainer);
         this.removeAllChildren(this._raidContainer);
         this.clearSelections();
      }
      
      private function clearSelections() : void
      {
         this._attackButton.lock(3);
         this._defendButton.lock(3);
         var _loc1_:PVPIncomingRaidInfoBox = PVPIncomingRaidInfoBox(InfoBoxBase.getSelected(PVPIncomingRaidInfoBox.selectionGroup));
         if(_loc1_ !== null)
         {
            this._selectedRaidPlayername = _loc1_.getPlayerName();
         }
         else
         {
            this._selectedRaidPlayername = null;
         }
         var _loc2_:PVPOpponentInfoBox = PVPOpponentInfoBox(InfoBoxBase.getSelected(PVPOpponentInfoBox.selectionGroup));
         if(_loc2_ !== null)
         {
            this._selectedOpponentPlayername = _loc2_.getPlayerName();
         }
         else
         {
            this._selectedOpponentPlayername = null;
         }
         InfoBoxBase.clearSelectedForAllGroups();
      }
      
      public function syncToData() : void
      {
         this.sortLists(this._currentSortType);
         this.buildView();
      }
      
      private function removeAllChildren(param1:DisplayObjectContainer) : void
      {
         while(param1.numChildren > 0)
         {
            param1.removeChildAt(0);
         }
      }
      
      private function goButtonClicked() : void
      {
         this.hide();
      }
      
      override public function hide(param1:Number = 0.3) : void
      {
         super.hide(param1);
         this._battleHistoryPanel.hide(param1);
         this._selectedOpponentPlayername = null;
         this._selectedRaidPlayername = null;
         if(_stage !== null)
         {
            _stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDownHandler);
         }
      }
      
      override protected function onHideComplete() : void
      {
         super.onHideComplete();
         this.clearSelections();
         this._friendsListIsVisible = false;
      }
      
      private function onSortBySignal(param1:String) : void
      {
         this._currentSortType = param1;
         this.sortLists(this._currentSortType);
         this.buildView();
      }
      
      private function sortLists(param1:String) : void
      {
         switch(param1)
         {
            case SortByDropdown.SORT_BY_CLAN:
               this.sortListsByClan();
               break;
            default:
               this.sortListsByName();
         }
      }
      
      private function sortListsByName() : void
      {
         this.sortArrayOnName(this._friends);
      }
      
      private function sortListsByClan() : void
      {
         this.sortArrayByClan(this._friends);
      }
      
      private function sortArrayOnName(param1:Array) : void
      {
         param1.sortOn("name",Array.CASEINSENSITIVE);
      }
      
      private function sortArrayByClan(param1:Array) : void
      {
         param1.sortOn("clan",Array.CASEINSENSITIVE);
      }
      
      private function onInfoBoxSelectionMadeSignal(param1:String, param2:InfoBoxBase) : void
      {
         switch(param1)
         {
            case PVPIncomingRaidInfoBox.selectionGroup:
               this._defendButton.unlock(1);
               break;
            case PVPOpponentInfoBox.selectionGroup:
               this._attackButton.unlock(1);
         }
      }
      
      private function syncSelectionArrow(param1:MovieClip, param2:MovieClip) : void
      {
         param1.visible = true;
         param1.x = param2.parent.x;
         param1.y = param2.parent.y + param2.y;
      }
      
      private function buildView() : void
      {
         var _loc1_:* = this._resourceStore.townLevel >= Constants.MINIMUM_PVP_LEVEL;
         this._clip.unlockClip.visible = !_loc1_;
         if(!_loc1_)
         {
            return;
         }
         this.buildOpponentsList(this._currentOpponentView);
         this.buildIncomingRaidsList(this._currentPendingAttackTypeView);
         this.checkForUnloadedInfoPanels();
      }
      
      private function toggleView(param1:Boolean) : void
      {
         this._friendsListIsVisible = !param1;
         if(this._resourceStore.townLevel >= Constants.MINIMUM_PVP_LEVEL)
         {
            if(param1)
            {
               this._opponentContainer.visible = false;
               this._opponentScrollBar.hide();
               this._smallQuickPlayButton.target.visible = false;
               this._clip.sortByDropdown.visible = false;
               this._clip.quickMatchDisplayClip.visible = true;
            }
            else
            {
               this._opponentContainer.visible = true;
               this._opponentScrollBar.syncScrollbarToContent();
               this._smallQuickPlayButton.target.visible = true;
               this._clip.sortByDropdown.visible = true;
               this._clip.quickMatchDisplayClip.visible = false;
            }
         }
         else
         {
            this._clip.quickMatchDisplayClip.visible = false;
            this._opponentContainer.visible = false;
            this._opponentScrollBar.hide();
            this._smallQuickPlayButton.target.visible = false;
            this._clip.sortByDropdown.visible = false;
         }
      }
      
      private function buildOpponentsList(param1:Array) : void
      {
         var _loc2_:PVPOpponentInfoBox = null;
         var _loc4_:int = 0;
         var _loc5_:Friend = null;
         InfoBoxBase.clearSelected(PVPOpponentInfoBox.selectionGroup);
         this._infoBoxes.length = 0;
         while(this._opponentContainer.numChildren > 0)
         {
            if(this._opponentContainer.getChildAt(0) is PVPOpponentInfoBox)
            {
               PVPOpponentInfoBox.recycleInfoBox(this._opponentContainer.getChildAt(0) as PVPOpponentInfoBox);
            }
            this._opponentContainer.removeChildAt(0);
         }
         this._attackButton.lock(3);
         var _loc3_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc5_ = param1[_loc4_];
            _loc2_ = this.getOpponentInfoBox(param1[_loc4_]);
            this._infoBoxes.push(_loc2_);
            _loc2_.y = _loc3_;
            _loc2_.yPos = _loc3_;
            if(_loc4_ % 2 === 0)
            {
               _loc2_.setBackground();
            }
            if(this._selectedOpponentPlayername !== null && _loc2_.getPlayerName() == this._selectedOpponentPlayername)
            {
               _loc2_.setSelected(true);
               this._attackButton.unlock(1);
            }
            this._opponentContainer.addChild(_loc2_);
            _loc3_ = _loc3_ + Y_STEP;
            _loc4_++;
         }
      }
      
      private function buildIncomingRaidsList(param1:Array) : void
      {
         var _loc2_:PVPIncomingRaidInfoBox = null;
         var _loc5_:int = 0;
         var _loc6_:Object = null;
         while(this._raidContainer.numChildren > 0)
         {
            if(this._raidContainer.getChildAt(0) is PVPIncomingRaidInfoBox)
            {
               PVPIncomingRaidInfoBox.recycleInfoBox(this._raidContainer.getChildAt(0) as PVPIncomingRaidInfoBox);
            }
            this._raidContainer.removeChildAt(0);
         }
         this._defendButton.lock(3);
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < param1.length)
         {
            _loc2_ = this.getIncomingRaidInfoBox(param1[_loc5_]);
            _loc2_.x = _loc3_;
            _loc2_.y = _loc4_;
            if(_loc5_ % 2 === 0)
            {
               _loc2_.setBackground();
            }
            if(this._selectedRaidPlayername !== null && _loc2_.getPlayerName() == this._selectedRaidPlayername)
            {
               _loc2_.setSelected(true);
               this._defendButton.unlock(1);
            }
            this._raidContainer.addChild(_loc2_);
            _loc4_ = _loc4_ + Y_STEP;
            _loc5_++;
         }
         this._raidsScrollBar.syncScrollbarToContent();
      }
      
      private function getOpponentInfoBox(param1:Friend) : PVPOpponentInfoBox
      {
         var _loc2_:PVPOpponentInfoBox = null;
         _loc2_ = PVPOpponentInfoBox.getInfoBox(param1);
         _loc2_.setPlayerName(param1.name);
         _loc2_.setClan(param1.clan);
         _loc2_.setHonour(0);
         _loc2_.setLevel(0);
         _loc2_.setState(PvPMain.STATE_NOT_INITIALISED);
         _loc2_.cityIndex = -1;
         this.boxDataLoader.populateWithCachedData(_loc2_);
         return _loc2_;
      }
      
      private function getIncomingRaidInfoBox(param1:IncomingRaid) : PVPIncomingRaidInfoBox
      {
         var _loc2_:PVPIncomingRaidInfoBox = null;
         _loc2_ = PVPIncomingRaidInfoBox.getInfoBox();
         _loc2_.setPlayerName(param1.name);
         _loc2_.setClan(param1.clan);
         _loc2_.setLevel(param1.cityLevel);
         _loc2_.setTimeRemaining(Formator.msToHrMin(param1.timeLeft));
         _loc2_.setHonour(param1.sender.honour);
         _loc2_.incomingRaid = param1;
         return _loc2_;
      }
      
      override public function reveal(param1:Number = 0.2) : void
      {
         var _loc2_:Boolean = isRevealed;
         super.reveal(param1);
         this.clear();
         this.buildView();
         this.toggleView(!this._friendsListIsVisible);
         this.hideLoadingBlocker(0);
         this._pvpNoMatchedOpponentFoundPanel.hide(0);
         this._opponentScrollBar.setToTop();
         this._raidsScrollBar.setToTop();
         MCSound.getInstance().playSound(MCSound.OPEN_PANEL);
         var _loc3_:Number = getTimer();
         if(_loc3_ - this._timeOfLastReveal > 5000 * 60 && ResourceStore.getInstance().townLevel >= Constants.MINIMUM_PVP_LEVEL)
         {
            PvPSignals.requestRefeshPvPData.dispatch();
            this._timeOfLastReveal = _loc3_;
         }
         this.configureKong();
         this.initialiseFriendsList();
      }
      
      private function configureKong() : void
      {
         if(Kong.isOnKong() && Constants.DISABLE_MVM_FRIENDS_ON_KONG)
         {
            this._clip.quickMatchDisplayClip.comingSoon.visible = true;
            this._attackFriendButton.lock();
         }
         else
         {
            this._clip.quickMatchDisplayClip.comingSoon.visible = false;
         }
         _stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDownHandler);
      }
      
      private function onPacifistModeChanged(param1:Boolean) : void
      {
         if(param1 == true)
         {
            this._clip.pacifistModeIcon.gotoAndStop(1);
         }
         else
         {
            this._clip.pacifistModeIcon.gotoAndStop(2);
         }
      }
      
      private function onRollOverPacifist(param1:MouseEvent) : void
      {
         if(PvPMain.isInPacifistMode)
         {
            TownUI.showToolTipSignal.dispatch(LocalisationConstants.PACIFIST_MODE_ON_DESCRIPTION);
         }
         else
         {
            TownUI.showToolTipSignal.dispatch(LocalisationConstants.PACIFIST_MODE_OFF_DESCRIPTION);
         }
      }
      
      private function onRollOutPacifist(param1:MouseEvent) : void
      {
         TownUI.hideToolTipSignal.dispatch();
      }
      
      private function onKeyDownHandler(param1:KeyboardEvent) : void
      {
         this.setScrollInfoBoxByLetter(String.fromCharCode(param1.keyCode));
      }
      
      protected function setScrollInfoBoxByLetter(param1:String) : InfoBoxBase
      {
         var _loc3_:int = 0;
         var _loc4_:String = null;
         param1 = param1.charAt(0).toLowerCase();
         var _loc2_:InfoBoxBase = null;
         _loc3_ = 0;
         while(_loc3_ < this._infoBoxes.length)
         {
            _loc2_ = this._infoBoxes[_loc3_];
            _loc4_ = _loc2_.friend.name.charAt(0).toLowerCase();
            if(_loc4_ === param1)
            {
               break;
            }
            _loc2_ = null;
            _loc3_++;
         }
         if(_loc2_ !== null)
         {
            this._opponentScrollBar.setScrollPosition(_loc2_.y);
         }
         return _loc2_;
      }
   }
}
