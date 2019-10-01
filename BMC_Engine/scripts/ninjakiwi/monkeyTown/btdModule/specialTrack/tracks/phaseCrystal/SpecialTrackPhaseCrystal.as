package ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.phaseCrystal
{
   import assests.effects.PhaseCrystalEffect;
   import assets.ability.ActivatedAbilityPhaseCrystal;
   import assets.occupiedSpace.Large;
   import assets.projectile.TerrorBlast;
   import assets.sound.TechnoTerrorAbility;
   import flash.display.BlendMode;
   import ninjakiwi.monkeyTown.btdModule.abilities.SpawnProjectile;
   import ninjakiwi.monkeyTown.btdModule.abilities.def.AbilityDef;
   import ninjakiwi.monkeyTown.btdModule.abilities.def.SpawnProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.DamageEffectDef;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.SpecialTrack;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.TowerPlace;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BloonWeightsDefinition;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.TileUniqueDataDefinition;
   
   public class SpecialTrackPhaseCrystal extends SpecialTrack
   {
       
      
      public function SpecialTrackPhaseCrystal()
      {
         super();
      }
      
      override public function setSpecialTrack(param1:BTDGameRequest) : void
      {
         super.setSpecialTrack(param1);
         param1.Difficulty(26);
         param1.BloonWeights(new BloonWeightsDefinition().StrongestBloonID(Constants.BFB_ID).StrongestBloonType(Constants.BFB_BLOON));
         param1.TerrainType(Constants.PHASE_CRYSTAL);
         param1.TileUniqueData(new TileUniqueDataDefinition().TrackID(0));
      }
      
      override public function applySpecialTrack(param1:BTDGameRequest) : void
      {
         super.applySpecialTrack(param1);
         this.addCrystal(360,270);
         Bloon.baseSpeedModifier = 1.5;
      }
      
      override public function clearSpecialTrack() : void
      {
         super.clearSpecialTrack();
         Bloon.baseSpeedModifier = 1;
      }
      
      private function addCrystal(param1:Number, param2:Number) : void
      {
         var _loc3_:ProjectileDef = new ProjectileDef().Display(TerrorBlast).Pierce(9999).Radius(230).DamageEffect(new DamageEffectDef().Damage(1000).CanBreakIce(true).Kill(true));
         var _loc4_:TowerDef = new TowerDef("Crystal").Label("Crystal").Description("").Display(null).Detail(null).DetailSmall(null).OccupiedSpace(Large).RangeOfVisibility(230).Abilities(Vector.<AbilityDef>([new SpawnProjectileDef("SpawnProjectile").Projectile(_loc3_).Cooldown(10).Sound(TechnoTerrorAbility).Thumb(ActivatedAbilityPhaseCrystal).Label("Bloon Annihilation Ability").Description("Destroys all bloons within short radius of tower, completely, and utterly. Does 1000 damage to MOAB-class bloons.").Effect(PhaseCrystalEffect).AbilityClass(SpawnProjectile).EffectBlend(BlendMode.ADD)]));
         var _loc5_:Tower = Main.instance.game.level.createTower(_loc4_.id,_loc4_,param1,param2,0);
         TowerPlace.towerPlacedSignal.dispatch(_loc5_);
      }
   }
}
