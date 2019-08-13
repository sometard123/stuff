package ninjakiwi.monkeyTown.analytics
{
   import org.osflash.signals.PrioritySignal;
   
   public class ErrorMessageTracking
   {
      
      public static const ERROR_NO_HISTORY_CODE:int = 1;
      
      public static const ERROR_INVALID_PACIFIST_CODE:int = 2;
      
      public static const ERROR_SERVER_ERROR_CODE:int = 3;
      
      public static const ERROR_NO_HISTORY_HEADING:String = "No History";
      
      public static const ERROR_INVALID_PACIFIST_HEADING:String = "Invalid Pacifist";
      
      public static const ERROR_SERVER_ERROR_HEADING:String = "Server Error";
      
      public static const errorTrackingSignal:PrioritySignal = new PrioritySignal(int,String,String);
       
      
      public function ErrorMessageTracking()
      {
         super();
      }
      
      public static function reportErrorMessageNoHistory(param1:String, param2:String, param3:String, param4:int, param5:Object, param6:Object) : String
      {
         var _loc7_:String = null;
         return "";
      }
      
      public static function reportErrorMessageInvalidPacifist(param1:String, param2:String, param3:Number, param4:Number, param5:String, param6:Object, param7:Object, param8:int = -1, param9:String = null) : String
      {
         var _loc10_:String = null;
         return "";
      }
   }
}
