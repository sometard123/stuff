package ninjakiwi.monkeyTown.btdModule.BSSpecialAbility
{
   import assets.maps.dryasabone.RainCloudClip;
   import display.Clip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.levels.rounds.BloonSpawnDefinition;
   import ninjakiwi.monkeyTown.btdModule.levels.rounds.BloonSpawnType;
   import ninjakiwi.monkeyTown.btdModule.levels.rounds.Round;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.TowerPlace;
   import ninjakiwi.monkeyTown.btdModule.tutorial.AllTacticsTutorial;
   import ninjakiwi.monkeyTown.btdModule.tutorial.AntiBossAbilityTutorialPanel;
   import ninjakiwi.monkeyTown.btdModule.tutorial.TacticsTutorial;
   import ninjakiwi.monkeyTown.btdModule.tutorial.tactics.Boost1TutorialPanel;
   import ninjakiwi.monkeyTown.btdModule.tutorial.tactics.Boost2TutorialPanel;
   import ninjakiwi.monkeyTown.btdModule.tutorial.tactics.RHS1TutorialPanel;
   import ninjakiwi.monkeyTown.btdModule.tutorial.tactics.RHS2TutorialPanel;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.monkeyTown.common.events.GameEvent;
   import ninjakiwi.monkeyTown.utils.DeepMixin;
   
   public class BSSpecialAbilityManager
   {
       
      
      private const _abilities:Vector.<BSSpecialAbility> = new Vector.<BSSpecialAbility>();
      
      private var _tutorialLayer:DisplayObjectContainer;
      
      private var _tutorialSave:Object;
      
      private var _tutorialPanelForAll:AllTacticsTutorial;
      
      private var _boost:MonkeyBoost;
      
      private var _rhs:RedHotSpikes;
      
      private var _antiBossAbilityTutorial:AntiBossAbilityTutorialPanel;
      
      public function BSSpecialAbilityManager(param1:DisplayObjectContainer)
      {
         super();
         this._boost = new MonkeyBoost(param1);
         this._rhs = new RedHotSpikes(param1);
         this._abilities.push(this._boost);
         this._abilities.push(this._rhs);
      }
      
      public function init() : void
      {
         var _loc1_:BSSpecialAbility = null;
         for each(_loc1_ in this._abilities)
         {
            _loc1_.init();
            _loc1_.moreBloonstonesNeeded.add(this.onBloonstonesCharged);
            _loc1_.bloonstonesSpent.add(this.analyticsCall);
         }
      }
      
      public function destory() : void
      {
         var _loc1_:BSSpecialAbility = null;
         for each(_loc1_ in this._abilities)
         {
            _loc1_.moreBloonstonesNeeded.remove(this.onBloonstonesCharged);
            _loc1_.bloonstonesSpent.remove(this.analyticsCall);
            _loc1_.destroy();
         }
         this._abilities.length = 0;
      }
      
      public function startGame(param1:BTDGameRequest, param2:DisplayObjectContainer) : void
      {
         var _loc3_:BSSpecialAbility = null;
         var _loc4_:Object = null;
         if(param1.bossAttack == null)
         {
         }
         for each(_loc3_ in this._abilities)
         {
            _loc3_.reset();
         }
         _loc4_ = {
            "all":false,
            "boost1":0,
            "boost2":0,
            "rhs1":0,
            "rhs2":0,
            "seenAntiBossAbilityTutorial":false
         };
         this._tutorialSave = DeepMixin.mix(_loc4_,param1.tutorialSave);
         this._tutorialLayer = param2;
         if(param1.isTutorial == false)
         {
            if(this._tutorialSave.all == false)
            {
               if(param1.isContestedTerritory == false)
               {
                  this._tutorialPanelForAll = new AllTacticsTutorial(this._tutorialLayer);
                  this._tutorialPanelForAll.reveal();
                  this._tutorialSave.all = true;
               }
            }
         }
         if(param1.bossAttack !== null)
         {
            if(this._antiBossAbilityTutorial === null)
            {
               this._antiBossAbilityTutorial = new AntiBossAbilityTutorialPanel(param2,this._tutorialSave);
            }
            else
            {
               this._antiBossAbilityTutorial.setTutorialSave(this._tutorialSave);
            }
         }
         if(this.checkTutorial() == true)
         {
            Bloon.tutorialBloonSpawned.addOnce(this.onTutorialBloonSpawned);
         }
         this._boost.setBonusCount(param1.extraMonkeyBoosts);
         this._rhs.setBonusCount(param1.extraRedHotSpikes);
         this.update();
      }
      
      public function reset() : void
      {
         var _loc1_:BSSpecialAbility = null;
         for each(_loc1_ in this._abilities)
         {
            _loc1_.reset();
         }
         this.update();
      }
      
      public function getSaveData() : Object
      {
         return this._tutorialSave;
      }
      
      public function endGame() : void
      {
         Bloon.tutorialBloonSpawned.remove(this.onTutorialBloonSpawned);
         if(this._antiBossAbilityTutorial !== null)
         {
            this._antiBossAbilityTutorial.hide();
         }
      }
      
      private function onBloonstonesCharged(param1:int) : void
      {
         Main.instance.notEnoughBloonstonesSidePanel.reveal();
      }
      
      private function onOpenShop() : void
      {
         Main.instance.dispatchEvent(new GameEvent(Constants.GAME_OPEN_SHOP,{"bloonstonesRequired":Main.instance.game.inGameMenu.notEnoughBloonstonesPanel.requiredBloonstones}));
      }
      
      public function update() : void
      {
         var _loc1_:BSSpecialAbility = null;
         var _loc2_:Number = NaN;
         for each(_loc1_ in this._abilities)
         {
            if(_loc1_.timer != null)
            {
               if(_loc1_.timer.running == true)
               {
                  _loc2_ = _loc1_.timer.current / _loc1_.timer.delay;
                  if(_loc1_.clip != null && _loc1_.clip.coolDown_mc != null)
                  {
                     _loc1_.clip.coolDown_mc.visible = true;
                     _loc1_.clip.coolDown_mc.gotoAndStop(int(_loc2_ * (_loc1_.clip.coolDown_mc.totalFrames - 1)) + 1);
                  }
               }
               else if(_loc1_.clip != null && _loc1_.clip.coolDown_mc != null)
               {
                  _loc1_.clip.coolDown_mc.visible = false;
               }
            }
         }
      }
      
      private function onTutorialBloonSpawned(param1:int) : void
      {
         var _loc2_:TacticsTutorial = null;
         if(param1 == Bloon.TUTORIAL_TYPE_BOOST_1 && this._boost.isAvailable == true)
         {
            _loc2_ = new Boost1TutorialPanel(this._tutorialLayer,this._tutorialSave);
         }
         else if(param1 == Bloon.TUTORIAL_TYPE_BOOST_2 && this._boost.isAvailable == true)
         {
            _loc2_ = new Boost2TutorialPanel(this._tutorialLayer,this._tutorialSave);
         }
         else if(param1 == Bloon.TUTORIAL_TYPE_RHS_1 && this._rhs.isAvailable == true)
         {
            _loc2_ = new RHS1TutorialPanel(this._tutorialLayer,this._tutorialSave);
         }
         else if(param1 == Bloon.TUTORIAL_TYPE_RHS_2 && this._rhs.isAvailable == true)
         {
            _loc2_ = new RHS2TutorialPanel(this._tutorialLayer,this._tutorialSave);
         }
         if(_loc2_ != null && false == _loc2_.isDisabled())
         {
            TowerPlace.blockTowerPlacing = true;
            Main.instance.pause = true;
            _loc2_.onHideSignal.addOnce(this.onTutorialHide);
            _loc2_.reveal();
         }
      }
      
      private function onTutorialHide() : void
      {
         Main.instance.pause = false;
         TowerPlace.blockTowerPlacing = false;
      }
      
      private function checkTutorial() : Boolean
      {
         var _loc3_:Round = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:BloonSpawnDefinition = null;
         var _loc8_:BloonSpawnType = null;
         var _loc1_:Vector.<Round> = Main.instance.game.level.roundGenerator.rounds;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = _loc1_[_loc2_];
            _loc4_ = _loc3_.queuedBloons.length;
            _loc5_ = 0;
            _loc6_ = 0;
            while(_loc6_ < _loc4_)
            {
               _loc7_ = _loc3_.queuedBloons[_loc6_] as BloonSpawnDefinition;
               _loc8_ = _loc7_.spawnType;
               if(this._tutorialSave.boost1 < 3)
               {
                  if(_loc8_.type >= Bloon.PINK && _loc8_.spacing <= Constants.SPACING_CLOSE)
                  {
                     _loc5_++;
                  }
                  else
                  {
                     _loc5_ = 0;
                  }
                  if(_loc5_ >= 6)
                  {
                     _loc7_.tutorialType = Bloon.TUTORIAL_TYPE_BOOST_1;
                     return true;
                  }
               }
               else if(this._tutorialSave.boost2 < 1)
               {
                  if(_loc8_.type == Bloon.MOAB)
                  {
                     _loc7_.tutorialType = Bloon.TUTORIAL_TYPE_BOOST_2;
                     return true;
                  }
               }
               if(this._tutorialSave.rhs1 < 3)
               {
                  if(_loc8_.type == Bloon.LEAD)
                  {
                     _loc7_.tutorialType = Bloon.TUTORIAL_TYPE_RHS_1;
                     return true;
                  }
               }
               else if(this._tutorialSave.rhs2 < 1)
               {
                  if(_loc8_.type == Bloon.LEAD && _loc8_.camo == true)
                  {
                     _loc7_.tutorialType = Bloon.TUTORIAL_TYPE_RHS_2;
                     return true;
                  }
               }
               _loc6_++;
            }
            _loc2_++;
         }
         return false;
      }
      
      private function analyticsCall(param1:BSSpecialAbility) : void
      {
         Main.instance.dispatchEvent(new GameEvent(Constants.GAME_TACTICS_ANALYTICS,{
            "id":param1.id,
            "difficulty":Main.instance.game.gameRequest.difficulty,
            "trackId":Main.instance.game.currentLevelDef.id,
            "roundReached":Main.instance.game.level.roundGenerator.roundIndex + 1
         }));
      }
      
      public function get abilities() : Vector.<BSSpecialAbility>
      {
         return this._abilities;
      }
   }
}
