package ninjakiwi.data
{
   public class NKDefinition
   {
       
      
      public function NKDefinition()
      {
         super();
      }
      
      public function mergeWithDefaults(param1:String) : void
      {
      }
      
      public function populateFromObject(param1:Object) : void
      {
         var _loc2_:* = null;
         for(_loc2_ in param1)
         {
            if(this.hasProperty(_loc2_))
            {
               this[_loc2_] = param1[_loc2_];
            }
         }
      }
      
      public function hasProperty(param1:String) : Boolean
      {
         var has:Boolean = false;
         var property:String = param1;
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
