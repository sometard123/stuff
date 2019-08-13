package ninjakiwi.monkeyTown.common.events
{
   import flash.events.Event;
   
   public class GameEvent extends Event
   {
      
      public static const DEFAULT_NAME:String = "com.lgrey.events.GameEvent";
      
      public static const PRE_DRAW:String = "preDraw";
      
      public static const PRE_PROCESS:String = "preProcess";
       
      
      public var data:Object;
      
      public function GameEvent(param1:String, param2:Object = null, param3:Boolean = true, param4:Boolean = true)
      {
         super(param1,param3,param4);
         this.data = param2;
      }
      
      override public function clone() : Event
      {
         return new GameEvent(type,this.data,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("DataEvent","data","type","bubbles","cancelable");
      }
   }
}
