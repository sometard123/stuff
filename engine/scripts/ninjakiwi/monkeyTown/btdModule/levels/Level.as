package ninjakiwi.monkeyTown.btdModule.levels
{
   import assets.sounds.Place;
   import assets.sounds.Sell;
   import display.ui.Button;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import flash.system.ApplicationDomain;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.collision.CollisionGrid;
   import ninjakiwi.monkeyTown.btdModule.entities.AceAircraft;
   import ninjakiwi.monkeyTown.btdModule.entities.MapElement;
   import ninjakiwi.monkeyTown.btdModule.events.BloonEvent;
   import ninjakiwi.monkeyTown.btdModule.events.LevelEvent;
   import ninjakiwi.monkeyTown.btdModule.events.TowerChangedEvent;
   import ninjakiwi.monkeyTown.btdModule.framework.Scene;
   import ninjakiwi.monkeyTown.btdModule.game.BuildTowerInfo;
   import ninjakiwi.monkeyTown.btdModule.game.Game;
   import ninjakiwi.monkeyTown.btdModule.ingame.HelpFromFriends;
   import ninjakiwi.monkeyTown.btdModule.levels.levelDefs.LevelDef;
   import ninjakiwi.monkeyTown.btdModule.levels.rounds.BloonSpawnTestModule;
   import ninjakiwi.monkeyTown.btdModule.levels.rounds.RoundGenerator;
   import ninjakiwi.monkeyTown.btdModule.levels.rounds.RoundGeneratorBloonBeacon;
   import ninjakiwi.monkeyTown.btdModule.levels.rounds.RoundGeneratorBoss;
   import ninjakiwi.monkeyTown.btdModule.levels.rounds.RoundGeneratorContest;
   import ninjakiwi.monkeyTown.btdModule.levels.rounds.RoundGeneratorPvP;
   import ninjakiwi.monkeyTown.btdModule.levels.terrain.TerrainSet;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   import ninjakiwi.monkeyTown.btdModule.sound.MaxSound;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.TowerFactory;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundStart.DeployMonkeyAce;
   import ninjakiwi.monkeyTown.btdModule.towers.def.AreaEffectDef;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradeDef;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.tool.LevelAnimation;
   import org.osflash.signals.PrioritySignal;
   import org.osflash.signals.Signal;
   
   public class Level extends Scene
   {
      
      public static const towerSoldSignal:Signal = new Signal(Tower);
      
      public static var camoDisabled:Boolean = false;
      
      public static const initialisedSignal:Signal = new Signal();
       
      
      public var health:CryptScore;
      
      public var cash:CryptScore;
      
      public var terrainSet:TerrainSet;
      
      private var trackPoints:Vector.<Vector2>;
      
      public var startTile:Tile;
      
      public var mainPath:Vector.<Tile>;
      
      public var collisionGrid:CollisionGrid;
      
      public var allTowers:Vector.<Tower>;
      
      public var bloons:Vector.<Bloon>;
      
      public var allProjectiles:Vector.<Projectile>;
      
      public var levelDef:LevelDef = null;
      
      public var game:Game = null;
      
      private var _roundInProgress:Boolean = false;
      
      public var roundGenerator:RoundGenerator;
      
      public var helpFromFriends:HelpFromFriends;
      
      private var disposableFrameClasses:Vector.<Class>;
      
      public var sabotageBloons:Boolean = false;
      
      public var boundries:Rectangle;
      
      public var sigHealthChange:Signal;
      
      public var sigBloonRemoved:PrioritySignal;
      
      public var sigTowerCreated:Signal;
      
      public var sigBloonLeaked:Signal;
      
      public var sigTowerPathUpgraded:Signal;
      
      public var sigUpgradePurchaseSignal:Signal;
      
      public var sigBloonSendWaveAdded:Signal;
      
      public var sigBloonSendWaveRemoved:Signal;
      
      public var sigBloonSendWaveCompleted:Signal;
      
      public var sigTowerTargetPriorityChanged:Signal;
      
      public var sigAceFlightPathChanged:Signal;
      
      public var sigTowerAbilityUsed:Signal;
      
      public var sigTowerTargetReticleChanged:Signal;
      
      public var sigLevelIsReady:Signal;
      
      private var _timeOfLastCashChangedEvent:Number = 0;
      
      private var _cashHasChanged:Boolean = false;
      
      private var _bossEntryPointX:Number = 0;
      
      private var _bossEntryPointY:Number = 0;
      
      private var placeSound:MaxSound;
      
      public var sellSound:MaxSound;
      
      public function Level()
      {
         this.health = new CryptScore();
         this.cash = new CryptScore();
         this.collisionGrid = new CollisionGrid();
         this.allTowers = new Vector.<Tower>();
         this.bloons = new Vector.<Bloon>();
         this.allProjectiles = new Vector.<Projectile>();
         this.disposableFrameClasses = new Vector.<Class>();
         this.sigHealthChange = new Signal();
         this.sigBloonRemoved = new PrioritySignal();
         this.sigTowerCreated = new Signal();
         this.sigBloonLeaked = new Signal(Bloon);
         this.sigTowerPathUpgraded = new Signal();
         this.sigUpgradePurchaseSignal = new Signal(UpgradeDef);
         this.sigBloonSendWaveAdded = new Signal();
         this.sigBloonSendWaveRemoved = new Signal();
         this.sigBloonSendWaveCompleted = new Signal();
         this.sigTowerTargetPriorityChanged = new Signal();
         this.sigAceFlightPathChanged = new Signal();
         this.sigTowerAbilityUsed = new Signal();
         this.sigTowerTargetReticleChanged = new Signal();
         this.sigLevelIsReady = new Signal();
         this.placeSound = new MaxSound(Place);
         this.sellSound = new MaxSound(Sell);
         super();
      }
      
      public function init(param1:Game, param2:LevelDef, param3:BTDGameRequest, param4:ApplicationDomain) : void
      {
         var assetClass:Class = null;
         var terrainClass:Class = null;
         var tile:Tile = null;
         var game:Game = param1;
         var levelDef:LevelDef = param2;
         var gameRequest:BTDGameRequest = param3;
         var applicationDomain:ApplicationDomain = param4;
         this.game = game;
         this.levelDef = levelDef;
         this.boundries = new Rectangle(Main.playArea.x,Main.playArea.y,Main.playArea.width,Main.playArea.height);
         this.clear();
         try
         {
            assetClass = Class(applicationDomain.getDefinition(levelDef.assetClassName));
            terrainClass = Class(applicationDomain.getDefinition(levelDef.terrainClassName));
         }
         catch(e:Error)
         {
            throw e;
         }
         this.collisionGrid.init(this);
         this.calcTrackPoints(terrainClass);
         this.sabotageBloons = false;
         this.addLevelVisuals(assetClass,applicationDomain);
         this.terrainSet = new TerrainSet(terrainClass);
         this.mainPath = levelDef.mainPath;
         for each(tile in this.mainPath)
         {
            tile.initialise(this.mainPath);
         }
         this.startTile = this.mainPath[0];
         if(gameRequest.pvpAttackDefinition !== null)
         {
            this.roundGenerator = new RoundGeneratorPvP(this);
            BloonSpawnTestModule.setRoundGenerator(this.roundGenerator);
         }
         else if(gameRequest.isContestedTerritory)
         {
            this.roundGenerator = new RoundGeneratorContest(this);
         }
         else if(gameRequest.isBloonBeacon)
         {
            this.roundGenerator = new RoundGeneratorBloonBeacon(this);
         }
         else if(gameRequest.bossAttack !== null)
         {
            this.roundGenerator = new RoundGeneratorBoss(this,gameRequest.bossAttack);
         }
         else
         {
            this.roundGenerator = new RoundGenerator(this);
            BloonSpawnTestModule.setRoundGenerator(this.roundGenerator);
         }
         this.roundGenerator.generate(gameRequest);
         this.helpFromFriends = new HelpFromFriends(gameRequest);
         Level.camoDisabled = false;
         Level.initialisedSignal.dispatch();
      }
      
      protected function addLevelVisuals(param1:Class, param2:ApplicationDomain) : void
      {
         var _loc4_:int = 0;
         var _loc5_:DisplayObject = null;
         var _loc6_:String = null;
         var _loc7_:MapElement = null;
         var _loc8_:int = 0;
         var _loc9_:String = null;
         var _loc3_:MovieClip = new param1();
         if(_loc3_.bottom)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc3_.bottom.numChildren)
            {
               _loc5_ = _loc3_.bottom.getChildAt(_loc4_);
               _loc6_ = getQualifiedClassName(_loc5_);
               if(!(_loc6_ == "flash.display::Shape" || _loc6_ == "flash.display::MovieClip"))
               {
                  _loc7_ = new MapElement(_loc5_.name);
                  if(_loc5_.name.indexOf("layer") != -1 || _loc5_.name.indexOf("Layer") != -1)
                  {
                     _loc8_ = int(_loc5_.name.slice(5));
                     _loc8_ = -_loc8_;
                     _loc7_.initialise(param2.getDefinition(_loc6_) as Class,_loc8_,0);
                  }
                  else
                  {
                     _loc7_.initialise(param2.getDefinition(_loc6_) as Class,-999 + _loc4_ * 0.001,0);
                  }
                  _loc7_.rotation = _loc5_.rotation / 180 * Math.PI;
                  _loc7_.x = _loc5_.x;
                  _loc7_.y = _loc5_.y;
                  if(_loc5_ is LevelAnimation)
                  {
                     this.initLevelAnimation(LevelAnimation(_loc5_),_loc7_);
                  }
                  addEntity(_loc7_);
                  this.disposableFrameClasses.push(Class(getDefinitionByName(_loc6_)));
               }
               _loc4_++;
            }
         }
         if(_loc3_.top)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc3_.top.numChildren)
            {
               _loc5_ = _loc3_.top.getChildAt(_loc4_);
               _loc9_ = getQualifiedClassName(_loc5_);
               if(!(_loc9_ == "flash.display::Shape" || _loc9_ == "flash.display::MovieClip"))
               {
                  _loc7_ = new MapElement(_loc5_.name);
                  _loc7_.initialise(getDefinitionByName(_loc9_) as Class,999 + _loc4_ * 0.001,0);
                  _loc7_.x = _loc5_.x;
                  _loc7_.y = _loc5_.y;
                  _loc7_.rotation = _loc5_.rotation / 180 * Math.PI;
                  if(_loc5_ is LevelAnimation)
                  {
                     this.initLevelAnimation(LevelAnimation(_loc5_),_loc7_);
                  }
                  addEntity(_loc7_);
                  this.disposableFrameClasses.push(Class(getDefinitionByName(_loc9_)));
               }
               _loc4_++;
            }
         }
         if(_loc3_.entryPoint)
         {
            this._bossEntryPointX = _loc3_.entryPoint.x;
            this._bossEntryPointY = _loc3_.entryPoint.y;
         }
      }
      
      private function initLevelAnimation(param1:LevelAnimation, param2:MapElement) : void
      {
         if(param1.startOnRandomFrame)
         {
            param2.clip.gotoAndPlay(param2.clip.frameCount * Math.random());
         }
         param2.clip.usePauseFrame = param1.usePauseFrame;
         param2.clip.pauseFrame = param1.pauseFrame;
         param2.clip.pauseTimeMin = param1.pauseTimeMin;
         param2.clip.pauseTimeMax = param1.pauseTimeMax;
         param2.clip.useFramerateModifier = param1.useFramerateModifier;
         if(param1.useFramerateModifier)
         {
            param2.clip.framerateModifier = Math.random() * (param1.framerateModifierMax - param1.framerateModifierMin) + param1.framerateModifierMin;
         }
      }
      
      override public function clear() : void
      {
         var _loc2_:Class = null;
         var _loc3_:Tower = null;
         var _loc4_:Projectile = null;
         var _loc1_:int = this.allTowers.length - 1;
         while(_loc1_ >= 0)
         {
            _loc3_ = this.allTowers[_loc1_];
            _loc3_.destroy();
            _loc1_--;
         }
         this.removeAllBloons();
         this.collisionGrid.clear();
         _loc1_ = this.allProjectiles.length - 1;
         while(_loc1_ >= 0)
         {
            _loc4_ = this.allProjectiles[_loc1_];
            _loc4_.destroy();
            _loc1_--;
         }
         this.terrainSet = null;
         this.startTile = null;
         this.mainPath = null;
         this._roundInProgress = false;
         this.allTowers.splice(0,this.allTowers.length);
         this.bloons.splice(0,this.bloons.length);
         this.allProjectiles.splice(0,this.allProjectiles.length);
         for each(_loc2_ in this.disposableFrameClasses)
         {
            Main.instance.frameFactory.destroyFrames(_loc2_);
         }
         if(this.roundGenerator != null)
         {
            this.roundGenerator.clear();
         }
         this.roundGenerator = null;
         super.clear();
      }
      
      public function clearTowers() : void
      {
         var _loc2_:Tower = null;
         var _loc1_:int = this.allTowers.length - 1;
         while(_loc1_ >= 0)
         {
            _loc2_ = this.allTowers[_loc1_];
            this.removeTower(_loc2_);
            _loc2_.destroy();
            _loc1_--;
         }
         this.allTowers.splice(0,this.allTowers.length);
      }
      
      public function clearProjectiles() : void
      {
      }
      
      override public function process(param1:Number) : void
      {
         var _loc2_:Bloon = null;
         var _loc3_:Number = NaN;
         Bloon.burstsThisProcess = 0;
         Main.gooch.start("roundGenerator_process");
         if(this.roundInProgress)
         {
            this.roundGenerator.process(param1);
         }
         Main.gooch.end();
         Main.gooch.start("collisionGrid_process");
         this.collisionGrid.process(param1);
         Main.gooch.end();
         Main.gooch.start("bloons_process");
         for each(_loc2_ in this.bloons)
         {
            _loc2_.process(param1);
         }
         Main.gooch.end();
         Main.gooch.start("helpFromFriends_process");
         this.helpFromFriends.process(param1);
         Main.gooch.end();
         _loc3_ = getTimer();
         if(this._cashHasChanged && _loc3_ - this._timeOfLastCashChangedEvent > 100)
         {
            dispatchEvent(new LevelEvent(LevelEvent.CASH_CHANGE));
            this._timeOfLastCashChangedEvent = _loc3_;
            this._cashHasChanged = false;
         }
         super.process(param1);
      }
      
      override public function draw(param1:BitmapData) : void
      {
         super.draw(param1);
      }
      
      public function startRound(param1:int) : void
      {
         if(!this._roundInProgress)
         {
         }
         this._roundInProgress = true;
         Bloon.counter = 0;
         this.roundGenerator.startRound(param1);
      }
      
      public function endRound() : void
      {
         this._roundInProgress = false;
      }
      
      public function isRoundInProgress() : Boolean
      {
         return this.roundInProgress;
      }
      
      public function hasBloonToGo() : Boolean
      {
         return this.roundGenerator.hasBloonsToGo();
      }
      
      public function levelIsComplete() : Boolean
      {
         return !this.hasBloonsInPlay() && this.roundGenerator.roundsAreComplete();
      }
      
      public function hasBloonsInPlay() : Boolean
      {
         return this.bloons.length > 0;
      }
      
      public function addBloon(param1:Bloon) : void
      {
         param1.scene = this;
         addDrawable(param1);
         this.bloons.push(param1);
         this.collisionGrid.addToCell(param1,param1.collisionCellIndex);
         dispatchEvent(new BloonEvent(BloonEvent.ADD,param1));
      }
      
      public function removeBloon(param1:Bloon) : void
      {
         var _loc2_:int = this.bloons.indexOf(param1);
         if(_loc2_ != -1)
         {
            this.bloons.splice(_loc2_,1);
            this.collisionGrid.removeFromCell(param1,param1.collisionCellIndex);
            cull(param1);
            this.sigBloonRemoved.dispatch(param1);
            param1.tile = null;
            Bloon.eventDispatcher.dispatchEvent(new BloonEvent(BloonEvent.REMOVE,param1));
            Pool.release(param1);
         }
      }
      
      public function removeAllBloons() : void
      {
         var _loc2_:Bloon = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.bloons.length)
         {
            _loc2_ = this.bloons[_loc1_];
            this.collisionGrid.removeFromCell(_loc2_,_loc2_.collisionCellIndex);
            cull(_loc2_);
            _loc2_.tile = null;
            Bloon.eventDispatcher.dispatchEvent(new BloonEvent(BloonEvent.REMOVE,_loc2_));
            Pool.release(_loc2_);
            _loc1_++;
         }
         this.bloons = new Vector.<Bloon>();
         Main.instance.game.benchmarkTracking.allBloons = this.bloons;
      }
      
      public function bloonLeaked(param1:Bloon) : void
      {
         this.decerementHealth(param1.rbe);
         dispatchEvent(new LevelEvent(LevelEvent.BLOON_LEAKED));
         this.sigBloonLeaked.dispatch(param1);
         this.game.didPlayerLostALife = true;
      }
      
      public function createTower(param1:String, param2:TowerDef, param3:Number, param4:Number, param5:Number) : Tower
      {
         var _loc7_:Vector.<AreaEffectDef> = null;
         var _loc8_:AreaEffectDef = null;
         var _loc6_:Tower = new Tower();
         _loc6_.id = param1;
         _loc6_.x = param3;
         _loc6_.y = param4;
         if(this.isPlaceableTower(param2))
         {
            this.placeSound.play();
            if(param2.areaEffects == null)
            {
               _loc7_ = this.getAreaEffects(param3,param4,_loc6_);
               if(_loc7_ != null)
               {
                  for each(_loc8_ in _loc7_)
                  {
                     if(_loc8_.upgrade != null)
                     {
                        _loc6_.addUpgrade(_loc8_.upgrade,false);
                     }
                  }
               }
            }
         }
         _loc6_.rootID = param2.id;
         _loc6_.baseDef = param2;
         _loc6_.initialise(param2,this);
         _loc6_.rotation = param5;
         this.sigTowerCreated.dispatch(new BuildTowerInfo(_loc6_.id,param2.id,param3,param4,param5));
         this.addTower(_loc6_);
         return _loc6_;
      }
      
      private function isPlaceableTower(param1:TowerDef) : Boolean
      {
         return param1.id != "RoadSpikes" && param1.id != "ExplodingPineapple" && param1.id != "CuddlyBear" && param1.id != "AntiCamoDust" && param1.id != "SandStormWind" && param1.id != "DryAsABoneRainStorm" && param1.id != "Crystal" && param1.id != "Whirpool" && param1.id != "StickySapFlower" && param1.id != "RedHotSpikes";
      }
      
      public function sellTower(param1:Tower) : void
      {
         Level.towerSoldSignal.dispatch(param1);
         this.removeTower(param1);
         param1.destroy();
         this.sellSound.play();
      }
      
      public function addTower(param1:Tower) : void
      {
         if(param1.rootID != TowerFactory.TOWER_ROADSPIKE && param1.rootID != TowerFactory.TOWER_PINEAPPLE && param1.rootID != Constants.TOWER_REDHOTSPIKES)
         {
            addEntity(param1);
            this.allTowers.push(param1);
            this.terrainSet.addTower(param1,this.allTowers);
            this.collisionGrid.registerTower(param1);
            this.dispatchEvent(new TowerChangedEvent("TOWER_ADDED",param1));
         }
      }
      
      public function removeTower(param1:Tower) : void
      {
         var _loc2_:int = this.allTowers.indexOf(param1);
         if(_loc2_ != -1)
         {
            this.allTowers.splice(_loc2_,1);
            cull(param1);
            if(this.allTowers.indexOf(param1) !== -1)
            {
            }
            if(param1.def != null && param1.rootID != TowerFactory.TOWER_ROADSPIKE && param1.rootID != TowerFactory.TOWER_PINEAPPLE && param1.rootID != Constants.TOWER_REDHOTSPIKES && param1.rootID != Constants.TOWER_CUDDLY_BEAR && param1.rootID != Constants.TOWER_ANTI_CAMO_DUST)
            {
               this.terrainSet.removeTower(param1,this.allTowers);
               this.collisionGrid.deregisterTower(param1);
            }
            this.dispatchEvent(new TowerChangedEvent("TOWER_REMOVED",param1));
         }
      }
      
      public function removeTowersOfType(param1:String) : void
      {
         var _loc2_:Vector.<Tower> = new Vector.<Tower>();
         var _loc3_:int = 0;
         while(_loc3_ < this.allTowers.length)
         {
            if(this.allTowers[_loc3_].id == param1)
            {
               _loc2_.push(this.allTowers[_loc3_]);
            }
            _loc3_++;
         }
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            this.removeTower(_loc2_[_loc4_]);
            _loc4_++;
         }
      }
      
      public function upgradeTowerPath(param1:Tower, param2:int) : void
      {
         param1.upgradePath(param2);
         this.performUpgradedTowerChecks(param1);
         this.sigTowerPathUpgraded.dispatch(param1.id,param2);
      }
      
      public function performUpgradedTowerChecks(param1:Tower) : void
      {
         if(param1 == null || param1.def == null)
         {
            return;
         }
         if(param1.rootID != TowerFactory.TOWER_ROADSPIKE && param1.rootID != TowerFactory.TOWER_PINEAPPLE)
         {
            this.collisionGrid.deregisterTower(param1);
            this.collisionGrid.registerTower(param1);
         }
         if(param1.def.id == TowerFactory.TOWER_SUPER_TEMPLE)
         {
            this.terrainSet.updateTowerMap(this.allTowers);
         }
      }
      
      public function addProjectile(param1:Projectile) : void
      {
         addEntity(param1);
         this.allProjectiles.push(param1);
         Main.instance.game.benchmarkTracking.onProjectileAdded();
      }
      
      public function removeProjectile(param1:Projectile) : void
      {
         var _loc2_:int = this.allProjectiles.indexOf(param1);
         if(_loc2_ != -1)
         {
            this.allProjectiles.splice(_loc2_,1);
            cull(param1);
         }
      }
      
      public function removeProjectilesOfType(param1:String) : void
      {
         var _loc2_:Vector.<Projectile> = new Vector.<Projectile>();
         var _loc3_:int = 0;
         while(_loc3_ < this.allProjectiles.length)
         {
            if(this.allProjectiles[_loc3_].owner.rootID == param1)
            {
               _loc2_.push(this.allProjectiles[_loc3_]);
            }
            _loc3_++;
         }
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            this.removeProjectile(_loc2_[_loc4_]);
            _loc4_++;
         }
      }
      
      public function isPlaceable(param1:MovieClip, param2:Boolean = false, param3:Boolean = false, param4:Boolean = false) : Boolean
      {
         if(param3)
         {
            return this.terrainSet.isOnTrack(param1);
         }
         return this.terrainSet.canPlace(param1,param2,param4);
      }
      
      public function decerementHealth(param1:int = 1) : void
      {
         var _loc2_:int = this.health.value;
         this.health.value = this.health.value - param1;
         if(this.health.value < 0)
         {
            this.health.value = 0;
         }
         var _loc3_:int = this.health.value - _loc2_;
         this.sigHealthChange.dispatch(this.health.value,_loc3_);
      }
      
      public function setHealth(param1:int) : void
      {
         if(this.health.value == param1)
         {
            return;
         }
         var _loc2_:int = this.health.value;
         this.health.value = param1;
         if(this.health.value < 0)
         {
            this.health.value = 0;
         }
         var _loc3_:int = this.health.value - _loc2_;
         this.sigHealthChange.dispatch(this.health.value,_loc3_);
      }
      
      public function setCash(param1:Number) : void
      {
         this.cash.value = param1;
         dispatchEvent(new LevelEvent(LevelEvent.CASH_CHANGE));
      }
      
      public function addCash(param1:Number) : void
      {
         this.cash.value = this.cash.value + param1;
         this._cashHasChanged = true;
      }
      
      public function removeCash(param1:Number) : void
      {
         this.cash.value = this.cash.value - param1;
         this._cashHasChanged = true;
      }
      
      public function canAfford(param1:int) : Boolean
      {
         return param1 <= this.cash.value;
      }
      
      public function calcCostMods(param1:Number, param2:Number, param3:Number, param4:Tower) : int
      {
         var _loc7_:AreaEffectDef = null;
         var _loc5_:Number = param1;
         var _loc6_:Vector.<AreaEffectDef> = this.getAreaEffects(param2,param3,param4);
         if(_loc6_ != null)
         {
            for each(_loc7_ in _loc6_)
            {
               _loc5_ = _loc5_ * _loc7_.costScale;
               if(_loc7_.costScale != 1)
               {
                  break;
               }
            }
         }
         return _loc5_;
      }
      
      public function calcTrackPoints(param1:Class) : void
      {
         var _loc5_:int = 0;
         var _loc2_:* = new param1();
         if(_loc2_["track"])
         {
         }
         var _loc3_:MovieClip = _loc2_.track;
         this.trackPoints = new Vector.<Vector2>();
         Main.instance.stage.addChild(_loc3_);
         _loc3_.visible = false;
         var _loc4_:int = this.boundries.x;
         while(_loc4_ < this.boundries.right)
         {
            _loc5_ = this.boundries.y;
            while(_loc5_ < this.boundries.bottom)
            {
               if(_loc3_.hitTestPoint(_loc4_,_loc5_,true))
               {
                  this.trackPoints.push(new Vector2(_loc4_,_loc5_));
               }
               _loc5_ = _loc5_ + 8;
            }
            _loc4_ = _loc4_ + 8;
         }
         Main.instance.stage.removeChild(_loc3_);
      }
      
      public function removeCamoFromAllActiveBloons() : void
      {
         var _loc1_:Vector.<int> = Bloon.baseImmunitiesByType;
         var _loc2_:int = Bloon.IMMUNITY_WITHOUT_NO_DETECTION;
         var _loc3_:Bloon = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         while(_loc5_ < this.bloons.length)
         {
            _loc3_ = this.bloons[_loc5_];
            if(_loc3_.isCamo != false)
            {
               _loc3_.immunity = _loc1_[_loc3_.type] & _loc2_;
               _loc3_.isCamo = false;
               _loc3_.clip.camoVisible = false;
            }
            _loc5_++;
         }
      }
      
      public function getTrackPointsInRadius(param1:Vector2, param2:Number) : Vector.<Vector2>
      {
         var _loc5_:Vector2 = null;
         var _loc3_:Vector.<Vector2> = new Vector.<Vector2>();
         var _loc4_:Number = Math.pow(param2,2);
         for each(_loc5_ in this.trackPoints)
         {
            if(Math.pow(_loc5_.x - param1.x,2) + Math.pow(_loc5_.y - param1.y,2) <= _loc4_)
            {
               _loc3_.push(_loc5_);
            }
         }
         return _loc3_;
      }
      
      public function getTowersInRange(param1:Number, param2:Number, param3:Number) : Vector.<Tower>
      {
         var _loc5_:Tower = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc4_:Vector.<Tower> = new Vector.<Tower>();
         for each(_loc5_ in this.allTowers)
         {
            _loc6_ = _loc5_.x - param1;
            _loc7_ = _loc5_.y - param2;
            _loc8_ = _loc6_ * _loc6_ + _loc7_ * _loc7_;
            if(_loc8_ <= param3 * param3)
            {
               if(_loc5_.resellable)
               {
                  _loc4_.push(_loc5_);
               }
            }
         }
         return _loc4_;
      }
      
      public function getAreaEffects(param1:Number, param2:Number, param3:Tower) : Vector.<AreaEffectDef>
      {
         var _loc5_:Tower = null;
         var _loc6_:AreaEffectDef = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc4_:Vector.<AreaEffectDef> = null;
         for each(_loc5_ in this.allTowers)
         {
            if(!(_loc5_ == param3 || _loc5_.def == null || _loc5_.def.areaEffects == null))
            {
               for each(_loc6_ in _loc5_.def.areaEffects)
               {
                  _loc7_ = _loc5_.x - param1;
                  _loc8_ = _loc5_.y - param2;
                  _loc9_ = _loc7_ * _loc7_ + _loc8_ * _loc8_;
                  if(_loc9_ <= _loc5_.def.rangeOfVisibility * _loc5_.def.rangeOfVisibility)
                  {
                     if(_loc4_ == null)
                     {
                        _loc4_ = new Vector.<AreaEffectDef>();
                     }
                     _loc4_.push(_loc6_);
                  }
               }
            }
         }
         return _loc4_;
      }
      
      public function getStrongestClosestBloon(param1:Vector2, param2:Boolean = false, param3:Boolean = false) : Bloon
      {
         var _loc7_:Bloon = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc4_:int = -1;
         var _loc5_:Number = Number.MAX_VALUE;
         var _loc6_:Bloon = null;
         for each(_loc7_ in this.bloons)
         {
            if(!(_loc7_.type < _loc4_ || param2 && _loc7_.type == Bloon.BOSS || param3 && _loc7_.isBoss))
            {
               _loc8_ = param1.x - _loc7_.x;
               _loc9_ = param1.y - _loc7_.y;
               _loc10_ = _loc8_ * _loc8_ + _loc9_ * _loc9_;
               if(_loc10_ < _loc5_ || _loc7_.type > _loc4_)
               {
                  _loc6_ = _loc7_;
                  _loc4_ = _loc7_.type;
                  _loc5_ = _loc10_;
               }
            }
         }
         return _loc6_;
      }
      
      public function getBloonsInRange(param1:Number, param2:Number, param3:Number) : Vector.<Bloon>
      {
         var _loc5_:Bloon = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc4_:Vector.<Bloon> = new Vector.<Bloon>();
         for each(_loc5_ in this.bloons)
         {
            if(!_loc5_.isInTunnel)
            {
               _loc6_ = _loc5_.x - param1;
               _loc7_ = _loc5_.y - param2;
               _loc8_ = _loc6_ * _loc6_ + _loc7_ * _loc7_;
               if(_loc8_ <= param3 * param3)
               {
                  _loc4_.push(_loc5_);
               }
            }
         }
         return _loc4_;
      }
      
      public function getBloonsInLastSeconds(param1:int) : Vector.<Bloon>
      {
         var _loc5_:Bloon = null;
         var _loc2_:Vector.<Bloon> = new Vector.<Bloon>();
         var _loc3_:Number = this.roundGenerator.currentRound != null?Number(this.roundGenerator.currentRound.currentTimeStamp):Number(-1);
         var _loc4_:Number = _loc3_ != -1?Number(_loc3_ - param1):Number(-1);
         if(_loc4_ != -1)
         {
            for each(_loc5_ in this.bloons)
            {
               if(_loc5_.timeStamp > _loc4_)
               {
                  _loc2_.push(_loc5_);
               }
            }
         }
         return _loc2_;
      }
      
      public function getTowerFromID(param1:String) : Tower
      {
         var _loc3_:Tower = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.allTowers.length)
         {
            _loc3_ = this.allTowers[_loc2_];
            if(_loc3_.def.id == param1)
            {
               return _loc3_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function getAllPlaceableTowersInLevel() : Vector.<Tower>
      {
         var _loc3_:Tower = null;
         var _loc1_:Vector.<Tower> = new Vector.<Tower>();
         var _loc2_:int = 0;
         while(_loc2_ < this.allTowers.length)
         {
            _loc3_ = this.allTowers[_loc2_];
            if(_loc3_.def != null && _loc3_.rootID != TowerFactory.TOWER_ROADSPIKE && _loc3_.rootID != TowerFactory.TOWER_PINEAPPLE && _loc3_.rootID != Constants.TOWER_REDHOTSPIKES && _loc3_.rootID != Constants.TOWER_CUDDLY_BEAR && _loc3_.rootID != Constants.TOWER_ANTI_CAMO_DUST)
            {
               _loc1_.push(_loc3_);
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getMostExpensiveTowerInLevel() : Tower
      {
         var _loc4_:Tower = null;
         var _loc1_:Tower = null;
         var _loc2_:Vector.<Tower> = this.getAllPlaceableTowersInLevel();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_];
            if(_loc1_ == null || _loc4_.spentOn > _loc1_.spentOn)
            {
               _loc1_ = _loc4_;
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function getMostExpensiveTowersInLevel(param1:int, param2:Vector.<Tower>) : void
      {
         var _loc6_:Tower = null;
         var _loc7_:int = 0;
         var _loc8_:Tower = null;
         var _loc9_:Boolean = false;
         var _loc10_:int = 0;
         var _loc11_:Tower = null;
         var _loc3_:Vector.<Tower> = this.getAllPlaceableTowersInLevel();
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         while(_loc5_ < param1)
         {
            _loc6_ = null;
            _loc7_ = 0;
            while(_loc7_ < _loc3_.length)
            {
               _loc8_ = _loc3_[_loc7_];
               if(null == _loc6_)
               {
                  _loc6_ = _loc8_;
               }
               else if(_loc8_.spentOn >= _loc6_.spentOn && _loc8_.isProjectileIncoming == false)
               {
                  _loc9_ = false;
                  _loc10_ = 0;
                  while(_loc10_ < param2.length)
                  {
                     _loc11_ = param2[_loc10_];
                     if(_loc8_ === _loc11_)
                     {
                        _loc9_ = true;
                        break;
                     }
                     _loc10_++;
                  }
                  if(false == _loc9_)
                  {
                     _loc6_ = _loc8_;
                  }
               }
               _loc7_++;
            }
            if(_loc6_)
            {
               param2.push(_loc6_);
            }
            _loc5_++;
         }
      }
      
      public function setTowerTargetPriority(param1:Tower, param2:int) : void
      {
         param1.targetPriority = param2;
         this.sigTowerTargetPriorityChanged.dispatch(param1.id,param2);
      }
      
      public function setAceFlightPath(param1:Tower, param2:int) : void
      {
         (DeployMonkeyAce.aces[param1] as AceAircraft).switchTo(param2);
         this.sigAceFlightPathChanged.dispatch(param1.id,param2);
      }
      
      public function useAbility(param1:Tower, param2:String, param3:Button = null) : Boolean
      {
         if(param1.abilityUse(param2))
         {
            if(param2 == "OverclockPick")
            {
               return false;
            }
            this.sigTowerAbilityUsed.dispatch(param1.id,param2);
            return true;
         }
         return false;
      }
      
      public function movedTargetingReticle(param1:Tower, param2:Number, param3:Number) : void
      {
         param1.aimAtReticle(param2,param3);
         this.sigTowerTargetReticleChanged.dispatch(param1.id,param2,param3);
      }
      
      public function calculateMvBBonusCash() : Number
      {
         var _loc1_:Number = Constants.PVB_CASH_PER_ROUND_MULTIPLIER * (this.roundGenerator.roundIndex + 1);
         return _loc1_;
      }
      
      public function getMousePos() : Vector2
      {
         return this.game.getMousePosForSlug(this);
      }
      
      public function isPlayerLevel() : Boolean
      {
         return this.game.isPlayerLevel(this);
      }
      
      public function get currentRoundDuration() : Number
      {
         return this.roundGenerator.currentRoundDuration;
      }
      
      public function get roundIndex() : int
      {
         return this.roundGenerator.roundIndex;
      }
      
      public function set roundIndex(param1:int) : void
      {
         this.roundGenerator.currentRoundIndex = param1;
      }
      
      public function get totalRounds() : int
      {
         return this.roundGenerator.totalRounds;
      }
      
      public function get roundInProgress() : Boolean
      {
         return this._roundInProgress;
      }
      
      public function get bossEntryPointX() : Number
      {
         return this._bossEntryPointX;
      }
      
      public function get bossEntryPointY() : Number
      {
         return this._bossEntryPointY;
      }
   }
}
