package ninjakiwi.monkeyTown.town.buildings.buildingManagers
{
   import ninjakiwi.monkeyTown.town.buildings.customClasses.BloontoniumStorageTank;
   import ninjakiwi.monkeyTown.town.data.definitions.ConfigData;
   import ninjakiwi.monkeyTown.town.management.Manager;
   import org.osflash.signals.Signal;
   
   public class BloontoniumStorageTankManager extends Manager
   {
       
      
      private const _config:ConfigData = ConfigData.getInstance();
      
      public var capacity:int = 0;
      
      public var maximumBloontoniumChangedSignal:Signal;
      
      public function BloontoniumStorageTankManager()
      {
         this.maximumBloontoniumChangedSignal = new Signal(int);
         super();
         validType = BloontoniumStorageTank;
      }
      
      public function recalculateMaximumCapacity() : int
      {
         var _loc2_:BloontoniumStorageTank = null;
         var _loc1_:int = _items.length;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < _loc1_)
         {
            _loc2_ = _items[_loc4_];
            _loc3_ = _loc3_ + _loc2_.capacity;
            _loc4_++;
         }
         this.capacity = _loc3_;
         return _loc3_;
      }
      
      override public function register(param1:*) : Boolean
      {
         var _loc2_:Boolean = super.register(param1);
         if(_loc2_)
         {
            this.recalculateMaximumCapacity();
            this.maximumBloontoniumChangedSignal.dispatch(this.capacity);
         }
         return _loc2_;
      }
      
      override public function deregister(param1:*) : Boolean
      {
         var _loc2_:Boolean = super.deregister(param1);
         if(_loc2_)
         {
            this.recalculateMaximumCapacity();
            this.maximumBloontoniumChangedSignal.dispatch(this.capacity);
         }
         return _loc2_;
      }
      
      override public function clear() : void
      {
         super.clear();
         this.capacity = 0;
      }
   }
}
