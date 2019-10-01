package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradeDef;
   
   public class CostSubtractBiggerBombs implements IBuffMethodModule
   {
       
      
      public function CostSubtractBiggerBombs()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         var _loc2_:UpgradeDef = BuffMethodModuleSharedFunctions.findUpgrade(Main.instance.towerFactory,Main.instance.towerMenuSet,"Bigger Bombs",param1.buffPathID);
         _loc2_.Cost(_loc2_.cost - param1.buffValue);
      }
   }
}
