package ninjakiwi.monkeyTown.utils
{
   public class Formator
   {
       
      
      public function Formator()
      {
         super();
      }
      
      public static function msToHrMin(param1:Number) : String
      {
         var _loc2_:int = param1 * 0.001;
         var _loc3_:int = _loc2_ / 60 % 60;
         var _loc4_:int = _loc2_ / 3600;
         var _loc5_:String = "";
         if(_loc4_ > 0)
         {
            return String(_loc4_) + "hrs";
         }
         if(_loc3_ > 0)
         {
            return String(_loc3_) + "mins";
         }
         return "1 min";
      }
   }
}
