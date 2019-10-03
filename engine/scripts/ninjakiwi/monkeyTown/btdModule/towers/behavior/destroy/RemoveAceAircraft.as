package ninjakiwi.monkeyTown.btdModule.towers.behavior.destroy
{
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundStart.DeployMonkeyAce;
   
   public class RemoveAceAircraft extends BehaviorDestroy
   {
       
      
      public function RemoveAceAircraft()
      {
         super();
      }
      
      override public function execute(param1:Tower) : void
      {
         if(DeployMonkeyAce.aces[param1])
         {
            DeployMonkeyAce.aces[param1].destroy();
         }
      }
   }
}
