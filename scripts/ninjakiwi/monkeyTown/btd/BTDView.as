package ninjakiwi.monkeyTown.btd
{
   import com.lgrey.events.LGDataEvent;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.EventDispatcher;
   import flash.events.ProgressEvent;
   import flash.utils.Dictionary;
   import ninjakiwi.monkeyTown.Main;
   import ninjakiwi.monkeyTown.analytics.AnalyticsUtil;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.common.audio.AudioState;
   import ninjakiwi.monkeyTown.common.btdModule.IBloonsTowerDefenseModule;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.GameResultDefinition;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.TileUniqueDataDefinition;
   import ninjakiwi.monkeyTown.common.events.GameEvent;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.interfaces.View;
   import ninjakiwi.monkeyTown.premiums.Premium;
   import ninjakiwi.monkeyTown.sound.LoadingSound;
   import ninjakiwi.monkeyTown.sound.MCMusic;
   import ninjakiwi.monkeyTown.sound.MCSound;
   import ninjakiwi.monkeyTown.sound.SoundID;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.helpFromFriends.CrateManager;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.ui.LoadProgressPanel;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   import ninjakiwi.monkeyTown.utils.ErrorReporter;
   import ninjakiwi.monkeyTown.utils.LoadSwfUtil;
   import org.osflash.signals.Signal;
   
   public class BTDView extends MovieClip implements View
   {
      
      public static var currentLoadingSound:LoadingSound = null;
      
      public static var currentMusicID:String = null;
      
      public static const btdLoadProgressSignal:Signal = new Signal(Number);
      
      public static const btdLoadCompleteSignal:Signal = new Signal();
      
      public static const audioTrackLoadComplete:Signal = new Signal();
      
      public static const btdVersionChanged:Signal = new Signal(String);
       
      
      public const gameCompleteSignal:Signal = new Signal(GameResultDefinition);
      
      public const gameCancelled:Signal = new Signal();
      
      private var _currentGameRequest:BTDGameRequest = null;
      
      private const _swfLoader:LoadSwfUtil = new LoadSwfUtil();
      
      private var _loadBar:LoadProgressPanel;
      
      private var _gameModule:IBloonsTowerDefenseModule = null;
      
      private var _gameModuleClip:MovieClip = null;
      
      private var _gameModuleHasLoaded:Boolean = false;
      
      private var _cuedGameRequest:BTDGameRequest = null;
      
      private var _previousMonkeyBoostsBalance:int = -1;
      
      private var _previousRedHotSpikesBalance:int = -1;
      
      private var blockTowerPlacingTargets:Dictionary;
      
      private var _queuedDataToPassToModule:Array;
      
      public function BTDView()
      {
         this.blockTowerPlacingTargets = new Dictionary();
         this._queuedDataToPassToModule = [];
         super();
         this._loadBar = new LoadProgressPanel(this);
         this._loadBar.setMessage("Loading BTD...");
         this._loadBar.watch(this._swfLoader);
         var _loc1_:String = Constants.BASE_PATH + Constants.BTD_MODULE_URL + "?cachebuster=" + Constants.BUILD_DATE;
         this._swfLoader.load(_loc1_,this.onBTDModuleLoaded);
         this._swfLoader.addEventListener(ProgressEvent.PROGRESS,this.onBTDModuleProgressHandler);
      }
      
      private function onBTDModuleProgressHandler(param1:ProgressEvent) : void
      {
         var _loc2_:Number = param1.bytesLoaded / param1.bytesTotal;
         btdLoadProgressSignal.dispatch(_loc2_);
      }
      
      private function onBTDModuleLoaded(param1:IBloonsTowerDefenseModule) : void
      {
         var _loc4_:Object = null;
         this._gameModule = IBloonsTowerDefenseModule(param1);
         this._gameModule.setIsStandalone(false);
         this._gameModule.usedCrateSignal.add(this.onModuleUsedCrate);
         this._gameModule.analyticsSignal.add(this.onAnalyticsSignal);
         this._gameModule.contestedTerritoryRoundCompletedSignal.add(MonkeyCityMain.getInstance().ui.contestedTerritoryPanel.onBTDRoundCompleted);
         this._gameModule.requestOptionsPanelSignal.add(this.onRequestOptionsPanelSignal);
         var _loc2_:int = 0;
         while(_loc2_ < this._queuedDataToPassToModule.length)
         {
            _loc4_ = this._queuedDataToPassToModule[_loc2_];
            this._gameModule.setData(_loc4_.key,_loc4_.data);
            _loc2_++;
         }
         this._queuedDataToPassToModule.length = 0;
         MovieClip(this._gameModule).doTest = false;
         this._gameModuleClip = MovieClip(param1);
         var _loc3_:String = this._gameModule.getVersion();
         if(Constants.BUILD_DATE !== _loc3_)
         {
            ErrorReporter.externalLog("Build dates were mismatched");
            Main.instance.returnToHomeScreenAndRequireRefresh();
            AnalyticsUtil.track("module_version_mismatch");
            return;
         }
         this._gameModuleClip.addEventListener(Constants.GAME_OVER,this.gameOverHandler);
         this._gameModuleClip.addEventListener(Constants.GAME_CANCELLED,this.gameOverHandler);
         this._gameModuleClip.addEventListener(Constants.GAME_REQUEST_BLOONSTONES,this.onRequestBloonstones);
         this._gameModuleClip.addEventListener(Constants.GAME_RETRY_WITH_BLOONSTONES,this.onRetryWithBloonstones);
         this._gameModuleClip.addEventListener(Constants.GAME_OPEN_SHOP,this.gameOpenShop);
         this._gameModule.eventBridge.addEventListener(Constants.CONSUME_MONKEY_BOOSTS,this.onConsumeMonkeyBoostsRequest);
         this._gameModule.eventBridge.addEventListener(Constants.CONSUME_RED_HOT_SPIKES,this.onConsumeRedHotSpikesRequest);
         this._gameModule.eventBridge.addEventListener(Constants.CONSUME_ANTI_BOSS_ABILITY,this.onConsumeAntiBossAbility);
         this._gameModule.eventBridge.addEventListener(Constants.TRACK_ANTI_BOSS_ABILITY,this.onTrackAntiBossAbility);
         ResourceStore.getInstance().globalResourcesChangedSignal.add(this.onGlobalResourcesChanged);
         this._gameModuleClip.addEventListener(Constants.GAME_TACTICS_ANALYTICS,this.gameTacticsAnalytics);
         addChild(this._gameModuleClip);
         this._gameModuleHasLoaded = true;
         if(this._cuedGameRequest !== null)
         {
            this.playGame(this._cuedGameRequest);
            this._cuedGameRequest = null;
         }
         btdLoadCompleteSignal.dispatch();
      }
      
      private function onGlobalResourcesChanged() : void
      {
         var _loc1_:ResourceStore = ResourceStore.getInstance();
         if(this._previousRedHotSpikesBalance != _loc1_.redHotSpikes)
         {
            this._gameModule.eventBridge.dispatchEvent(new LGDataEvent(Constants.RED_HOT_SPIKES_BALANCE_CHANGED,{"balance":_loc1_.redHotSpikes}));
            this._previousRedHotSpikesBalance = _loc1_.redHotSpikes;
         }
         if(this._previousMonkeyBoostsBalance != _loc1_.monkeyBoosts)
         {
            this._gameModule.eventBridge.dispatchEvent(new LGDataEvent(Constants.MONKEY_BOOSTS_BALANCE_CHANGED,{"balance":_loc1_.monkeyBoosts}));
            this._previousMonkeyBoostsBalance = _loc1_.monkeyBoosts;
         }
      }
      
      private function onConsumeAntiBossAbility(param1:LGDataEvent) : void
      {
         switch(param1.data.type)
         {
            case Constants.BOSS_BANE_ID:
               ResourceStore.getInstance().bossBanes--;
               break;
            case Constants.BOSS_BLAST_ID:
               ResourceStore.getInstance().bossBlasts--;
               break;
            case Constants.BOSS_CHILL_ID:
               ResourceStore.getInstance().bossChills--;
               break;
            case Constants.BOSS_WEAKEN_ID:
               ResourceStore.getInstance().bossWeakens--;
         }
      }
      
      private function onTrackAntiBossAbility(param1:LGDataEvent) : void
      {
         var _loc2_:GameplayEvent = GameEventManager.getInstance().bossEventManager.findCurrentEvent();
         if(_loc2_ == null)
         {
            return;
         }
         AnalyticsUtil.track("use_bosspowerup",JSON.stringify({
            "powerupName":param1.data.type,
            "wasFree":param1.data.wasFree,
            "level":GameEventManager.getInstance().bossEventManager.bossLevel,
            "bossName":_loc2_.dataID,
            "cityLevel":ResourceStore.getInstance().townLevel
         }));
      }
      
      private function onConsumeRedHotSpikesRequest(param1:LGDataEvent) : void
      {
         ResourceStore.getInstance().redHotSpikes = ResourceStore.getInstance().redHotSpikes - param1.data.howMany;
      }
      
      private function onConsumeMonkeyBoostsRequest(param1:LGDataEvent) : void
      {
         ResourceStore.getInstance().monkeyBoosts = ResourceStore.getInstance().monkeyBoosts - param1.data.howMany;
      }
      
      private function onRequestOptionsPanelSignal() : void
      {
         PanelManager.getInstance().showFreePanel(TownUI.getInstance().optionsPanel);
      }
      
      private function onAnalyticsSignal(... rest) : void
      {
         AnalyticsUtil.track.apply(null,rest);
      }
      
      private function onModuleUsedCrate() : void
      {
         CrateManager.getInstance().useCrate();
      }
      
      private function gameTacticsAnalytics(param1:GameEvent) : void
      {
         AnalyticsUtil.track(param1.data.id,String(param1.data.difficulty),ResourceStore.getInstance().townLevel,param1.data.trackId,String(param1.data.roundReached));
      }
      
      private function onRetryWithBloonstones(param1:GameEvent) : void
      {
         var _loc2_:String = param1.data.id;
         var _loc3_:int = param1.data.roundReached;
         var _loc4_:int = param1.data.bloonstonesSpent;
         GameSignals.BTD_RETRY.dispatch(_loc4_,ResourceStore.getInstance().bloonstones,_loc3_,_loc2_);
      }
      
      private function gameOpenShop(param1:GameEvent) : void
      {
         Premium.getInstance().showStoreForBloonstones(param1.data.bloonstonesRequired);
      }
      
      private function gameOverHandler(param1:GameEvent) : void
      {
         var _loc2_:GameResultDefinition = param1.data.result;
         this.gameComplete(_loc2_);
      }
      
      public function playGame(param1:BTDGameRequest, param2:Function = null) : void
      {
         var musicID:String = null;
         var tileUniqueData:TileUniqueDataDefinition = null;
         var version:String = null;
         var btdGameRequest:BTDGameRequest = param1;
         var onLaunchedCallback:Function = param2;
         t.DoNotBroadcast = true;
         t.DoNotBroadcast = false;
         try
         {
            if(!this._gameModuleHasLoaded)
            {
               ErrorReporter.externalLog("BTDView::playGame() - MODULE NOT LOADED!");
               this._cuedGameRequest = btdGameRequest;
               return;
            }
            btdGameRequest.timeLaunched = MonkeySystem.getInstance().getSecureTime();
            if(Constants.BUILD_DATE !== this._gameModule.getVersion())
            {
               Main.instance.returnToHomeScreenAndRequireRefresh();
               AnalyticsUtil.track("module_version_mismatch");
               return;
            }
            this._currentGameRequest = btdGameRequest;
            if(this._gameModule)
            {
               version = this._gameModule.startGame(btdGameRequest);
               btdVersionChanged.dispatch(version);
               if(onLaunchedCallback !== null)
               {
                  onLaunchedCallback();
               }
            }
         }
         catch(e:Error)
         {
            ErrorReporter.externalLog("BTDView::playGame() error occurred in BTDView::playGame()");
            ErrorReporter.externalLog("BTDView::playGame()",e.name,e.message,e.getStackTrace);
         }
         MCSound.getInstance().playSound(MCSound.ATTACK);
         if(btdGameRequest.pvpAttackDefinition !== null)
         {
            musicID = SoundID.PVP_MUSIC;
         }
         else
         {
            musicID = MCMusic.getTrackIDForTerrain(btdGameRequest.terrainType);
         }
         var musicIsLoaded:Boolean = MCMusic.isTrackLoaded(musicID);
         if(musicIsLoaded)
         {
            MCMusic.playTrack(musicID);
            audioTrackLoadComplete.dispatch();
            currentLoadingSound = null;
            currentMusicID = musicID;
         }
         else
         {
            currentLoadingSound = MCMusic.loadTrack(musicID);
            currentMusicID = musicID;
            currentLoadingSound.completeSignal.addOnce(function(param1:LoadingSound):void
            {
               MCMusic.playTrack(currentMusicID);
               audioTrackLoadComplete.dispatch();
               currentLoadingSound = null;
            });
         }
         AudioState.REQUEST_STATE_SYNC.dispatch();
         Main.instance.clearMainBitmapData();
      }
      
      public function tearDownGame() : void
      {
         if(this._gameModule)
         {
            this._gameModule.endGame();
         }
         this.destroyCuedEvents();
      }
      
      public function destroyCuedEvents() : void
      {
         this._cuedGameRequest = null;
      }
      
      public function gameComplete(param1:GameResultDefinition) : void
      {
         this.gameCompleteSignal.dispatch(param1);
      }
      
      private function onRequestBloonstones(param1:GameEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Function = null;
         var _loc4_:Boolean = false;
         if(param1.data.hasOwnProperty("bloonstones") && param1.data.hasOwnProperty("callback") && param1.data.hasOwnProperty("spend"))
         {
            _loc2_ = param1.data.bloonstones;
            _loc3_ = param1.data.callback;
            _loc4_ = param1.data.spend;
            if(ResourceStore.getInstance().bloonstones >= _loc2_)
            {
               if(_loc4_ == true)
               {
                  ResourceStore.getInstance().bloonstones = ResourceStore.getInstance().bloonstones - _loc2_;
               }
               _loc3_(true,ResourceStore.getInstance().bloonstones);
            }
            else
            {
               _loc3_(false,ResourceStore.getInstance().bloonstones);
            }
         }
      }
      
      public function process(param1:Number) : void
      {
      }
      
      public function draw(param1:BitmapData) : void
      {
      }
      
      public function prepareToReveal() : void
      {
      }
      
      public function prepareToExit() : void
      {
      }
      
      public function arriveAfterTransition() : void
      {
      }
      
      public function sleepAfterExit() : void
      {
      }
      
      public function reset() : void
      {
      }
      
      public function get gameModule() : IBloonsTowerDefenseModule
      {
         return this._gameModule;
      }
      
      public function setBlockTowerPlacing(param1:Boolean, param2:*) : void
      {
         if(this._gameModule == null)
         {
            return;
         }
         this.blockTowerPlacingTargets[param2] = param1;
         for each(param1 in this.blockTowerPlacingTargets)
         {
            if(param1 == true)
            {
               this._gameModule.blockTowerPlacing = true;
               return;
            }
         }
         this._gameModule.blockTowerPlacing = false;
      }
      
      public function passDataToModule(param1:String, param2:*) : void
      {
         if(this._gameModuleHasLoaded)
         {
            this._gameModule.setData(param1,param2);
         }
         else
         {
            this._queuedDataToPassToModule.push({
               "key":param1,
               "value":param2
            });
         }
      }
      
      public function setSFXAudible(param1:Boolean) : void
      {
         if(this._gameModule !== null)
         {
            this._gameModule.audioIsAudible = param1;
         }
      }
      
      public function pauseGame() : void
      {
         if(this.moduleHasLoaded)
         {
            this._gameModule.pauseGame();
         }
      }
      
      public function unPauseGame() : void
      {
         if(this.moduleHasLoaded)
         {
            this._gameModule.unPauseGame();
         }
      }
      
      public function get moduleHasLoaded() : Boolean
      {
         return this._gameModule !== null;
      }
      
      public function get eventBridge() : EventDispatcher
      {
         if(this.moduleHasLoaded)
         {
            return this._gameModule.eventBridge;
         }
         return null;
      }
   }
}
