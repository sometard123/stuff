package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradeDef;
   
   public class CostScaleOverclockBloonTrap implements IBuffMethodModule
   {
       
      
      public function CostScaleOverclockBloonTrap()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         var _loc2_:UpgradeDef = null;
         var _loc3_:UpgradeDef = null;
         var _loc5_:UpgradeDef = null;
         var _loc6_:UpgradeDef = null;
         _loc2_ = BuffMethodModuleSharedFunctions.findUpgrade(Main.instance.towerFactory,Main.instance.towerMenuSet,"Overclock",param1.buffPathID);
         _loc3_ = BuffMethodModuleSharedFunctions.findUpgrade(Main.instance.towerFactoryUnmodified,Main.instance.towerMenuSetUnmodified,"Overclock",param1.buffPathID);
         var _loc4_:Number = _loc2_.cost / _loc3_.cost - (1 - param1.buffValue);
         _loc2_.Cost(_loc3_.cost * _loc4_);
         _loc5_ = BuffMethodModuleSharedFunctions.findUpgrade(Main.instance.towerFactory,Main.instance.towerMenuSet,"Bloon Trap",param1.buffPathID);
         _loc6_ = BuffMethodModuleSharedFunctions.findUpgrade(Main.instance.towerFactoryUnmodified,Main.instance.towerMenuSetUnmodified,"Bloon Trap",param1.buffPathID);
         var _loc7_:Number = _loc5_.cost / _loc6_.cost - (1 - param1.buffValue);
         _loc5_.Cost(_loc6_.cost * _loc7_);
      }
   }
}
