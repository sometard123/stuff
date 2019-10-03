package ninjakiwi.monkeyTown.town.buildings.buildingManagers
{
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.buildings.customClasses.IPowerSource;
   import ninjakiwi.monkeyTown.town.data.definitions.ConfigData;
   import ninjakiwi.monkeyTown.town.management.Manager;
   import org.osflash.signals.Signal;
   
   public class PowerSourceManager extends Manager
   {
       
      
      private const _system:MonkeySystem = MonkeySystem.getInstance();
      
      private var _totalPower:int;
      
      private var _config:ConfigData;
      
      public var totalPowerChangedSignal:Signal;
      
      public function PowerSourceManager()
      {
         this._config = ConfigData.getInstance();
         this.totalPowerChangedSignal = new Signal(int);
         super();
         validType = IPowerSource;
      }
      
      public function get totalPowerGenerated() : int
      {
         return this._totalPower;
      }
      
      public function addPowerFromUpgrade(param1:int) : void
      {
         var _loc2_:int = this._totalPower;
         this._totalPower = this._totalPower + param1;
         this.totalPowerChangedSignal.dispatch(this._totalPower);
         GameSignals.POWER_CHANGED.dispatch(this._totalPower);
         GameSignals.POWER_CHANGED_DIFF.dispatch(this._totalPower - _loc2_);
      }
      
      override public function register(param1:*) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:Building = null;
         var _loc5_:IPowerSource = null;
         var _loc2_:Boolean = super.register(param1);
         if(_loc2_)
         {
            _loc3_ = this._totalPower;
            _loc4_ = Building(param1);
            _loc5_ = IPowerSource(_loc4_);
            this._totalPower = this._totalPower + _loc5_.power;
            this.totalPowerChangedSignal.dispatch(this._totalPower);
            GameSignals.POWER_CHANGED.dispatch(this._totalPower);
            GameSignals.POWER_CHANGED_DIFF.dispatch(this._totalPower - _loc3_);
         }
         return _loc2_;
      }
      
      override public function deregister(param1:*) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:IPowerSource = null;
         var _loc2_:Boolean = super.deregister(param1);
         if(_loc2_)
         {
            _loc3_ = this._totalPower;
            _loc4_ = IPowerSource(param1);
            if(Building(_loc4_).buildComplete)
            {
               this._totalPower = this._totalPower - _loc4_.power;
               this.totalPowerChangedSignal.dispatch(this._totalPower);
               GameSignals.POWER_CHANGED.dispatch(this._totalPower);
               GameSignals.POWER_CHANGED_DIFF.dispatch(this._totalPower - _loc3_);
            }
         }
         return _loc2_;
      }
      
      override public function clear() : void
      {
         super.clear();
         this._totalPower = 0;
      }
   }
}
