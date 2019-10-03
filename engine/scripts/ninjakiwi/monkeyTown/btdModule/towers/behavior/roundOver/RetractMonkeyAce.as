package ninjakiwi.monkeyTown.btdModule.towers.behavior.roundOver
{
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundStart.DeployMonkeyAce;
   
   public class RetractMonkeyAce extends BehaviorRoundOver
   {
       
      
      public function RetractMonkeyAce()
      {
         super();
      }
      
      override public function execute(param1:Tower) : void
      {
         if(DeployMonkeyAce.aces[param1])
         {
            DeployMonkeyAce.aces[param1].land();
         }
      }
   }
}
