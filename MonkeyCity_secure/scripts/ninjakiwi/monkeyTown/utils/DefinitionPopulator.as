package ninjakiwi.monkeyTown.utils
{
   import mx.utils.DescribeTypeCache;
   
   public class DefinitionPopulator
   {
       
      
      public function DefinitionPopulator()
      {
         super();
      }
      
      public function isObjectDynamic(param1:*) : Boolean
      {
         var _loc2_:XML = DescribeTypeCache.describeType(param1).typeDescription;
         return _loc2_.@isDynamic.toString() == "true";
      }
      
      public function populateDefinitionFromObject(param1:*, param2:Object) : void
      {
         var _loc4_:* = null;
         var _loc3_:Boolean = this.isObjectDynamic(param1);
         for(_loc4_ in param2)
         {
            if(_loc3_ || param1.hasOwnProperty(_loc4_))
            {
               param1[_loc4_] = param2[_loc4_];
            }
         }
      }
      
      public function populateDefinitionFromTableObject(param1:*, param2:Object, param3:int) : void
      {
         var _loc5_:* = null;
         var _loc4_:Boolean = this.isObjectDynamic(param1);
         for(_loc5_ in param2)
         {
            if(_loc4_ || param1.hasOwnProperty(_loc5_))
            {
               param1[_loc5_] = param2[_loc5_][param3];
            }
         }
      }
   }
}
