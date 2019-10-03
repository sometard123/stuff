package ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.blastopopoulos
{
   import assets.bloons.BlastapopoulosEntranceAnimationClip;
   import assets.sounds.VortexSpawn;
   import flash.utils.setTimeout;
   import ninjakiwi.monkeyTown.btdModule.abilities.animations.VortexSmokeParticle;
   import ninjakiwi.monkeyTown.btdModule.abilities.antiTowerAbilities.BlastapopoulosAntiTowerAbility;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.bloons.bossBloons.BossConstants;
   import ninjakiwi.monkeyTown.btdModule.events.BloonEvent;
   import ninjakiwi.monkeyTown.btdModule.specialEffects.BossEnterEffect;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.SpecialTrackBoss;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BossBattleAttackDefinition;
   
   public class SpecialTrackBlastopopoulos extends SpecialTrackBoss
   {
       
      
      private var BLASTOPOPOULUS_SPAWN_DELAY:Number = 20;
      
      private var _blastPulse:BlastapopoulosAntiTowerAbility;
      
      private var _previousBossHealth:int = 2147483647;
      
      public function SpecialTrackBlastopopoulos(param1:BossBattleAttackDefinition)
      {
         param1.bossType = Bloon.BOSS_BLASTAPOPOULOS;
         super(param1,this.BLASTOPOPOULUS_SPAWN_DELAY);
         cashAwardModifier = 1.5;
         this._blastPulse = new BlastapopoulosAntiTowerAbility();
      }
      
      override public function setSpecialTrack(param1:BTDGameRequest) : void
      {
         super.setSpecialTrack(param1);
         this._previousBossHealth = _attackDef.bossHitPoints;
      }
      
      override public function clearSpecialTrack() : void
      {
         this._blastPulse.clean();
         super.clearSpecialTrack();
      }
      
      override protected function spawnBoss(... rest) : void
      {
         var arg:Array = rest;
         var superSpawnBoss:Function = super.spawnBoss;
         setTimeout(function():void
         {
            superSpawnBoss();
            _bossBloon.tile = _bossEntryTile;
            _bossBloon.radius = BossConstants.BLASTAPOPOULOS_RADIUS;
            _bossBloon.rotation = -Math.PI * 2;
            _blastPulse.initialise(_bossBloon,_attackDef.bossLevel);
         },1000);
      }
      
      override protected function initEnterEffect() : void
      {
         bossEntryEffect = new BossEnterEffect(new BlastapopoulosEntranceAnimationClip(),VortexSpawn);
         Main.instance.effectLayer.addChild(bossEntryEffect);
         bossEntryEffect.reset();
      }
      
      override public function update(param1:Number) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:VortexSmokeParticle = null;
         if(this._blastPulse !== null)
         {
            this._blastPulse.update(param1);
         }
         if(_bossBloon !== null && Math.random() < 0.45)
         {
            _loc2_ = false;
            if(_bossBloon.health / _bossBloon.maxHealth < 0.25)
            {
               _loc2_ = true;
            }
            _loc3_ = new VortexSmokeParticle(_loc2_);
            _loc3_.x = _bossBloon.x - _bossBloon.movementDirection.x * 95 + (Math.random() - 0.5) * 70;
            _loc3_.y = _bossBloon.y - _bossBloon.movementDirection.y * 107 + (Math.random() - 0.5) * 70;
            _loc3_.velocity.x = -_bossBloon.movementDirection.x * (1 + Math.random() * 0.1) * 0.5;
            _loc3_.velocity.y = -_bossBloon.movementDirection.y * (1 + Math.random() * 0.1) * 0.5;
            _loc3_.clip.framerateModifier = 0.3;
            _loc3_.clip.useFramerateModifier = true;
         }
      }
      
      override protected function onBloonDamage(param1:BloonEvent) : void
      {
         super.onBloonDamage(param1);
         if(_bossBloon === null || param1.bloon !== _bossBloon)
         {
            return;
         }
         var _loc2_:Number = Math.max(0,_bossBloon.health);
         var _loc3_:Number = Math.ceil(_loc2_ / _bossBloon.maxHealth * 4);
         var _loc4_:Number = Math.ceil(this._previousBossHealth / _bossBloon.maxHealth * 4);
         if(_loc3_ != _loc4_ && _loc3_ !== 0)
         {
            explodeSkullRange(_loc3_ - 1,_loc4_ - 1);
         }
         this._previousBossHealth = _loc2_;
      }
   }
}
