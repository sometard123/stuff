package ninjakiwi.monkeyTown.utils
{
   public class DeepMixin
   {
       
      
      public function DeepMixin()
      {
         super();
      }
      
      public static function mix(param1:Object, param2:Object) : Object
      {
         var _loc3_:* = undefined;
         var _loc4_:* = false;
         var _loc5_:Boolean = false;
         for(_loc3_ in param2)
         {
            _loc4_ = param1[_loc3_] != null;
            _loc5_ = param2[_loc3_] is Array || typeof param2[_loc3_] == "object";
            if(_loc4_ && _loc5_)
            {
               mix(param1[_loc3_],param2[_loc3_]);
            }
            else
            {
               param1[_loc3_] = param2[_loc3_];
            }
         }
         return param1;
      }
   }
}
