package ninjakiwi.monkeyTown.utils
{
   public class FlagRegistry
   {
       
      
      public var flags:Object;
      
      public function FlagRegistry()
      {
         this.flags = {};
         super();
      }
      
      public function getState(param1:String) : Boolean
      {
         if(this.flags[param1] == undefined)
         {
            this.flags[param1] = false;
            return false;
         }
         return this.flags[param1];
      }
      
      public function setState(param1:String, param2:Boolean = true) : void
      {
         this.flags[param1] = param2;
      }
   }
}
