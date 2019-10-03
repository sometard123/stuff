package ninjakiwi.monkeyTown.btdModule.specialTrack.tracks
{
   import assets.BloonariusDeath;
   import assets.BloonariusEntrance;
   import assets.sounds.BloonariusDeathSound;
   import assets.sounds.BloonariusEntranceSound;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.events.BloonEvent;
   import ninjakiwi.monkeyTown.btdModule.events.LevelEvent;
   import ninjakiwi.monkeyTown.btdModule.game.Game;
   import ninjakiwi.monkeyTown.btdModule.ingame.InGameMenu;
   import ninjakiwi.monkeyTown.btdModule.levels.Level;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.specialEffects.BossDestroyedEffect;
   import ninjakiwi.monkeyTown.btdModule.specialEffects.BossEnterEffect;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BossBattleAttackDefinition;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BossBattleResultDefinition;
   import org.osflash.signals.Signal;
   
   public class SpecialTrackBoss extends SpecialTrack
   {
      
      public static const onBossSpawnedSignal:Signal = new Signal(Bloon);
       
      
      private var _previousHealth:Number = 2147483647;
      
      public var cashAwardModifier:Number = 1.0;
      
      private var _bossSpawnDelay:Number;
      
      private var _timeOfBossSpawnCountdownStart:Number = -1;
      
      private var _bossWinHasBeenCalled:Boolean = false;
      
      protected var _bossResultDefinition:BossBattleResultDefinition;
      
      protected var _attackDef:BossBattleAttackDefinition;
      
      protected var _bossSpawnTimer:Timer;
      
      protected var _bossID:int = -1;
      
      protected var _bossBloon:Bloon = null;
      
      protected var _bossIsDead:Boolean = false;
      
      public var bossDestroyedEffect:BossDestroyedEffect;
      
      public var bossEntryEffect:BossEnterEffect;
      
      protected var _enterEffectClass:Class;
      
      protected var _destroyedEffectClass:Class;
      
      protected var _bossEntryTile:Tile = null;
      
      public function SpecialTrackBoss(param1:BossBattleAttackDefinition, param2:Number = 0)
      {
         this._bossSpawnTimer = new Timer(1000,0);
         this._enterEffectClass = BloonariusEntrance;
         this._destroyedEffectClass = BloonariusDeath;
         super();
         this._bossID = param1.bossType;
         this._attackDef = param1;
         this._bossSpawnDelay = param2;
         this._bossWinHasBeenCalled = false;
         Main.instance.game.level.sigBloonRemoved.addWithPriority(this.checkBossWin,1000);
         Main.instance.game.addEventListener(LevelEvent.ROUND_START,this.onRoundStart);
      }
      
      public static function spawnChild(param1:Bloon, param2:int, param3:Boolean = false, param4:Boolean = false) : void
      {
         if(param1 === null)
         {
            return;
         }
         var _loc5_:Level = Main.instance.game.level;
         var _loc6_:Bloon = new Bloon();
         _loc6_.initialise(_loc5_,param2,param1.tile,0,param4,param3,param1.timeStamp);
         _loc6_.tileProgress = param1.tileProgress;
         _loc5_.addBloon(_loc6_);
      }
      
      override public function setSpecialTrack(param1:BTDGameRequest) : void
      {
         super.setSpecialTrack(param1);
         this._bossIsDead = false;
         Bloon.eventDispatcher.addEventListener(BloonEvent.BOSS_DESTROYED,this.onBossDestroyed);
         Main.instance.game.inGameMenu.setRoundTextVisible(false);
         Main.instance.game.inGameMenu.setHealthbarVisible(false);
         Main.instance.game.inGameMenu.setAntiBossAbilitiesVisible(false);
         Main.instance.game.inGameMenu.bossHealthBar.setBossIcon(param1.bossAttack.bossID);
         this._bossResultDefinition = new BossBattleResultDefinition();
         this._bossResultDefinition.remainingHP = this._attackDef.bossHitPoints;
         Main.instance.game.inGameMenu.bossDefeatPanel.okSignal.add(this.onDefeatPanelOK);
         Main.instance.eventBridge.addEventListener("gameIsReady",this.onGameIsReady);
         Main.instance.game.addEventListener(LevelEvent.ROUND_START,this.calculateEntryPoints);
      }
      
      private function calculateEntryPoints(... rest) : void
      {
         var _loc6_:Tile = null;
         Main.instance.game.removeEventListener(LevelEvent.ROUND_START,this.calculateEntryPoints);
         var _loc2_:Vector.<Tile> = Main.instance.game.level.levelDef.mainPath;
         var _loc3_:Rectangle = Main.mapArea;
         var _loc4_:Array = [];
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc6_ = _loc2_[_loc5_];
            if((_loc6_.startX < _loc3_.left || _loc6_.startX > _loc3_.right || _loc6_.startY < _loc3_.top || _loc6_.startY > _loc3_.bottom) && _loc6_.endX > _loc3_.left && _loc6_.endX < _loc3_.right && _loc6_.endY > _loc3_.top && _loc6_.endY < _loc3_.bottom)
            {
               _loc4_.push(_loc6_);
            }
            _loc5_++;
         }
         this._bossEntryTile = _loc4_[0];
         if(_loc4_[1])
         {
            Main.instance.game.level.startTile = _loc4_[1];
         }
      }
      
      private function onGameIsReady(param1:Event) : void
      {
         Main.instance.eventBridge.removeEventListener("gameIsReady",this.onGameIsReady);
         this.initEnterEffect();
         this.initDestroyedEffect();
      }
      
      protected function initEnterEffect() : void
      {
         this.bossEntryEffect = new BossEnterEffect(new BloonariusEntrance(),BloonariusEntranceSound);
         Main.instance.effectLayer.addChild(this.bossEntryEffect);
         this.bossEntryEffect.reset();
      }
      
      protected function initDestroyedEffect() : void
      {
         this.bossDestroyedEffect = new BossDestroyedEffect(new BloonariusDeath(),BloonariusDeathSound);
         Main.instance.effectLayer.addChild(this.bossDestroyedEffect);
         this.bossDestroyedEffect.reset();
      }
      
      override public function clearSpecialTrack() : void
      {
         Main.instance.game.level.sigBloonRemoved.remove(this.checkBossWin);
         Main.instance.game.removeEventListener(LevelEvent.ROUND_START,this.onRoundStart);
         Bloon.eventDispatcher.removeEventListener(BloonEvent.BOSS_DESTROYED,this.onBossDestroyed);
         Bloon.eventDispatcher.removeEventListener(BloonEvent.DAMAGE,this.onBloonDamage);
         Main.instance.game.inGameMenu.victoryGenericPanel.okSignal.remove(this.onDefeatPanelOK);
         Main.instance.eventBridge.removeEventListener("gameIsReady",this.onGameIsReady);
         BossEnterEffect.BOSS_ENTER_ANIMATION_QUEUE.remove(this.spawnBoss);
         BossDestroyedEffect.DESTROY_EFFECT_FINISHED.remove(this.onBossDestroyEffectFinished);
         Main.instance.game.removeEventListener(LevelEvent.ROUND_START,this.calculateEntryPoints);
         Main.instance.game.inGameMenu.bossDefeatPanel.okSignal.remove(this.onDefeatPanelOK);
         BossEnterEffect.BOSS_ENTER_ANIMATION_QUEUE.remove(this.spawnBoss);
         this._bossSpawnTimer.removeEventListener(TimerEvent.TIMER,this.bossSpawnCheck);
         this._bossSpawnTimer.stop();
         this._bossSpawnTimer.reset();
         if(this.bossEntryEffect !== null)
         {
            this.bossEntryEffect.clean();
         }
         if(this.bossDestroyedEffect !== null)
         {
            this.bossDestroyedEffect.clean();
         }
         this._bossResultDefinition = null;
         this._attackDef = null;
         this._bossSpawnTimer = null;
      }
      
      private function onDefeatPanelOK() : void
      {
         Main.instance.cancelGame(false,false);
      }
      
      protected function checkBossWin(param1:Bloon) : void
      {
         if(this._bossID == -1)
         {
            return;
         }
         if(param1 === this._bossBloon && this._bossBloon.health > 0)
         {
            Main.instance.game.level.sigBloonRemoved.remove(this.checkBossWin);
            this.onBossWin();
         }
      }
      
      public function onBossWin(... rest) : void
      {
         Main.instance.game.level.sigBloonRemoved.remove(this.checkBossWin);
         Bloon.eventDispatcher.removeEventListener(BloonEvent.DAMAGE,this.onBloonDamage);
         if(this._bossWinHasBeenCalled)
         {
            return;
         }
         this._bossWinHasBeenCalled = true;
         Main.instance.game.inGameMenu.bossDefeatPanel.reveal();
      }
      
      protected function onBossDestroyed(param1:BloonEvent) : void
      {
         this._bossIsDead = true;
         BossDestroyedEffect.DESTROY_EFFECT_FINISHED.addOnce(this.onBossDestroyEffectFinished);
      }
      
      private function onBossDestroyEffectFinished(... rest) : void
      {
         var _loc2_:Game = Main.instance.game;
         _loc2_.inGameMenu.endGame();
         _loc2_.inGameMenu.enableInGameMenu(false);
         Main.instance.game.endGame(false);
      }
      
      protected function onRoundStart(param1:LevelEvent) : void
      {
         Main.instance.game.removeEventListener(LevelEvent.ROUND_START,this.onRoundStart);
         this.startCountdownToBossSpawn();
      }
      
      protected function startCountdownToBossSpawn() : void
      {
         this._timeOfBossSpawnCountdownStart = Main.instance.game.getGameTime();
         this._bossSpawnTimer.addEventListener(TimerEvent.TIMER,this.bossSpawnCheck);
         this._bossSpawnTimer.reset();
         this._bossSpawnTimer.start();
      }
      
      protected function bossSpawnCheck(param1:TimerEvent) : void
      {
         var _loc2_:Number = Main.instance.game.getGameTime();
         if(_loc2_ - this._timeOfBossSpawnCountdownStart > this._bossSpawnDelay)
         {
            this._bossSpawnTimer.stop();
            this._bossSpawnTimer.reset();
            BossEnterEffect.BOSS_ENTER_ANIMATION_QUEUE.remove(this.spawnBoss);
            BossEnterEffect.BOSS_ENTER_ANIMATION_QUEUE.add(this.spawnBoss);
            if(this.bossEntryEffect !== null)
            {
               this.bossEntryEffect.startEffect(Main.instance.game.level.bossEntryPointX,Main.instance.game.level.bossEntryPointY);
            }
         }
      }
      
      protected function spawnBoss(... rest) : void
      {
         var _loc2_:Level = Main.instance.game.level;
         BossEnterEffect.BOSS_ENTER_ANIMATION_QUEUE.remove(this.spawnBoss);
         this._bossBloon = new Bloon();
         this._bossBloon.initialise(_loc2_,this._bossID,_loc2_.startTile,0,false,false,0);
         if(this._attackDef.bossLevel < 0)
         {
            this._attackDef.bossLevel = 1;
         }
         this._bossBloon.health = this._attackDef.bossHitPoints;
         this._bossBloon.maxHealth = this._attackDef.bossMaxHitPoints;
         if(this._bossBloon.health < 0)
         {
            this._bossBloon.health = 0;
         }
         Main.instance.game.inGameMenu.setHealthbarVisible(true);
         Main.instance.game.inGameMenu.setAntiBossAbilitiesVisible(true);
         this.syncUI();
         InGameMenu.instance.bossHealthBar.resetSkulls();
         this._bossBloon.radius = 100;
         _loc2_.addBloon(this._bossBloon);
         Bloon.eventDispatcher.addEventListener(BloonEvent.DAMAGE,this.onBloonDamage);
         onBossSpawnedSignal.dispatch(this._bossBloon);
      }
      
      protected function onBloonDamage(param1:BloonEvent) : void
      {
         if(this._bossBloon === null || param1.bloon !== this._bossBloon)
         {
            return;
         }
         this.syncUI();
         this._bossResultDefinition.remainingHP = this._bossBloon.health;
         if(this._bossResultDefinition.remainingHP < 0)
         {
            this._bossResultDefinition.remainingHP = 0;
         }
         if(this._bossResultDefinition.remainingHP > this._previousHealth)
         {
         }
         this._previousHealth = this._bossResultDefinition.remainingHP;
         var _loc2_:int = param1.layers * this.cashAwardModifier;
         Main.instance.game.level.addCash(_loc2_);
      }
      
      protected function syncUI() : void
      {
         Main.instance.game.inGameMenu.setHealthBarProgress(this._bossBloon.health / this._bossBloon.maxHealth);
         Main.instance.game.inGameMenu.setBossLevel(this._attackDef.bossLevel);
      }
      
      public function getBossBattleResult() : BossBattleResultDefinition
      {
         if(this._bossResultDefinition.remainingHP == 0 || this._bossResultDefinition.remainingHP == 1)
         {
         }
         return this._bossResultDefinition;
      }
      
      public function explodeSkullRange(param1:int, param2:int) : void
      {
         var _loc3_:int = param1;
         while(_loc3_ <= param2)
         {
            InGameMenu.instance.bossHealthBar.explodeSkull(_loc3_);
            _loc3_++;
         }
      }
      
      public function explodeSkull(param1:int) : void
      {
         InGameMenu.instance.bossHealthBar.explodeSkull(param1);
      }
      
      public function get bossBloon() : Bloon
      {
         return this._bossBloon;
      }
      
      public function get attackDef() : BossBattleAttackDefinition
      {
         return this._attackDef;
      }
      
      public function get bossEntryTile() : Tile
      {
         return this._bossEntryTile;
      }
   }
}
