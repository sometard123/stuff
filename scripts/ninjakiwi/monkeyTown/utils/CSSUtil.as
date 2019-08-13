package ninjakiwi.monkeyTown.utils
{
   public class CSSUtil
   {
       
      
      public function CSSUtil()
      {
         super();
      }
      
      public static function wrapInRed(param1:String) : String
      {
         return "<span class = \"red\">" + param1 + "</span>";
      }
      
      public static function wrapInGreen(param1:String) : String
      {
         return "<span class = \"green\">" + param1 + "</span>";
      }
   }
}
