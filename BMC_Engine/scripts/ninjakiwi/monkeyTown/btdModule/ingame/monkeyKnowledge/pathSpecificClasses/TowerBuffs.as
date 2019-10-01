package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.pathSpecificClasses
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.BuffManager;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.AreaAttackSpeedAdd;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.AreaDiscountAdd;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.AreaPopCashScaleAdd;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.AreaRangeScale;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.AttackCooldownScale;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.AttackCooldownScaleFireball;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.BananaCashAdd;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.BananasInRoundAdd;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.BananasInRoundAddBananaPlantation;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.BaseAttackCooldownScale;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.BaseCostScale;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.BurnyStuffDurationAdd;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.CooldownSubtractAnnihilation;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.CooldownSubtractFoam;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.CooldownSubtractSpikeStorm;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.CostScale;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.CostScaleFlashBomb;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.CostScaleOverclockBloonTrap;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.CostSubtract;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.CostSubtractBiggerBombs;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.CostSubtractBladeShooter;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.CostSubtractBloontoniumDarts;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.CostSubtractCorrosiveGlue;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.CostSubtractFullMetalJacket;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.CostSubtractGlueSoak;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.CostSubtractLaserBlasts;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.CostSubtractMonkeyPirates;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.CostSubtractSpectre;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.CostSubtractSunGod;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.DamageAddCeramicSnapFreeze;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.DamageAddCeramicSpikedBall;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.DamageAddTheBigOne;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.DamageScaleMOAB;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.DamageScaleMOABShredder;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.EndOfRoundBalanceScaleAdd;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.EndOfRoundInterestScaleAdd;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.FootprintScale;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.HitAreaScale;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.ImmunityBlack;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.ImmunityCamoSentry;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.ImmunityLeadSentry;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.ImmunityWhiteZebraSnapFreeze;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.InterestRateAdd;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.LayersRemovedAdd;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.LifetimeAddCallToArms;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.LifetimeAddPhoenix;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.PermafrostSlowAdd;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.PierceAdd;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.PierceAddBase;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.PierceAddFrag;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.PierceAddGlueSplatter;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.PierceAddSentry;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.PierceAddWhirlwind;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.PineappleSurpriseCooldownSet;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.PineappleSurpriseGrill;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.ProjectileAdd;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.ProjectileAddBloonjitsu;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.ProjectileAddGrape;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.ProjectileLifetimeScale;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.ProjectileSpeedScale;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.PurgeRegenChance;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.PurgeRegenChanceLightning;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.SacrificeValueScaleSet;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.SightCollisionScaleArcticWind;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.SightScale;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.SightScaleLongerCannons;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.SightScaleSentry;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.SignalFlareRemoveRegenCount;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.SlowScaleGlueAdd;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.SpreadScale;
   
   public class TowerBuffs
   {
      
      public static const instance:TowerBuffs = new TowerBuffs();
       
      
      public function TowerBuffs()
      {
         super();
      }
      
      public function activateBuffs() : void
      {
         var _loc1_:* = null;
         for(_loc1_ in Main.instance.game.gameRequest.availableTowers)
         {
            BuffManager.instance.activateBuffsOfMethodInPath(CostSubtract,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(CostSubtractLaserBlasts,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(CostSubtractSunGod,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(CostSubtractSpectre,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(CostSubtractGlueSoak,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(CostSubtractCorrosiveGlue,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(CostSubtractBloontoniumDarts,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(CostSubtractMonkeyPirates,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(CostSubtractBiggerBombs,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(CostSubtractBladeShooter,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(CostSubtractFullMetalJacket,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(BaseCostScale,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(CostScale,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(CostScaleOverclockBloonTrap,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(CostScaleFlashBomb,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(SightScale,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(SightScaleLongerCannons,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(SightScaleSentry,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(SightCollisionScaleArcticWind,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(PierceAddBase,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(PierceAdd,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(PierceAddFrag,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(PierceAddWhirlwind,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(PierceAddGlueSplatter,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(PierceAddSentry,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(CooldownSubtractFoam,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(CooldownSubtractAnnihilation,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(CooldownSubtractSpikeStorm,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(BaseAttackCooldownScale,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(AttackCooldownScale,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(AttackCooldownScaleFireball,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(DamageAddCeramicSnapFreeze,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(DamageAddCeramicSpikedBall,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(DamageAddTheBigOne,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(DamageScaleMOAB,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(DamageScaleMOABShredder,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(SpreadScale,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(ProjectileAdd,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(ProjectileAddGrape,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(ProjectileAddBloonjitsu,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(ProjectileLifetimeScale,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(ProjectileSpeedScale,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(AreaDiscountAdd,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(AreaPopCashScaleAdd,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(AreaRangeScale,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(AreaAttackSpeedAdd,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(HitAreaScale,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(LayersRemovedAdd,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(FootprintScale,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(ImmunityBlack,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(ImmunityWhiteZebraSnapFreeze,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(ImmunityCamoSentry,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(ImmunityLeadSentry,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(LifetimeAddPhoenix,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(LifetimeAddCallToArms,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(PurgeRegenChance,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(PurgeRegenChanceLightning,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(PermafrostSlowAdd,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(SacrificeValueScaleSet,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(SlowScaleGlueAdd,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(PineappleSurpriseCooldownSet,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(BurnyStuffDurationAdd,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(SignalFlareRemoveRegenCount,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(PineappleSurpriseGrill,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(BananaCashAdd,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(BananasInRoundAdd,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(BananasInRoundAddBananaPlantation,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(InterestRateAdd,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(EndOfRoundBalanceScaleAdd,_loc1_);
            BuffManager.instance.activateBuffsOfMethodInPath(EndOfRoundInterestScaleAdd,_loc1_);
         }
      }
   }
}
