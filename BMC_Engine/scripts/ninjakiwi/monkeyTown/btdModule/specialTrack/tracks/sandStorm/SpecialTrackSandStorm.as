package ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.sandStorm
{
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.levels.Level;
   import ninjakiwi.monkeyTown.btdModule.levels.rounds.RoundGeneratorSandstorm;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.SpecialTrack;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.TileUniqueDataDefinition;
   
   public class SpecialTrackSandStorm extends SpecialTrack
   {
       
      
      public var abilityAnimation:SandStormAbilityAnimation;
      
      public function SpecialTrackSandStorm()
      {
         super();
      }
      
      override public function clearSpecialTrack() : void
      {
         super.clearSpecialTrack();
         Tile.processWindDirection = false;
         this.abilityAnimation.disposeFrames();
         this.abilityAnimation = null;
         Bloon.cashChanceModifier = 1;
         SandStormWindAbility.onExecuteSignal.remove(this.onAbilityActivate);
         SandStormWindAbility.onFinishedSignal.remove(this.onAbilityFinished);
      }
      
      override public function setSpecialTrack(param1:BTDGameRequest) : void
      {
         super.setSpecialTrack(param1);
         param1.TerrainType(Constants.TERRAIN_SANDSTORM);
         param1.TileUniqueData(new TileUniqueDataDefinition().TrackID(0));
      }
      
      private function onAbilityActivate() : void
      {
         this.abilityAnimation.activate();
      }
      
      private function onAbilityFinished() : void
      {
         this.abilityAnimation.deactivate();
      }
      
      private function patchAvailableTowers(param1:Object) : void
      {
         var _loc2_:* = null;
         for(_loc2_ in param1)
         {
            if(_loc2_ == Constants.TOWER_FARM || _loc2_ == Constants.TOWER_ICE)
            {
               param1[_loc2_].allowed = false;
            }
         }
      }
      
      override public function applySpecialTrack(param1:BTDGameRequest) : void
      {
         super.applySpecialTrack(param1);
         param1.Difficulty(23);
         this.patchAvailableTowers(param1.availableTowers);
         var _loc2_:Level = Main.instance.game.level;
         _loc2_.roundGenerator = new RoundGeneratorSandstorm(_loc2_);
         _loc2_.roundGenerator.generate(param1);
         Tile.processWindDirection = true;
         this.addWindActivatedAbility();
         this.abilityAnimation = new SandStormAbilityAnimation();
         Main.instance.game.level.addEntity(this.abilityAnimation);
         SandStormWindAbility.onExecuteSignal.add(this.onAbilityActivate);
         SandStormWindAbility.onFinishedSignal.add(this.onAbilityFinished);
         Bloon.cashChanceModifier = 0.5;
      }
      
      private function addWindActivatedAbility() : void
      {
         SandStormWindAbility.add();
      }
   }
}
