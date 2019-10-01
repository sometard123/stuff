package ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.dryAsABone
{
   import assets.PlayUI.ActivatedAbilityDryAsABoneRainClip;
   import assets.module.CoolDownTimerClip;
   import assets.occupiedSpace.Small;
   import assets.sound.Rainstorm;
   import ninjakiwi.monkeyTown.btdModule.abilities.Ability;
   import ninjakiwi.monkeyTown.btdModule.abilities.def.AbilityDef;
   import ninjakiwi.monkeyTown.btdModule.game.Game;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.pathSpecificClasses.ActiveAbilityEmpower;
   import ninjakiwi.monkeyTown.btdModule.levels.Level;
   import ninjakiwi.monkeyTown.btdModule.levels.rounds.RoundGenerator;
   import ninjakiwi.monkeyTown.btdModule.sound.MaxSound;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.TowerPlace;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   
   public class RainCloudActivatedAbility extends Ability
   {
      
      private static var tower:Tower;
      
      private static var _game:Game;
      
      private static var _level:Level;
      
      private static var _IS_READY:Boolean = true;
       
      
      public function RainCloudActivatedAbility()
      {
         super();
         _game = Main.instance.game;
         _level = Main.instance.game.level;
      }
      
      public static function reset() : void
      {
         _IS_READY = true;
      }
      
      public static function add() : void
      {
         var _loc1_:AbilityDef = null;
         reset();
         _loc1_ = new AbilityDef("DryAsABoneRainStorm");
         _loc1_.cooldown = 60 * ActiveAbilityEmpower.instance.abilityCooldownScale;
         _loc1_.label = "Rainstorm";
         _loc1_.description = "Waters thirsty Banana Farms.";
         _loc1_.sound = Rainstorm;
         _loc1_.thumb = ActivatedAbilityDryAsABoneRainClip;
         _loc1_.ability = RainCloudActivatedAbility;
         var _loc2_:TowerDef = new TowerDef("DryAsABoneRainStorm").Label("Rainstorm").Description("").OccupiedSpace(Small).RangeOfVisibility(60).Detail(null).DetailSmall(ActivatedAbilityDryAsABoneRainClip).Abilities(Vector.<AbilityDef>([_loc1_]));
         tower = Main.instance.game.level.createTower(_loc2_.id,_loc2_,0,0,0);
         tower.resellable = false;
         tower.coolDownTimerGuage = new CoolDownTimerClip();
         TowerPlace.towerPlacedSignal.dispatch(tower);
      }
      
      private static function get gameTime() : Number
      {
         return Main.instance.game.getGameTime();
      }
      
      private function onRoundStart(param1:int) : void
      {
         _IS_READY = true;
         RoundGenerator.roundStartSignal.remove(this.onRoundStart);
         Game.GAME_RESTART_RESET_SIGNAL.remove(this.onRestartReset);
      }
      
      private function onRestartReset() : void
      {
         _IS_READY = true;
         RoundGenerator.roundStartSignal.remove(this.onRoundStart);
         Game.GAME_RESTART_RESET_SIGNAL.remove(this.onRestartReset);
      }
      
      override public function execute(param1:Tower, param2:AbilityDef) : void
      {
         SpecialTrackDryAsABone.abilityActivated();
         _IS_READY = false;
         RoundGenerator.roundStartSignal.add(this.onRoundStart);
         new MaxSound(param2.sound).play();
         Game.GAME_RESTART_RESET_SIGNAL.remove(this.onRestartReset);
         Game.GAME_RESTART_RESET_SIGNAL.add(this.onRestartReset);
      }
      
      override public function get isReady() : Boolean
      {
         return _IS_READY;
      }
   }
}
