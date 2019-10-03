package ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.sandStorm
{
   import assets.PlayUI.ActivatedAbilitySandStormClip;
   import assets.PlayUI.SandStormClip;
   import assets.module.CoolDownTimerClip;
   import assets.occupiedSpace.Small;
   import assets.projectile.LargeExplosion;
   import assets.sound.Sandstorm;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import ninjakiwi.monkeyTown.btdModule.abilities.Ability;
   import ninjakiwi.monkeyTown.btdModule.abilities.ProjectileHitAll;
   import ninjakiwi.monkeyTown.btdModule.abilities.def.AbilityDef;
   import ninjakiwi.monkeyTown.btdModule.abilities.def.ProjectileHitAllDef;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.entities.Effect;
   import ninjakiwi.monkeyTown.btdModule.game.Game;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.pathSpecificClasses.ActiveAbilityEmpower;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.DamageEffectDef;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.sound.MaxSound;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.TowerPlace;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   import ninjakiwi.monkeyTown.btdModule.weapons.HasProjectile;
   import org.osflash.signals.Signal;
   
   public class SandStormWindAbility extends Ability
   {
      
      public static const speedScale:Number = 0.5;
      
      public static var onExecuteSignal:Signal = new Signal();
      
      public static var onFinishedSignal:Signal = new Signal();
      
      private static const DURATION_OF_ABILITY_SEC:Number = 20;
      
      private static const COOLDOWN:Number = 90;
      
      private static const POP_INTERVAL_SEC:Number = 0.1;
      
      private static const CHANCE_OF_POP_PER_SEC_PER_BLOON:Number = 1;
      
      private static var _checkTimer:Timer = new Timer(POP_INTERVAL_SEC / 1000,0);
      
      private static var _timeActivated:Number = 0;
      
      private static var _timeOfLastPop:Number = 0;
      
      private static var tower:Tower;
      
      private static var projectileDef:ProjectileHitAllDef = null;
      
      private static var sound:MaxSound = null;
       
      
      public function SandStormWindAbility()
      {
         super();
      }
      
      public static function reset() : void
      {
         Game.GAME_RESTART_RESET_SIGNAL.remove(reset);
         _checkTimer.removeEventListener(TimerEvent.TIMER,checkElapsedTime);
         _checkTimer.reset();
         removeAffect();
         if(sound)
         {
            sound.stop();
         }
      }
      
      public static function add() : void
      {
         var _loc3_:DamageEffectDef = null;
         var _loc4_:ProjectileDef = null;
         reset();
         if(projectileDef === null)
         {
            _loc3_ = new DamageEffectDef().Damage(1);
            _loc4_ = new ProjectileDef().Display(LargeExplosion).Pierce(10000).Radius(1000).DamageEffect(_loc3_);
            projectileDef = new ProjectileHitAllDef("ProjectileHitAllArtllery").Projectile(_loc4_).Cooldown(COOLDOWN * ActiveAbilityEmpower.instance.abilityCooldownScale).Thumb(ActivatedAbilitySandStormClip).Label("Sandstorm Wind").Description("").AbilityClass(ProjectileHitAll);
         }
         var _loc1_:AbilityDef = new AbilityDef("SandStormWind");
         _loc1_.cooldown = COOLDOWN * ActiveAbilityEmpower.instance.abilityCooldownScale;
         _loc1_.label = "Sandstorm Wind";
         _loc1_.description = "Sends a strong gust of wind that slows down the bloons.";
         _loc1_.sound = Sandstorm;
         _loc1_.thumb = ActivatedAbilitySandStormClip;
         _loc1_.ability = SandStormWindAbility;
         var _loc2_:TowerDef = new TowerDef("SandStormWind").Label("S").Description("").OccupiedSpace(Small).RangeOfVisibility(60).Detail(null).DetailSmall(SandStormClip).Abilities(Vector.<AbilityDef>([_loc1_]));
         tower = Main.instance.game.level.createTower(_loc2_.id,_loc2_,0,0,0);
         tower.resellable = false;
         tower.coolDownTimerGuage = new CoolDownTimerClip();
         TowerPlace.towerPlacedSignal.dispatch(tower);
         sound = new MaxSound(_loc1_.sound);
      }
      
      private static function get gameTime() : Number
      {
         return Main.instance.game.getGameTime();
      }
      
      public static function removeAffect() : void
      {
         Bloon.sandstormActive = false;
         Bloon.sandstormSpeedScale = 1;
         onFinishedSignal.dispatch();
         if(sound)
         {
            sound.stop();
         }
      }
      
      private static function checkElapsedTime(param1:TimerEvent) : void
      {
         var _loc2_:Number = gameTime;
         if(_loc2_ - _timeOfLastPop > POP_INTERVAL_SEC)
         {
            damageBloons();
         }
         if(_loc2_ - _timeActivated > DURATION_OF_ABILITY_SEC)
         {
            reset();
         }
      }
      
      private static function damageBloons() : void
      {
         var _loc6_:Bloon = null;
         var _loc7_:Effect = null;
         var _loc1_:Number = gameTime;
         var _loc2_:Number = _loc1_ - _timeOfLastPop;
         _timeOfLastPop = _loc1_;
         var _loc3_:Number = CHANCE_OF_POP_PER_SEC_PER_BLOON * POP_INTERVAL_SEC;
         var _loc4_:Projectile = Pool.get(Projectile);
         _loc4_.initialise(projectileDef.projectile,tower.level,tower.buffs,null);
         _loc4_.owner = tower;
         var _loc5_:Vector.<Bloon> = tower.level.bloons.concat();
         if(_loc4_.def.glueEffect != null)
         {
            _loc4_.def.glueEffect = (tower.def.weapons[0] as HasProjectile).projectile.glueEffect;
         }
         for each(_loc6_ in _loc5_)
         {
            if(Math.random() < _loc3_)
            {
               _loc6_.handleCollision(_loc4_);
            }
         }
         if(projectileDef.fullscreenEffect != null)
         {
            _loc7_ = new Effect();
            _loc7_.initialise(projectileDef.fullscreenEffect,3000);
            Main.instance.game.level.addEntity(_loc7_);
         }
      }
      
      override public function execute(param1:Tower, param2:AbilityDef) : void
      {
         Bloon.sandstormActive = true;
         Bloon.sandstormSpeedScale = speedScale;
         _timeActivated = gameTime;
         _timeOfLastPop = _timeActivated;
         damageBloons();
         _checkTimer.addEventListener(TimerEvent.TIMER,checkElapsedTime,false,0,true);
         _checkTimer.start();
         onExecuteSignal.dispatch();
         if(sound)
         {
            sound.play(1,6);
         }
         Game.GAME_EXIT_SIGNAL.remove(reset);
         Game.GAME_EXIT_SIGNAL.add(reset);
         Game.GAME_RESTART_RESET_SIGNAL.remove(reset);
         Game.GAME_RESTART_RESET_SIGNAL.add(reset);
      }
   }
}
