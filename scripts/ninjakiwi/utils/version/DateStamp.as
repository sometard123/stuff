package ninjakiwi.utils.version
{
   public class DateStamp
   {
      
      private static var DATE_STAMP:String = "??";
      
      {
         DATE_STAMP = "Tue 11/20/2012.14:33:25.68";
      }
      
      public function DateStamp()
      {
         super();
      }
      
      public static function getDateStamp() : String
      {
         return DATE_STAMP;
      }
   }
}
