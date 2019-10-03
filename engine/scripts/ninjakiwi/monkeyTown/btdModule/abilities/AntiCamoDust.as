package ninjakiwi.monkeyTown.btdModule.abilities
{
   import assets.PlayUI.AntiCamoDustClip;
   import assets.ability.ActivatedAbilityAntiCamoDust;
   import assets.module.CoolDownTimerClip;
   import assets.occupiedSpace.Small;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import ninjakiwi.monkeyTown.btdModule.abilities.animations.AntiCamoDustAnimation;
   import ninjakiwi.monkeyTown.btdModule.abilities.def.AbilityDef;
   import ninjakiwi.monkeyTown.btdModule.events.LevelEvent;
   import ninjakiwi.monkeyTown.btdModule.game.Game;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.pathSpecificClasses.ActiveAbilityEmpower;
   import ninjakiwi.monkeyTown.btdModule.levels.Level;
   import ninjakiwi.monkeyTown.btdModule.sound.MaxSound;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.TowerPlace;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   
   public class AntiCamoDust extends Ability
   {
      
      private static const DURATION_OF_ABILITY_SEC:Number = 20;
      
      private static const ACTIVATION_INTERVAL:Number = 100;
      
      private static var _checkTimer:Timer = null;
      
      private static var _timeActivated:Number = 0;
      
      private static var _abilityAnimation:AntiCamoDustAnimation;
      
      private static var _tower:Tower = null;
      
      private static var _doesEffectExist:Boolean = false;
       
      
      public function AntiCamoDust()
      {
         super();
         if(false == _doesEffectExist)
         {
            _abilityAnimation = new AntiCamoDustAnimation();
            Main.instance.game.level.addEntity(_abilityAnimation);
            _doesEffectExist = true;
         }
      }
      
      public static function reset(param1:LevelEvent = null) : void
      {
         Level.camoDisabled = false;
         if(_abilityAnimation)
         {
            _abilityAnimation.deactivate();
         }
         if(_checkTimer)
         {
            _checkTimer.removeEventListener(TimerEvent.TIMER,checkElapsedTime);
            _checkTimer.reset();
            _checkTimer = null;
         }
         Main.instance.game.removeEventListener(LevelEvent.ROUND_START,activateLogic);
         Main.instance.game.removeEventListener(LevelEvent.ROUND_OVER,reset);
      }
      
      public static function add() : void
      {
         var _loc1_:AbilityDef = null;
         reset();
         _loc1_ = new AbilityDef("AntiCamoDust");
         _loc1_.cooldown = 45 * ActiveAbilityEmpower.instance.abilityCooldownScale;
         _loc1_.label = "Anti-camo Dust";
         _loc1_.description = "Removes camo from all newly spawned bloons for 20 seconds.";
         _loc1_.sound = assets.sound.AntiCamoDust;
         _loc1_.thumb = ActivatedAbilityAntiCamoDust;
         _loc1_.ability = ninjakiwi.monkeyTown.btdModule.abilities.AntiCamoDust;
         var _loc2_:TowerDef = new TowerDef("AntiCamoDust").Label("Anti Camo Dust").Description("").OccupiedSpace(Small).RangeOfVisibility(60).Detail(null).DetailSmall(AntiCamoDustClip).Abilities(Vector.<AbilityDef>([_loc1_]));
         _tower = Main.instance.game.level.createTower(_loc2_.id,_loc2_,0,0,0);
         _tower.resellable = false;
         _tower.coolDownTimerGuage = new CoolDownTimerClip();
         _tower.rootID = "AntiCamoDust";
         TowerPlace.towerPlacedSignal.dispatch(_tower);
         Game.GAME_EXIT_SIGNAL.remove(onRemoveFromGame);
         Game.GAME_EXIT_SIGNAL.add(onRemoveFromGame);
      }
      
      private static function onRemoveFromGame() : void
      {
         reset();
         if(_abilityAnimation)
         {
            _abilityAnimation.disposeFrames();
            _abilityAnimation = null;
            Main.instance.game.level.cull(_abilityAnimation);
            _doesEffectExist = false;
         }
      }
      
      private static function activateLogic(param1:LevelEvent = null) : void
      {
         Main.instance.game.removeEventListener(LevelEvent.ROUND_START,activateLogic);
         Main.instance.game.level.removeCamoFromAllActiveBloons();
         Level.camoDisabled = true;
         _timeActivated = Main.instance.game.getGameTime();
         _checkTimer = new Timer(ACTIVATION_INTERVAL,0);
         _checkTimer.addEventListener(TimerEvent.TIMER,checkElapsedTime,false,0,true);
         _checkTimer.start();
      }
      
      private static function checkElapsedTime(param1:TimerEvent) : void
      {
         var _loc2_:Number = Main.instance.game.getGameTime() - _timeActivated;
         if(_loc2_ > DURATION_OF_ABILITY_SEC)
         {
            reset();
         }
      }
      
      override public function execute(param1:Tower, param2:AbilityDef) : void
      {
         reset();
         Main.instance.game.addEventListener(LevelEvent.ROUND_OVER,reset,false,0,true);
         if(Main.instance.game.level.isRoundInProgress())
         {
            this.activateEffects(param2);
            activateLogic();
         }
         else
         {
            this.activateEffects(param2);
            Main.instance.game.addEventListener(LevelEvent.ROUND_START,activateLogic);
         }
      }
      
      private function activateEffects(param1:AbilityDef) : void
      {
         _abilityAnimation.activate();
         new MaxSound(param1.sound).play();
         _doesEffectExist = true;
      }
   }
}
