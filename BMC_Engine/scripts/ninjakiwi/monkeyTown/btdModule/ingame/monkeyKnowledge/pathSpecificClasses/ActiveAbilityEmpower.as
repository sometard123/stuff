package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.pathSpecificClasses
{
   import assests.effects.UpEffect;
   import ninjakiwi.monkeyTown.btdModule.analytics.GameInfoTracking;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.BuffManager;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.AbilityCooldownsScale;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.AbilityEmpowerAttackCooldown;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.AbilityEmpowerPierceDuration;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.HealthCashChance;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.HealthCashStunChance;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.HealthChance;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.StunEffectDef;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.modifiers.AttackSpeedTemporaryModifierBuff;
   import ninjakiwi.monkeyTown.btdModule.utils.GameInRoundTimer;
   import ninjakiwi.monkeyTown.btdModule.utils.GameSpeedTimer;
   import ninjakiwi.monkeyTown.btdModule.utils.Rndm;
   
   public class ActiveAbilityEmpower
   {
      
      public static const instance:ActiveAbilityEmpower = new ActiveAbilityEmpower();
      
      private static const ACTIVE_ABILITY_ID:String = "ActiveAbility";
      
      public static const EMPOWER_ABILITY_TIER_HEALTH:int = 1;
      
      public static const EMPOWER_ABILITY_TIER_HEALTH_CASH:int = 2;
      
      public static const EMPOWER_ABILITY_TIER_HEALTH_CASH_STUN:int = 3;
      
      private static const EMPOWER_PIERCE_PIERCE_BONUS:int = 1;
      
      private static const EMPOWER_ABILITY_HEALTH_INCREASE:int = 5;
      
      private static const EMPOWER_ABILITY_CASH_INCREASE:Number = 100;
      
      private static const EMPOWER_ABILITY_STUN_DURATION:Number = 0.5;
      
      private static const EMPOWER_ABILITY_ATTACK_SPEED_DURATION:Number = 10;
      
      private static const EFFECT_X_OFFSET:Number = -3;
      
      private static const CASH_UP_EFFECT_Y_OFFSET:Number = -24;
       
      
      private var _cashUpEffect:UpEffect;
      
      private var _livesUpEffect:UpEffect;
      
      private var _empowerPierceTimer:GameInRoundTimer;
      
      private var _empowerStunEffectDef:StunEffectDef = null;
      
      private var _towersAffectedByAttackSpeedEmpower:Vector.<Tower>;
      
      public var healthCashStunTier:int = 0;
      
      public var healthCashStunChance:Number = 0;
      
      public var empowerPierceDuration:Number = 0;
      
      public var empowerAttackSpeedDuration:Number = 0;
      
      public var abilityCooldownScale:Number = 1;
      
      public var attackSpeedMultiplier:Number = 1;
      
      public function ActiveAbilityEmpower()
      {
         this._empowerPierceTimer = new GameInRoundTimer();
         this._towersAffectedByAttackSpeedEmpower = new Vector.<Tower>();
         super();
         this._empowerStunEffectDef = new StunEffectDef();
         this._empowerStunEffectDef.Lifespan(EMPOWER_ABILITY_STUN_DURATION);
         this._empowerStunEffectDef.CantEffect(Vector.<int>([Bloon.MOAB,Bloon.BFB,Bloon.BOSS,Bloon.DDT]));
      }
      
      public function reset() : void
      {
         this.healthCashStunTier = 0;
         this.healthCashStunChance = 0;
         this.empowerPierceDuration = 0;
         this.empowerAttackSpeedDuration = 0;
         this.abilityCooldownScale = 1;
         this.attackSpeedMultiplier = 1;
         this.onEmpowerPierceEnded();
         this.cleanUpCashUpEffect();
         this.cleanUpLivesUpEffect();
         Main.instance.game.level.sigTowerAbilityUsed.remove(this.onTowerAbilityUsed);
      }
      
      public function activateBuffs() : void
      {
         this.reset();
         BuffManager.instance.activateBuffsOfMethodInPath(AbilityCooldownsScale,ACTIVE_ABILITY_ID);
         BuffManager.instance.activateBuffsOfMethodInPath(HealthChance,ACTIVE_ABILITY_ID);
         BuffManager.instance.activateBuffsOfMethodInPath(HealthCashChance,ACTIVE_ABILITY_ID);
         BuffManager.instance.activateBuffsOfMethodInPath(HealthCashStunChance,ACTIVE_ABILITY_ID);
         BuffManager.instance.activateBuffsOfMethodInPath(AbilityEmpowerPierceDuration,ACTIVE_ABILITY_ID);
         BuffManager.instance.activateBuffsOfMethodInPath(AbilityEmpowerAttackCooldown,ACTIVE_ABILITY_ID);
         Main.instance.game.level.sigTowerAbilityUsed.add(this.onTowerAbilityUsed);
      }
      
      private function onTowerAbilityUsed(param1:String, param2:String) : void
      {
         this.empowerPierce();
         this.rollForHealthCashStun();
         this.empowerAttackSpeed();
      }
      
      public function empowerPierce() : void
      {
         if(this.empowerPierceDuration == 0)
         {
            return;
         }
         this.onEmpowerPierceEnded();
         this._empowerPierceTimer = new GameInRoundTimer(this.empowerPierceDuration);
         this._empowerPierceTimer.start();
         this._empowerPierceTimer.addEventListener(GameSpeedTimer.COMPLETE,this.onEmpowerPierceEnded);
      }
      
      private function onEmpowerPierceEnded(... rest) : void
      {
         if(this._empowerPierceTimer)
         {
            this._empowerPierceTimer.removeEventListener(GameSpeedTimer.COMPLETE,this.onEmpowerPierceEnded);
            this._empowerPierceTimer.stop();
            this._empowerPierceTimer = null;
         }
      }
      
      public function getEmpoweredPierceBonus() : int
      {
         if(this._empowerPierceTimer && this._empowerPierceTimer.running)
         {
            return EMPOWER_PIERCE_PIERCE_BONUS;
         }
         return 0;
      }
      
      public function rollForHealthCashStun() : Boolean
      {
         if(this.healthCashStunChance <= 0 || this.healthCashStunTier <= 0)
         {
            return false;
         }
         var _loc1_:Number = Rndm.float(0,1);
         if(_loc1_ > this.healthCashStunChance)
         {
            return false;
         }
         if(this.healthCashStunTier >= EMPOWER_ABILITY_TIER_HEALTH)
         {
            this.empowerHealth();
         }
         if(this.healthCashStunTier >= EMPOWER_ABILITY_TIER_HEALTH_CASH)
         {
            this.empowerCash();
         }
         if(this.healthCashStunTier >= EMPOWER_ABILITY_TIER_HEALTH_CASH_STUN)
         {
            this.empowerStun();
         }
         return true;
      }
      
      private function empowerHealth() : void
      {
         Main.instance.game.level.setHealth(Main.instance.game.level.health.value + EMPOWER_ABILITY_HEALTH_INCREASE);
         this.generateLivesUpEffect();
      }
      
      private function empowerCash() : void
      {
         Main.instance.game.level.addCash(EMPOWER_ABILITY_CASH_INCREASE);
         Main.instance.game.gameInfoTracking.cashEarned(EMPOWER_ABILITY_CASH_INCREASE,GameInfoTracking.CASH_TYPE_ABILITY_EMPOWER);
         this.generateCashUpEffect();
      }
      
      public function generateCashUpEffect() : void
      {
         this.cleanUpCashUpEffect();
         this._cashUpEffect = new UpEffect();
         this._cashUpEffect.x = this._cashUpEffect.x + EFFECT_X_OFFSET;
         this._cashUpEffect.y = this._cashUpEffect.y + CASH_UP_EFFECT_Y_OFFSET;
         this._cashUpEffect.gotoAndPlay(0);
         Main.instance.effectLayer.addChild(this._cashUpEffect);
      }
      
      public function cleanUpCashUpEffect() : void
      {
         if(this._cashUpEffect != null)
         {
            this._cashUpEffect.visible = false;
            this._cashUpEffect.stop();
            this._cashUpEffect = null;
         }
      }
      
      public function generateLivesUpEffect() : void
      {
         this.cleanUpLivesUpEffect();
         this._livesUpEffect = new UpEffect();
         this._livesUpEffect.x = this._livesUpEffect.x + EFFECT_X_OFFSET;
         this._livesUpEffect.gotoAndPlay(0);
         Main.instance.effectLayer.addChild(this._livesUpEffect);
      }
      
      public function cleanUpLivesUpEffect() : void
      {
         if(this._livesUpEffect != null)
         {
            this._livesUpEffect.visible = false;
            this._livesUpEffect.stop();
            this._livesUpEffect = null;
         }
      }
      
      private function empowerStun() : void
      {
         var _loc1_:Vector.<Bloon> = Main.instance.game.level.bloons;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc1_[_loc2_].applyStun(this._empowerStunEffectDef);
            _loc2_++;
         }
      }
      
      private function empowerAttackSpeed() : void
      {
         var _loc2_:Tower = null;
         if(this.attackSpeedMultiplier == 1)
         {
            return;
         }
         var _loc1_:Vector.<Tower> = Main.instance.game.level.allTowers;
         for each(_loc2_ in _loc1_)
         {
            if(!(_loc2_.def == null || _loc2_.def.areaEffects != null))
            {
               if(_loc2_.rootID != "BananaFarm")
               {
                  _loc2_.modifiers.add(new AttackSpeedTemporaryModifierBuff(_loc2_,EMPOWER_ABILITY_ATTACK_SPEED_DURATION,this.attackSpeedMultiplier));
               }
            }
         }
      }
   }
}
