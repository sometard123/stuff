package ninjakiwi.monkeyTown.btdModule.towers.behavior.roundOver
{
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundStart.BananaEmitter;
   
   public class Intrest extends BehaviorRoundOver
   {
       
      
      public function Intrest()
      {
         super();
      }
      
      override public function execute(param1:Tower) : void
      {
         var _loc2_:BananaEmitter = null;
         if(param1.def && param1.def.behavior && param1.def.behavior.roundStart)
         {
            _loc2_ = param1.def.behavior.roundStart as BananaEmitter;
            if(_loc2_ != null)
            {
               _loc2_.setBankedFunds(_loc2_.getBankedFunds(param1) * _loc2_.intrestMultiplier,param1);
               param1.dispatchEvent(new PropertyModEvent("funds"));
            }
         }
      }
   }
}
