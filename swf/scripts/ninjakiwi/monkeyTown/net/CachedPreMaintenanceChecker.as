package ninjakiwi.monkeyTown.net
{
   import flash.utils.getTimer;
   
   public class CachedPreMaintenanceChecker
   {
      
      private static const _CHECK_FREQUENCY:Number = 1000 * 60;
      
      private static var _timeLastChecked:Number = -_CHECK_FREQUENCY;
      
      private static var _wasPreMaintenanceLastCheck:Boolean = false;
       
      
      public function CachedPreMaintenanceChecker()
      {
         super();
      }
      
      public static function checkPreMaintenance(param1:Function) : void
      {
         var callback:Function = param1;
         var getTimerResult:Number = getTimer();
         if(getTimerResult - _timeLastChecked < _CHECK_FREQUENCY)
         {
            if(callback !== null)
            {
               callback(_wasPreMaintenanceLastCheck);
            }
            return;
         }
         var checker:PreBTDServerCheck = new PreBTDServerCheck(function mvmServerCheckCallback(param1:Object):void
         {
            _wasPreMaintenanceLastCheck = param1.preMaintenance;
            _timeLastChecked = getTimer();
            if(callback !== null)
            {
               callback(_wasPreMaintenanceLastCheck);
            }
         });
         checker.checkStatus();
      }
   }
}
