package ninjakiwi.monkeyTown.btdModule.utils
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import ninjakiwi.monkeyTown.btdModule.framework.Processable;
   
   public class GameSpeedTimer extends EventDispatcher implements Processable
   {
      
      public static const TIMER:String = "timer";
      
      public static const COMPLETE:String = "timerComplete";
      
      public static const DESTROYED:String = "timerDestroyed";
       
      
      public var delay:Number = 0;
      
      public var current:Number = 0;
      
      public var speedModifier:Number = 1.0;
      
      public var running:Boolean = false;
      
      public var repeat:int = 0;
      
      public var initialRepeat:int = 0;
      
      public var extra:Object = null;
      
      public function GameSpeedTimer(param1:Number = 0, param2:int = 1)
      {
         super();
         this.delay = param1;
         this.repeat = param2;
         this.initialRepeat = param2;
         this.start();
      }
      
      public static function btd4FramesToSeconds(param1:int) : Number
      {
         return param1 / 35;
      }
      
      public static function btd4FrameTime() : Number
      {
         return btd4FramesToSeconds(1);
      }
      
      public function initialise(param1:Number, param2:int = 1) : void
      {
         this.delay = param1;
         this.repeat = param2;
         this.initialRepeat = param2;
         this.speedModifier = 1;
         this.current = 0;
         this.running = false;
         this.start();
      }
      
      public function destroy() : void
      {
         dispatchEvent(new Event(DESTROYED));
      }
      
      public function start() : void
      {
         if(!this.running)
         {
            Main.instance.game.addProcessable(this);
            this.running = true;
         }
      }
      
      public function stop() : void
      {
         if(this.running)
         {
            Main.instance.game.cull(this);
            this.running = false;
         }
      }
      
      public function reset() : void
      {
         this.stop();
         this.current = 0;
         this.repeat = this.initialRepeat;
         this.speedModifier = 1;
         this.start();
      }
      
      public function process(param1:Number) : void
      {
         if(this.delay <= 0)
         {
            this.delay = 0.001;
         }
         this.current = this.current + param1 * this.speedModifier;
         while(this.current >= this.delay)
         {
            this.current = this.current - this.delay;
            dispatchEvent(new Event(TIMER));
            if(this.repeat != -1)
            {
               this.repeat--;
               if(this.repeat == 0)
               {
                  this.stop();
                  this.destroy();
               }
               dispatchEvent(new Event(COMPLETE));
            }
         }
      }
   }
}
