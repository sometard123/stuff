package ninjakiwi.monkeyTown.town.ui.contestedTerritory
{
   import assets.town.ContestedTerritoryPanelClip;
   import assets.town.ExtraInfoPanel;
   import assets.town.PVPPanelClip;
   import assets.town.ResetTimerContainer;
   import assets.town.ScoreBoard;
   import assets.town.TownAvatarContainer;
   import assets.ui.MilestoneRewardClip;
   import assets.ui.Spam250Clip;
   import assets.ui.TravellingMerchantIconClip;
   import com.codecatalyst.promise.Deferred;
   import com.codecatalyst.promise.Promise;
   import com.greensock.TweenLite;
   import com.greensock.easing.Back;
   import com.lgrey.utils.LGDisplayListUtil;
   import com.ninjakiwi.gateway.nk.NKBarContainer;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.text.TextField;
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import ninjakiwi.dancingShadows.DancingShadows;
   import ninjakiwi.dancingShadows.INumber;
   import ninjakiwi.link.URLLoaderPromise;
   import ninjakiwi.link.User;
   import ninjakiwi.link.userID;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.Main;
   import ninjakiwi.monkeyTown.analytics.ErrorMessageTracking;
   import ninjakiwi.monkeyTown.analytics.IdleTracker;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.common.LevelDefData;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BloonWeightsDefinition;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.GameResultDefinition;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.TileUniqueDataDefinition;
   import ninjakiwi.monkeyTown.contestedTerritory.ContestPanelHelper;
   import ninjakiwi.monkeyTown.contestedTerritory.ContestTestObjects;
   import ninjakiwi.monkeyTown.data.KeyValueStore;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.dust.Particle;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledge;
   import ninjakiwi.monkeyTown.net.CachedPreMaintenanceChecker;
   import ninjakiwi.monkeyTown.net.Squeeze;
   import ninjakiwi.monkeyTown.net.kloud.Kloud;
   import ninjakiwi.monkeyTown.pvp.Friend;
   import ninjakiwi.monkeyTown.pvp.IncomingRaid;
   import ninjakiwi.monkeyTown.pvp.InviteUser;
   import ninjakiwi.monkeyTown.pvp.PvPAttackDefinition;
   import ninjakiwi.monkeyTown.pvp.PvPClient;
   import ninjakiwi.monkeyTown.pvp.PvPMain;
   import ninjakiwi.monkeyTown.saleEvents.SaleEventData;
   import ninjakiwi.monkeyTown.saleEvents.ui.KnowledgePackSaleIntroPanel;
   import ninjakiwi.monkeyTown.sound.MCSound;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.buildings.customClasses.UpgradeableBuilding;
   import ninjakiwi.monkeyTown.town.data.ContestedTerritoryPlayerData;
   import ninjakiwi.monkeyTown.town.data.ContestedTerritorySessionData;
   import ninjakiwi.monkeyTown.town.data.GameMods;
   import ninjakiwi.monkeyTown.town.data.load.UserDataLoader;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.gameEvents.ui.GenericEventPopupPanel;
   import ninjakiwi.monkeyTown.town.gameEvents.ui.MilestoneRewardInfoBox;
   import ninjakiwi.monkeyTown.town.gameEvents.ui.OccupationRewardInfoBox;
   import ninjakiwi.monkeyTown.town.helpFromFriends.CrateManager;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldViewSignals;
   import ninjakiwi.monkeyTown.town.quests.QuestCounter;
   import ninjakiwi.monkeyTown.town.townMap.TrackManager;
   import ninjakiwi.monkeyTown.town.ui.AvatarLoader;
   import ninjakiwi.monkeyTown.town.ui.ClanLoader;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.EventsMenuButton;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.BossIsHidingCustomButtons;
   import ninjakiwi.monkeyTown.town.ui.myTrack.MyTrackThumbNailClip;
   import ninjakiwi.monkeyTown.town.ui.pvp.SortByDropdown;
   import ninjakiwi.monkeyTown.ui.ContestLoseWeekPanel;
   import ninjakiwi.monkeyTown.ui.ContestWinWeekPanel;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.HideRevealViewBottomUIPanel;
   import ninjakiwi.monkeyTown.ui.TransitionSignals;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.AnimationRange;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.DustBurst;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelGroups;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   import ninjakiwi.monkeyTown.userServices.kong.Kong;
   import ninjakiwi.monkeyTown.utils.Flatten;
   import org.osflash.signals.PrioritySignal;
   import org.osflash.signals.Signal;
   
   public class ContestedTerritoryPanel extends HideRevealViewBottomUIPanel
   {
      
      public static const panelRevealedSignal:PrioritySignal = new PrioritySignal(int);
      
      public static const gameEndedSignal:PrioritySignal = new PrioritySignal(int,int,int,Boolean,Boolean,String,int,int);
      
      public static const collectCashSignal:PrioritySignal = new PrioritySignal(int,int,String);
      
      public static const collectBloonstonesSignal:PrioritySignal = new PrioritySignal(int,String);
      
      public static const joinedSignal:PrioritySignal = new PrioritySignal();
      
      public static const winSignal:PrioritySignal = new PrioritySignal();
      
      public static const endContestSignal:PrioritySignal = new PrioritySignal();
      
      public static const updateOccupationSignal:PrioritySignal = new PrioritySignal(Number);
      
      public static const historyFoundSignal:PrioritySignal = new PrioritySignal(Object,Number);
      
      public static const MILLISECONDS_IN_AN_HOUR:Number = 3600000;
      
      public static const LOAD_HISTORY_ERROR_RETRY_INTERVAL:Number = 20;
      
      public static const JOIN_ERROR_RETRY_INTERVAL:Number = 10;
      
      public static const CONTESTED_TERRITORY_SERVER_SYNC_INTERVAL:Number = 15 * 60 * 1000;
      
      public static const CONTESTED_TERRITORY_NUM_OF_CITIES:int = 6;
      
      public static const CONTESTED_TERRITORY_LEVEL_REQUIREMENT:int = 5;
      
      public static const CONTESTED_TERRITORY_LEVEL_TIERS:Array = [9,13,17,21,25,29,33,37,41,44];
      
      public static const CONTESTED_TERRITORY_NUMBER_OF_CITY_TIERS:int = 9;
      
      public static const CONTESTED_TERRITORY_EXTRA_ROUNDS:int = 200;
      
      public static const CONTESTED_TERRITORY_DIFFICULTY_RANK:int = 2;
      
      public static const CONTESTED_TERRITORY_MAX_SCORE_INTERVAL:Number = 60 * 1000;
      
      public static const CONTESTED_TERRITORY_CAPTURE_CASH_REWARD_BASE:int = 200;
      
      public static const CONTESTED_TERRITORY_COOKIE_NAME:String = "monkey_city_contested_territory";
      
      public static var forceErrorOnLoadHistoryResponse:Boolean = false;
      
      public static var forceSuccessOnLoadHistoryResponse:Boolean = false;
      
      public static var forceHistory:Boolean = false;
      
      public static var forceTenSecondsRemainingInWeek:Boolean = false;
      
      public static var forceRetryMessageOnJoin:Boolean = false;
      
      public static var forceInvalidLastLootTime:Boolean = false;
       
      
      private const TIMER_UPDATE_INTERVAL:Number = 1000;
      
      private var _clip:ContestedTerritoryPanelClip;
      
      private var _lockedOverlay:MovieClip;
      
      private var _closeButton:ButtonControllerBase;
      
      private var _collectionButton:ButtonControllerBase;
      
      private var _coinBurst:MovieClip;
      
      private var _banksFullAnimation:MovieClip;
      
      private var _playButton:ButtonControllerBase;
      
      private var _eventsModule:ContestedTerritoryEventsModule;
      
      private var _scoreBoard:ScoreBoard;
      
      private var _bananaTemple:MovieClip;
      
      private var _templeGraphic:MovieClip;
      
      private var _templeButton:MovieClip;
      
      private var _templePlayBanner:MovieClip;
      
      private var _bloonRetakeContainer:ResetTimerContainer;
      
      private var _towns:Vector.<TownAvatarContainer>;
      
      private var _scoreNameFields:Vector.<TextField>;
      
      private var _scoreTimeFields:Vector.<TextField>;
      
      private var _trucks:Vector.<MovieClip>;
      
      private var _loadingMessage:MovieClip;
      
      private var _sessionData:ContestedTerritorySessionData;
      
      private var _playerData:Vector.<ContestedTerritoryPlayerData>;
      
      private var _playerDataSorted:Vector.<ContestedTerritoryPlayerData>;
      
      private var _myPlayerData:ContestedTerritoryPlayerData;
      
      private var _leadingPlayerData:ContestedTerritoryPlayerData;
      
      private var _previousLeadingPlayerData:ContestedTerritoryPlayerData;
      
      private var _lastResponseFromSaveScore:Object = null;
      
      private var _gameRequestOfLastGame:BTDGameRequest = null;
      
      private var _gameResultOfLastGame:GameResultDefinition = null;
      
      private var _urlLoader:URLLoader;
      
      private var _urlLoaderRequest:URLRequest;
      
      private var _isMouseOverCity:Vector.<Boolean>;
      
      private var _isMouseOverTemplePlayButton:Boolean = false;
      
      private var _bloonstoneEndOfWeekReward:INumber;
      
      private var _lastKnownLeadingPlayerUserID:String;
      
      private var _leadingPlayerCityID:int;
      
      private var _timestampThisFrame:Number;
      
      private var _timeUntilNextServerSync:Number;
      
      private var _cashBeforeCollect:Number;
      
      private var _cashAfterCollect:Number;
      
      private var _timeCashedUpUntil:Number;
      
      private var _timeStampOfLastBTDRoundComplete:Number;
      
      private var _timeEnteredDeferEndOfWeekUpdate:Number;
      
      private var _deferEndOfWeekUpdateDelayTime:Number;
      
      private var _timeEnteredEndOfWeekLoadPeriod:Number;
      
      private var _numOfCompletedRounds:int;
      
      private var _numOfCompletedRoundsToSave:int;
      
      private var _lastNumOfCompletedRoundsSaved:int;
      
      private var _numberOfRoundsToBeatInGame:int;
      
      private var _proposedTrackName:String;
      
      private var _proposedRoundGeneratorSeed:int;
      
      private var _isDataLoaded:Boolean = false;
      
      private var _collectingCash:Boolean = false;
      
      private var _hasFoundFirstLeader:Boolean = false;
      
      private var _isUpdatingWhileHidden:Boolean = false;
      
      private var _isWaitingForScoreToSave:Boolean = false;
      
      private var _errorOnLastScoreSave:Boolean = false;
      
      private var _syncing:Boolean = false;
      
      private var _inEndOfWeekLoadPeriod:Boolean = false;
      
      private var _deferEndOfWeekUpdate:Boolean = false;
      
      private var _waitingForLoadHistoryResponse:Boolean = false;
      
      private var _waitingForJoinResponse:Boolean = false;
      
      private var _dispatchWinForHistory:Boolean = false;
      
      private var _playerControlsCTWhileInGame:Boolean = false;
      
      private var _isLegacyRoom:Boolean = false;
      
      private var _isLastHistoryRoomLegacy:Boolean = false;
      
      private var _isInBTDGame:Boolean = false;
      
      private var _curtainIsOpen:Boolean;
      
      private var _timeOfLastUpdate:Number = 0;
      
      private const CT_VERBOSE:Boolean = true;
      
      private var _lastHistoryRoomID:String = "";
      
      public function ContestedTerritoryPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         this._clip = new ContestedTerritoryPanelClip();
         this._lockedOverlay = this._clip.unlockClip;
         this._closeButton = new ButtonControllerBase(this._clip.closeButton);
         this._collectionButton = new ButtonControllerBase(this._clip.collectionButton);
         this._coinBurst = this._clip.coinBurst;
         this._banksFullAnimation = this._clip.banksFull;
         this._playButton = new ButtonControllerBase(this._clip.playButton);
         this._eventsModule = new ContestedTerritoryEventsModule(this._clip.eventsModuleSmall,this._clip.eventsModuleLarge);
         this._scoreBoard = this._clip.scoreBoard;
         this._bananaTemple = this._clip.bananaTemple;
         this._templeGraphic = this._clip.valleyTemple;
         this._templeButton = this._clip.templeHit;
         this._templePlayBanner = this._clip.templePlayBanner;
         this._bloonRetakeContainer = this._clip.resetTimerContainer;
         this._towns = new Vector.<TownAvatarContainer>();
         this._scoreNameFields = new Vector.<TextField>();
         this._scoreTimeFields = new Vector.<TextField>();
         this._trucks = new Vector.<MovieClip>();
         this._loadingMessage = this._clip.loadingMessage;
         this._sessionData = new ContestedTerritorySessionData();
         this._playerData = new Vector.<ContestedTerritoryPlayerData>();
         this._playerDataSorted = new Vector.<ContestedTerritoryPlayerData>();
         this._isMouseOverCity = new Vector.<Boolean>();
         this._bloonstoneEndOfWeekReward = DancingShadows.getOne();
         super(param1,param2);
      }
      
      public function init() : void
      {
         addChild(this._clip);
         isModal = true;
         enableDefaultOnResize(this._clip);
         LGDisplayListUtil.getInstance().setPlayStateOfAllChildMovieClips(this,false,true,true);
         this._towns.push(this._clip.town0);
         this._towns.push(this._clip.town1);
         this._towns.push(this._clip.town2);
         this._towns.push(this._clip.town3);
         this._towns.push(this._clip.town4);
         this._towns.push(this._clip.town5);
         this._scoreNameFields.push(this._scoreBoard.playerNameBoardField0);
         this._scoreNameFields.push(this._scoreBoard.playerNameBoardField1);
         this._scoreNameFields.push(this._scoreBoard.playerNameBoardField2);
         this._scoreNameFields.push(this._scoreBoard.playerNameBoardField3);
         this._scoreNameFields.push(this._scoreBoard.playerNameBoardField4);
         this._scoreNameFields.push(this._scoreBoard.playerNameBoardField5);
         this._scoreTimeFields.push(this._scoreBoard.heldTimeBoardField0);
         this._scoreTimeFields.push(this._scoreBoard.heldTimeBoardField1);
         this._scoreTimeFields.push(this._scoreBoard.heldTimeBoardField2);
         this._scoreTimeFields.push(this._scoreBoard.heldTimeBoardField3);
         this._scoreTimeFields.push(this._scoreBoard.heldTimeBoardField4);
         this._scoreTimeFields.push(this._scoreBoard.heldTimeBoardField5);
         this._trucks.push(this._clip.truckClip06);
         this._trucks.push(this._clip.truckClip01);
         this._trucks.push(this._clip.truckClip02);
         this._trucks.push(this._clip.truckClip03);
         this._trucks.push(this._clip.truckClip04);
         this._trucks.push(this._clip.truckClip05);
         this._closeButton.setClickFunction(this.hide);
         this._collectionButton.setClickFunction(this.onCollect);
         this._playButton.setClickFunction(this.onPlay);
         var i:int = 0;
         while(i < CONTESTED_TERRITORY_NUM_OF_CITIES)
         {
            this._playerData.push(new ContestedTerritoryPlayerData());
            this._towns[i].avatarModule.visible = false;
            this._towns[i].territoryOwnerStar.visible = false;
            this._towns[i].extraInfoPanel.visible = false;
            this._towns[i].townTier.visible = false;
            this._towns[i].mouseChildren = false;
            this._towns[i].avatarModule.honourField.visible = false;
            this._towns[i].avatarModule.honourSymbol.visible = false;
            this._trucks[i].visible = false;
            this._isMouseOverCity.push(false);
            i++;
         }
         this._templeGraphic.mouseEnabled = false;
         this._templeGraphic.mouseChildren = false;
         this._templeButton.mouseEnabled = true;
         this._templeButton.useHandCursor = true;
         this._templeButton.buttonMode = true;
         this._collectionButton.target.visible = false;
         Flatten.flatten(this._clip.background);
         WorldViewSignals.buildWorldStartSignal.add(this.onReset);
         WorldViewSignals.buildWorldEndSignal.add(this.onBuildWorldEnd);
         TransitionSignals.closeCurtainCompleteSignal.add(this.onCloseCurtainCompleteSignal);
         TransitionSignals.raiseCurtainCompleteSignal.add(this.onRaiseCurtainCompleteSignal);
         TransitionSignals.beganLoadingBTDGame.add(function():void
         {
            inGameSleep(true);
         });
         TransitionSignals.endTransitionFromBTDToCity.add(function():void
         {
            inGameSleep(false);
         });
         ResourceStore.getInstance().townLevelChangedDiffSignal.add(this.onTownLevelChangedSignal);
         this._coinBurst.mouseEnabled = false;
         this._coinBurst.mouseChildren = false;
         this._coinBurst.addEventListener(Event.COMPLETE,this.onCoinBurstCompleteHandler);
         this.hideCoinBurst();
         this._banksFullAnimation.mouseEnabled = false;
         this._banksFullAnimation.mouseChildren = false;
         this._banksFullAnimation.addEventListener(Event.COMPLETE,this.onBanksFullCompleteHandler);
         this.hideBanksFullAnimation();
         this._clip.hallOfFameButton.visible = false;
         this._urlLoader = new URLLoader();
         this._urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
         this._urlLoaderRequest = new URLRequest();
         this._urlLoaderRequest.method = URLRequestMethod.GET;
      }
      
      private function onReset() : void
      {
         this.disableInteraction();
         this._leadingPlayerData = null;
         this._previousLeadingPlayerData = null;
         this._leadingPlayerCityID = -1;
         this._gameRequestOfLastGame = null;
         this._gameResultOfLastGame = null;
         this._isMouseOverTemplePlayButton = false;
         var _loc1_:int = 0;
         while(_loc1_ < this._isMouseOverCity.length)
         {
            this._isMouseOverCity[_loc1_] = false;
            _loc1_++;
         }
         this._bloonstoneEndOfWeekReward.value = 0;
         this._timestampThisFrame = getTimer();
         this._timeUntilNextServerSync = CONTESTED_TERRITORY_SERVER_SYNC_INTERVAL;
         this._cashBeforeCollect = 0;
         this._cashAfterCollect = 0;
         this._timeCashedUpUntil = 0;
         this._timeStampOfLastBTDRoundComplete = 0;
         this._numOfCompletedRounds = 0;
         this._numOfCompletedRoundsToSave = 0;
         this._lastNumOfCompletedRoundsSaved = 0;
         this._timeEnteredDeferEndOfWeekUpdate = 0;
         this._deferEndOfWeekUpdateDelayTime = 0;
         this._timeEnteredEndOfWeekLoadPeriod = 0;
         this._numberOfRoundsToBeatInGame = 0;
         this._isDataLoaded = false;
         this._collectingCash = false;
         this._hasFoundFirstLeader = false;
         this._isUpdatingWhileHidden = false;
         this._isWaitingForScoreToSave = false;
         this._errorOnLastScoreSave = false;
         this._syncing = false;
         this._deferEndOfWeekUpdate = false;
         this._waitingForLoadHistoryResponse = false;
         this._waitingForJoinResponse = false;
         this._dispatchWinForHistory = false;
         this._playerControlsCTWhileInGame = false;
         this._isLegacyRoom = false;
         this._isInBTDGame = false;
         this._lastResponseFromSaveScore = null;
         this._lastKnownLeadingPlayerUserID = "";
         this._sessionData.reset();
         var _loc2_:int = 0;
         while(_loc2_ < this._playerData.length)
         {
            this._playerData[_loc2_].reset();
            _loc2_++;
         }
         this._myPlayerData = null;
         this._bloonRetakeContainer.visible = false;
         this._loadingMessage.visible = false;
         if(this._inEndOfWeekLoadPeriod)
         {
            this.exitEndOfWeekLoadPeriod();
         }
      }
      
      public function onBuildWorldEnd() : void
      {
         if(Constants.DISABLE_CONTESTED_TERRITORY)
         {
            return;
         }
         if(ResourceStore.getInstance().townLevel < CONTESTED_TERRITORY_LEVEL_REQUIREMENT)
         {
            return;
         }
         if(this.isInContestedTerritory())
         {
            if(!this.CT_VERBOSE)
            {
            }
            if(!this.CT_VERBOSE)
            {
            }
            this.syncFromCityLoadObject();
            this.checkForDailyPopups();
            this._isDataLoaded = true;
            this._isUpdatingWhileHidden = true;
            addEventListener(Event.ENTER_FRAME,this.onFrameEnterHidden);
            this._timestampThisFrame = getTimer();
         }
         else
         {
            if(!this.CT_VERBOSE)
            {
            }
            if(!this.CT_VERBOSE)
            {
            }
            this.requestToLoadHistory();
         }
      }
      
      private function syncFromCityLoadObject() : void
      {
         if(!this.CT_VERBOSE)
         {
         }
         var _loc1_:Object = {"contestedTerritory":MonkeySystem.getInstance().city.contestedTerritoryData};
         this.syncData(_loc1_,true);
      }
      
      public function isInContestedTerritory() : Boolean
      {
         return MonkeySystem.getInstance().city.contestedTerritoryData != null;
      }
      
      public function onHistoryLoad(param1:Object, param2:Object) : void
      {
         var onHistoryLoadResponse:Object = param1;
         var onHistoryLoadRequest:Object = param2;
         this._waitingForLoadHistoryResponse = false;
         if(forceErrorOnLoadHistoryResponse)
         {
            onHistoryLoadResponse.success = false;
            onHistoryLoadResponse.bmc_code = "try_again";
            onHistoryLoadResponse.bmc_errno = 0;
         }
         if(forceSuccessOnLoadHistoryResponse)
         {
            onHistoryLoadResponse.success = true;
         }
         this._isLastHistoryRoomLegacy = false;
         if(forceHistory)
         {
            TownUI.getInstance().contestedTerritoryPanel.sessionData.week = TownUI.getInstance().contestedTerritoryPanel.sessionData.week - 1;
         }
         if(!this.CT_VERBOSE)
         {
         }
         if(onHistoryLoadResponse.success == false)
         {
            if(!this.CT_VERBOSE)
            {
            }
            if(onHistoryLoadResponse.bmc_code == "try_again" && onHistoryLoadResponse.bmc_errno == 0)
            {
               if(!this.CT_VERBOSE)
               {
               }
               if(false == this._inEndOfWeekLoadPeriod)
               {
                  this.enterEndOfWeekLoadPeriod();
               }
               if(!this.CT_VERBOSE)
               {
               }
               TweenLite.delayedCall(LOAD_HISTORY_ERROR_RETRY_INTERVAL,function():void
               {
                  if(!CT_VERBOSE)
                  {
                  }
                  if(!CT_VERBOSE)
                  {
                  }
                  requestToLoadHistory();
               });
               return;
            }
            this.sanityCheckHistoryLoad(onHistoryLoadResponse,onHistoryLoadRequest);
            if(this._inEndOfWeekLoadPeriod)
            {
               this.exitEndOfWeekLoadPeriod();
            }
            if(isRevealed)
            {
               this.requestToJoinContestedTerritory();
            }
            return;
         }
         if(this._inEndOfWeekLoadPeriod)
         {
            this.exitEndOfWeekLoadPeriod();
         }
         var hasHistory:Boolean = onHistoryLoadResponse.room != null;
         if(forceHistory)
         {
            if(hasHistory == false)
            {
               onHistoryLoadResponse = ContestTestObjects.CONTESTED_TERRITORY_HISTORY_TEST_OBJECT_CASE_1;
               hasHistory = true;
            }
         }
         if(hasHistory)
         {
            if(!this.CT_VERBOSE)
            {
            }
            this.endOfWeekHistoryFound(onHistoryLoadResponse.room);
         }
         else
         {
            if(!this.CT_VERBOSE)
            {
            }
            this.sanityCheckHistoryLoad(onHistoryLoadResponse,onHistoryLoadRequest);
            if(isRevealed)
            {
               this.requestToJoinContestedTerritory();
            }
            else
            {
               this.checkForDailyPopups();
            }
         }
      }
      
      public function endOfWeekHistoryFound(param1:Object) : void
      {
         var _loc7_:ContestLoseWeekPanel = null;
         var _loc8_:int = 0;
         this._bloonstoneEndOfWeekReward.value = 0;
         this._dispatchWinForHistory = false;
         this._lastHistoryRoomID = param1.roomID;
         this._isLastHistoryRoomLegacy = false;
         if(param1.hasOwnProperty("isLegacyRoom"))
         {
            this._isLastHistoryRoomLegacy = param1.isLegacyRoom;
         }
         var _loc2_:String = MonkeySystem.getInstance().nkGatewayUser.loginInfo.id;
         ContestPanelHelper.patchMissingScores(param1);
         var _loc3_:Vector.<Object> = new Vector.<Object>();
         _loc3_ = ContestPanelHelper.fetchPlayersFromServerResponse(param1);
         ContestPanelHelper.sortPlayersByTimeHeld(_loc3_);
         var _loc4_:int = ContestPanelHelper.getPositionOfUserInPlayerList(_loc3_,_loc2_);
         historyFoundSignal.dispatch(param1,_loc3_[_loc4_].score.duration);
         if(!this.CT_VERBOSE)
         {
         }
         if(false == ContestPanelHelper.doesRankingGiveBloonstones(_loc4_))
         {
            if(!this.CT_VERBOSE)
            {
            }
            _loc7_ = TownUI.getInstance().contestLoseWeekPanel;
            _loc7_.updateInfo(_loc3_,param1.levelTier);
            _loc7_.onRevealSignal.remove(this.markHistoryAsSeen);
            _loc7_.onRevealSignal.add(this.markHistoryAsSeen);
            ContestLoseWeekPanel.doneViewing.remove(this.onHistoryPanelClosed);
            ContestLoseWeekPanel.doneViewing.add(this.onHistoryPanelClosed);
            PanelManager.getInstance().showPanel(_loc7_);
            return;
         }
         var _loc5_:Boolean = ContestPanelHelper.canPlayerHaveBloonstones(_loc2_,_loc3_,_loc4_);
         if(_loc4_ == 0 && _loc3_[0].score.duration > 0)
         {
            this._dispatchWinForHistory = true;
         }
         var _loc6_:ContestWinWeekPanel = TownUI.getInstance().contestWinWeekPanel;
         ContestWinWeekPanel.doneViewing.remove(this.onHistoryPanelClosed);
         ContestWinWeekPanel.doneViewing.add(this.onHistoryPanelClosed);
         ContestWinWeekPanel.rewardClaimedSignal.remove(this.markHistoryAsSeen);
         if(_loc5_)
         {
            _loc8_ = ContestPanelHelper.CONTESTED_TERRITORY_BLOONSTONES_REWARDS[_loc4_];
            if(!this.CT_VERBOSE)
            {
            }
            this._bloonstoneEndOfWeekReward.value = _loc8_;
            ContestWinWeekPanel.rewardClaimedSignal.add(this.markHistoryAsSeen);
            _loc6_.updateInfo(_loc3_,_loc4_,param1.levelTier,_loc5_);
            PanelManager.getInstance().showPanel(_loc6_);
         }
         else
         {
            if(!this.CT_VERBOSE)
            {
            }
            _loc6_.onRevealSignal.remove(this.markHistoryAsSeen);
            _loc6_.onRevealSignal.add(this.markHistoryAsSeen);
            _loc6_.updateInfo(_loc3_,_loc4_,param1.levelTier,_loc5_);
            PanelManager.getInstance().showPanel(_loc6_);
         }
      }
      
      public function markHistoryAsSeen(... rest) : void
      {
         if(!this.CT_VERBOSE)
         {
         }
         if(this._bloonstoneEndOfWeekReward.value != 0)
         {
            if(!this.CT_VERBOSE)
            {
            }
            ResourceStore.getInstance().bloonstones = ResourceStore.getInstance().bloonstones + this._bloonstoneEndOfWeekReward.value;
            collectBloonstonesSignal.dispatch(ResourceStore.getInstance().townLevel,this._lastHistoryRoomID);
         }
         if(this._dispatchWinForHistory)
         {
            if(!this.CT_VERBOSE)
            {
            }
            winSignal.dispatch();
         }
         endContestSignal.dispatch();
         this.markHistoryAsSeenTracking();
         if(!this.CT_VERBOSE)
         {
         }
         if(false == forceHistory)
         {
            Kloud.closeRoomContestedTerritory(this._lastHistoryRoomID,this._isLastHistoryRoomLegacy);
         }
      }
      
      public function onHistoryPanelClosed(param1:Boolean) : void
      {
         if(isRevealed)
         {
            if(!this.CT_VERBOSE)
            {
            }
            this.requestToJoinContestedTerritory();
         }
         else if(param1)
         {
            if(!this.CT_VERBOSE)
            {
            }
            PanelManager.getInstance().showFreePanel(MonkeyCityMain.getInstance().ui.contestedTerritoryPanel);
         }
         else if(!this.CT_VERBOSE)
         {
         }
      }
      
      public function enterEndOfWeekLoadPeriod() : void
      {
         if(this._inEndOfWeekLoadPeriod)
         {
            if(!this.CT_VERBOSE)
            {
            }
            return;
         }
         if(!this.CT_VERBOSE)
         {
         }
         this.onReset();
         MonkeySystem.getInstance().city.contestedTerritoryData = null;
         this._inEndOfWeekLoadPeriod = true;
         this.populateLoadingFields();
         this.disableInteraction();
         this.fadeInLoadingThrobber();
         this._timeEnteredEndOfWeekLoadPeriod = getTimer();
      }
      
      public function fadeInLoadingThrobber() : void
      {
         this._loadingMessage.alpha = 0;
         this._loadingMessage.visible = true;
         this._loadingMessage.gotoAndPlay(1);
         var transitionTime:Number = 0.5;
         TweenLite.to(this._loadingMessage,transitionTime,{"alpha":1});
         TweenLite.delayedCall(transitionTime,function():void
         {
         });
      }
      
      public function exitEndOfWeekLoadPeriod() : void
      {
         if(!this.CT_VERBOSE)
         {
         }
         this._inEndOfWeekLoadPeriod = false;
         this.enableInteraction();
         this.fadeOutLoadingThrobber();
      }
      
      public function fadeOutLoadingThrobber() : void
      {
         if(false == this._loadingMessage.visible)
         {
            return;
         }
         var transitionTime:Number = 0.2;
         TweenLite.to(this._loadingMessage,transitionTime,{"alpha":0});
         TweenLite.delayedCall(transitionTime,function():void
         {
            _loadingMessage.visible = false;
         });
         this._loadingMessage.stop();
      }
      
      private function checkForDailyPopups() : void
      {
         var _loc4_:Vector.<String> = null;
         var _loc5_:Vector.<Object> = null;
         var _loc6_:Object = null;
         if(!this.CT_VERBOSE)
         {
         }
         var _loc1_:Date = new Date(MonkeySystem.getInstance().getSecureTime());
         var _loc2_:Object = Kloud.loadCookie(CONTESTED_TERRITORY_COOKIE_NAME).data;
         var _loc3_:* = false;
         if(_loc2_.hasOwnProperty(MonkeySystem.getInstance().nkGatewayUser.loginInfo.id) == false)
         {
            _loc3_ = isRevealed == false;
         }
         else if(false == (_loc2_[MonkeySystem.getInstance().nkGatewayUser.loginInfo.id].day == _loc1_.getUTCDate() && _loc2_[MonkeySystem.getInstance().nkGatewayUser.loginInfo.id].month == _loc1_.getUTCMonth() && _loc2_[MonkeySystem.getInstance().nkGatewayUser.loginInfo.id].year == _loc1_.getUTCFullYear()))
         {
            _loc3_ = isRevealed == false;
         }
         if(0 == int(QuestCounter.getInstance().getCustomValue(ContestedTerritoryUnlockedPanel.CONTEST_UNLOCKED_QUEST_STRING)) || MonkeyCityMain.getInstance().ui.contestedTerritoryUnlockedPanel.hasBeenRevealedThisSession)
         {
            _loc3_ = false;
         }
         else if(this.canPopUpLostLeadPanel())
         {
            TownUI.getInstance().contestLostLead.updateInfo(this._sessionData.levelTier,this._leadingPlayerData.userName,this._leadingPlayerData.userID,this._leadingPlayerData.cityLevel,this.getRoundToBeatForLead());
            PanelManager.getInstance().showPanel(TownUI.getInstance().contestLostLead);
            _loc3_ = false;
         }
         if(_loc3_)
         {
            _loc4_ = new Vector.<String>();
            _loc5_ = new Vector.<Object>();
            _loc6_ = _loc2_;
            if(_loc6_.hasOwnProperty(MonkeySystem.getInstance().nkGatewayUser.loginInfo.id))
            {
               _loc6_ = _loc6_[MonkeySystem.getInstance().nkGatewayUser.loginInfo.id];
               _loc6_["day"] = _loc1_.getUTCDate();
               _loc6_["month"] = _loc1_.getUTCMonth();
               _loc6_["year"] = _loc1_.getUTCFullYear();
            }
            else
            {
               _loc6_ = {
                  "day":_loc1_.getUTCDate(),
                  "month":_loc1_.getUTCMonth(),
                  "year":_loc1_.getUTCFullYear()
               };
            }
            _loc4_.push(MonkeySystem.getInstance().nkGatewayUser.loginInfo.id);
            _loc5_.push(_loc6_);
            Kloud.saveCookieFromObjects(CONTESTED_TERRITORY_COOKIE_NAME,_loc4_,_loc5_);
            if(this.isInContestedTerritory())
            {
               TownUI.getInstance().contestDailyPanelWithScores.updateInfo(_system.city.contestedTerritoryData);
               PanelManager.getInstance().showPanel(TownUI.getInstance().contestDailyPanelWithScores,PanelGroups.CONTESTED_TERRITORY);
            }
            else
            {
               PanelManager.getInstance().showPanel(TownUI.getInstance().contestDailyPanel,PanelGroups.CONTESTED_TERRITORY);
            }
         }
         else if(!this.CT_VERBOSE)
         {
         }
      }
      
      override public function reveal(param1:Number = 0.5) : void
      {
         if(Constants.DISABLE_CONTESTED_TERRITORY || Kong.isOnKong() && Constants.DISABLE_CT_ON_KONG)
         {
            return;
         }
         if(isRevealed)
         {
            return;
         }
         this._eventsModule.activate();
         panelRevealedSignal.dispatch(ResourceStore.getInstance().townLevel);
         this._lockedOverlay.visible = false;
         this._bananaTemple.play();
         if(this._inEndOfWeekLoadPeriod)
         {
            if(!this.CT_VERBOSE)
            {
            }
            this._loadingMessage.play();
         }
         else if(this._deferEndOfWeekUpdate)
         {
            if(!this.CT_VERBOSE)
            {
            }
            this.finaliseDeferredContestedTerritoryEnded();
         }
         else if(this._isDataLoaded == false)
         {
            this.disableInteraction();
            this.setAvatarModuleVisiblity(false);
            if(ResourceStore.getInstance().townLevel < CONTESTED_TERRITORY_LEVEL_REQUIREMENT)
            {
               this._lockedOverlay.visible = true;
               this.populateLockedFields();
            }
            else if(false == this.isInContestedTerritory())
            {
               if(!this.CT_VERBOSE)
               {
               }
               this.requestToJoinContestedTerritory();
            }
            else
            {
               if(!this.CT_VERBOSE)
               {
               }
               this.syncFromCityLoadObject();
            }
         }
         else
         {
            this.enableInteraction();
            this.updateTrucks();
         }
         onRevealSignal.addOnce(this.onPanelRevealComplete);
         this._timeOfLastUpdate = 0;
         removeEventListener(Event.ENTER_FRAME,this.onFrameEnterHidden);
         removeEventListener(Event.ENTER_FRAME,this.onFrameEnter);
         addEventListener(Event.ENTER_FRAME,this.onFrameEnter);
         MCSound.getInstance().playSound(MCSound.OPEN_PANEL);
         super.reveal(param1);
      }
      
      private function requestToJoinContestedTerritory() : void
      {
         if(Constants.DISABLE_CONTESTED_TERRITORY)
         {
            return;
         }
         if(this._waitingForJoinResponse)
         {
            if(!this.CT_VERBOSE)
            {
            }
            return;
         }
         if(TownUI.getInstance().gameEventsUIManager.ctMilestonesRewardPanel.isRevealed)
         {
            TownUI.getInstance().gameEventsUIManager.ctMilestonesRewardPanel.hide();
         }
         if(TownUI.getInstance().gameEventsUIManager.ctOccupationRewardPanel.isRevealed)
         {
            TownUI.getInstance().gameEventsUIManager.ctOccupationRewardPanel.hide();
         }
         this.fadeInLoadingThrobber();
         this._waitingForJoinResponse = true;
         if(!this.CT_VERBOSE)
         {
         }
         var _loc1_:int = ContestPanelHelper.getNumOfMondaysSinceFirstMonday(MonkeySystem.getInstance().getSecureTime());
         this._proposedTrackName = ContestPanelHelper.getContestedTerritoryTrackNameBasedOnID(_loc1_ - ContestPanelHelper.CONTESTED_TERRITORY_MAP_STARTING_MONDAY,MonkeySystem.getInstance().city.cityIndex);
         this._proposedRoundGeneratorSeed = _loc1_;
         var _loc2_:Object = {
            "trackName":this._proposedTrackName,
            "seed":this._proposedRoundGeneratorSeed
         };
         Kloud.joinContestedTerritory(ResourceStore.getInstance().townLevel,MonkeySystem.getInstance().userName,MonkeySystem.getInstance().city.name,_loc2_,this.onJoinContestedTerritory);
         this.populateLoadingFields();
      }
      
      private function onPanelRevealComplete(param1:HideRevealView) : void
      {
         onRevealSignal.remove(onRevealComplete);
         this._templeButton.addEventListener(MouseEvent.ROLL_OVER,this.onTempleButtonRollOver);
         this._templeButton.addEventListener(MouseEvent.ROLL_OUT,this.onTempleButtonRollOut);
         this._templeButton.addEventListener(MouseEvent.MOUSE_UP,this.onPlay);
         this._templePlayBanner.addEventListener("TemplePlayBannerRevealed",this.onTemplePlayBannerRevealed);
         this._templePlayBanner.addEventListener("TemplePlayBannerHidden",this.onTemplePlayBannerHidden);
         var _loc2_:int = 0;
         while(_loc2_ < CONTESTED_TERRITORY_NUM_OF_CITIES)
         {
            this._towns[_loc2_].addEventListener(MouseEvent.ROLL_OVER,this.onMouseOver);
            this._towns[_loc2_].addEventListener(MouseEvent.ROLL_OUT,this.onMouseOut);
            _loc2_++;
         }
         var _loc3_:int = 0;
         while(_loc3_ < CONTESTED_TERRITORY_NUM_OF_CITIES)
         {
            this._towns[_loc3_].extraInfoPanel.addEventListener("ExtraInfoRevealed",this.onExtraInfoRevealed);
            this._towns[_loc3_].extraInfoPanel.addEventListener(Event.COMPLETE,this.onExtraInfoAnimationComplete);
            _loc3_++;
         }
         if(false == this._sessionData.amLeading && null != this._myPlayerData)
         {
            updateOccupationSignal.dispatch(this._myPlayerData.timeHoldingTerritory);
         }
      }
      
      override public function hide(param1:Number = 0.5) : void
      {
         if(!isRevealed || this._isInBTDGame)
         {
            return;
         }
         this._eventsModule.deactivate();
         onHideSignal.addOnce(this.onPanelHideComplete);
         this._templeButton.removeEventListener(MouseEvent.ROLL_OVER,this.onTempleButtonRollOver);
         this._templeButton.removeEventListener(MouseEvent.ROLL_OUT,this.onTempleButtonRollOut);
         this._templeButton.removeEventListener(MouseEvent.MOUSE_UP,this.onPlay);
         this._templePlayBanner.removeEventListener("TemplePlayBannerRevealed",this.onTemplePlayBannerRevealed);
         this._templePlayBanner.removeEventListener("TemplePlayBannerHidden",this.onTemplePlayBannerHidden);
         var _loc2_:int = 0;
         while(_loc2_ < CONTESTED_TERRITORY_NUM_OF_CITIES)
         {
            this._towns[_loc2_].removeEventListener(MouseEvent.ROLL_OVER,this.onMouseOver);
            this._towns[_loc2_].removeEventListener(MouseEvent.ROLL_OUT,this.onMouseOut);
            _loc2_++;
         }
         var _loc3_:int = 0;
         while(_loc3_ < CONTESTED_TERRITORY_NUM_OF_CITIES)
         {
            this._towns[_loc3_].extraInfoPanel.removeEventListener("ExtraInfoRevealed",this.onExtraInfoRevealed);
            this._towns[_loc3_].extraInfoPanel.removeEventListener(Event.COMPLETE,this.onExtraInfoAnimationComplete);
            _loc3_++;
         }
         removeEventListener(Event.ENTER_FRAME,this.onFrameEnter);
         removeEventListener(Event.ENTER_FRAME,this.onFrameEnterHidden);
         addEventListener(Event.ENTER_FRAME,this.onFrameEnterHidden);
         this._isUpdatingWhileHidden = true;
         super.hide(param1);
         this.disableInteraction();
      }
      
      private function onPanelHideComplete(param1:HideRevealView) : void
      {
         onHideSignal.remove(onHideComplete);
         this._templeGraphic.gotoAndStop(1);
         this._bananaTemple.gotoAndStop(1);
         this._loadingMessage.gotoAndStop(1);
         var _loc2_:int = 0;
         while(_loc2_ < this._towns.length)
         {
            this._towns[_loc2_].extraInfoPanel.gotoAndStop(1);
            _loc2_++;
         }
         var _loc3_:int = 0;
         while(_loc3_ < this._trucks.length)
         {
            this._trucks[_loc3_].gotoAndStop(1);
            _loc3_++;
         }
      }
      
      private function onJoinContestedTerritory(param1:Object) : void
      {
         var response:Object = param1;
         if(!this.CT_VERBOSE)
         {
         }
         this._waitingForJoinResponse = false;
         if(forceRetryMessageOnJoin)
         {
            response.success = false;
            response.bmc_code = "try_again";
         }
         if(response.success == false)
         {
            if(!this.CT_VERBOSE)
            {
            }
            if(!this.CT_VERBOSE)
            {
            }
            if(response.bmc_code == "try_again")
            {
               if(!this.CT_VERBOSE)
               {
               }
               if(!this.CT_VERBOSE)
               {
               }
               this.fadeInLoadingThrobber();
               TweenLite.delayedCall(JOIN_ERROR_RETRY_INTERVAL,function():void
               {
                  _loadingMessage.visible = false;
                  requestToJoinContestedTerritory();
               });
            }
            else
            {
               this.fadeOutLoadingThrobber();
            }
            return;
         }
         GameEventManager.getInstance().ctOccupationManager.setLastKnownHoldTime(0,MonkeySystem.getInstance().city.cityIndex);
         TownUI.getInstance().gameEventsUIManager.ctOccupationRewardPanel.lastKnownHoldTimeForCity = 0;
         this.fadeOutLoadingThrobber();
         MonkeySystem.getInstance().city.contestedTerritoryData = response;
         this.syncData(response,true);
         this.enableInteraction();
         this._isDataLoaded = true;
         joinedSignal.dispatch();
         if(isRevealed)
         {
            updateOccupationSignal.dispatch(0);
         }
      }
      
      private function onLoadContestedTerritory(param1:Object) : void
      {
         if(!this.CT_VERBOSE)
         {
         }
         if(param1.success == false || param1.contestedTerritory == null)
         {
            if(!this.CT_VERBOSE)
            {
            }
            if(param1.message == "bmc_invalid")
            {
               return;
            }
            if(!this.CT_VERBOSE)
            {
            }
            this.onContestedTerritoryEnded();
            return;
         }
         MonkeySystem.getInstance().city.contestedTerritoryData = param1;
         this.syncData(param1);
         this.enableInteraction();
         this._isDataLoaded = true;
      }
      
      private function syncData(param1:Object, param2:Boolean = false) : void
      {
         var _loc10_:Object = null;
         var _loc11_:int = 0;
         if(!this.CT_VERBOSE)
         {
         }
         if(!this.CT_VERBOSE)
         {
         }
         if(param1 == null)
         {
            if(!this.CT_VERBOSE)
            {
            }
            return;
         }
         var _loc3_:Number = MonkeySystem.getInstance().getSecureTime();
         ContestPanelHelper.patchMissingScores(param1.contestedTerritory);
         var _loc4_:Object = param1.contestedTerritory.cities;
         var _loc5_:Object = param1.contestedTerritory.score;
         this._isLegacyRoom = false;
         if(param1.contestedTerritory.hasOwnProperty("isLegacyRoom"))
         {
            this._isLegacyRoom = param1.contestedTerritory.isLegacyRoom;
         }
         this._sessionData.roomID = param1.contestedTerritory.roomID;
         this._sessionData.levelTier = param1.contestedTerritory.levelTier;
         this._sessionData.minimumRound = param1.contestedTerritory.minRounds;
         if(this._sessionData.levelTier > 9)
         {
            this._sessionData.levelTier = 9;
         }
         if(param1.contestedTerritory != null && param1.contestedTerritory.hasOwnProperty("lastLootTime"))
         {
            this._sessionData.lastLootTime = param1.contestedTerritory.lastLootTime - param1.contestedTerritory.lootTimeOffset;
         }
         else if(!this.CT_VERBOSE)
         {
         }
         var _loc6_:Object = Squeeze.derialiseAndDecompress(param1.contestedTerritory.data);
         if(!this.CT_VERBOSE)
         {
         }
         if(!this.CT_VERBOSE)
         {
         }
         this._sessionData.trackName = _loc6_.trackName;
         this._sessionData.trackData = TrackManager.getInstance().findTrack(this._sessionData.trackName);
         this._sessionData.roundGeneratorSeed = _loc6_.seed;
         this._sessionData.week = ContestPanelHelper.getNumOfMondaysSinceFirstMonday(_loc3_);
         this.saveWeekOfLastKnownCT(this._sessionData.week);
         var _loc7_:Vector.<Object> = ContestPanelHelper.fetchPlayersFromServerResponse(param1.contestedTerritory);
         var _loc8_:Object = ContestPanelHelper.getCurrentLeadingPlayer(_loc7_,this._sessionData.minimumRound,_loc3_);
         ContestPanelHelper.addCurrentLeaderTotal(_loc8_,_loc3_);
         if(false == param1.contestedTerritory.hasOwnProperty("scoreUpdated"))
         {
            param1.contestedTerritory.scoreUpdated = false;
         }
         if(param2)
         {
            param1.contestedTerritory.scoreUpdated = true;
         }
         var _loc9_:int = 0;
         for each(_loc10_ in _loc4_)
         {
            this._playerData[_loc9_].userName = _loc10_.userName;
            this._playerData[_loc9_].userID = _loc10_.userID;
            this._playerData[_loc9_].cityIndex = _loc9_;
            this._playerData[_loc9_].cityLevel = _loc10_.cityLevel;
            this._playerData[_loc9_].cityName = _loc10_.cityName;
            if(this._playerData[_loc9_].userID == MonkeySystem.getInstance().nkGatewayUser.loginInfo.id)
            {
               this._myPlayerData = this._playerData[_loc9_];
               this._myPlayerData.cityLevel = ResourceStore.getInstance().townLevel;
            }
            if(param1.contestedTerritory.scoreUpdated)
            {
               this._playerData[_loc9_].roundsBeatenCurrent = _loc10_.score.current;
               this._playerData[_loc9_].roundsBeatenBest = _loc10_.score.best;
               this._playerData[_loc9_].timestampOfLastCapture = _loc10_.score.time;
               this._playerData[_loc9_].timestampOfLastCaptureWithDuration = _loc10_.score.durationTime;
               this._playerData[_loc9_].timeHoldingTerritory = _loc10_.score.duration;
               this._playerData[_loc9_].timeHoldingTerritoryWithoutCurrent = _loc10_.score.durationWithoutCurrent;
            }
            _loc9_++;
         }
         this._sessionData.numberOfPlayersJoined = _loc9_;
         _loc11_ = _loc9_;
         while(_loc11_ < CONTESTED_TERRITORY_NUM_OF_CITIES)
         {
            this._playerData[_loc11_].userName = "";
            this._playerData[_loc11_].userID = "";
            this._playerData[_loc11_].cityIndex = _loc11_;
            this._playerData[_loc11_].cityLevel = 0;
            this._playerData[_loc11_].cityName = "";
            this._playerData[_loc11_].timeHoldingTerritory = -1;
            this._playerData[_loc11_].timeHoldingTerritoryWithoutCurrent = -1;
            this._playerData[_loc11_].timestampOfLastCapture = -1;
            this._playerData[_loc11_].timestampOfLastCaptureWithDuration = -1;
            this._playerData[_loc11_].roundsBeatenBest = 0;
            _loc11_++;
         }
         this._sessionData.cashPerHour = ResourceStore.getInstance().townLevel * ResourceStore.getInstance().townLevel * 2;
         this._sessionData.cashPerHour = this._sessionData.cashPerHour + 200;
         this._timeUntilNextServerSync = CONTESTED_TERRITORY_SERVER_SYNC_INTERVAL;
         this._timestampThisFrame = getTimer();
         this.updateCities();
         if(param1.contestedTerritory.scoreUpdated)
         {
            if(_loc8_ != null)
            {
               if(this.hasScoreTimestampExpired(_loc8_.score.time))
               {
                  _loc8_ = null;
               }
            }
            this.updateLeader(!!_loc8_?_loc8_.userID:"-1");
         }
         this.lastLootTimeSanityCheck();
         this.updateTimeHeldPanel();
         this.updateExtraInfoPanels();
         this.updateCollectCashField();
         this.updateTier();
         this.updateBloonRetake(_loc3_);
         this._playButton.fadeIn(0);
         this._timeOfLastUpdate = 0;
      }
      
      private function syncDataWithOnlyScoreObject(param1:Object) : void
      {
         var _loc7_:Object = null;
         if(!this.CT_VERBOSE)
         {
         }
         if(!this.CT_VERBOSE)
         {
         }
         if(param1 == null)
         {
            if(!this.CT_VERBOSE)
            {
            }
            return;
         }
         var _loc2_:Number = MonkeySystem.getInstance().getSecureTime();
         ContestPanelHelper.patchMissingScoresOfScoreObject(param1);
         var _loc3_:Vector.<Object> = ContestPanelHelper.fetchScoresFromScoreObject(param1);
         var _loc4_:* = _loc3_.length != 0;
         var _loc5_:Object = null;
         if(_loc4_)
         {
            _loc5_ = ContestPanelHelper.getCurrentLeadingScoreFromScores(_loc3_,this._sessionData.minimumRound,_loc2_);
            ContestPanelHelper.addCurrentLeaderTotalToScoreObject(_loc5_,_loc2_);
            if(_loc5_ != null)
            {
               if(this.hasScoreTimestampExpired(_loc5_.time))
               {
                  _loc5_ = null;
               }
            }
         }
         var _loc6_:int = 0;
         while(_loc6_ < this._sessionData.numberOfPlayersJoined)
         {
            _loc7_ = param1[this._playerData[_loc6_].userID];
            if(_loc7_ == null)
            {
               this._playerData[_loc6_].roundsBeatenCurrent = 0;
               this._playerData[_loc6_].roundsBeatenBest = 0;
               this._playerData[_loc6_].timestampOfLastCapture = 0;
               this._playerData[_loc6_].timestampOfLastCaptureWithDuration = 0;
               this._playerData[_loc6_].timeHoldingTerritory = 0;
               this._playerData[_loc6_].timeHoldingTerritoryWithoutCurrent = 0;
            }
            else
            {
               this._playerData[_loc6_].roundsBeatenCurrent = _loc7_.current;
               this._playerData[_loc6_].roundsBeatenBest = _loc7_.best;
               this._playerData[_loc6_].timestampOfLastCapture = _loc7_.time;
               this._playerData[_loc6_].timestampOfLastCaptureWithDuration = _loc7_.durationTime;
               this._playerData[_loc6_].timeHoldingTerritory = _loc7_.duration;
               this._playerData[_loc6_].timeHoldingTerritoryWithoutCurrent = _loc7_.durationWithoutCurrent;
            }
            _loc6_++;
         }
         if(_loc4_)
         {
            this.updateLeader(!!_loc5_?_loc5_.userID:"-1");
            this.updateTimeHeldPanel();
            this.updateExtraInfoPanels();
         }
         this.lastLootTimeSanityCheck();
         this._timeUntilNextServerSync = CONTESTED_TERRITORY_SERVER_SYNC_INTERVAL;
         this._timestampThisFrame = getTimer();
         this._timeOfLastUpdate = 0;
      }
      
      private function updateBestScoresWithScoreObject(param1:Object) : void
      {
         ContestPanelHelper.patchMissingScores(param1);
         var _loc2_:Vector.<Object> = ContestPanelHelper.fetchScoresFromScoreObject(param1);
         var _loc3_:int = 0;
         while(_loc3_ < this._sessionData.numberOfPlayersJoined)
         {
            if(param1[this._playerData[_loc3_].userID] != null)
            {
               this._playerData[_loc3_].roundsBeatenBest = param1[this._playerData[_loc3_].userID].best;
            }
            _loc3_++;
         }
         if(!this.CT_VERBOSE)
         {
         }
      }
      
      private function onContestedTerritoryEnded() : void
      {
         if(isRevealed)
         {
            this.finaliseDeferredContestedTerritoryEnded();
         }
         else
         {
            this.enterDeferEndOfWeekUpdate();
         }
      }
      
      private function enterDeferEndOfWeekUpdate() : void
      {
         if(!this.CT_VERBOSE)
         {
         }
         this.onReset();
         MonkeySystem.getInstance().city.contestedTerritoryData = null;
         this._deferEndOfWeekUpdate = true;
         var _loc1_:Number = 1000 * 60 * 5;
         var _loc2_:Number = 1000 * 60 * 25;
         this._deferEndOfWeekUpdateDelayTime = Math.random() * _loc2_ + _loc1_;
         this._timeEnteredDeferEndOfWeekUpdate = getTimer();
         if(!this.CT_VERBOSE)
         {
         }
      }
      
      private function updateDeferEndOfWeekUpdate() : void
      {
         if(getTimer() - this._timeEnteredDeferEndOfWeekUpdate > this._deferEndOfWeekUpdateDelayTime)
         {
            this.finaliseDeferredContestedTerritoryEnded();
            return;
         }
      }
      
      private function finaliseDeferredContestedTerritoryEnded() : void
      {
         if(!this.CT_VERBOSE)
         {
         }
         if(this._inEndOfWeekLoadPeriod)
         {
            if(!this.CT_VERBOSE)
            {
            }
            return;
         }
         this._deferEndOfWeekUpdate = false;
         this.requestToLoadHistory();
      }
      
      private function requestToLoadHistory() : void
      {
         if(this._waitingForLoadHistoryResponse)
         {
            return;
         }
         this.fadeInLoadingThrobber();
         this._waitingForLoadHistoryResponse = true;
         Kloud.loadHistoryContestedTerritory(this.onHistoryLoad);
      }
      
      public function updateCities() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < CONTESTED_TERRITORY_NUM_OF_CITIES)
         {
            this._towns[_loc1_].townTier.gotoAndStop(this._sessionData.levelTier);
            if(_loc1_ >= this._sessionData.numberOfPlayersJoined)
            {
               this._towns[_loc1_].townTier.visible = false;
               this._towns[_loc1_].avatarModule.visible = false;
               this._towns[_loc1_].extraInfoPanel.visible = false;
               this._towns[_loc1_].territoryOwnerStar.visible = false;
               this._towns[_loc1_].playerNameAvatarField.text = "";
               this._towns[_loc1_].avatarModule.levelField.text = "";
            }
            else
            {
               this._towns[_loc1_].townTier.visible = true;
               this._towns[_loc1_].playerNameAvatarField.visible = true;
               this._towns[_loc1_].playerNameAvatarField.text = this._playerData[_loc1_].userName;
               this._towns[_loc1_].avatarModule.visible = true;
               if(this._playerData[_loc1_].userID == this._myPlayerData.userID)
               {
                  this._towns[_loc1_].avatarModule.levelField.text = String(this.applyLevelCap(ResourceStore.getInstance().townLevel));
                  this._towns[_loc1_].avatarModule.levelField.text = String(this.applyLevelCap(this._playerData[_loc1_].cityLevel));
               }
               else
               {
                  this._towns[_loc1_].avatarModule.levelField.text = String(this.applyLevelCap(this._playerData[_loc1_].cityLevel));
               }
               this._towns[_loc1_].avatarModule.clanContainer.removeChildren();
               this._towns[_loc1_].avatarModule.clanContainer.addChild(new ClanLoader(this._playerData[_loc1_].userID));
               this._towns[_loc1_].avatarModule.avatarContainer.container.removeChildren();
               this._towns[_loc1_].avatarModule.avatarContainer.container.addChild(new AvatarLoader(this._playerData[_loc1_].userID));
               this._towns[_loc1_].avatarModule.play();
               this._towns[_loc1_].extraInfoPanel.visible = true;
            }
            _loc1_++;
         }
      }
      
      public function updateTimeHeldPanel() : void
      {
         this.updateDaysRemainingField(this._sessionData.getDaysRemaining());
         this._playerDataSorted.length = 0;
         var j:int = 0;
         while(j < this._playerData.length)
         {
            this._playerDataSorted.push(this._playerData[j]);
            j++;
         }
         this._playerDataSorted.sort(function(param1:ContestedTerritoryPlayerData, param2:ContestedTerritoryPlayerData):int
         {
            if(param1.timeHoldingTerritory > param2.timeHoldingTerritory)
            {
               return -1;
            }
            if(param1.timeHoldingTerritory < param2.timeHoldingTerritory)
            {
               return 1;
            }
            return 0;
         });
         var i:int = 0;
         while(i < CONTESTED_TERRITORY_NUM_OF_CITIES)
         {
            if(i >= this._sessionData.numberOfPlayersJoined)
            {
               this._scoreNameFields[i].text = "";
               this._scoreTimeFields[i].text = "";
            }
            else
            {
               this._scoreNameFields[i].text = this._playerDataSorted[i].userName;
               this._scoreTimeFields[i].text = this.getTimeStringDaysFromUnixTime(this._playerDataSorted[i].timeHoldingTerritory);
            }
            i++;
         }
      }
      
      public function updateLeader(param1:String = "-1") : void
      {
         if(param1 == "-1")
         {
            if(!this.CT_VERBOSE)
            {
            }
            this.updateNoLeader();
            return;
         }
         var _loc2_:ContestedTerritoryPlayerData = null;
         var _loc3_:int = 0;
         while(_loc3_ < this._sessionData.numberOfPlayersJoined)
         {
            if(param1 == this._playerData[_loc3_].userID)
            {
               _loc2_ = this._playerData[_loc3_];
               this._leadingPlayerCityID = _loc3_;
               break;
            }
            _loc3_++;
         }
         if(_loc2_ == null)
         {
            if(!this.CT_VERBOSE)
            {
            }
            this._sessionData.amLeading = false;
            this._playerControlsCTWhileInGame = this._sessionData.amLeading;
            return;
         }
         this._lastKnownLeadingPlayerUserID = _loc2_.userID;
         this._sessionData.amLeading = _loc2_.userID == this._myPlayerData.userID;
         this._playerControlsCTWhileInGame = this._sessionData.amLeading;
         if(false == this._hasFoundFirstLeader)
         {
            this._hasFoundFirstLeader = true;
            this._previousLeadingPlayerData = null;
            this._leadingPlayerData = _loc2_;
         }
         else if(_loc2_.userID != this._leadingPlayerData.userID)
         {
            if(!this.CT_VERBOSE)
            {
            }
            this._previousLeadingPlayerData = this._leadingPlayerData;
            this._leadingPlayerData = _loc2_;
            if(this._previousLeadingPlayerData.userID == this._myPlayerData.userID)
            {
               MonkeyCityMain.getInstance().ui.contestLostLead.updateInfo(this._sessionData.levelTier,this._leadingPlayerData.userName,this._leadingPlayerData.userID,this._leadingPlayerData.cityLevel,this.getRoundToBeatForLead());
               if(false == MonkeyCityMain.getInstance().ui.contestLostLead.isRevealed)
               {
                  PanelManager.getInstance().showPanel(MonkeyCityMain.getInstance().ui.contestLostLead);
               }
            }
         }
         this.updateTrucks();
         this.updateStars();
         this.updateHeldPlayerNameField(this._leadingPlayerData.userName);
         this.updateTimeOnCollectButtonField(0);
         this.updateRoundField(this._leadingPlayerData.roundsBeatenCurrent);
         if(this.isContestedTerritoryClaimed())
         {
            this.saveLastRecordedOwnerUserID();
         }
      }
      
      private function updateNoLeader() : void
      {
         this._leadingPlayerData = null;
         this._leadingPlayerCityID = -1;
         this._clip.heldDataContainer.roundField.text = LocalisationConstants.CONTEST_UNCLAIMED;
         this._clip.heldDataContainer.heldPlayerField.text = LocalisationConstants.CONTEST_UNCLAIMED_ROUND.split("<round>").join(String(this.getRoundToBeatForLead()));
         this._clip.heldDataContainer.timeHeldField.text = "";
         this.updateTrucks();
         this.updateStars();
         this._sessionData.amLeading = false;
         this._playerControlsCTWhileInGame = this._sessionData.amLeading;
         this._hasFoundFirstLeader = false;
         if(this.canPopUpExpiredPanel())
         {
            PanelManager.getInstance().showPanel(MonkeyCityMain.getInstance().ui.contestExpiredPanel);
         }
      }
      
      private function hasScoreTimestampExpired(param1:Number) : Boolean
      {
         var _loc2_:Number = MonkeySystem.getInstance().getSecureTime();
         var _loc3_:Number = _loc2_ - param1;
         return _loc3_ >= ContestPanelHelper.CONTESTED_TERRITORY_MAX_CAPTURE_TIME;
      }
      
      private function canPopUpExpiredPanel() : Boolean
      {
         var _loc5_:Vector.<String> = null;
         var _loc6_:Vector.<Object> = null;
         var _loc7_:Object = null;
         var _loc1_:Object = Kloud.loadCookie(CONTESTED_TERRITORY_COOKIE_NAME).data;
         var _loc2_:Boolean = false;
         if(this.hasScoreTimestampExpired(this._myPlayerData.timestampOfLastCapture) == false)
         {
            return false;
         }
         var _loc3_:String = this.getLatestOwnerUserID();
         var _loc4_:String = "expiryTimeCity" + MonkeySystem.getInstance().city.cityIndex;
         if(_loc3_ == this._myPlayerData.userID)
         {
            if(_loc1_.hasOwnProperty(this._myPlayerData.userID) == false)
            {
               _loc2_ = true;
            }
            else if(_loc1_[this._myPlayerData.userID].hasOwnProperty(_loc4_) == false)
            {
               _loc2_ = true;
            }
            else if(_loc1_[this._myPlayerData.userID][_loc4_] != this._myPlayerData.timestampOfLastCapture)
            {
               _loc2_ = true;
            }
         }
         if(_loc2_)
         {
            _loc5_ = new Vector.<String>();
            _loc6_ = new Vector.<Object>();
            _loc7_ = _loc1_;
            if(_loc7_.hasOwnProperty(this._myPlayerData.userID))
            {
               _loc7_ = _loc7_[this._myPlayerData.userID];
               _loc7_[_loc4_] = this._myPlayerData.timestampOfLastCapture;
            }
            else
            {
               _loc7_ = {_loc4_.valueOf():this._myPlayerData.timestampOfLastCapture};
            }
            _loc5_.push(this._myPlayerData.userID);
            _loc6_.push(_loc7_);
            Kloud.saveCookieFromObjects(CONTESTED_TERRITORY_COOKIE_NAME,_loc5_,_loc6_);
         }
         return _loc2_;
      }
      
      private function getLatestOwnerUserID() : String
      {
         var _loc1_:String = "-1";
         var _loc2_:Number = 0;
         var _loc3_:int = 0;
         while(_loc3_ < this._sessionData.numberOfPlayersJoined)
         {
            if(this._playerData[_loc3_].timestampOfLastCapture > _loc2_)
            {
               _loc1_ = this._playerData[_loc3_].userID;
               _loc2_ = this._playerData[_loc3_].timestampOfLastCapture;
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      private function canPopUpLostLeadPanel() : Boolean
      {
         var _loc4_:String = null;
         var _loc1_:Object = Kloud.loadCookie(CONTESTED_TERRITORY_COOKIE_NAME).data;
         var _loc2_:String = MonkeySystem.getInstance().nkGatewayUser.loginInfo.id;
         if(this._hasFoundFirstLeader == false)
         {
            return false;
         }
         if(this._sessionData.amLeading)
         {
            return false;
         }
         if(this.hasScoreTimestampExpired(this._myPlayerData.timestampOfLastCapture))
         {
            return false;
         }
         if(false == _loc1_.hasOwnProperty(_loc2_))
         {
            return false;
         }
         var _loc3_:String = "lastRecordedOwnerUserIDCity" + MonkeySystem.getInstance().city.cityIndex;
         if(_loc1_[_loc2_].hasOwnProperty(_loc3_.valueOf()) && _loc1_[_loc2_].hasOwnProperty("week"))
         {
            if(_loc1_[_loc2_].week != ContestPanelHelper.getNumOfMondaysSinceFirstMonday(MonkeySystem.getInstance().getSecureTime()))
            {
               return false;
            }
            _loc4_ = this.getLatestOwnerUserID();
            if(_loc1_[_loc2_][_loc3_] == _loc2_ && _loc4_ != _loc2_)
            {
               return true;
            }
         }
         return false;
      }
      
      private function saveLastRecordedOwnerUserID() : void
      {
         var _loc1_:Vector.<String> = new Vector.<String>();
         var _loc2_:Vector.<Object> = new Vector.<Object>();
         var _loc3_:Object = Kloud.loadCookie(CONTESTED_TERRITORY_COOKIE_NAME).data;
         var _loc4_:String = "lastRecordedOwnerUserIDCity" + MonkeySystem.getInstance().city.cityIndex;
         if(_loc3_.hasOwnProperty(MonkeySystem.getInstance().nkGatewayUser.loginInfo.id))
         {
            _loc3_ = _loc3_[MonkeySystem.getInstance().nkGatewayUser.loginInfo.id];
            _loc3_[_loc4_] = this._leadingPlayerData.userID;
            _loc3_["week"] = ContestPanelHelper.getNumOfMondaysSinceFirstMonday(MonkeySystem.getInstance().getSecureTime());
         }
         else
         {
            _loc3_ = {
               _loc4_.valueOf():this._leadingPlayerData.userID,
               "week":ContestPanelHelper.getNumOfMondaysSinceFirstMonday(MonkeySystem.getInstance().getSecureTime())
            };
         }
         _loc1_.push(MonkeySystem.getInstance().nkGatewayUser.loginInfo.id);
         _loc2_.push(_loc3_);
         Kloud.saveCookieFromObjects(CONTESTED_TERRITORY_COOKIE_NAME,_loc1_,_loc2_);
      }
      
      public function updateCollectCashField() : void
      {
         if(this._sessionData.amLeading == false)
         {
            this._collectionButton.target.visible = false;
            return;
         }
         this._collectionButton.target.useHandCursor = true;
         this._collectionButton.target.visible = true;
         this.squeezeCashFromCashTime();
         this._collectionButton.target.goldField.text = String(this._sessionData.cash);
      }
      
      private function updateDaysRemainingField(param1:Number) : void
      {
         this._scoreBoard.daysBoardField.text = LocalisationConstants.CONTEST_DAYS_REMAINING.split("<days remaining>").join(String(param1));
      }
      
      private function updateHeldPlayerNameField(param1:String) : void
      {
         this._clip.heldDataContainer.heldPlayerField.text = LocalisationConstants.CONTEST_HELD_BY.split("<player name>").join(param1);
      }
      
      private function updateRoundField(param1:int) : void
      {
         this._clip.heldDataContainer.roundField.text = LocalisationConstants.CONTEST_ROUND.split("<round number>").join(String(param1));
      }
      
      private function updateTimeOnCollectButtonField(param1:Number) : void
      {
         this._clip.heldDataContainer.timeHeldField.text = LocalisationConstants.CONTEST_FOR.split("<time>").join(this.getTimeStringHoursFromUnixTime(param1));
      }
      
      private function updateExtraInfoPanels() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._sessionData.numberOfPlayersJoined)
         {
            this._towns[_loc1_].extraInfoPanel.extraInfoContainer.extraCityNameField.text = this._playerData[_loc1_].cityName;
            this._towns[_loc1_].extraInfoPanel.extraInfoContainer.extraRoundField.text = LocalisationConstants.CONTEST_EXTRA_INFO_ROUND.split("<round>").join(String(this._playerData[_loc1_].roundsBeatenBest));
            this._towns[_loc1_].extraInfoPanel.extraInfoContainer.extraTimeField.text = this.getTimeStringDaysFromUnixTime(this._playerData[_loc1_].timeHoldingTerritory);
            _loc1_++;
         }
      }
      
      private function updateTrucks() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._trucks.length)
         {
            this._trucks[_loc1_].stop();
            this._trucks[_loc1_].visible = false;
            _loc1_++;
         }
         if(this.isContestedTerritoryClaimed())
         {
            this._trucks[this._leadingPlayerCityID].play();
            this._trucks[this._leadingPlayerCityID].visible = true;
         }
      }
      
      private function updateStars() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._towns.length)
         {
            this._towns[_loc1_].territoryOwnerStar.visible = false;
            _loc1_++;
         }
         if(this.isContestedTerritoryClaimed())
         {
            this._towns[this._leadingPlayerCityID].territoryOwnerStar.visible = true;
         }
      }
      
      private function updateBloonRetake(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         if(this.isContestedTerritoryClaimed())
         {
            _loc2_ = param1 - this._leadingPlayerData.timestampOfLastCapture;
            this._bloonRetakeContainer.visible = true;
            this._bloonRetakeContainer.resetTimerField.text = this.getTimeStringHoursFromUnixTime(ContestPanelHelper.CONTESTED_TERRITORY_MAX_CAPTURE_TIME - _loc2_);
         }
         else
         {
            this._bloonRetakeContainer.visible = false;
         }
      }
      
      private function updateTier() : void
      {
         this._clip.contestedTerritoryTitle.contestedTerritoryTitle.text = LocalisationConstants.CONTEST_TIER_TITLE.split("<tier>").join(this._sessionData.levelTier.toString());
      }
      
      public function onFrameEnter(param1:Event) : void
      {
         var _loc2_:Number = NaN;
         if(Constants.DISABLE_CONTESTED_TERRITORY)
         {
            return;
         }
         if(this._inEndOfWeekLoadPeriod)
         {
            return;
         }
         if(this._deferEndOfWeekUpdate)
         {
            this.updateDeferEndOfWeekUpdate();
            return;
         }
         if(false == this._isDataLoaded)
         {
            return;
         }
         if(this._waitingForLoadHistoryResponse)
         {
            return;
         }
         if(this._waitingForJoinResponse)
         {
            return;
         }
         if(getTimer() - this._timeOfLastUpdate > this.TIMER_UPDATE_INTERVAL)
         {
            _loc2_ = MonkeySystem.getInstance().getSecureTime();
            this.updateTimes(_loc2_);
            this.frameEnter(_loc2_);
            this._timeOfLastUpdate = getTimer();
         }
      }
      
      public function onFrameEnterHidden(param1:Event) : void
      {
         var _loc2_:Number = NaN;
         if(Constants.DISABLE_CONTESTED_TERRITORY)
         {
            return;
         }
         if(this._inEndOfWeekLoadPeriod)
         {
            return;
         }
         if(this._deferEndOfWeekUpdate)
         {
            this.updateDeferEndOfWeekUpdate();
            return;
         }
         if(false == this._isDataLoaded)
         {
            return;
         }
         if(getTimer() - this._timeOfLastUpdate > this.TIMER_UPDATE_INTERVAL)
         {
            _loc2_ = MonkeySystem.getInstance().getSecureTime();
            this.frameEnter(_loc2_);
            this._timeOfLastUpdate = getTimer();
         }
      }
      
      private function frameEnter(param1:Number) : void
      {
         var _loc2_:int = ContestPanelHelper.getNumOfMondaysSinceFirstMonday(param1);
         if(this._sessionData.week != _loc2_)
         {
            if(!this.CT_VERBOSE)
            {
            }
            this.onContestedTerritoryEnded();
            return;
         }
         var _loc3_:Number = this._timestampThisFrame;
         this._timestampThisFrame = getTimer();
         var _loc4_:Number = this._timestampThisFrame - _loc3_;
         this._timeUntilNextServerSync = this._timeUntilNextServerSync - _loc4_;
         if(this.hasLeadExpiredThisFrame(param1))
         {
            this.onLeadingPlayerExpiredThisFrame();
            return;
         }
         this.syncToServer();
      }
      
      private function syncToServer() : void
      {
         if(this._isWaitingForScoreToSave || this._deferEndOfWeekUpdate || this._syncing || this._inEndOfWeekLoadPeriod)
         {
            return;
         }
         if(this._timeUntilNextServerSync < 0)
         {
            if(!this.CT_VERBOSE)
            {
            }
            this._timeUntilNextServerSync = CONTESTED_TERRITORY_SERVER_SYNC_INTERVAL;
            this._timestampThisFrame = getTimer();
            this._syncing = true;
            Kloud.updateContestedTerritory(this._sessionData.roomID,this.getLatestScoreTransactionTime(),this.onServerSync);
         }
      }
      
      public function onServerSync(param1:Object) : void
      {
         var _loc2_:int = 0;
         if(!this.CT_VERBOSE)
         {
         }
         this._syncing = false;
         if(param1.success == false)
         {
            if(!this.CT_VERBOSE)
            {
            }
            if(!this.CT_VERBOSE)
            {
            }
            return;
         }
         if(param1.contestedTerritory.scoreUpdated == false)
         {
            if(!this.CT_VERBOSE)
            {
            }
            return;
         }
         if(this._isLegacyRoom)
         {
            if(!this.CT_VERBOSE)
            {
            }
            this.syncDataWithOnlyScoreObject(param1.contestedTerritory.score);
            _loc2_ = 0;
            if(param1.contestedTerritory.hasOwnProperty("cities"))
            {
               _loc2_ = (this._lastResponseFromSaveScore.contestedTerritory.cities as Array).length;
            }
            if(_loc2_ != this._sessionData.numberOfPlayersJoined || this.checkForForeignUserInScoreObject(param1.contestedTerritory.score))
            {
               if(!this.CT_VERBOSE)
               {
               }
               Kloud.loadContestedTerritory(this.getLatestScoreTransactionTime(),this.onLoadContestedTerritory);
            }
         }
         else
         {
            if(!this.CT_VERBOSE)
            {
            }
            this.onLoadContestedTerritory(param1);
         }
      }
      
      public function updateTimes(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(this._inEndOfWeekLoadPeriod)
         {
            return;
         }
         this.updateBloonRetake(param1);
         this.updateCollectCashField();
         if(this.isContestedTerritoryClaimed())
         {
            _loc2_ = param1 - this._leadingPlayerData.timestampOfLastCapture;
            _loc3_ = param1 - Math.max(this._leadingPlayerData.timestampOfLastCapture,this._leadingPlayerData.timestampOfLastCaptureWithDuration);
            this._leadingPlayerData.timeHoldingTerritory = this._leadingPlayerData.timeHoldingTerritoryWithoutCurrent + _loc3_;
            this.updateExtraInfoPanels();
            this.updateTimeOnCollectButtonField(_loc2_);
            this.updateTimeHeldPanel();
            if(this._sessionData.amLeading)
            {
               updateOccupationSignal.dispatch(this._leadingPlayerData.timeHoldingTerritory);
            }
         }
      }
      
      private function hasLeadExpiredThisFrame(param1:Number = -1) : Boolean
      {
         if(this.isContestedTerritoryClaimed() == false)
         {
            return false;
         }
         param1 = param1 == -1?Number(MonkeySystem.getInstance().getSecureTime()):Number(param1);
         var _loc2_:Number = param1 - this._leadingPlayerData.timestampOfLastCapture;
         var _loc3_:* = _loc2_ >= ContestPanelHelper.CONTESTED_TERRITORY_MAX_CAPTURE_TIME;
         return _loc3_;
      }
      
      private function onLeadingPlayerExpiredThisFrame() : void
      {
         if(this.canPopUpExpiredPanel())
         {
            PanelManager.getInstance().showPanel(MonkeyCityMain.getInstance().ui.contestExpiredPanel);
         }
         this._leadingPlayerData.timeHoldingTerritory = this._leadingPlayerData.timeHoldingTerritoryWithoutCurrent + ContestPanelHelper.CONTESTED_TERRITORY_MAX_CAPTURE_TIME;
         this._leadingPlayerData.timeHoldingTerritoryWithoutCurrent = this._leadingPlayerData.timeHoldingTerritory;
         this.updateNoLeader();
         this.updateExtraInfoPanels();
         this.updateTimeHeldPanel();
         this.updateCollectCashField();
      }
      
      private function isContestedTerritoryClaimed() : Boolean
      {
         return this._leadingPlayerData != null;
      }
      
      private function disableInteraction() : void
      {
         this._collectionButton.disableMouseInteraction();
         this._playButton.disableMouseInteraction();
         this._templeButton.mouseEnabled = false;
      }
      
      private function enableInteraction() : void
      {
         this._collectionButton.enableMouseInteraction();
         this._playButton.enableMouseInteraction();
         this._closeButton.enableMouseInteraction();
         this._templeButton.mouseEnabled = true;
      }
      
      private function onCollect() : void
      {
         if(this._sessionData.cash <= 0 || this._collectingCash)
         {
            return;
         }
         if(!this.CT_VERBOSE)
         {
         }
         this._cashBeforeCollect = ResourceStore.getInstance().monkeyMoney;
         this._cashAfterCollect = this._cashBeforeCollect + this._sessionData.cash;
         this._timeCashedUpUntil = this._sessionData.lastLootTime;
         if(ResourceStore.getInstance().monkeyMoney >= ResourceStore.getInstance().bankCapacity)
         {
            this.showBanksFullAnimation();
            ResourceStore.getInstance().banksAreFullSignal.dispatch();
            if(!this.CT_VERBOSE)
            {
            }
            return;
         }
         if(this._cashAfterCollect > ResourceStore.getInstance().bankCapacity)
         {
            this._cashAfterCollect = ResourceStore.getInstance().bankCapacity;
            this._timeCashedUpUntil = this.calculateNewCashTimeFromCollectedCash(this._cashAfterCollect - this._cashBeforeCollect);
         }
         else
         {
            this._timeCashedUpUntil = MonkeySystem.getInstance().getSecureTime();
         }
         Kloud.collectLootContestedTerritory(this._timeCashedUpUntil,this._sessionData.roomID,this.onServerCollectLoot);
         this.showCoinBurst();
         this._collectingCash = true;
      }
      
      private function onServerCollectLoot(param1:Object) : void
      {
         this._collectingCash = false;
         if(param1.success == false)
         {
            if(!this.CT_VERBOSE)
            {
            }
            if(!this.CT_VERBOSE)
            {
            }
            if(param1.bmc_code == "low_score")
            {
               if(!this.CT_VERBOSE)
               {
               }
               Kloud.loadContestedTerritory(this.getLatestScoreTransactionTime(),this.onLoadContestedTerritory);
               this._timeUntilNextServerSync = CONTESTED_TERRITORY_SERVER_SYNC_INTERVAL;
               this._timestampThisFrame = getTimer();
            }
            return;
         }
         if(!this.CT_VERBOSE)
         {
         }
         this._sessionData.lastLootTime = this._timeCashedUpUntil;
         if(!this.CT_VERBOSE)
         {
         }
         var _loc2_:Number = this._cashAfterCollect - this._cashBeforeCollect;
         if(_loc2_ == 0)
         {
            return;
         }
         collectCashSignal.dispatch(ResourceStore.getInstance().townLevel,_loc2_,this._sessionData.roomID);
         ResourceStore.getInstance().setMonkeyMoney(this._cashAfterCollect,false);
         this._sessionData.cash = this._sessionData.cash - _loc2_;
         if(this._sessionData.cash != 0)
         {
            ResourceStore.getInstance().banksAreFullSignal.dispatch();
         }
         this.updateCollectCashField();
      }
      
      public function onPlay(param1:MouseEvent = null) : void
      {
         var e:MouseEvent = param1;
         MonkeyCityMain.getInstance().ui.attackPanelContest.syncToTrackData(this._sessionData.trackData);
         MonkeyCityMain.getInstance().ui.attackPanelContest.attackClickedSignal.addOnce(this.startGame);
         MonkeyCityMain.getInstance().ui.attackPanelContest.cancelClickedSignal.addOnce(function():void
         {
            MonkeyCityMain.getInstance().ui.attackPanelContest.attackClickedSignal.remove(startGame);
         });
         PanelManager.getInstance().showPanel(TownUI.getInstance().attackPanelContest,null,2);
      }
      
      private function squeezeCashFromCashTime() : void
      {
         if(this._collectingCash)
         {
            return;
         }
         var _loc1_:Number = MonkeySystem.getInstance().getSecureTime() - this._sessionData.lastLootTime;
         this._sessionData.cash = int(_loc1_ / MILLISECONDS_IN_AN_HOUR * this._sessionData.cashPerHour);
      }
      
      private function calculateNewCashTimeFromCollectedCash(param1:Number) : Number
      {
         var _loc2_:Number = this._sessionData.lastLootTime;
         _loc2_ = _loc2_ + this.translateCashToCashTime(param1);
         return _loc2_;
      }
      
      private function translateCashToCashTime(param1:Number) : Number
      {
         return param1 / this._sessionData.cashPerHour * MILLISECONDS_IN_AN_HOUR;
      }
      
      private function populateLoadingFields() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._towns.length)
         {
            this._towns[_loc1_].avatarModule.visible = false;
            this._towns[_loc1_].territoryOwnerStar.visible = false;
            this._towns[_loc1_].extraInfoPanel.visible = false;
            _loc1_++;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this._towns.length)
         {
            this._towns[_loc2_].playerNameAvatarField.text = "Loading...";
            _loc2_++;
         }
         var _loc3_:int = 0;
         while(_loc3_ < this._scoreNameFields.length)
         {
            this._scoreNameFields[_loc3_].text = "";
            this._scoreTimeFields[_loc3_].text = "";
            _loc3_++;
         }
         var _loc4_:int = 0;
         while(_loc4_ < this._trucks.length)
         {
            this._trucks[_loc4_].stop();
            this._trucks[_loc4_].visible = false;
            _loc4_++;
         }
         this._clip.heldDataContainer.roundField.text = "Loading...";
         this._clip.heldDataContainer.heldPlayerField.text = "";
         this._clip.heldDataContainer.timeHeldField.text = "";
         this._scoreBoard.daysBoardField.text = "Loading...";
         this._collectionButton.target.goldField.text = "";
         this._bloonRetakeContainer.visible = false;
         this._collectionButton.target.visible = false;
         this._playButton.target.visible = false;
      }
      
      private function populateLockedFields() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._towns.length)
         {
            this._towns[_loc1_].avatarModule.visible = false;
            this._towns[_loc1_].territoryOwnerStar.visible = false;
            this._towns[_loc1_].extraInfoPanel.visible = false;
            _loc1_++;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this._towns.length)
         {
            this._towns[_loc2_].playerNameAvatarField.text = "";
            _loc2_++;
         }
         var _loc3_:int = 0;
         while(_loc3_ < this._scoreNameFields.length)
         {
            this._scoreNameFields[_loc3_].text = "";
            this._scoreTimeFields[_loc3_].text = "";
            _loc3_++;
         }
         this._clip.heldDataContainer.roundField.text = "";
         this._clip.heldDataContainer.heldPlayerField.text = "";
         this._clip.heldDataContainer.timeHeldField.text = "";
         this._scoreBoard.daysBoardField.text = "";
         this._collectionButton.target.goldField.text = "";
         this._bananaTemple.stop();
      }
      
      private function onMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:TownAvatarContainer = param1.target as TownAvatarContainer;
         _loc2_.extraInfoPanel.play();
         var _loc3_:int = 0;
         while(_loc3_ < this._sessionData.numberOfPlayersJoined)
         {
            if(this._towns[_loc3_].name == _loc2_.name)
            {
               this._isMouseOverCity[_loc3_] = true;
            }
            _loc3_++;
         }
      }
      
      private function onMouseOut(param1:MouseEvent) : void
      {
         var _loc2_:TownAvatarContainer = param1.target as TownAvatarContainer;
         _loc2_.extraInfoPanel.play();
         var _loc3_:int = 0;
         while(_loc3_ < this._sessionData.numberOfPlayersJoined)
         {
            if(this._towns[_loc3_].name == _loc2_.name)
            {
               this._isMouseOverCity[_loc3_] = false;
            }
            _loc3_++;
         }
      }
      
      private function onExtraInfoRevealed(param1:Event) : void
      {
         var _loc2_:ExtraInfoPanel = param1.target as ExtraInfoPanel;
         var _loc3_:int = 0;
         while(_loc3_ < this._sessionData.numberOfPlayersJoined)
         {
            if((_loc2_.parent as TownAvatarContainer).name == this._towns[_loc3_].name)
            {
               if(this._isMouseOverCity[_loc3_])
               {
                  _loc2_.stop();
               }
            }
            _loc3_++;
         }
      }
      
      private function onExtraInfoAnimationComplete(param1:Event) : void
      {
         var _loc2_:ExtraInfoPanel = param1.target as ExtraInfoPanel;
         var _loc3_:int = 0;
         while(_loc3_ < this._towns.length)
         {
            if((_loc2_.parent as TownAvatarContainer).name == this._towns[_loc3_].name)
            {
               if(false == this._isMouseOverCity[_loc3_])
               {
                  _loc2_.stop();
               }
            }
            _loc3_++;
         }
      }
      
      private function onTempleButtonRollOver(param1:Event) : void
      {
         this._isMouseOverTemplePlayButton = true;
         this._templeGraphic.gotoAndStop(2);
         this._templePlayBanner.play();
      }
      
      private function onTempleButtonRollOut(param1:Event) : void
      {
         this._isMouseOverTemplePlayButton = false;
         this._templeGraphic.gotoAndStop(1);
         this._templePlayBanner.play();
      }
      
      private function onTemplePlayBannerRevealed(param1:Event) : void
      {
         if(this._isMouseOverTemplePlayButton)
         {
            this._templePlayBanner.stop();
         }
      }
      
      private function onTemplePlayBannerHidden(param1:Event) : void
      {
         if(this._isMouseOverTemplePlayButton == false)
         {
            this._templePlayBanner.stop();
         }
      }
      
      private function getTimeStringDaysFromUnixTime(param1:Number) : String
      {
         param1 = param1 < 0?Number(0):Number(param1);
         var _loc2_:String = new String();
         var _loc3_:Date = new Date();
         _loc3_.setTime(param1);
         var _loc4_:String = _loc3_.dateUTC - 1 < 10?String("0" + (_loc3_.dateUTC - 1)):String(_loc3_.dateUTC - 1);
         var _loc5_:String = _loc3_.hoursUTC < 10?String("0" + _loc3_.hoursUTC):String(_loc3_.hoursUTC);
         var _loc6_:String = _loc3_.minutesUTC < 10?String("0" + _loc3_.minutesUTC):String(_loc3_.minutesUTC);
         _loc2_ = _loc4_ + ":" + _loc5_ + ":" + _loc6_;
         return _loc2_;
      }
      
      private function getTimeStringHoursFromUnixTime(param1:Number) : String
      {
         param1 = param1 < 0?Number(0):Number(param1);
         var _loc2_:String = new String();
         var _loc3_:Date = new Date();
         _loc3_.setTime(param1);
         var _loc4_:String = _loc3_.hoursUTC < 10?String("0" + _loc3_.hoursUTC):String(_loc3_.hoursUTC);
         var _loc5_:String = _loc3_.minutesUTC < 10?String("0" + _loc3_.minutesUTC):String(_loc3_.minutesUTC);
         var _loc6_:String = _loc3_.secondsUTC < 10?String("0" + _loc3_.secondsUTC):String(_loc3_.secondsUTC);
         _loc2_ = _loc4_ + ":" + _loc5_ + ":" + _loc6_;
         return _loc2_;
      }
      
      private function startGame(param1:int, param2:Array) : void
      {
         if(this._isDataLoaded == false)
         {
            return;
         }
         this._lastResponseFromSaveScore = null;
         this._errorOnLastScoreSave = false;
         var _loc3_:BTDGameRequest = new BTDGameRequest();
         var _loc4_:Number = this.getDifficultyFromTier(this._sessionData.levelTier);
         var _loc5_:Number = MonkeySystem.getInstance().getSecureTime();
         var _loc6_:Number = ContestPanelHelper.convertWeeksToMilliseconds(this._sessionData.week) + ContestPanelHelper.convertDaysToMilliseconds(ContestPanelHelper.DAY_OF_FIRST_MONDAY_UNIX);
         var _loc7_:Number = _loc6_ + ContestPanelHelper.MILLISECONDS_IN_A_WEEK;
         var _loc8_:Number = _loc7_ - _loc5_;
         if(forceTenSecondsRemainingInWeek)
         {
            _loc8_ = 10000;
         }
         if(!this.CT_VERBOSE)
         {
         }
         var _loc9_:BloonWeightsDefinition = new BloonWeightsDefinition();
         _loc9_.strongestBloonType = Constants.DDT_BLOON;
         _loc9_.strongestBloonID = Constants.DDT_ID;
         this._numberOfRoundsToBeatInGame = this.getRoundToBeatForLead();
         this._lastNumOfCompletedRoundsSaved = 0;
         this._numOfCompletedRounds = 0;
         this._numOfCompletedRoundsToSave = 0;
         var _loc10_:* = false == this._sessionData.amLeading;
         var _loc11_:int = MonkeySystem.getInstance().city.cityIndex;
         _loc3_.ExtraRedHotSpikes(ResourceStore.getInstance().redHotSpikes).ExtraMonkeyBoosts(ResourceStore.getInstance().monkeyBoosts).AvailableUpgrades(MonkeySystem.getInstance().city.upgradeTree.getDescriptionForBTDModule()).AvailableTowers(MonkeySystem.getInstance().city.buildingManager.getAvailableTowersDescription(this._sessionData.trackData.terrainID)).StartingMoney(param1).StartingLives(ResourceStore.getInstance().btdStartingLives).TerrainType(this._sessionData.trackData.terrainID).TerrainName(this._sessionData.trackData.terrainName).TileUniqueData(new TileUniqueDataDefinition().TrackID(LevelDefData.getTrackIndex(this._sessionData.trackData.terrainID,this._sessionData.trackData.trackDefName,_loc11_))).TrackSelectionBias(1).IsReplayMode(false).IsCamoTile(false).IsRegenTile(false).CamoChanceModifier(this._sessionData.levelTier == 9?Number(1.1):Number(1)).RegenChanceModifier(this._sessionData.levelTier == 9?Number(1.1):Number(1)).MoreLead(this._sessionData.levelTier == 9?int(Constants.LOTS):int(Constants.NORMAL)).IsTutorial(false).IsContestedTerritory(true).Difficulty(_loc4_).DifficultyRankRelativeToMTL(6).DifficultyDescription(_system.map.getDifficultyDescriptionByRank(6)).Crates(param2).ContestedTerritoryRoundToBeat(this._numberOfRoundsToBeatInGame).ContestedTerritoryForCapture(_loc10_).ExtensionRounds(CONTESTED_TERRITORY_EXTRA_ROUNDS).Seed(this._sessionData.roundGeneratorSeed).TimeLeftInWeek(_loc8_).CityIndex(_loc11_).BloonWeights(_loc9_);
         this._gameRequestOfLastGame = _loc3_;
         this._isInBTDGame = true;
         MonkeyCityMain.getInstance().launchContestedTerritoryWithEnabledCheck(_loc3_);
      }
      
      public function premaintenanceCancel() : void
      {
         this._isInBTDGame = false;
         this.enableInteraction();
      }
      
      public function onBTDRoundCompleted(param1:int, param2:Number) : void
      {
         var roundCompleted:int = param1;
         var timeStamp:Number = param2;
         this._timeStampOfLastBTDRoundComplete = timeStamp;
         TownUI.getInstance().genericModalSpinner.reveal(1);
         CachedPreMaintenanceChecker.checkPreMaintenance(function(param1:Boolean):void
         {
            var _loc2_:* = false;
            var _loc3_:Boolean = false;
            TownUI.getInstance().genericModalSpinner.hide();
            if(param1)
            {
               MonkeyCityMain.getInstance().btdView.gameModule.displayPremaintenanceSignal.dispatch();
               if(roundCompleted > _numberOfRoundsToBeatInGame)
               {
                  saveRound(roundCompleted);
               }
            }
            else
            {
               if(!CT_VERBOSE)
               {
               }
               _numOfCompletedRounds = roundCompleted;
               _loc2_ = roundCompleted == _numberOfRoundsToBeatInGame;
               _loc3_ = false;
               if(roundCompleted > _numberOfRoundsToBeatInGame && roundCompleted >= 50 && roundCompleted % 5 == 0)
               {
                  _loc3_ = true;
               }
               if(_loc2_ || _loc3_)
               {
                  saveRound(roundCompleted);
               }
               else if(!CT_VERBOSE)
               {
               }
            }
         });
      }
      
      private function saveRound(param1:int) : void
      {
         if(!this.CT_VERBOSE)
         {
         }
         this._numOfCompletedRoundsToSave = param1;
         var _loc2_:int = this._myPlayerData.cityLevel != ResourceStore.getInstance().townLevel?int(ResourceStore.getInstance().townLevel):-1;
         this._myPlayerData.cityLevel = ResourceStore.getInstance().townLevel;
         if(_loc2_ != -1)
         {
            if(!this.CT_VERBOSE)
            {
            }
         }
         Kloud.saveScoreContestedTerritory(param1,this._sessionData.roomID,this.getCaptureRewardAsCashTime(),MonkeySystem.getInstance().getSecureTime(),false,_loc2_,this.onNewScoreSaved);
      }
      
      public function btdGameEnded(param1:GameResultDefinition) : void
      {
         this._isInBTDGame = false;
         this._gameResultOfLastGame = param1;
         if(this._lastResponseFromSaveScore == null || this._numOfCompletedRoundsToSave == this._lastResponseFromSaveScore.id)
         {
            if(!this.CT_VERBOSE)
            {
            }
            this.onBTDGameEndedAndScoreSaved();
         }
         else
         {
            if(!this.CT_VERBOSE)
            {
            }
            this._isWaitingForScoreToSave = true;
         }
      }
      
      private function onBTDGameEndedAndScoreSaved() : void
      {
         var levelToSet:int = 0;
         if(this._gameResultOfLastGame.contestedTerritoryExpired)
         {
            if(!this.CT_VERBOSE)
            {
            }
            if(!this.CT_VERBOSE)
            {
            }
            this._deferEndOfWeekUpdate = false;
            this.onContestedTerritoryEnded();
            this.inGameSleep(false);
            return;
         }
         if(this._numOfCompletedRounds > this._myPlayerData.roundsBeatenBest && this._numOfCompletedRounds != this._numberOfRoundsToBeatInGame || this._numOfCompletedRounds > this._numberOfRoundsToBeatInGame)
         {
            this._numOfCompletedRoundsToSave = this._numOfCompletedRounds;
            levelToSet = this._myPlayerData.cityLevel != ResourceStore.getInstance().townLevel?int(ResourceStore.getInstance().townLevel):-1;
            this._myPlayerData.cityLevel = ResourceStore.getInstance().townLevel;
            if(levelToSet != -1)
            {
               if(!this.CT_VERBOSE)
               {
               }
            }
            this.fadeInLoadingThrobber();
            Kloud.saveScoreContestedTerritory(this._numOfCompletedRounds,this._sessionData.roomID,this.getCaptureRewardAsCashTime(),MonkeySystem.getInstance().getSecureTime(),true,levelToSet,function(param1:Object):void
            {
               fadeOutLoadingThrobber();
               onNewScoreSaved(param1);
               if(_errorOnLastScoreSave)
               {
                  if(!CT_VERBOSE)
                  {
                  }
                  onEndGameScoreConflict();
               }
               else
               {
                  onEndGameSync();
               }
            });
            return;
         }
         if(this._errorOnLastScoreSave)
         {
            if(!this.CT_VERBOSE)
            {
            }
            this.onEndGameScoreConflict();
         }
         else
         {
            this.onEndGameSync();
         }
      }
      
      private function onEndGameScoreConflict() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Boolean = false;
         if(Constants.DISABLE_CONTESTED_TERRITORY)
         {
            return;
         }
         if(this._lastResponseFromSaveScore != null)
         {
            _loc1_ = 0;
            if(this._lastResponseFromSaveScore.contestedTerritory.hasOwnProperty("cities"))
            {
               _loc1_ = (this._lastResponseFromSaveScore.contestedTerritory.cities as Array).length;
            }
            _loc2_ = _loc1_ != this._sessionData.numberOfPlayersJoined || this.checkForForeignUserInScoreObject(this._lastResponseFromSaveScore.contestedTerritory.score);
            if(_loc2_)
            {
               if(!this.CT_VERBOSE)
               {
               }
               if(!this.CT_VERBOSE)
               {
               }
               Kloud.loadContestedTerritory(this.getLatestScoreTransactionTimeFromScoreObject(this._lastResponseFromSaveScore.contestedTerritory.score),this.onLoadContestedTerritory);
            }
            else
            {
               this._timeUntilNextServerSync = 0;
            }
            gameEndedSignal.dispatch(ResourceStore.getInstance().townLevel,this._numOfCompletedRounds,this._lastNumOfCompletedRoundsSaved,this._gameResultOfLastGame.cancelledGame,this._lastResponseFromSaveScore.id >= this._numberOfRoundsToBeatInGame,this._sessionData.roomID,this._sessionData.levelTier,this._numberOfRoundsToBeatInGame,this._gameRequestOfLastGame.tileUniqueData.trackClassName);
         }
         else
         {
            this._timeUntilNextServerSync = 0;
            gameEndedSignal.dispatch(ResourceStore.getInstance().townLevel,this._numOfCompletedRounds,this._lastNumOfCompletedRoundsSaved,this._gameResultOfLastGame.cancelledGame,this._lastNumOfCompletedRoundsSaved >= this._numberOfRoundsToBeatInGame,this._sessionData.roomID,this._sessionData.levelTier,this._numberOfRoundsToBeatInGame,this._gameRequestOfLastGame.tileUniqueData.trackClassName);
         }
         this.inGameSleep(false);
         this.enableInteraction();
      }
      
      private function onEndGameSync() : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         var _loc5_:Boolean = false;
         if(Constants.DISABLE_CONTESTED_TERRITORY)
         {
            return;
         }
         if(this._lastResponseFromSaveScore != null)
         {
            _loc2_ = this._sessionData.amLeading;
            this.syncDataWithOnlyScoreObject(this._lastResponseFromSaveScore.contestedTerritory.score);
            _loc3_ = this._sessionData.amLeading && false == _loc2_;
            if(_loc3_)
            {
               if(!this.CT_VERBOSE)
               {
               }
               if(this._curtainIsOpen)
               {
                  this.showWinPanel();
               }
               else
               {
                  TransitionSignals.raiseCurtainCompleteSignal.addOnce(this.showWinPanel);
               }
            }
            _loc4_ = 0;
            if(this._lastResponseFromSaveScore.contestedTerritory.hasOwnProperty("cities"))
            {
               _loc4_ = (this._lastResponseFromSaveScore.contestedTerritory.cities as Array).length;
            }
            _loc5_ = _loc4_ != this._sessionData.numberOfPlayersJoined || this.checkForForeignUserInScoreObject(this._lastResponseFromSaveScore.contestedTerritory.score);
            if(_loc5_)
            {
               if(!this.CT_VERBOSE)
               {
               }
               if(!this.CT_VERBOSE)
               {
               }
               Kloud.loadContestedTerritory(this.getLatestScoreTransactionTimeFromScoreObject(this._lastResponseFromSaveScore.contestedTerritory.score),this.onLoadContestedTerritory);
            }
         }
         this.inGameSleep(false);
         this.enableInteraction();
         var _loc1_:* = this._lastNumOfCompletedRoundsSaved >= this._numberOfRoundsToBeatInGame;
         gameEndedSignal.dispatch(ResourceStore.getInstance().townLevel,this._numOfCompletedRounds,this._lastNumOfCompletedRoundsSaved,this._gameResultOfLastGame.cancelledGame,_loc1_,this._sessionData.roomID,this._sessionData.levelTier,this._numberOfRoundsToBeatInGame,this._gameRequestOfLastGame.tileUniqueData.trackClassName);
      }
      
      private function showWinPanel() : void
      {
         TownUI.getInstance().contestWinGamePanel.updateInfo(this._lastNumOfCompletedRoundsSaved,this._gameResultOfLastGame.cancelledGame);
         PanelManager.getInstance().showPanel(TownUI.getInstance().contestWinGamePanel,null,2);
      }
      
      private function onNewScoreSaved(param1:Object) : void
      {
         var playersOwnScoreObject:Object = null;
         var scores:Vector.<Object> = null;
         var leadingScoreObject:Object = null;
         var conflict:Boolean = false;
         var userName:String = null;
         var newScoreToBeat:int = 0;
         var i:int = 0;
         var timestampOfNewLastLootTime:Number = NaN;
         var response:Object = param1;
         if(response.success)
         {
            this._lastResponseFromSaveScore = response;
            playersOwnScoreObject = response.contestedTerritory.score[MonkeySystem.getInstance().nkGatewayUser.loginInfo.id];
            if(!this.CT_VERBOSE)
            {
            }
            this._lastNumOfCompletedRoundsSaved = response.id;
            if(this._lastNumOfCompletedRoundsSaved == this._numberOfRoundsToBeatInGame)
            {
               scores = ContestPanelHelper.fetchScoresFromScoreObject(response.contestedTerritory.score);
               leadingScoreObject = ContestPanelHelper.getCurrentLeadingScoreFromScores(scores,this._sessionData.minimumRound,MonkeySystem.getInstance().getSecureTime(),true);
               if(leadingScoreObject != null)
               {
                  conflict = leadingScoreObject.userID != playersOwnScoreObject.userID;
               }
               else
               {
                  conflict = false;
               }
               if(conflict)
               {
                  this._playerControlsCTWhileInGame = false;
                  userName = "";
                  newScoreToBeat = leadingScoreObject.best + 1;
                  i = 0;
                  while(i < this._sessionData.numberOfPlayersJoined)
                  {
                     if(this._playerData[i].userID == leadingScoreObject.userID)
                     {
                        userName = this._playerData[i].userName;
                        break;
                     }
                     i++;
                  }
                  if(userName == "")
                  {
                     with({})
                     {
                        
                        success = function(param1:String):void
                        {
                           Main.instance.btdView.gameModule.contestedTerritoryLeadingScoreBeat(conflict,param1,newScoreToBeat);
                        };
                     }
                     this.loadUserName(leadingScoreObject.userID,function(param1:String):void
                     {
                        Main.instance.btdView.gameModule.contestedTerritoryLeadingScoreBeat(conflict,param1,newScoreToBeat);
                     },function error():void
                     {
                        userName = "Another player";
                        Main.instance.btdView.gameModule.contestedTerritoryLeadingScoreBeat(conflict,userName,newScoreToBeat);
                     });
                  }
                  else
                  {
                     Main.instance.btdView.gameModule.contestedTerritoryLeadingScoreBeat(conflict,userName,newScoreToBeat);
                  }
                  this._numberOfRoundsToBeatInGame = newScoreToBeat;
               }
               else
               {
                  if(false == this._playerControlsCTWhileInGame)
                  {
                     if(response.contestedTerritory.hasOwnProperty("lastLootTime") && response.contestedTerritory.lastLootTime != null)
                     {
                        if(!this.CT_VERBOSE)
                        {
                        }
                        this._sessionData.lastLootTime = response.contestedTerritory.lastLootTime - this.getCaptureRewardAsCashTime();
                     }
                  }
                  Main.instance.btdView.gameModule.contestedTerritoryLeadingScoreBeat(conflict);
                  if(forceInvalidLastLootTime)
                  {
                     response.contestedTerritory.lastLootTime = null;
                  }
                  if(false == this._playerControlsCTWhileInGame)
                  {
                     if(response.hasOwnProperty("contestedTerritory") == false || response.contestedTerritory.hasOwnProperty("lastLootTime") == false || response.contestedTerritory.lastLootTime == null || response.contestedTerritory.lastLootTime <= ContestPanelHelper.CONTESTED_TERRITORY_MAX_CAPTURE_TIME)
                     {
                        timestampOfNewLastLootTime = leadingScoreObject.time - this.getCaptureRewardAsCashTime();
                        this._sessionData.lastLootTime = timestampOfNewLastLootTime;
                     }
                  }
                  this._playerControlsCTWhileInGame = true;
               }
               this._lastKnownLeadingPlayerUserID = leadingScoreObject.userID;
            }
            if(this._numOfCompletedRoundsToSave == this._lastNumOfCompletedRoundsSaved)
            {
               this._errorOnLastScoreSave = false;
               if(this._isWaitingForScoreToSave)
               {
                  this._isWaitingForScoreToSave = false;
                  this.onBTDGameEndedAndScoreSaved();
               }
            }
         }
         else
         {
            if(!this.CT_VERBOSE)
            {
            }
            if(!this.CT_VERBOSE)
            {
            }
            if(response.id == this._numOfCompletedRoundsToSave)
            {
               this._errorOnLastScoreSave = true;
               if(this._isWaitingForScoreToSave)
               {
                  this._isWaitingForScoreToSave = false;
                  this.onBTDGameEndedAndScoreSaved();
               }
            }
         }
      }
      
      private function loadUserName(param1:String, param2:Function, param3:Function) : void
      {
         var data:Object = null;
         var onLoadURL:Function = null;
         var userID:String = param1;
         var successCallback:Function = param2;
         var errorCallback:Function = param3;
         onLoadURL = function(param1:Event):void
         {
            var e:Event = param1;
            try
            {
               data = JSON.parse(_urlLoader.data);
            }
            catch(e:Error)
            {
               if(!CT_VERBOSE)
               {
               }
               _urlLoader.removeEventListener(IOErrorEvent.IO_ERROR,errorCallback);
               _urlLoader.removeEventListener(Event.COMPLETE,onLoadURL);
               return;
            }
            if(data === null || !data.username)
            {
               if(!CT_VERBOSE)
               {
               }
               _urlLoader.removeEventListener(IOErrorEvent.IO_ERROR,errorCallback);
               _urlLoader.removeEventListener(Event.COMPLETE,onLoadURL);
               return;
            }
            successCallback(data.username);
         };
         this._urlLoaderRequest.url = Constants.USER_INFORMATION_PATH_SERVICE + userID;
         this._urlLoader.removeEventListener(IOErrorEvent.IO_ERROR,errorCallback);
         this._urlLoader.removeEventListener(Event.COMPLETE,onLoadURL);
         this._urlLoader.addEventListener(IOErrorEvent.IO_ERROR,errorCallback,false,0,true);
         this._urlLoader.addEventListener(Event.COMPLETE,onLoadURL,false,0,true);
         this._urlLoader.load(this._urlLoaderRequest);
      }
      
      private function inGameSleep(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(!this.CT_VERBOSE)
         {
         }
         if(param1)
         {
            this._templePlayBanner.gotoAndStop(1);
            this._templeButton.gotoAndStop(1);
            removeEventListener(Event.ENTER_FRAME,this.onFrameEnter);
            removeEventListener(Event.ENTER_FRAME,this.onFrameEnterHidden);
            this._templeButton.removeEventListener(MouseEvent.ROLL_OVER,this.onTempleButtonRollOver);
            this._templeButton.removeEventListener(MouseEvent.ROLL_OUT,this.onTempleButtonRollOut);
            this._templeButton.removeEventListener(MouseEvent.MOUSE_UP,this.onPlay);
            this._templePlayBanner.removeEventListener("TemplePlayBannerRevealed",this.onTemplePlayBannerRevealed);
            this._templePlayBanner.removeEventListener("TemplePlayBannerHidden",this.onTemplePlayBannerHidden);
            _loc2_ = 0;
            while(_loc2_ < CONTESTED_TERRITORY_NUM_OF_CITIES)
            {
               this._towns[_loc2_].removeEventListener(MouseEvent.ROLL_OVER,this.onMouseOver);
               this._towns[_loc2_].removeEventListener(MouseEvent.ROLL_OUT,this.onMouseOut);
               _loc2_++;
            }
            _loc3_ = 0;
            while(_loc3_ < CONTESTED_TERRITORY_NUM_OF_CITIES)
            {
               this._towns[_loc3_].extraInfoPanel.removeEventListener("ExtraInfoRevealed",this.onExtraInfoRevealed);
               this._towns[_loc3_].extraInfoPanel.removeEventListener(Event.COMPLETE,this.onExtraInfoAnimationComplete);
               this._towns[_loc3_].gotoAndStop(1);
               this._towns[_loc3_].extraInfoPanel.gotoAndStop(1);
               this._isMouseOverCity[_loc3_] = false;
               _loc3_++;
            }
            _loc4_ = 0;
            while(_loc4_ < this._trucks.length)
            {
               this._trucks[_loc4_].gotoAndStop(1);
               _loc4_++;
            }
            this._bananaTemple.stop();
         }
         else
         {
            this._templePlayBanner.gotoAndStop(1);
            this._templeGraphic.gotoAndStop(1);
            removeEventListener(Event.ENTER_FRAME,this.onFrameEnter);
            removeEventListener(Event.ENTER_FRAME,this.onFrameEnterHidden);
            if(isRevealed)
            {
               addEventListener(Event.ENTER_FRAME,this.onFrameEnter);
            }
            else
            {
               addEventListener(Event.ENTER_FRAME,this.onFrameEnterHidden);
            }
            this._templeButton.addEventListener(MouseEvent.ROLL_OVER,this.onTempleButtonRollOver);
            this._templeButton.addEventListener(MouseEvent.ROLL_OUT,this.onTempleButtonRollOut);
            this._templeButton.addEventListener(MouseEvent.MOUSE_UP,this.onPlay);
            this._templePlayBanner.addEventListener("TemplePlayBannerRevealed",this.onTemplePlayBannerRevealed);
            this._templePlayBanner.addEventListener("TemplePlayBannerHidden",this.onTemplePlayBannerHidden);
            _loc5_ = 0;
            while(_loc5_ < CONTESTED_TERRITORY_NUM_OF_CITIES)
            {
               this._towns[_loc5_].addEventListener(MouseEvent.ROLL_OVER,this.onMouseOver);
               this._towns[_loc5_].addEventListener(MouseEvent.ROLL_OUT,this.onMouseOut);
               _loc5_++;
            }
            _loc6_ = 0;
            while(_loc6_ < CONTESTED_TERRITORY_NUM_OF_CITIES)
            {
               this._towns[_loc6_].extraInfoPanel.addEventListener("ExtraInfoRevealed",this.onExtraInfoRevealed);
               this._towns[_loc6_].extraInfoPanel.addEventListener(Event.COMPLETE,this.onExtraInfoAnimationComplete);
               _loc6_++;
            }
            this.updateTrucks();
            this._bananaTemple.play();
         }
      }
      
      private function setAvatarModuleVisiblity(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._sessionData.numberOfPlayersJoined)
         {
            this._towns[_loc2_].playerNameAvatarField.visible = param1;
            this._towns[_loc2_].avatarModule.visible = param1;
            this._towns[_loc2_].extraInfoPanel.visible = param1;
            this._towns[_loc2_].territoryOwnerStar.visible = false;
            if(this.isContestedTerritoryClaimed() && this._leadingPlayerCityID == _loc2_)
            {
               this._towns[_loc2_].territoryOwnerStar.visible = param1;
            }
            _loc2_++;
         }
      }
      
      private function lastLootTimeSanityCheck() : void
      {
         var _loc1_:Number = NaN;
         if(forceInvalidLastLootTime)
         {
            this._sessionData.lastLootTime = 0;
         }
         if(this._sessionData.amLeading)
         {
            if(this._sessionData.lastLootTime <= ContestPanelHelper.CONTESTED_TERRITORY_MAX_CAPTURE_TIME)
            {
               _loc1_ = this._myPlayerData.timestampOfLastCapture - this.getCaptureRewardAsCashTime();
               this._sessionData.lastLootTime = _loc1_;
            }
         }
      }
      
      private function showCoinBurst() : void
      {
         if(this._coinBurst.isPlaying)
         {
            return;
         }
         this._coinBurst.gotoAndPlay(1);
         this._coinBurst.visible = true;
      }
      
      private function hideCoinBurst() : void
      {
         this._coinBurst.gotoAndStop(1);
         this._coinBurst.visible = false;
      }
      
      private function showBanksFullAnimation() : void
      {
         if(this._banksFullAnimation.isPlaying)
         {
            return;
         }
         this._banksFullAnimation.gotoAndPlay(1);
         this._banksFullAnimation.visible = true;
      }
      
      private function hideBanksFullAnimation() : void
      {
         this._banksFullAnimation.gotoAndStop(1);
         this._banksFullAnimation.visible = false;
      }
      
      private function onCoinBurstCompleteHandler(param1:Event) : void
      {
         this.hideCoinBurst();
      }
      
      private function onBanksFullCompleteHandler(param1:Event) : void
      {
         this.hideBanksFullAnimation();
      }
      
      private function onRaiseCurtainCompleteSignal() : void
      {
         this._curtainIsOpen = true;
      }
      
      private function onCloseCurtainCompleteSignal() : void
      {
         this._curtainIsOpen = false;
      }
      
      private function onTownLevelChangedSignal(param1:int) : void
      {
         if(false == this._isDataLoaded)
         {
            return;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this._sessionData.numberOfPlayersJoined)
         {
            if(this._playerData[_loc2_].userID == this._myPlayerData.userID)
            {
               this._towns[_loc2_].avatarModule.levelField.text = String(this.applyLevelCap(ResourceStore.getInstance().townLevel));
               break;
            }
            _loc2_++;
         }
      }
      
      public function getDifficultyFromTier(param1:int) : int
      {
         var _loc2_:int = 0;
         if(param1 == 1)
         {
            _loc2_ = 6;
         }
         else
         {
            _loc2_ = CONTESTED_TERRITORY_LEVEL_TIERS[param1] - 3;
         }
         return _loc2_;
      }
      
      public function getRoundToBeatForLead() : int
      {
         if(this.isContestedTerritoryClaimed())
         {
            return this._leadingPlayerData.roundsBeatenCurrent + 1;
         }
         return this._sessionData.minimumRound;
      }
      
      public function getLatestScoreTransactionTime() : Number
      {
         var _loc1_:Number = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this._sessionData.numberOfPlayersJoined)
         {
            if(this._playerData[_loc2_].timestampOfLastCapture > _loc1_)
            {
               _loc1_ = this._playerData[_loc2_].timestampOfLastCapture;
            }
            _loc2_++;
         }
         if(!this.CT_VERBOSE)
         {
         }
         return _loc1_;
      }
      
      public function getLatestScoreTransactionTimeFromScoreObject(param1:Object) : Number
      {
         var _loc3_:Object = null;
         ContestPanelHelper.patchMissingScoresOfScoreObject(param1);
         var _loc2_:Number = 0;
         for each(_loc3_ in param1)
         {
            if(_loc3_.time > _loc2_)
            {
               _loc2_ = _loc3_.time;
            }
         }
         if(!this.CT_VERBOSE)
         {
         }
         return _loc2_;
      }
      
      public function checkForForeignUserInScoreObject(param1:Object) : Boolean
      {
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         ContestPanelHelper.patchMissingScoresOfScoreObject(param1);
         var _loc2_:Vector.<Object> = ContestPanelHelper.fetchScoresFromScoreObject(param1);
         var _loc3_:int = 0;
         while(true)
         {
            if(_loc3_ >= _loc2_.length)
            {
               return false;
            }
            _loc4_ = false;
            _loc5_ = 0;
            while(_loc5_ < this._sessionData.numberOfPlayersJoined)
            {
               if(this._playerData[_loc5_].userID == _loc2_[_loc3_].userID)
               {
                  _loc4_ = true;
                  break;
               }
               _loc5_++;
            }
            if(false == _loc4_)
            {
               break;
            }
            _loc3_++;
         }
         return true;
      }
      
      public function getCaptureRewardAsCashTime() : Number
      {
         return this.translateCashToCashTime(CONTESTED_TERRITORY_CAPTURE_CASH_REWARD_BASE * this._sessionData.levelTier);
      }
      
      public function applyLevelCap(param1:int) : int
      {
         var _loc2_:int = param1 > Constants.MAX_CITY_LEVEL?int(Constants.MAX_CITY_LEVEL):int(param1);
         return _loc2_;
      }
      
      public function saveWeekOfLastKnownCT(param1:int) : void
      {
         var _loc2_:Object = Kloud.loadCookie(CONTESTED_TERRITORY_COOKIE_NAME).data;
         var _loc3_:Vector.<String> = new Vector.<String>();
         var _loc4_:Vector.<Object> = new Vector.<Object>();
         var _loc5_:Object = _loc2_;
         var _loc6_:String = "weekOfLastKnownCT" + MonkeySystem.getInstance().city.cityIndex;
         if(_loc5_.hasOwnProperty(MonkeySystem.getInstance().nkGatewayUser.loginInfo.id))
         {
            _loc5_ = _loc5_[MonkeySystem.getInstance().nkGatewayUser.loginInfo.id];
            _loc5_[_loc6_] = param1;
         }
         else
         {
            _loc5_ = {"weekOfLastKnownCT":param1};
         }
         _loc3_.push(MonkeySystem.getInstance().nkGatewayUser.loginInfo.id);
         _loc4_.push(_loc5_);
         Kloud.saveCookieFromObjects(CONTESTED_TERRITORY_COOKIE_NAME,_loc3_,_loc4_);
      }
      
      public function sanityCheckHistoryLoad(param1:Object, param2:Object) : void
      {
         var _loc4_:int = 0;
         var _loc3_:Object = Kloud.loadCookie(CONTESTED_TERRITORY_COOKIE_NAME).data;
         _loc4_ = ContestPanelHelper.getNumOfMondaysSinceFirstMonday(MonkeySystem.getInstance().getSecureTime());
         var _loc5_:int = _loc4_ - 1;
         var _loc6_:String = "weekOfLastKnownCT" + MonkeySystem.getInstance().city.cityIndex;
         if(_loc3_.hasOwnProperty(MonkeySystem.getInstance().nkGatewayUser.loginInfo.id) == false || _loc3_[MonkeySystem.getInstance().nkGatewayUser.loginInfo.id].hasOwnProperty(_loc6_) == false)
         {
            return;
         }
         var _loc7_:int = _loc3_[MonkeySystem.getInstance().nkGatewayUser.loginInfo.id][_loc6_];
         if(_loc7_ == -1)
         {
            return;
         }
         if(_loc5_ == _loc7_)
         {
            ErrorMessageTracking.reportErrorMessageNoHistory(MonkeySystem.getInstance().nkGatewayUser.loginInfo.id,MonkeySystem.getInstance().userName,this._sessionData.roomID,_loc7_,param1,param2);
         }
      }
      
      public function markHistoryAsSeenTracking() : void
      {
         this.saveWeekOfLastKnownCT(-1);
      }
      
      public function getMyTimeHeldFromServerObject() : Number
      {
         if(false == this.isInContestedTerritory())
         {
            return 0;
         }
         var _loc1_:Vector.<Object> = ContestPanelHelper.fetchPlayersFromServerResponse(MonkeySystem.getInstance().city.contestedTerritoryData);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            if(_loc1_[_loc2_].userID == MonkeySystem.getInstance().nkGatewayUser.loginInfo.id)
            {
               return _loc1_[_loc2_].timeHeld;
            }
            _loc2_++;
         }
         return 0;
      }
      
      public function get sessionData() : ContestedTerritorySessionData
      {
         return this._sessionData;
      }
      
      public function get playerData() : Vector.<ContestedTerritoryPlayerData>
      {
         return this._playerData;
      }
      
      public function get playerDataSorted() : Vector.<ContestedTerritoryPlayerData>
      {
         return this._playerDataSorted;
      }
      
      public function set timeUntilNextServerSync(param1:Number) : void
      {
         this._timeUntilNextServerSync = param1;
      }
      
      public function get myPlayerData() : ContestedTerritoryPlayerData
      {
         return this._myPlayerData;
      }
      
      public function set deferEndOfWeekUpdateDelayTime(param1:Number) : void
      {
         this._deferEndOfWeekUpdateDelayTime = param1;
      }
   }
}
