package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.DamageEffectDef;
   import ninjakiwi.monkeyTown.btdModule.weapons.SpikeSpread;
   
   public class DamageAddCeramicSpikedBall implements IBuffMethodModule
   {
       
      
      public function DamageAddCeramicSpikedBall()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         var _loc2_:SpikeSpread = null;
         var _loc4_:SpikeSpread = null;
         _loc2_ = Main.instance.towerFactory.getBaseTower("SpikedBallFactory").weapons[0] as SpikeSpread;
         var _loc3_:DamageEffectDef = _loc2_.projectile.damageEffect;
         _loc3_.ceramicAdd = _loc3_.ceramicAdd + param1.buffValue;
         _loc4_ = Main.instance.towerFactory.getBaseTower("SpikedMines").weapons[0] as SpikeSpread;
         var _loc5_:DamageEffectDef = _loc4_.projectile.damageEffect;
         _loc5_.ceramicAdd = _loc5_.ceramicAdd + param1.buffValue;
      }
   }
}
