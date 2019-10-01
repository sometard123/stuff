package ninjakiwi.monkeyTown.btdModule.tutorial
{
   import assets.btdmodule.tutorial.ArrowSetClip;
   import assets.btdmodule.tutorial.DeadZone1Clip;
   import assets.btdmodule.tutorial.DeadZone2Clip;
   import assets.btdmodule.tutorial.DeadZoneTargetClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.btdModule.game.BuildTowerInfo;
   import ninjakiwi.monkeyTown.btdModule.game.Game;
   import ninjakiwi.monkeyTown.btdModule.ingame.GameGoButtonController;
   import ninjakiwi.monkeyTown.btdModule.ingame.InGameMenu;
   import ninjakiwi.monkeyTown.btdModule.levels.rounds.BloonSpawnType;
   import ninjakiwi.monkeyTown.btdModule.levels.rounds.Round;
   import ninjakiwi.monkeyTown.btdModule.levels.terrain.TerrainType;
   import ninjakiwi.monkeyTown.btdModule.state.Message;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.TowerPlace;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   
   public class TutorialManager
   {
       
      
      private var _tutorialIndex:int = 0;
      
      private var _game:Game;
      
      private var _menu:InGameMenu;
      
      private var _gameContainer:DisplayObjectContainer;
      
      private var _UIContainer:DisplayObjectContainer;
      
      private var _arrowSet:ArrowSetClip;
      
      private var _deadZone1Clip:DeadZone1Clip;
      
      private var _deadZone2Clip:DeadZone2Clip;
      
      private var _deadZoneTargetClip:DeadZoneTargetClip;
      
      private var _panel:TutorialPanel;
      
      private var _deadZone1:TerrainType;
      
      private var _deadZone2:TerrainType;
      
      public function TutorialManager(param1:DisplayObjectContainer, param2:DisplayObjectContainer, param3:Game, param4:InGameMenu)
      {
         var gameContainer:DisplayObjectContainer = param1;
         var UIContainer:DisplayObjectContainer = param2;
         var game:Game = param3;
         var inGameMenu:InGameMenu = param4;
         this._arrowSet = new ArrowSetClip();
         this._deadZone1Clip = new DeadZone1Clip();
         this._deadZone2Clip = new DeadZone2Clip();
         this._deadZoneTargetClip = new DeadZoneTargetClip();
         this._deadZone1 = new TerrainType(this._deadZone1Clip);
         this._deadZone2 = new TerrainType(this._deadZone2Clip);
         super();
         this._game = game;
         this._menu = inGameMenu;
         this._UIContainer = UIContainer;
         this._gameContainer = gameContainer;
         this._arrowSet.visible = false;
         this._panel = new TutorialPanel(this._UIContainer);
         this._deadZone1Clip.alpha = 0.5;
         this._deadZone2Clip.alpha = 0.5;
         this._UIContainer.addChild(this._deadZone1Clip);
         this._UIContainer.addChild(this._deadZone2Clip);
         this._deadZone1Clip.visible = false;
         this._deadZone2Clip.visible = false;
         this._UIContainer.addChild(this._deadZoneTargetClip);
         this._deadZoneTargetClip.visible = false;
         try
         {
            this._menu.mc.uiPanels.towerSelected.sell.gotoAndStop("Invalid");
         }
         catch(e:Error)
         {
         }
         InGameMenu.prepareNextRoundSignal.addOnce(this.onPrepareNextRound);
         TowerPlace.towerPlacedSignal.add(this.onTowerPlaced);
      }
      
      public function setRound(param1:BTDGameRequest) : void
      {
         var _loc5_:BloonSpawnType = null;
         var _loc2_:Vector.<Round> = new Vector.<Round>();
         var _loc3_:Round = new Round(Main.instance.game.level);
         var _loc4_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < 10)
         {
            _loc5_ = new BloonSpawnType(Constants.RED_ID);
            _loc5_.Spacing(Constants.SPACING_NORMAL);
            _loc3_.queueBloon(_loc5_);
            _loc4_++;
         }
         _loc2_.push(_loc3_);
         _loc3_ = new Round(Main.instance.game.level);
         _loc4_ = 0;
         while(_loc4_ < 20)
         {
            _loc5_ = new BloonSpawnType(Constants.RED_ID);
            _loc5_.Spacing(Constants.SPACING_NORMAL);
            _loc3_.queueBloon(_loc5_);
            _loc4_++;
         }
         _loc2_.push(_loc3_);
         _loc3_ = new Round(Main.instance.game.level);
         _loc4_ = 0;
         while(_loc4_ < 30)
         {
            _loc5_ = new BloonSpawnType(Constants.RED_ID);
            _loc5_.Spacing(Constants.SPACING_NORMAL);
            _loc3_.queueBloon(_loc5_);
            _loc4_++;
         }
         _loc2_.push(_loc3_);
         Main.instance.game.level.roundGenerator.setCustomRounds(_loc2_);
      }
      
      public function endTutorial() : void
      {
         if(this._UIContainer != null)
         {
            if(this._UIContainer.contains(this._arrowSet))
            {
               this._UIContainer.removeChild(this._arrowSet);
            }
            if(this._UIContainer.contains(this._deadZone1Clip))
            {
               this._UIContainer.removeChild(this._deadZone1Clip);
            }
            if(this._UIContainer.contains(this._deadZone2Clip))
            {
               this._UIContainer.removeChild(this._deadZone2Clip);
            }
            if(this._UIContainer.contains(this._deadZoneTargetClip))
            {
               this._UIContainer.removeChild(this._deadZoneTargetClip);
            }
         }
         try
         {
            this._menu.mc.uiPanels.towerSelected.sell.gotoAndStop("Out");
         }
         catch(e:Error)
         {
         }
         this._game.level.sigTowerCreated.remove(this.onFirstTowerPlaced);
         this._panel.nextSignal.remove(this.nextTutorialStep);
         InGameMenu.prepareNextRoundSignal.remove(this.onPrepareNextRound);
         GameGoButtonController.goButtonClickToPlaySignal.remove(this.goButtonClickedAfterFirstTower);
         this._panel.okSignal.remove(this.okClickedAtLastTutorial);
         this.okClickedAtLastTutorial();
         TowerPlace.towerPlacedSignal.remove(this.onTowerPlaced);
         if(this._panel != null)
         {
            this._panel.destroyPanel();
         }
      }
      
      private function onPrepareNextRound() : void
      {
         if(this._tutorialIndex == 0)
         {
            this.nextTutorialStep();
         }
         else if(this._tutorialIndex == 4)
         {
            this.nextTutorialStep();
         }
         else if(this._tutorialIndex == 6)
         {
            this.nextTutorialStep();
         }
      }
      
      private function nextTutorialStep() : Boolean
      {
         if(this._tutorialIndex >= InGameTutorialData.TUTORIALS.length || this._tutorialIndex < 0)
         {
            return false;
         }
         var _loc1_:int = 10;
         var _loc2_:int = 0;
         this._arrowSet.visible = false;
         switch(this._tutorialIndex)
         {
            default:
               this._tutorialIndex = 0;
               return false;
            case 0:
               this._arrowSet.visible = true;
               this._arrowSet.gotoAndStop(1);
               this._menu.stateMachine.changeState(null,null);
               InGameMenu.enableGoButtonSignal.dispatch(false);
               this._panel.nextSignal.addOnce(this.nextTutorialStep);
               this._panel.setSymbol(1);
               break;
            case 1:
               this._arrowSet.visible = false;
               this._panel.nextSignal.addOnce(this.nextTutorialStep);
               this._panel.setSymbol(2);
               break;
            case 2:
               if(this._UIContainer != null)
               {
                  this._UIContainer.addChild(this._arrowSet);
               }
               this._arrowSet.visible = true;
               this._arrowSet.gotoAndStop(2);
               this._menu.stateMachine.changeState(this._menu.neutral,new Message());
               this._game.level.terrainSet.generateTestMaps(this._deadZone1);
               this._deadZone1Clip.visible = true;
               this._deadZoneTargetClip.gotoAndStop(1);
               this._deadZoneTargetClip.visible = true;
               this._game.level.sigTowerCreated.addOnce(this.onFirstTowerPlaced);
               this._panel.setSymbol(3,10);
               _loc1_ = 17;
               _loc2_ = 100;
               Main.instance.game.inGameMenu.goButton.isCancelEnabled = false;
               break;
            case 3:
               InGameMenu.enableGoButtonSignal.dispatch(true);
               GameGoButtonController.goButtonClickToPlaySignal.addOnce(this.goButtonClickedAfterFirstTower);
               this._panel.nextSignal.addOnce(this.nextTutorialStep);
               this._panel.setSymbol(4,10);
               _loc2_ = 100;
               break;
            case 4:
               InGameMenu.enableGoButtonSignal.dispatch(false);
               this._menu.stateMachine.changeState(null,null);
               this._panel.nextSignal.addOnce(this.nextTutorialStep);
               this._panel.setSymbol(5);
               _loc1_ = 23;
               break;
            case 5:
               this._menu.stateMachine.changeState(this._menu.neutral,new Message());
               this._game.level.terrainSet.generateTestMaps(this._deadZone2);
               this._deadZone2Clip.visible = true;
               this._deadZoneTargetClip.gotoAndStop(2);
               this._deadZoneTargetClip.visible = true;
               this._game.level.sigTowerCreated.addOnce(this.onSecondTowerPlaced);
               this._panel.setSymbol(3,10);
               _loc1_ = 17;
               _loc2_ = -50;
               Main.instance.game.inGameMenu.goButton.isCancelEnabled = false;
               break;
            case 6:
               InGameMenu.enableGoButtonSignal.dispatch(false);
               this._menu.stateMachine.changeState(null,null);
               this._panel.okSignal.addOnce(this.okClickedAtLastTutorial);
               this._panel.setSymbol(6);
               _loc1_ = 23;
               _loc2_ = -50;
         }
         if(this._panel != null)
         {
            this._panel.setMessage(InGameTutorialData.TUTORIALS[this._tutorialIndex].description,InGameTutorialData.TUTORIALS[this._tutorialIndex].buttonType,_loc1_,_loc2_);
            this._panel.reveal();
         }
         this._tutorialIndex++;
         return true;
      }
      
      private function onFirstTowerPlaced(param1:BuildTowerInfo) : void
      {
         this._deadZone1Clip.visible = false;
         this._deadZoneTargetClip.visible = false;
         this.nextTutorialStep();
         Main.instance.game.inGameMenu.goButton.isCancelEnabled = true;
      }
      
      private function onSecondTowerPlaced(param1:BuildTowerInfo) : void
      {
         this._deadZone2Clip.visible = false;
         this._deadZoneTargetClip.visible = false;
         this._panel.hide();
         InGameMenu.prepareNextRoundSignal.addOnce(this.onPrepareNextRound);
         InGameMenu.enableGoButtonSignal.dispatch(true);
         Main.instance.game.inGameMenu.goButton.isCancelEnabled = true;
      }
      
      private function goButtonClickedAfterFirstTower() : void
      {
         this._panel.hide();
         InGameMenu.prepareNextRoundSignal.addOnce(this.onPrepareNextRound);
      }
      
      private function goButtonClickedAfterSecondTower() : void
      {
         this._panel.hide();
      }
      
      private function okClickedAtLastTutorial() : void
      {
         InGameMenu.enableGoButtonSignal.dispatch(true);
         this._menu.stateMachine.changeState(this._menu.neutral,new Message());
         Main.instance.tooltip.enable = true;
      }
      
      private function onTowerPlaced(param1:Tower) : void
      {
         param1.resellable = false;
      }
   }
}
