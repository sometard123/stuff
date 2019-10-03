package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradeDef;
   
   public class CostSubtractBloontoniumDarts implements IBuffMethodModule
   {
       
      
      public function CostSubtractBloontoniumDarts()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         var _loc2_:UpgradeDef = BuffMethodModuleSharedFunctions.findUpgrade(Main.instance.towerFactory,Main.instance.towerMenuSet,"Depleted Bloontonium Darts",param1.buffPathID);
         _loc2_.Cost(_loc2_.cost - param1.buffValue);
      }
   }
}
