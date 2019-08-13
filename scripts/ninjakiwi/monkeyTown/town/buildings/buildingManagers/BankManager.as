package ninjakiwi.monkeyTown.town.buildings.buildingManagers
{
   import com.lgrey.signal.SignalHub;
   import ninjakiwi.monkeyTown.town.buildings.customClasses.BankBuilding;
   import ninjakiwi.monkeyTown.town.data.definitions.ConfigData;
   import ninjakiwi.monkeyTown.town.management.Manager;
   import org.osflash.signals.PrioritySignal;
   import org.osflash.signals.Signal;
   
   public class BankManager extends Manager
   {
      
      public static const bankCapacityChangedSignal:PrioritySignal = new PrioritySignal();
      
      public static const bankCheckingSignal:Signal = new Signal(Function);
       
      
      private const _config:ConfigData = ConfigData.getInstance();
      
      public var capacity:int;
      
      private const _hubResources:SignalHub = SignalHub.getHub("resources");
      
      public var maximumMoneyChangedSignal:Signal;
      
      public function BankManager()
      {
         this.capacity = this._config.startingMoney;
         this.maximumMoneyChangedSignal = this._hubResources.defineSignal("maximumMoneyChanged");
         super();
         validType = BankBuilding;
      }
      
      public function recalculateMaximumCapacity() : int
      {
         var _loc2_:BankBuilding = null;
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
         bankCapacityChangedSignal.dispatch();
         return _loc3_;
      }
      
      public function getMaximumPillage() : int
      {
         var bank:BankBuilding = null;
         var totalPillage:int = 0;
         totalPillage = 0;
         var portionOfCapacityToCount:Number = 0.5;
         var i:int = 0;
         while(i < _items.length)
         {
            bank = _items[i];
            if(bank.buildComplete)
            {
               portionOfCapacityToCount = 0.5;
               if(bank.tier === 2)
               {
                  portionOfCapacityToCount = 0.4;
               }
               else if(bank.tier === 3)
               {
                  portionOfCapacityToCount = 0.33;
               }
               else if(bank.tier === 4)
               {
                  portionOfCapacityToCount = 0.25;
               }
               else if(bank.tier > 4)
               {
                  portionOfCapacityToCount = 0.2;
               }
               totalPillage = totalPillage + bank.upgradeableValue * portionOfCapacityToCount;
            }
            i++;
         }
         BankManager.bankCheckingSignal.dispatch(function(param1:int):void
         {
            totalPillage = totalPillage + param1 * 0.5;
         });
         if(totalPillage <= 0)
         {
         }
         return totalPillage;
      }
      
      override public function register(param1:*) : Boolean
      {
         var _loc2_:Boolean = super.register(param1);
         if(_loc2_)
         {
            this.recalculateMaximumCapacity();
            this.maximumMoneyChangedSignal.dispatch(this.capacity);
         }
         return _loc2_;
      }
      
      override public function deregister(param1:*) : Boolean
      {
         var _loc2_:Boolean = super.deregister(param1);
         if(_loc2_)
         {
            this.recalculateMaximumCapacity();
            this.maximumMoneyChangedSignal.dispatch(this.capacity);
         }
         return _loc2_;
      }
      
      override public function clear() : void
      {
         super.clear();
         this.capacity = this._config.startingMoney;
      }
   }
}
