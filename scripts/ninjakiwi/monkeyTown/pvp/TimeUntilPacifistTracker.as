package ninjakiwi.monkeyTown.pvp
{
   import ninjakiwi.monkeyTown.common.Constants;
   
   public class TimeUntilPacifistTracker
   {
      
      private static var _timeUntilPacifist:Number = -1;
       
      
      public function TimeUntilPacifistTracker()
      {
         super();
      }
      
      public static function setTimeUntilPacifist(param1:Number) : void
      {
         _timeUntilPacifist = param1;
      }
      
      public static function get getTimeUntilPacifist() : Number
      {
         return _timeUntilPacifist;
      }
      
      public static function resetTimeUntilPacifist() : void
      {
         _timeUntilPacifist = Constants.PACIFIST_INTERVAL;
      }
   }
}
