package ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.dreadbloon
{
   import assets.BloonariusDeath;
   import assets.EmptyEntranceEffectClip;
   import assets.sounds.BossDeath;
   import assets.sounds.DreadBloonSpawn;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.bloons.bossBloons.BossConstants;
   import ninjakiwi.monkeyTown.btdModule.events.BloonEvent;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.levels.Level;
   import ninjakiwi.monkeyTown.btdModule.specialEffects.BossDestroyedEffect;
   import ninjakiwi.monkeyTown.btdModule.specialEffects.BossEnterEffect;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.SpecialTrackBoss;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   import ninjakiwi.monkeyTown.btdModule.weapons.Surround;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BossBattleAttackDefinition;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgePathDefinition;
   
   public class SpecialTrackDreadbloon extends SpecialTrackBoss
   {
       
      
      private var DREADBLOON_SPAWN_DELAY:Number = 20;
      
      private var _shield:DreadBloonShield;
      
      private var _previousBossHealth:int = 2147483647;
      
      private var _regenLevels:Array = null;
      
      private const SKULL_REGEN_LEVEL:Number = 1;
      
      private const REGEN_DELAY_MIN:Number = 25;
      
      private const REGEN_DELAY_MAX:Number = 35;
      
      private const AUTO_REGEN_SHIELD_MIN_LEVEL:int = 10;
      
      private var _timeUntilRegen:Number = 0;
      
      private var _dreadEnterEffect:DreadEnterEffect;
      
      public function SpecialTrackDreadbloon(param1:BossBattleAttackDefinition)
      {
         this._shield = new DreadBloonShield();
         _attackDef = param1;
         param1.bossType = Bloon.BOSS_DREADBLOON;
         super(param1,this.DREADBLOON_SPAWN_DELAY);
      }
      
      override protected function initEnterEffect() : void
      {
         bossEntryEffect = new BossEnterEffect(new EmptyEntranceEffectClip(),DreadBloonSpawn);
         Main.instance.effectLayer.addChild(bossEntryEffect);
         bossEntryEffect.reset();
      }
      
      override public function setSpecialTrack(param1:BTDGameRequest) : void
      {
         super.setSpecialTrack(param1);
         Level.initialisedSignal.add(this.onLevelInitialised);
         this.setCashModifier();
      }
      
      private function setCashModifier() : void
      {
         var _loc1_:int = _attackDef.bossLevel;
         if(_loc1_ < 10)
         {
            Bloon.cashChanceModifier = 1.5;
         }
         else
         {
            Bloon.cashChanceModifier = Math.max(1,(20 - _loc1_ / 2) / 10);
         }
      }
      
      private function onLevelInitialised() : void
      {
         Level.initialisedSignal.remove(this.onLevelInitialised);
         this._dreadEnterEffect = DreadEnterEffect.create();
         this._dreadEnterEffect.x = Main.instance.game.level.bossEntryPointX;
         this._dreadEnterEffect.y = Main.instance.game.level.bossEntryPointY;
      }
      
      override public function clearSpecialTrack() : void
      {
         super.clearSpecialTrack();
         Level.initialisedSignal.remove(this.onLevelInitialised);
         Bloon.cashChanceModifier = 1;
      }
      
      override protected function spawnBoss(... rest) : void
      {
         super.spawnBoss();
         this._previousBossHealth = _bossBloon.health;
         this._dreadEnterEffect.go();
         this.calculateRegenLevels();
         _bossBloon.isShielded = true;
         this._shield.setBoss(_bossBloon);
         if(attackDef.bossLevel < 10)
         {
            this._shield.maxHealth = 100 * attackDef.bossLevel;
         }
         else
         {
            this._shield.maxHealth = Math.pow(attackDef.bossLevel,2) * 10;
         }
         this._shield.reset();
         this.calculateRegenLevels();
         Main.instance.game.inGameMenu.setHealthbarShieldVisible(true);
         _bossBloon.radius = BossConstants.DREADBLOON_RADIUS;
         Bloon.eventDispatcher.addEventListener(BloonEvent.DAMAGE_SHIELD,this.onBloonDamageShield);
      }
      
      private function calculateRegenLevels() : void
      {
         this._regenLevels = [0.1,0.25,0.33,0.5];
      }
      
      private function getCurrentRegenLevel() : Number
      {
         var _loc1_:Number = Math.max(0,_bossBloon.health);
         var _loc2_:Number = Math.ceil(_loc1_ / _bossBloon.maxHealth * 4);
         var _loc3_:int = 4 - _loc2_;
         if(_loc3_ in this._regenLevels)
         {
            return this._regenLevels[_loc3_];
         }
         return this._regenLevels[this._regenLevels.length - 1];
      }
      
      override public function update(param1:Number) : void
      {
         super.update(param1);
         if(attackDef.bossLevel >= this.AUTO_REGEN_SHIELD_MIN_LEVEL && _bossBloon !== null && false === _bossIsDead && false === _bossBloon.isShielded)
         {
            this._timeUntilRegen = this._timeUntilRegen - param1;
            if(this._timeUntilRegen <= 0)
            {
               this.regenShieldBy(this.getCurrentRegenLevel(),4);
            }
         }
      }
      
      private function startRegenCountdown() : void
      {
         this._timeUntilRegen = this.REGEN_DELAY_MIN + Math.random() * (this.REGEN_DELAY_MAX - this.REGEN_DELAY_MIN);
      }
      
      private function onBloonDamageShield(param1:BloonEvent) : void
      {
         if(param1.bloon === _bossBloon)
         {
            this.damageShield(param1.tower,param1.layers);
         }
      }
      
      override protected function onBloonDamage(param1:BloonEvent) : void
      {
         super.onBloonDamage(param1);
         if(param1.bloon !== _bossBloon)
         {
            return;
         }
         var _loc2_:Number = Math.max(0,_bossBloon.health);
         var _loc3_:Number = Math.ceil(_loc2_ / _bossBloon.maxHealth * 4);
         var _loc4_:Number = Math.ceil(this._previousBossHealth / _bossBloon.maxHealth * 4);
         if(_loc3_ != _loc4_ && _loc3_ !== 0 && _loc3_ !== 4)
         {
            this.regenShieldTo(this.SKULL_REGEN_LEVEL,4);
            explodeSkullRange(_loc3_ - 1,_loc4_ - 1);
         }
         this._previousBossHealth = _loc2_;
      }
      
      private function damageShield(param1:Tower, param2:int) : void
      {
         this._shield.damage(param2,param1);
         if(attackDef.bossLevel >= this.AUTO_REGEN_SHIELD_MIN_LEVEL && this._shield.health <= 0)
         {
            this.startRegenCountdown();
         }
      }
      
      private function regenShieldTo(param1:Number = 1.0, param2:Number = 4) : void
      {
         if(false === _bossIsDead)
         {
            this._shield.regenerateTo(param1,param2);
         }
      }
      
      private function regenShieldBy(param1:Number = 1.0, param2:Number = 4) : void
      {
         if(false === _bossIsDead)
         {
            this._shield.regenerateBy(param1,param2);
         }
      }
      
      override protected function onBossDestroyed(param1:BloonEvent) : void
      {
         super.onBossDestroyed(param1);
         this._shield.cancelRegen();
      }
      
      override protected function initDestroyedEffect() : void
      {
         bossDestroyedEffect = new BossDestroyedEffect(new BloonariusDeath(),BossDeath);
         Main.instance.effectLayer.addChild(bossDestroyedEffect);
         bossDestroyedEffect.reset();
      }
   }
}
