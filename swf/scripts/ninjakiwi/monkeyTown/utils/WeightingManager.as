package ninjakiwi.monkeyTown.utils
{
   public class WeightingManager
   {
       
      
      private var _items:Vector.<WeightedItem>;
      
      public function WeightingManager()
      {
         this._items = new Vector.<WeightingManager>();
         super();
      }
      
      public function addWeightedItem(param1:*, param2:Number) : void
      {
         var _loc3_:WeightedItem = new WeightedItem(param1,param2);
         this._items.push(_loc3_);
         this.normaliseWeights();
      }
      
      public function getRandomItem(param1:Number = -1) : *
      {
         var _loc3_:WeightedItem = null;
         var _loc2_:Number = param1;
         if(param1 < 0)
         {
            _loc2_ = Math.random();
         }
         else if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         else if(_loc2_ > 1)
         {
            _loc2_ = 1;
         }
         var _loc4_:int = 0;
         while(_loc4_ < this._items.length)
         {
            _loc3_ = this._items[_loc4_];
            if(_loc2_ >= _loc3_.rangeLow && _loc2_ <= _loc3_.rangeHigh)
            {
               return _loc3_.target;
            }
            _loc4_++;
         }
         return null;
      }
      
      public function clear() : void
      {
         this._items.length = 0;
      }
      
      private function normaliseWeights() : void
      {
         var _loc1_:WeightedItem = null;
         var _loc3_:int = 0;
         var _loc2_:Number = 0;
         _loc3_ = 0;
         while(_loc3_ < this._items.length)
         {
            _loc1_ = this._items[_loc3_];
            _loc2_ = _loc2_ + _loc1_.weight;
            _loc3_++;
         }
         if(_loc2_ === 0)
         {
            _loc2_ = 0.00001;
         }
         var _loc4_:Number = 0;
         _loc3_ = 0;
         while(_loc3_ < this._items.length)
         {
            _loc1_ = this._items[_loc3_];
            _loc1_.normalisedWeight = _loc1_.weight / _loc2_;
            _loc1_.rangeLow = _loc4_;
            _loc4_ = _loc4_ + _loc1_.normalisedWeight;
            _loc1_.rangeHigh = _loc4_;
            _loc3_++;
         }
      }
   }
}

class WeightedItem
{
    
   
   public var target;
   
   public var weight:Number = 0;
   
   public var normalisedWeight:Number = 0;
   
   public var rangeLow:Number = 0;
   
   public var rangeHigh:Number = 0;
   
   function WeightedItem(param1:*, param2:Number)
   {
      super();
      this.target = param1;
      this.weight = param2;
   }
}
