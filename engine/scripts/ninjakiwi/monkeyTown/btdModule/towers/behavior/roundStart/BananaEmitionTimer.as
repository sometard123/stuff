package ninjakiwi.monkeyTown.btdModule.towers.behavior.roundStart
{
   import flash.events.Event;
   import ninjakiwi.monkeyTown.btdModule.entities.Banana;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.utils.GameSpeedTimer;
   
   public class BananaEmitionTimer
   {
       
      
      private var tower:Tower = null;
      
      private var timer:GameSpeedTimer = null;
      
      private var cash:int = 0;
      
      private var lifespan:Number = 0;
      
      private var emitter:BananaEmitter = null;
      
      private var asset:Class = null;
      
      public var cancelable:Boolean = true;
      
      public function BananaEmitionTimer()
      {
         super();
      }
      
      public function initialise(param1:Tower, param2:Number, param3:int, param4:Number, param5:Class, param6:BananaEmitter = null) : void
      {
         this.tower = param1;
         this.cash = param3;
         this.lifespan = param4;
         this.emitter = param6;
         this.asset = param5;
         this.timer = new GameSpeedTimer(param2);
         this.timer.addEventListener(GameSpeedTimer.COMPLETE,this.emit);
      }
      
      public function cancel() : void
      {
         if(this.cancelable)
         {
            this.timer.stop();
            this.timer.removeEventListener(GameSpeedTimer.COMPLETE,this.emit);
         }
      }
      
      public function emit(param1:Event) : void
      {
         var _loc2_:Banana = null;
         if(this.emitter == null)
         {
            _loc2_ = new Banana();
            _loc2_.initialise(this.tower,this.cash,this.lifespan,this.asset);
            _loc2_.x = this.tower.x;
            _loc2_.y = this.tower.y;
            this.tower.level.addEntity(_loc2_);
            BananaEmitter.addBanana(_loc2_);
            this.timer.removeEventListener(GameSpeedTimer.COMPLETE,this.emit);
         }
         else
         {
            this.emitter.setBankedFunds(this.emitter.getBankedFunds(this.tower) + this.cash,this.tower);
            this.tower.dispatchEvent(new PropertyModEvent("funds"));
         }
      }
   }
}
