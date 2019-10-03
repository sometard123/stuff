package ninjakiwi.monkeyTown.btdModule.towers.behavior.roundOver
{
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.process.WhirpoolStore;
   
   public class ResetWhirpool extends BehaviorRoundOver
   {
       
      
      public function ResetWhirpool()
      {
         super();
      }
      
      override public function execute(param1:Tower) : void
      {
         if(WhirpoolStore.store != null)
         {
            WhirpoolStore.returnAll(param1);
            delete WhirpoolStore.store[param1];
         }
         if(WhirpoolStore.hasSuckedStore != null)
         {
            delete WhirpoolStore.hasSuckedStore[param1];
         }
      }
   }
}
