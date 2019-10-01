package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradeDef;
   
   public class CostSubtractFullMetalJacket implements IBuffMethodModule
   {
       
      
      public function CostSubtractFullMetalJacket()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         var _loc2_:UpgradeDef = BuffMethodModuleSharedFunctions.findUpgrade(Main.instance.towerFactory,Main.instance.towerMenuSet,"Full Metal Jacket",param1.buffPathID);
         _loc2_.Cost(_loc2_.cost - param1.buffValue);
      }
   }
}
