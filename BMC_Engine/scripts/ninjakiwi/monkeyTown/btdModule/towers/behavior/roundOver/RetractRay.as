package ninjakiwi.monkeyTown.btdModule.towers.behavior.roundOver
{
   import ninjakiwi.monkeyTown.btdModule.entities.MapElement;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundStart.DeployRay;
   
   public class RetractRay extends BehaviorRoundOver
   {
       
      
      public function RetractRay()
      {
         super();
      }
      
      override public function execute(param1:Tower) : void
      {
         var _loc2_:MapElement = DeployRay.rays[param1];
         if(_loc2_ != null)
         {
            _loc2_.destroy();
         }
         DeployRay.rays[param1] = null;
      }
   }
}
