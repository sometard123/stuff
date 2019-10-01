package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradeDef;
   
   public class PierceAddFrag implements IBuffMethodModule
   {
       
      
      public function PierceAddFrag()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         var _loc2_:UpgradeDef = null;
         _loc2_ = BuffMethodModuleSharedFunctions.findUpgrade(Main.instance.towerFactory,Main.instance.towerMenuSet,"Frag Bombs",param1.buffPathID);
         var _loc3_:ProjectileDef = _loc2_.add.weaponMod.projectileMod.behaviorMod["addCollision"].projectile;
         _loc3_.Pierce(_loc3_.pierce + param1.buffValue);
      }
   }
}
