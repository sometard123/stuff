package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradeDef;
   import ninjakiwi.monkeyTown.btdModule.weapons.Single;
   
   public class AttackCooldownScaleFireball implements IBuffMethodModule
   {
       
      
      public function AttackCooldownScaleFireball()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         var _loc2_:UpgradeDef = null;
         var _loc3_:UpgradeDef = null;
         var _loc4_:Single = null;
         var _loc5_:Single = null;
         _loc2_ = BuffMethodModuleSharedFunctions.findUpgrade(Main.instance.towerFactory,Main.instance.towerMenuSet,"Fireball",param1.buffPathID);
         _loc3_ = BuffMethodModuleSharedFunctions.findUpgrade(Main.instance.towerFactoryUnmodified,Main.instance.towerMenuSetUnmodified,"Fireball",param1.buffPathID);
         _loc4_ = _loc2_.add.weapons[0] as Single;
         _loc5_ = _loc3_.add.weapons[0] as Single;
         var _loc6_:Number = _loc4_.reloadTime / _loc5_.reloadTime - (1 - param1.buffValue);
         _loc4_.ReloadTime(_loc5_.reloadTime * _loc6_);
      }
   }
}
