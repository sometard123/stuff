package ninjakiwi.monkeyTown.town.ui.clock
{
   import com.greensock.TweenLite;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldView;
   import org.osflash.signals.Signal;
   
   public class ClockManager
   {
      
      public static const clockWasDestroyedSignal:Signal = new Signal(Clock);
       
      
      private var _container:DisplayObjectContainer;
      
      private var _clocks:Array;
      
      private const _system:MonkeySystem = MonkeySystem.getInstance();
      
      public function ClockManager(param1:DisplayObjectContainer)
      {
         this._clocks = new Array();
         super();
         this._container = param1;
      }
      
      public function process() : void
      {
         var _loc2_:Clock = null;
         var _loc1_:Number = this._system.getSecureTime();
         var _loc3_:int = 0;
         while(_loc3_ < this._clocks.length)
         {
            _loc2_ = this._clocks[_loc3_];
            if(_loc1_ - _loc2_.timeOfLastUpdate > 1000)
            {
               _loc2_.update(_loc1_);
            }
            _loc3_++;
         }
      }
      
      public function addClock(param1:Clock) : Clock
      {
         this._clocks.push(param1);
         this.updateClockPositions();
         param1.update(this._system.getSecureTime());
         WorldView.addOverlayFlashItems(param1);
         return param1;
      }
      
      public function clear() : void
      {
         var _loc1_:Clock = null;
         var _loc2_:int = 0;
         while(_loc2_ < this._clocks.length)
         {
            if(this._clocks[_loc2_].parent)
            {
               this._clocks[_loc2_].parent.removeChild(this._clocks[_loc2_]);
            }
            _loc2_++;
         }
         this._clocks.length = 0;
      }
      
      public function updateClockPositions() : void
      {
         var _loc1_:Clock = null;
         var _loc2_:int = this._clocks.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = this._clocks[_loc3_];
            _loc1_.syncPositionToTarget();
            _loc3_++;
         }
      }
      
      public function killClock(param1:Clock, param2:Boolean = true) : void
      {
         var _loc3_:int = 0;
         while(_loc3_ < this._clocks.length)
         {
            if(this._clocks[_loc3_] == param1)
            {
               if(param2)
               {
                  TweenLite.to(param1,0.5,{
                     "alpha":0,
                     "onComplete":this.removeClockFromContainer,
                     "onCompleteParams":[param1]
                  });
               }
               else
               {
                  this.removeClockFromContainer(param1);
               }
               this._clocks.splice(_loc3_,1);
               break;
            }
            _loc3_++;
         }
         ClockManager.clockWasDestroyedSignal.dispatch(param1);
      }
      
      protected function removeClockFromContainer(param1:Clock) : void
      {
         WorldView.removeOverlayFlashItem(param1);
      }
   }
}
