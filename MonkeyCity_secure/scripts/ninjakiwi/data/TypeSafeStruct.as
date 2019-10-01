package ninjakiwi.data
{
   public class TypeSafeStruct
   {
       
      
      public function TypeSafeStruct()
      {
         super();
      }
      
      public static function compare(param1:Object, param2:Object, param3:String = "Compare", param4:Boolean = true, param5:Boolean = false) : void
      {
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = null;
         var _loc9_:* = false;
         for(_loc8_ in param2)
         {
            if(param1[_loc8_] !== undefined)
            {
               _loc6_ = param1[_loc8_];
               _loc7_ = param2[_loc8_];
               if(_loc6_ !== null)
               {
                  if(param4 && _loc6_ is Array)
                  {
                     if(_loc7_ is Array)
                     {
                        if(_loc6_.length > 0 && _loc7_.length > 0)
                        {
                           compare({_loc8_.toString():_loc6_[0]},{_loc8_.toString():_loc7_[0]},param3,param4,param5);
                        }
                     }
                  }
                  else
                  {
                     _loc9_ = _loc6_.toString() === "[object Object]";
                     if(_loc9_)
                     {
                        compare(_loc6_,_loc7_,param3,param4,param5);
                     }
                     else if(typeof _loc6_ === typeof _loc7_)
                     {
                        if(!param5)
                        {
                        }
                     }
                  }
               }
            }
         }
      }
      
      public function populateFromDataObject(param1:Object) : void
      {
         var _loc2_:* = null;
         for(_loc2_ in param1)
         {
            if(this.hasProperty(this,_loc2_))
            {
               this[_loc2_] = param1[_loc2_];
            }
         }
      }
      
      public function mixin(param1:Object, param2:Object) : void
      {
         var _loc3_:* = null;
         for(_loc3_ in param2)
         {
            if(param1[_loc3_] !== undefined)
            {
            }
            param1[_loc3_] = param2[_loc3_];
         }
      }
      
      public function renameField(param1:Object, param2:String, param3:String) : void
      {
         if(param1.hasOwnProperty(param2))
         {
            param1[param3] = param1[param2];
            delete param1[param2];
         }
      }
      
      public function copyByKey(param1:*, param2:String) : Boolean
      {
         if(this.hasProperty(param1,param2))
         {
            if(this.hasProperty(this,param2))
            {
               this[param2] = param1[param2];
               return true;
            }
            return false;
         }
         return false;
      }
      
      private function hasProperty(param1:*, param2:String) : Boolean
      {
         var has:Boolean = false;
         var target:* = param1;
         var property:String = param2;
         try
         {
            has = this[property] !== undefined;
         }
         catch(e:Error)
         {
            has = false;
         }
         return has;
      }
   }
}
