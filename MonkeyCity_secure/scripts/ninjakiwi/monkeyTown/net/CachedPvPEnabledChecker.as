package ninjakiwi.monkeyTown.net
{
   import flash.utils.getTimer;
   
   public class CachedPvPEnabledChecker
   {
      
      private static const _CHECK_FREQUENCY:Number = 1000 * 60;
      
      private static var _timeLastChecked:Number = -_CHECK_FREQUENCY;
      
      private static var _wasEnabledAtLastCheck:Boolean = true;
       
      
      public function CachedPvPEnabledChecker()
      {
         super();
      }
      
      public static function checkEnabled(param1:Function) : void
      {
         var callback:Function = param1;
         if(getTimer() - _timeLastChecked < _CHECK_FREQUENCY)
         {
            if(callback !== null)
            {
               callback(_wasEnabledAtLastCheck);
            }
            return;
         }
         var checker:PreBTDServerCheck = new PreBTDServerCheck(function mvmServerCheckCallback(param1:Object):void
         {
            _wasEnabledAtLastCheck = !param1.mvmIsDisabled;
            _timeLastChecked = getTimer();
            if(callback !== null)
            {
               callback(_wasEnabledAtLastCheck);
            }
         });
         checker.checkStatus();
      }
   }
}
