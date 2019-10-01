package ninjakiwi.state
{
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class TimerState extends State
   {
       
      
      private var timer:Timer;
      
      public function TimerState(param1:String, param2:Number)
      {
         super(param1);
         this.timer = new Timer(param2 * 1000,1);
         this.timer.addEventListener(TimerEvent.TIMER_COMPLETE,this.timeUp);
      }
      
      override protected function enterActions() : void
      {
         if(!this.timer.running)
         {
            this.timer.reset();
            this.timer.start();
         }
      }
      
      override protected function exitActions() : void
      {
         this.timer.reset();
      }
      
      private function timeUp(param1:TimerEvent) : void
      {
         dispatchEvent(new Event(TimerEvent.TIMER_COMPLETE));
      }
   }
}
