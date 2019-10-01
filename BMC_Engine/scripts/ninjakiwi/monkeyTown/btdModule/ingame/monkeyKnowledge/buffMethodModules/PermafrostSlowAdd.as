package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.IceEffectDef;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.IceEffectModDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradeDef;
   import ninjakiwi.monkeyTown.btdModule.weapons.Surround;
   
   public class PermafrostSlowAdd implements IBuffMethodModule
   {
       
      
      public function PermafrostSlowAdd()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         var _loc2_:UpgradeDef = null;
         var _loc4_:TowerDef = null;
         var _loc5_:Surround = null;
         _loc2_ = BuffMethodModuleSharedFunctions.findUpgrade(Main.instance.towerFactory,Main.instance.towerMenuSet,"Permafrost",param1.buffPathID);
         var _loc3_:IceEffectModDef = _loc2_.add.weaponMod.projectileMod.iceEffectMod;
         _loc3_.Permafrost(_loc3_.permafrost - param1.buffValue);
         _loc4_ = Main.instance.towerFactory.getBaseTower("IceShards");
         _loc5_ = _loc4_.weapons[0] as Surround;
         var _loc6_:IceEffectDef = _loc5_.projectile.iceEffect;
         _loc6_.Permafrost(_loc6_.permafrost - param1.buffValue);
      }
   }
}
