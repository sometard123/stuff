package ninjakiwi.monkeyTown.data
{
   import org.osflash.signals.Signal;
   
   public class KeyValueStore
   {
      
      private static var instance:KeyValueStore;
       
      
      public const dataHasChangedSignal:Signal = new Signal();
      
      public const readySignal:Signal = new Signal();
      
      private var _hasBeenInitialised:Boolean = false;
      
      private var _data:Object = null;
      
      public function KeyValueStore(param1:SingletonEnforcer#1572)
      {
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use KeyValueStore.getInstance() instead of new.");
         }
      }
      
      public static function getInstance() : KeyValueStore
      {
         if(instance == null)
         {
            instance = new KeyValueStore(new SingletonEnforcer#1572());
         }
         return instance;
      }
      
      public function initData(param1:Object) : void
      {
         this._data = param1;
         this._hasBeenInitialised = true;
         this.readySignal.dispatch();
      }
      
      public function reset() : void
      {
         this._data = null;
         this._hasBeenInitialised = false;
      }
      
      public function set(param1:String, param2:*) : Boolean
      {
         if(!this._hasBeenInitialised)
         {
            return false;
         }
         if(!this.validValue(param2))
         {
            return false;
         }
         this._data[param1] = param2;
         this.dataHasChangedSignal.dispatch();
         return true;
      }
      
      public function get(param1:String, param2:Function) : void
      {
         if(!this._hasBeenInitialised || this._data === null)
         {
            param2(null);
            return;
         }
         if(this._data.hasOwnProperty(param1))
         {
            param2(this._data[param1]);
            return;
         }
         param2(null);
      }
      
      private function validValue(param1:*) : Boolean
      {
         var value:* = param1;
         try
         {
            JSON.stringify(value);
         }
         catch(e:Error)
         {
            return false;
         }
         return true;
      }
      
      public function getSaveData() : Object
      {
         return this._data;
      }
      
      public function get hasBeenInitialised() : Boolean
      {
         return this._hasBeenInitialised;
      }
   }
}

class SingletonEnforcer#1572
{
    
   
   function SingletonEnforcer#1572()
   {
      super();
   }
}
