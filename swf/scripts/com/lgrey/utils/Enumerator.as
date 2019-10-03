package com.lgrey.utils
{
   import flash.utils.Dictionary;
   
   public class Enumerator
   {
      
      private static var _types:Dictionary = new Dictionary();
       
      
      public function Enumerator()
      {
         super();
      }
      
      public static function getID(param1:*) : int
      {
         if(_types[param1])
         {
            return int(_types[param1]++);
         }
         _types[param1] = 1;
         return 0;
      }
   }
}
