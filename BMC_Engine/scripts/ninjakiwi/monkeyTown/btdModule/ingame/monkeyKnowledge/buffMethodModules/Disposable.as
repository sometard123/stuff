package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.towers.TowerAvailabilityManager;
   
   public class Disposable implements IBuffMethodModule
   {
       
      
      public function Disposable()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         TowerAvailabilityManager.instance.addFreeTower(param1.buffPathID);
      }
   }
}
