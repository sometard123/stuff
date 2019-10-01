package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradeDef;
   import ninjakiwi.monkeyTown.btdModule.weapons.SingleSpread;
   
   public class PierceAddGlueSplatter implements IBuffMethodModule
   {
       
      
      public function PierceAddGlueSplatter()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         var _loc2_:UpgradeDef = null;
         var _loc4_:TowerDef = null;
         var _loc5_:SingleSpread = null;
         _loc2_ = BuffMethodModuleSharedFunctions.findUpgrade(Main.instance.towerFactory,Main.instance.towerMenuSet,"Glue Splatter",param1.buffPathID);
         var _loc3_:ProjectileDef = _loc2_.add.weaponMod.projectileMod.behaviorMod["addCollision"]["projectile"];
         _loc3_.pierce = _loc3_.pierce + param1.buffValue;
         _loc4_ = Main.instance.towerFactory.getBaseTower("GlueHose");
         _loc5_ = _loc4_.weapons[0] as SingleSpread;
         var _loc6_:ProjectileDef = _loc5_.projectile.behavior.collision["projectile"];
         _loc6_.pierce = _loc6_.pierce + param1.buffValue;
      }
   }
}
