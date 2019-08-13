package ninjakiwi.monkeyTown.ui
{
   import flash.utils.Dictionary;
   
   public class UIMutex
   {
       
      
      private var _groups:Dictionary;
      
      public function UIMutex()
      {
         this._groups = new Dictionary();
         super();
      }
      
      public function getLock(param1:*) : Boolean
      {
         if(this._groups[param1] === undefined)
         {
            this._groups[param1] = true;
            return true;
         }
         if(this._groups[param1] === true)
         {
            return false;
         }
         this._groups[param1] = true;
         return true;
      }
      
      public function unLock(param1:*) : void
      {
         this._groups[param1] = false;
      }
      
      public function isLocked(param1:*) : Boolean
      {
         if(this._groups[param1] === undefined)
         {
            return false;
         }
         return this._groups[param1];
      }
   }
}
