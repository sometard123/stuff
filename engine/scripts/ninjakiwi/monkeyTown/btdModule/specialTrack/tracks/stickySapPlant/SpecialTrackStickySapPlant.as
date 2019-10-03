package ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.stickySapPlant
{
   import assests.effects.GlueGunnerRain;
   import assets.PlayUI.StickySapFlowerClip;
   import assets.ability.ActivatedAbilityStickySapFlower;
   import assets.module.CoolDownTimerClip;
   import assets.occupiedSpace.Small;
   import assets.projectile.GlueShot;
   import assets.sound.GlueStrike;
   import assets.towers.stickySapFlowerExplode;
   import ninjakiwi.monkeyTown.btdModule.abilities.StickySapFlowerBlossom;
   import ninjakiwi.monkeyTown.btdModule.abilities.def.AbilityDef;
   import ninjakiwi.monkeyTown.btdModule.abilities.def.StickySapFlowerDef;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.entities.StickySapFlower;
   import ninjakiwi.monkeyTown.btdModule.ingame.DirectUseAbilityButton;
   import ninjakiwi.monkeyTown.btdModule.levels.rounds.BloonSpawnDefinition;
   import ninjakiwi.monkeyTown.btdModule.levels.rounds.BloonSpawnType;
   import ninjakiwi.monkeyTown.btdModule.levels.rounds.Round;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.GlueEffectDef;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.SpecialTrack;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.TowerPlace;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.initialise.Sacrifice;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BloonWeightsDefinition;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.TileUniqueDataDefinition;
   
   public class SpecialTrackStickySapPlant extends SpecialTrack
   {
       
      
      public function SpecialTrackStickySapPlant()
      {
         super();
      }
      
      override public function setSpecialTrack(param1:BTDGameRequest) : void
      {
         super.setSpecialTrack(param1);
         param1.BloonWeights(new BloonWeightsDefinition().StrongestBloonID(Constants.CERAMIC_ID).StrongestBloonType(Constants.CERAMIC_BLOON));
         param1.TerrainType(Constants.STICKY_SAP_PLANT);
         param1.TileUniqueData(new TileUniqueDataDefinition().TrackID(0));
         if(param1.bloonWeights.strongestBloonID >= Constants.MOAB_ID)
         {
            param1.bloonWeights.StrongestBloonID(Constants.CERAMIC_ID);
            param1.bloonWeights.StrongestBloonType(Constants.CERAMIC_BLOON);
         }
         Bloon.cashChanceModifier = 0.33;
      }
      
      override public function clearSpecialTrack() : void
      {
         super.clearSpecialTrack();
         Bloon.cashChanceModifier = 1;
      }
      
      override public function applySpecialTrack(param1:BTDGameRequest) : void
      {
         var _loc4_:Round = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         super.applySpecialTrack(param1);
         this.addFlower(275,250);
         this.addFlower(435,270);
         var _loc2_:Vector.<Round> = Main.instance.game.level.roundGenerator.rounds;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_];
            _loc5_ = _loc4_.queuedBloons.length;
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               if((_loc4_.queuedBloons[_loc6_] as BloonSpawnDefinition).spawnType.type < Bloon.MOAB - 1)
               {
                  (_loc4_.queuedBloons[_loc6_] as BloonSpawnDefinition).spawnType.typeModifier = 1;
               }
               _loc6_++;
            }
            _loc3_++;
         }
         if(_loc2_.length > 0)
         {
            _loc2_[_loc2_.length - 1].queueBloon(new BloonSpawnType(Constants.MOAB_ID).Spacing(Constants.SPACING_NORMAL));
            _loc2_[_loc2_.length - 1].queueBloon(new BloonSpawnType(Constants.MOAB_ID).Spacing(Constants.SPACING_NORMAL * 10));
         }
      }
      
      private function addFlower(param1:Number, param2:Number) : void
      {
         var _loc3_:ProjectileDef = new ProjectileDef().Display(GlueShot).Pierce(99999).Radius(99999).EffectMask(Vector.<int>([Bloon.IMMUNITY_NO_DETECTION,Bloon.IMMUNITY_GLUE])).GlueEffect(new GlueEffectDef().Lifespan(11.43).Soak(true).CorosionInterval(2.29));
         var _loc4_:AbilityDef = new StickySapFlowerDef("StickySapFlowerBlossom").Projectile(_loc3_).Cooldown(45).FullscreenEffect(GlueGunnerRain).Sound(GlueStrike).Thumb(ActivatedAbilityStickySapFlower).Label("Sticky Sap Flower Ability").Description("Glues all bloons on the screen.").AbilityClass(StickySapFlowerBlossom);
         var _loc5_:TowerDef = new TowerDef("StickySapFlower").Label("Sticky Sap Flower").Description("").Display(stickySapFlowerExplode).OccupiedSpace(Small).RangeOfVisibility(60).Detail(null).DetailSmall(StickySapFlowerClip).TargetMask(Vector.<int>([Bloon.IMMUNITY_NO_DETECTION,Bloon.IMMUNITY_GLUE])).SacrificeType(Sacrifice.SACRIFICE_TYPE_GLUE).CanPriorityTarget(false).Abilities(Vector.<AbilityDef>([_loc4_]));
         var _loc6_:Tower = Main.instance.game.level.createTower(_loc5_.id,_loc5_,param1,param2,0);
         _loc6_.resellable = false;
         _loc6_.coolDownTimerGuage = new CoolDownTimerClip();
         _loc6_.directUseAbilityButton = new DirectUseAbilityButton(_loc6_,_loc4_);
         _loc6_.hasPopCount = false;
         TowerPlace.towerPlacedSignal.dispatch(_loc6_);
         var _loc7_:StickySapFlower = new StickySapFlower();
         _loc7_.initialise(_loc6_,_loc4_);
         _loc6_.level.addEntity(_loc7_);
      }
   }
}
