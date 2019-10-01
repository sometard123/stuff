package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradeDef;
   
   public class LifetimeAddPhoenix implements IBuffMethodModule
   {
       
      
      public function LifetimeAddPhoenix()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         var _loc2_:UpgradeDef = BuffMethodModuleSharedFunctions.findUpgrade(Main.instance.towerFactory,Main.instance.towerMenuSet,"Summon Phoenix",param1.buffPathID);
         _loc2_.assign.buffs.push(param1);
      }
   }
}
