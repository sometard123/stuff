package ninjakiwi.monkeyTown.premiums
{
   import org.osflash.signals.Signal;
   
   public final class SecureBloonstones
   {
      
      private static var _cuedRequests:Array = [];
      
      public static const onBloonstonesSpentSignal:Signal = new Signal(Object);
       
      
      public function SecureBloonstones()
      {
         super();
      }
      
      public static function bloonstonesChanging(param1:int, param2:int) : void
      {
         var _loc3_:int = param2 - param1;
         var _loc4_:BloonstonesRequest = new BloonstonesRequest(_loc3_,param2);
         if(_cuedRequests.length === 0)
         {
            _loc4_.go(requestComplete);
         }
         else
         {
            _cuedRequests.push(_loc4_);
         }
         if(_cuedRequests.length > 10)
         {
         }
      }
      
      public static function requestComplete(param1:Object) : void
      {
         var _loc2_:BloonstonesRequest = null;
         if(param1.success)
         {
            onBloonstonesSpentSignal.dispatch(param1);
         }
         if(_cuedRequests.length > 0)
         {
            _loc2_ = _cuedRequests.shift();
            _loc2_.go(requestComplete);
         }
      }
   }
}
