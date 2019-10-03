package ninjakiwi.monkeyTown.btdModule.utils
{
   public class GlobalTimerObject
   {
       
      
      private var _id:String;
      
      private var _timeLeft:int;
      
      private var _callback:Function;
      
      public function GlobalTimerObject(param1:String, param2:int, param3:Function)
      {
         super();
         this._id = param1;
         this._timeLeft = param2;
         this._callback = param3;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function get timeLeft() : int
      {
         return this._timeLeft;
      }
      
      public function get callback() : Function
      {
         return this._callback;
      }
      
      public function decreaseTime(param1:int) : void
      {
         this._timeLeft = this._timeLeft - param1;
      }
      
      public function resetTime(param1:int) : void
      {
         this._timeLeft = param1;
      }
   }
}
