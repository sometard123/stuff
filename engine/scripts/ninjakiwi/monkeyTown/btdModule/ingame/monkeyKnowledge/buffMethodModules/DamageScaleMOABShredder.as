package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.DamageEffectDef;
   import ninjakiwi.monkeyTown.btdModule.weapons.SpikeSpread;
   
   public class DamageScaleMOABShredder implements IBuffMethodModule
   {
       
      
      public function DamageScaleMOABShredder()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         var _loc2_:SpikeSpread = null;
         var _loc4_:SpikeSpread = null;
         _loc2_ = Main.instance.towerFactory.getBaseTower("MoabShrederSpikes").weapons[0] as SpikeSpread;
         var _loc3_:DamageEffectDef = _loc2_.projectile.damageEffect;
         _loc3_.moabScale = _loc3_.moabScale * param1.buffValue;
         _loc4_ = Main.instance.towerFactory.getBaseTower("SpikeStorm").weapons[0] as SpikeSpread;
         var _loc5_:DamageEffectDef = _loc4_.projectile.damageEffect;
         _loc5_.moabScale = _loc5_.moabScale * param1.buffValue;
      }
   }
}
