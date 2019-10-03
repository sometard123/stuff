package ninjakiwi.monkeyTown.btdModule.towers.behavior.roundOver
{
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundStart.SpawnArcticWind;
   
   public class RetractArcticWind extends BehaviorRoundOver
   {
       
      
      public function RetractArcticWind()
      {
         super();
      }
      
      override public function execute(param1:Tower) : void
      {
         if(SpawnArcticWind.arcticWinds[param1])
         {
            SpawnArcticWind.arcticWinds[param1].destroy();
            SpawnArcticWind.arcticWinds[param1] = null;
         }
      }
   }
}
