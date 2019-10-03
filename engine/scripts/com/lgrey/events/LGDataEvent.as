package com.lgrey.events
{
   import flash.events.Event;
   
   public class LGDataEvent extends Event
   {
      
      public static const DEFAULT_NAME:String = "com.lgrey.events.LGDataEvent";
       
      
      public var data:Object;
      
      public function LGDataEvent(param1:String, param2:Object = null, param3:Boolean = true, param4:Boolean = true)
      {
         super(param1,param3,param4);
         this.data = param2;
      }
      
      override public function clone() : Event
      {
         return new LGDataEvent(type,this.data,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("DataEvent","data","type","bubbles","cancelable");
      }
   }
}
