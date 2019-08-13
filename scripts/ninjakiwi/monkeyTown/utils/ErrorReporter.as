package ninjakiwi.monkeyTown.utils
{
   import flash.external.ExternalInterface;
   
   public class ErrorReporter
   {
       
      
      public function ErrorReporter()
      {
         super();
      }
      
      public static function error(param1:String, ... rest) : void
      {
         var _loc3_:int = 0;
         while(_loc3_ < rest.length)
         {
            param1 = param1 + (" " + rest[_loc3_]);
            _loc3_++;
         }
      }
      
      public static function say(param1:String, ... rest) : void
      {
         var _loc3_:int = 0;
         while(_loc3_ < rest.length)
         {
            param1 = param1 + (" " + rest[_loc3_]);
            _loc3_++;
         }
      }
      
      public static function deep(param1:Object, param2:Boolean = false) : void
      {
         t.DoNotTrace = true;
         var _loc3_:String = t.obj(param1);
         t.DoNotTrace = false;
         if(param2)
         {
            externalLog(_loc3_);
         }
      }
      
      public static function externalLog(param1:String, ... rest) : void
      {
         var _loc3_:int = 0;
         while(_loc3_ < rest.length)
         {
            param1 = param1 + (" " + rest[_loc3_]);
            _loc3_++;
         }
         if(ExternalInterface.available)
         {
            ExternalInterface.call("console.log",param1);
         }
      }
   }
}
