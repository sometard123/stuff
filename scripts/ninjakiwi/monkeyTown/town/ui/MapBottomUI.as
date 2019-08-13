package ninjakiwi.monkeyTown.town.ui
{
   import assets.town.BottomMapUI;
   import com.greensock.TweenLite;
   import com.greensock.easing.Linear;
   import flash.display.MovieClip;
   import flash.events.KeyboardEvent;
   import flash.events.TimerEvent;
   import flash.geom.ColorTransform;
   import flash.ui.Keyboard;
   import flash.utils.Timer;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.net.kloud.HandShake;
   import ninjakiwi.monkeyTown.pvp.PvPSignals;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.BuildingPlacer;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldViewSignals;
   import ninjakiwi.monkeyTown.town.townMap.TrackManager;
   import ninjakiwi.monkeyTown.town.ui.attack.crates.CrateGiveGetButtonController;
   import ninjakiwi.monkeyTown.ui.OpenMonkeyKnowledgeButton;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.buttons.DisableableButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   import ninjakiwi.monkeyTown.userServices.kong.Kong;
   import ninjakiwi.monkeyTown.utils.Flatten;
   import org.osflash.signals.Signal;
   
   public class MapBottomUI
   {
      
      private static var _instance:MapBottomUI;
      
      public static const TASK_BUTTON:String = "tasksButton";
      
      public static const MY_TOWERS_BUTTON:String = "myTowersButton";
      
      public static const BUILD_BUTTON:String = "buildButton";
      
      public static const UPGRADES_BUTTON:String = "upgradesButton";
      
      public static const RAID_BUTTON:String = "raidButton";
      
      public static const MANAGE_TOWNS_BUTTON:String = "manageTownsButton";
      
      private static const HIDE_AMOUNT:int = 60;
       
      
      private var _clip:BottomMapUI;
      
      private const _system:MonkeySystem = MonkeySystem.getInstance();
      
      private var _contestedTerritoryButton:DisableableButtonControllerBase;
      
      private var _specialTracksButton:DisableableButtonControllerBase;
      
      private var _myTowersButton:DisableableButtonControllerBase;
      
      private var _buildButton:DisableableButtonControllerBase;
      
      private var _cancelBuildButton:DisableableButtonControllerBase;
      
      private var _cancelMoveButton:DisableableButtonControllerBase;
      
      private var _upgradesButton:DisableableButtonControllerBase;
      
      private var _pvpButton:DisableableButtonControllerBase;
      
      private var _manageCitiesButton:DisableableButtonControllerBase;
      
      private var _giveCrateButton:DisableableButtonControllerBase;
      
      private var _getCrateButton:DisableableButtonControllerBase;
      
      private var _crateGiveGetButtonController:CrateGiveGetButtonController;
      
      private var _optionsButton:ButtonControllerBase;
      
      private var _ctEventSash:MovieClip;
      
      private var _openMonkeyKnowledeButton:OpenMonkeyKnowledgeButton;
      
      public const buildButtonClickedSignal:Signal = new Signal();
      
      public const contestedTerritoryButtonClickedSignal:Signal = new Signal();
      
      public const specialTracksButtonClickedSignal:Signal = new Signal();
      
      public const cancelBuildButtonClickedSignal:Signal = new Signal();
      
      public const cancelMoveButtonClickedSignal:Signal = new Signal();
      
      public const upgradesButtonClickedSignal:Signal = new Signal();
      
      public const pvpButtonClickedSignal:Signal = new Signal();
      
      public const myTowersButtonClickedSignal:Signal = new Signal();
      
      public const myCitiesButtonClickedSignal:Signal = new Signal();
      
      public const getCrateButtonClickedSignal:Signal = new Signal();
      
      public const giveCrateButtonClickedSignal:Signal = new Signal();
      
      private const syncTimer:Timer = new Timer(1000 * 60 * 5);
      
      private var _orignY:Number = 0;
      
      private var _isShown:Boolean = true;
      
      public function MapBottomUI(param1:MovieClip)
      {
         super();
         _instance = this;
         this.init(param1);
      }
      
      public static function getInstance() : MapBottomUI
      {
         return _instance;
      }
      
      private function init(param1:MovieClip) : void
      {
         var clip:MovieClip = param1;
         this._clip = BottomMapUI(clip);
         this._orignY = this._clip.y;
         this._contestedTerritoryButton = new DisableableButtonControllerBase(this._clip.contestedTerritoryButton);
         this._specialTracksButton = new DisableableButtonControllerBase(this._clip.specialTracksButton);
         this._myTowersButton = new DisableableButtonControllerBase(this._clip.myTowersButton);
         this._buildButton = new DisableableButtonControllerBase(this._clip.buildButton);
         this._cancelBuildButton = new DisableableButtonControllerBase(this._clip.cancelBuildButton);
         this._cancelMoveButton = new DisableableButtonControllerBase(this._clip.cancelMoveButton);
         this._upgradesButton = new DisableableButtonControllerBase(this._clip.upgradesButton);
         this._pvpButton = new DisableableButtonControllerBase(this._clip.raidButton);
         this._manageCitiesButton = new DisableableButtonControllerBase(this._clip.manageTownsButtons);
         this._giveCrateButton = new DisableableButtonControllerBase(this._clip.crateButtons.giveCrateButton);
         this._getCrateButton = new DisableableButtonControllerBase(this._clip.crateButtons.getCrateButton);
         this._optionsButton = new ButtonControllerBase(this._clip.optionsButton);
         this._optionsButton.setClickFunction(this.onOptionsButtonClick);
         this._openMonkeyKnowledeButton = new OpenMonkeyKnowledgeButton(this._clip.monkeyKnowledgeButton);
         this._ctEventSash = this._clip.eventOn;
         this._ctEventSash.visible = false;
         this._ctEventSash.mouseEnabled = false;
         this._ctEventSash.mouseChildren = false;
         this.syncTimer.addEventListener(TimerEvent.TIMER,this.onSyncTimer);
         this.syncTimer.start();
         GameEventManager.gameEventManagerReadySignal.add(this.onGameEventManagerReadySignal);
         var newColorTransform:ColorTransform = new ColorTransform(0.2,0.2,0.2,1,140,112,54);
         this._contestedTerritoryButton.changeLockedColorTransform(newColorTransform);
         this._specialTracksButton.changeLockedColorTransform(newColorTransform);
         this._myTowersButton.changeLockedColorTransform(newColorTransform);
         this._buildButton.changeLockedColorTransform(newColorTransform);
         this._cancelBuildButton.changeLockedColorTransform(newColorTransform);
         this._cancelMoveButton.changeLockedColorTransform(newColorTransform);
         this._upgradesButton.changeLockedColorTransform(newColorTransform);
         this._pvpButton.changeLockedColorTransform(newColorTransform);
         this._manageCitiesButton.changeLockedColorTransform(newColorTransform);
         if(Constants.DISABLE_CONTESTED_TERRITORY == false)
         {
            this._contestedTerritoryButton.setClickFunction(this.contestedTerritoryButtonClickedSignal.dispatch);
         }
         else
         {
            this._contestedTerritoryButton.disableMouseInteraction();
            this._contestedTerritoryButton.gotoAndStop(3);
         }
         this._specialTracksButton.setClickFunction(this.specialTracksButtonClickedSignal.dispatch);
         this._myTowersButton.setClickFunction(this.myTowersButtonClickedSignal.dispatch);
         this._buildButton.setClickFunction(this.buildButtonClickedSignal.dispatch);
         this._cancelBuildButton.setClickFunction(this.cancelBuildButtonClickedSignal.dispatch);
         this._cancelMoveButton.setClickFunction(this.cancelMoveButtonClickedSignal.dispatch);
         this._upgradesButton.setClickFunction(this.upgradesButtonClickedSignal.dispatch);
         this._pvpButton.setClickFunction(this.pvpButtonClickedSignal.dispatch);
         this._manageCitiesButton.setClickFunction(this.myCitiesButtonClickedSignal.dispatch);
         this._getCrateButton.setClickFunction(this.getCrateButtonClickedSignal.dispatch);
         this._giveCrateButton.setClickFunction(this.giveCrateButtonClickedSignal.dispatch);
         this.cancelBuildButtonEnabled = false;
         GameSignals.TUTORIAL_DISABLE_BASE_BUTTONS.add(this.disableAllButtons);
         GameSignals.TUTORIAL_ENABLE_BUTTONS.add(this.enableAllButtons);
         GameSignals.TUTORIAL_ENABLE_BASE_BUTTON.add(this.enableButton);
         this._clip.manageTownsButtons.gotoAndStop(0);
         this._clip.specialTracksButton.visible = false;
         this._clip.leftCogs.gotoAndStop(1);
         this._clip.rightCogs.gotoAndStop(1);
         this._clip.rightCogs.visible = false;
         PvPSignals.pvpDataUpdatedSignal.add(this.onPvPDataUpdatedSignal);
         PvPSignals.attackRemoved.add(this.onAttackRemovedSignal);
         TrackManager.unlockedCountChangedSignal.add(this.setNumberOfNewUnlockedTracks);
         this._clip.numberOfRaids.visible = false;
         MonkeyCityMain.globalResetSignal.add(this.onReset);
         WorldViewSignals.buildWorldStartSignal.add(this.onReset);
         Building.requestMoveSignal.add(function():void
         {
            cancelMoveButtonEnabled = true;
         });
         Flatten.flatten(this._clip.leavesLeft);
         Flatten.flatten(this._clip.leavesRight);
         BuildingPlacer.placingBuildingWasCancelled.add(function():void
         {
            cancelMoveButtonEnabled = false;
            cancelBuildButtonEnabled = false;
            cancelBuildButtonClickedSignal.dispatch();
            cancelMoveButtonClickedSignal.dispatch();
         });
         this._crateGiveGetButtonController = new CrateGiveGetButtonController(this._clip.crateButtons);
         HandShake.sessionInitialisedSignal.add(this.onSessionInitialised);
      }
      
      private function onGameEventManagerReadySignal() : void
      {
         this.syncEventSash();
      }
      
      private function onSyncTimer(param1:TimerEvent) : void
      {
         this.syncEventSash();
      }
      
      private function syncEventSash() : void
      {
         var _loc1_:Array = GameEventManager.getInstance().getActiveEvents();
         this._ctEventSash.visible = false;
         this._ctEventSash.star.stop();
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            if("ctMilestones" == _loc1_[_loc2_].type || "ctOccupation" == _loc1_[_loc2_].type)
            {
               this._ctEventSash.visible = true;
               this._ctEventSash.star.play();
               break;
            }
            _loc2_++;
         }
      }
      
      private function onOptionsButtonClick() : void
      {
         PanelManager.getInstance().showFreePanel(TownUI.getInstance().optionsPanel);
      }
      
      private function onSessionInitialised() : void
      {
         if(Kong.isOnKong())
         {
            this.configureForKong();
         }
      }
      
      public function configureForKong() : void
      {
         if(Constants.DISABLE_CT_ON_KONG)
         {
            this._clip.contestedTerritoryButton.visible = false;
            this._contestedTerritoryButton.lock();
         }
         if(Constants.DISABLE_CRATES_ON_KONG)
         {
            this._clip.crateButtons.visible = false;
            this._clip.rightCogs.visible = true;
         }
      }
      
      private function onReset() : void
      {
         this.enableAllButtons();
         this.resetHide();
         this.setNumberOfPvPIncomingAttacks(0);
         this._openMonkeyKnowledeButton.clip.visible = false;
      }
      
      private function hide(param1:Number = 0.2) : void
      {
         TweenLite.killTweensOf(this._clip);
         TweenLite.to(this._clip,param1,{
            "y":this._orignY + HIDE_AMOUNT,
            "ease":Linear.easeIn
         });
         this._isShown = false;
      }
      
      private function show(param1:Number = 0.2) : void
      {
         TweenLite.killTweensOf(this._clip);
         TweenLite.to(this._clip,param1,{
            "y":this._orignY,
            "ease":Linear.easeOut
         });
         this._isShown = true;
      }
      
      private function resetHide() : void
      {
         TweenLite.killTweensOf(this._clip);
         this._isShown = true;
         this._clip.y = this._orignY;
      }
      
      public function resize(param1:int, param2:int) : void
      {
         this._orignY = this._clip.y;
         TweenLite.killTweensOf(this._clip);
         if(this._isShown)
         {
            this._clip.y = this._orignY;
         }
         else
         {
            this._clip.y = this._orignY + HIDE_AMOUNT;
         }
      }
      
      private function onAttackRemovedSignal(param1:int) : void
      {
         this.setNumberOfPvPIncomingAttacks(param1);
      }
      
      private function onPvPDataUpdatedSignal(param1:Object, param2:Object, param3:Object) : void
      {
         this.setNumberOfPvPIncomingAttacks(param1.incomingRaids.length);
      }
      
      public function set cancelBuildButtonEnabled(param1:Boolean) : void
      {
         this._cancelBuildButton.target.visible = param1;
         if(param1)
         {
            this._system.flashStage.addEventListener(KeyboardEvent.KEY_DOWN,this.keydownHandler);
            this._system.flashStage.focus = this._system.flashStage;
         }
         else
         {
            this._system.flashStage.removeEventListener(KeyboardEvent.KEY_DOWN,this.keydownHandler);
         }
         this._cancelMoveButton.target.visible = false;
      }
      
      public function set cancelMoveButtonEnabled(param1:Boolean) : void
      {
         this._cancelMoveButton.target.visible = param1;
         if(param1)
         {
            this._system.flashStage.addEventListener(KeyboardEvent.KEY_DOWN,this.keydownHandler);
            this._system.flashStage.focus = this._system.flashStage;
         }
         else
         {
            this._system.flashStage.removeEventListener(KeyboardEvent.KEY_DOWN,this.keydownHandler);
         }
         this._cancelBuildButton.target.visible = false;
      }
      
      public function get openMonkeyKnowledeButton() : OpenMonkeyKnowledgeButton
      {
         return this._openMonkeyKnowledeButton;
      }
      
      private function keydownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ESCAPE)
         {
            this.cancelBuildButtonClickedSignal.dispatch();
            this.cancelMoveButtonClickedSignal.dispatch();
         }
      }
      
      public function disableAllButtons() : void
      {
         if(false == Constants.DISABLE_CONTESTED_TERRITORY)
         {
            this._contestedTerritoryButton.lock(1);
         }
         this._specialTracksButton.lock(1);
         this._myTowersButton.lock(1);
         this._buildButton.lock(1);
         this._upgradesButton.lock(1);
         this._upgradesButton.lock(1);
         this._pvpButton.lock(1);
         this._manageCitiesButton.lock(1);
         this._giveCrateButton.lock(1);
         this._getCrateButton.lock(1);
         this.hide();
      }
      
      public function enableAllButtons() : void
      {
         if(false == Constants.DISABLE_CONTESTED_TERRITORY)
         {
            this._contestedTerritoryButton.unlock();
         }
         this._specialTracksButton.unlock();
         this._myTowersButton.unlock();
         this._buildButton.unlock();
         this._upgradesButton.unlock();
         this._upgradesButton.unlock();
         this._pvpButton.unlock();
         this._manageCitiesButton.unlock();
         this._giveCrateButton.unlock();
         this._getCrateButton.unlock();
         this.show();
      }
      
      public function enableButton(param1:String) : void
      {
         switch(param1)
         {
            case "contestedTerritoryButton":
               if(false == Constants.DISABLE_CONTESTED_TERRITORY)
               {
                  this._contestedTerritoryButton.unlock();
               }
               break;
            case "tasksButton":
               this._specialTracksButton.unlock();
               break;
            case "myTowersButton":
               this._myTowersButton.unlock();
               break;
            case "buildButton":
               this._buildButton.unlock();
               break;
            case "upgradesButton":
               this._upgradesButton.unlock();
               break;
            case "raidButton":
               this._pvpButton.unlock();
               break;
            case "manageTownsButtons":
               this._manageCitiesButton.unlock();
         }
         if(!this._isShown)
         {
            this.show();
         }
      }
      
      public function moveLeftCogs(param1:Number) : void
      {
         this._clip.leftCogs.play();
         TweenLite.delayedCall(param1,this.stopLeftCogs);
      }
      
      private function stopLeftCogs() : void
      {
         this._clip.leftCogs.stop();
      }
      
      public function moveRightCogs(param1:Number) : void
      {
         if(!this._clip.rightCogs.visible)
         {
            return;
         }
         this._clip.rightCogs.play();
         TweenLite.delayedCall(param1,this.stopRightCogs);
      }
      
      private function stopRightCogs() : void
      {
         this._clip.rightCogs.stop();
      }
      
      public function setNumberOfPvPIncomingAttacks(param1:int) : void
      {
         this._clip.numberOfRaids.numberField.text = param1.toString();
         if(param1 !== 0)
         {
            this._clip.numberOfRaids.visible = true;
            this._clip.numberOfRaids.gotoAndStop(2);
         }
         else
         {
            this._clip.numberOfRaids.gotoAndStop(1);
            this._clip.numberOfRaids.visible = false;
         }
      }
      
      private function setNumberOfNewUnlockedTracks(param1:int) : void
      {
         this._clip.numberOfArchives.numberField.text = param1.toString();
         if(param1 !== 0)
         {
            this._clip.numberOfArchives.visible = true;
            this._clip.numberOfArchives.gotoAndStop(2);
         }
         else
         {
            this._clip.numberOfArchives.gotoAndStop(1);
            this._clip.numberOfArchives.visible = false;
         }
         if(ResourceStore.getInstance().townLevel < Constants.MIN_MYTRACK_LEVEL)
         {
            this._clip.numberOfArchives.visible = false;
         }
      }
   }
}
