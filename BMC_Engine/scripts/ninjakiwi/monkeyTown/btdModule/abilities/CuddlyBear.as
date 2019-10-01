package ninjakiwi.monkeyTown.btdModule.abilities
{
   import assests.effects.UpEffect;
   import assets.PlayUI.ActivatedAbilityCuddlyBearClip;
   import assets.PlayUI.CuddlyBearClip;
   import assets.module.CoolDownTimerClip;
   import assets.occupiedSpace.Small;
   import assets.sound.Teddy;
   import flash.utils.Timer;
   import ninjakiwi.monkeyTown.btdModule.abilities.animations.CuddlyBearAnimation;
   import ninjakiwi.monkeyTown.btdModule.abilities.def.AbilityDef;
   import ninjakiwi.monkeyTown.btdModule.game.Game;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.pathSpecificClasses.ActiveAbilityEmpower;
   import ninjakiwi.monkeyTown.btdModule.levels.rounds.RoundGenerator;
   import ninjakiwi.monkeyTown.btdModule.sound.MaxSound;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.TowerPlace;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   
   public class CuddlyBear extends Ability
   {
      
      private static const ABILITY_COOLDOWN:Number = 120;
      
      private static const LIFE_INCREASE:int = 20;
      
      private static var _checkTimer:Timer = new Timer(ABILITY_COOLDOWN,0);
      
      private static var _timeActivated:Number = 0;
      
      public static var _abilityAnimation:CuddlyBearAnimation;
      
      public static var _healthUp:UpEffect;
      
      private static var _tower:Tower = null;
       
      
      private var _isReady:Boolean = true;
      
      public function CuddlyBear()
      {
         super();
         onRemoveFromGame();
         _abilityAnimation = new CuddlyBearAnimation();
         Main.instance.game.level.addEntity(_abilityAnimation);
         _healthUp = new UpEffect();
         Main.instance.effectLayer.addChild(_healthUp);
      }
      
      public static function add() : void
      {
         var _loc1_:AbilityDef = null;
         _loc1_ = new AbilityDef("CuddlyBear");
         _loc1_.cooldown = ABILITY_COOLDOWN * ActiveAbilityEmpower.instance.abilityCooldownScale;
         _loc1_.label = "Cuddly Bear";
         _loc1_.description = "Cuddly Bear spreads the love, providing 20 bonus lives.";
         _loc1_.sound = Teddy;
         _loc1_.thumb = ActivatedAbilityCuddlyBearClip;
         _loc1_.ability = CuddlyBear;
         var _loc2_:TowerDef = new TowerDef("CuddlyBear").Label("Cuddly Bear").Description("").OccupiedSpace(Small).RangeOfVisibility(60).Detail(null).DetailSmall(CuddlyBearClip).Abilities(Vector.<AbilityDef>([_loc1_]));
         _tower = Main.instance.game.level.createTower(_loc2_.id,_loc2_,0,0,0);
         _tower.resellable = false;
         _tower.coolDownTimerGuage = new CoolDownTimerClip();
         _tower.rootID = "CuddlyBear";
         TowerPlace.towerPlacedSignal.dispatch(_tower);
         Game.GAME_EXIT_SIGNAL.remove(onRemoveFromGame);
         Game.GAME_EXIT_SIGNAL.add(onRemoveFromGame);
      }
      
      private static function onRemoveFromGame() : void
      {
         if(_abilityAnimation)
         {
            _abilityAnimation.deactivate();
         }
         if(_abilityAnimation)
         {
            _abilityAnimation.disposeFrames();
            _abilityAnimation = null;
         }
      }
      
      private static function get gameTime() : Number
      {
         return Main.instance.game.getGameTime();
      }
      
      override public function execute(param1:Tower, param2:AbilityDef) : void
      {
         Main.instance.game.level.setHealth(Main.instance.game.level.health.value + LIFE_INCREASE);
         _timeActivated = gameTime;
         this._isReady = false;
         RoundGenerator.roundStartSignal.add(this.onRoundStart);
         _abilityAnimation.activate();
         _healthUp.gotoAndPlay(0);
         new MaxSound(param2.sound).play();
      }
      
      private function onRoundStart(param1:int) : void
      {
         if(Main.instance.game.level.roundIndex == 0)
         {
            return;
         }
         this._isReady = true;
         RoundGenerator.roundStartSignal.remove(this.onRoundStart);
      }
      
      override public function get isReady() : Boolean
      {
         return this._isReady;
      }
   }
}
