package ninjakiwi.monkeyTown.town.ui.bloontoniumGenerator
{
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.tick.Tickable;
   import ninjakiwi.monkeyTown.town.management.Manager;
   
   public class BloontoniumStatsManager extends Manager implements Tickable
   {
       
      
      private const _system:MonkeySystem = MonkeySystem.getInstance();
      
      public function BloontoniumStatsManager()
      {
         super();
         validType = BloontoniumStats;
      }
      
      override public function tick() : void
      {
         var _loc3_:BloontoniumStats = null;
         var _loc4_:Number = NaN;
         var _loc1_:Number = this._system.getSecureTime();
         var _loc2_:int = _items.length;
         if(_hasItemsInDegisterCue)
         {
            processDeregisterCue();
         }
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_ = BloontoniumStats(_items[_loc5_]);
            _loc4_ = _loc1_ - _loc3_.timeLastUpdated;
            if(_loc4_ > 1000)
            {
               _loc3_.update(_loc1_);
            }
            if(_loc3_.isFull)
            {
               _loc3_.updatePulsation();
            }
            _loc5_++;
         }
      }
      
      public function updateAll() : void
      {
         var _loc1_:Number = this._system.getSecureTime();
         var _loc2_:int = 0;
         while(_loc2_ < length)
         {
            BloontoniumStats(_items[_loc2_]).update(_loc1_);
            _loc2_++;
         }
      }
      
      public function putAllBloontoniumIntoStorage() : void
      {
         var _loc2_:BloontoniumStats = null;
         var _loc1_:int = _items.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = BloontoniumStats(_items[_loc3_]);
            _loc2_.retrieveBloontonium();
            _loc3_++;
         }
      }
      
      override public function clear() : void
      {
         var _loc2_:BloontoniumStats = null;
         var _loc1_:int = _items.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = _items[_loc3_];
            if(_loc2_.parent)
            {
               _loc2_.parent.removeChild(_loc2_);
            }
            _loc3_++;
         }
         super.clear();
      }
   }
}
