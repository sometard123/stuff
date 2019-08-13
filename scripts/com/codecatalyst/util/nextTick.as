package com.codecatalyst.util
{
   public function nextTick(param1:Function, param2:Array = null) : void
   {
      CallbackQueue.instance.schedule(param1,param2);
   }
}

import flash.utils.clearInterval;
import flash.utils.setInterval;

class CallbackQueue
{
   
   public static const instance:CallbackQueue = new CallbackQueue();
    
   
   protected const queuedCallbacks:Array = [];
   
   protected var intervalId:int = 0;
   
   function CallbackQueue()
   {
      super();
   }
   
   public function schedule(param1:Function, param2:Array = null) : void
   {
      this.queuedCallbacks.push(new Callback(param1,param2));
      if(this.queuedCallbacks.length == 1)
      {
         this.intervalId = setInterval(this.execute,0);
      }
   }
   
   protected function execute() : void
   {
      var _loc1_:Callback = null;
      clearInterval(this.intervalId);
      for each(_loc1_ in this.queuedCallbacks)
      {
         _loc1_.execute();
      }
      this.queuedCallbacks.length = 0;
   }
}

class Callback
{
    
   
   protected var closure:Function;
   
   protected var parameters:Array;
   
   function Callback(param1:Function, param2:Array = null)
   {
      super();
      this.closure = param1;
      this.parameters = param2;
   }
   
   public function execute() : void
   {
      this.closure.apply(null,this.parameters);
   }
}
