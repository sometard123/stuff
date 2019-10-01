package ninjakiwi.monkeyTown.town.management
{
   public class Manager
   {
       
      
      protected var _items:Array;
      
      protected var _deregisterQueue:Array;
      
      protected var _hasItemsInDegisterCue:Boolean = false;
      
      public var validType:Class = null;
      
      public function Manager()
      {
         this._items = [];
         this._deregisterQueue = [];
         super();
      }
      
      public function tick() : void
      {
         if(this._hasItemsInDegisterCue)
         {
            this.processDeregisterCue();
         }
         var _loc1_:int = this._items.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this._items[_loc2_].tick();
            _loc2_++;
         }
      }
      
      public function clear() : void
      {
         this._items.length = 0;
         this._deregisterQueue.length = 0;
      }
      
      public function callFunctionOnAllItems(param1:String) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:int = this._items.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = this._items[_loc4_];
            if(_loc3_["functionName"] && _loc3_["functionName"] is Function)
            {
               _loc3_["functionName"]();
            }
            _loc4_++;
         }
      }
      
      protected function processDeregisterCue() : void
      {
         var _loc1_:int = this._deregisterQueue.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this.deregister(this._deregisterQueue[_loc2_]);
            _loc2_++;
         }
         this._deregisterQueue.length = 0;
         this._hasItemsInDegisterCue = false;
      }
      
      public function register(param1:*) : Boolean
      {
         if(this.validType != null)
         {
            if(!(param1 is this.validType))
            {
               return false;
            }
         }
         this._items.push(param1);
         return true;
      }
      
      public function deregisterOnNextTick(param1:*) : void
      {
         this._deregisterQueue.push(param1);
         this._hasItemsInDegisterCue = true;
      }
      
      public function deregister(param1:*) : Boolean
      {
         if(this.validType != null)
         {
            if(!(param1 is this.validType))
            {
               return false;
            }
         }
         this.removeItemFromArray(this._items,param1);
         return true;
      }
      
      public function countTotalOfPropertyInItems(param1:String) : int
      {
         var _loc3_:* = undefined;
         var _loc2_:int = this._items.length;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_ = this._items[_loc5_];
            if(_loc3_[param1])
            {
               _loc4_ = _loc4_ + _loc3_[param1];
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      protected function removeItemFromArray(param1:Array, param2:*) : Boolean
      {
         var _loc3_:int = param1.length;
         while(--_loc3_ > -1)
         {
            if(param2 == param1[_loc3_])
            {
               param1.splice(_loc3_,1);
               return true;
            }
         }
         return false;
      }
      
      public function get numItems() : int
      {
         return this._items.length;
      }
   }
}
