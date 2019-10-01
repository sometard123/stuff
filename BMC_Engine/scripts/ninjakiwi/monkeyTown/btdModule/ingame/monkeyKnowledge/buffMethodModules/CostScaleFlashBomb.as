package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradeDef;
   
   public class CostScaleFlashBomb implements IBuffMethodModule
   {
       
      
      public function CostScaleFlashBomb()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         var _loc2_:UpgradeDef = null;
         var _loc3_:UpgradeDef = null;
         _loc2_ = BuffMethodModuleSharedFunctions.findUpgrade(Main.instance.towerFactory,Main.instance.towerMenuSet,"Flash Bomb",param1.buffPathID);
         _loc3_ = BuffMethodModuleSharedFunctions.findUpgrade(Main.instance.towerFactoryUnmodified,Main.instance.towerMenuSetUnmodified,"Flash Bomb",param1.buffPathID);
         var _loc4_:Number = _loc2_.cost / _loc3_.cost - (1 - param1.buffValue);
         _loc2_.Cost(_loc3_.cost * _loc4_);
      }
   }
}
