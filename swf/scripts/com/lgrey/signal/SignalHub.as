package com.lgrey.signal
{
   import flash.utils.Dictionary;
   import org.osflash.signals.PrioritySignal;
   
   public class SignalHub
   {
      
      private static var instances:Dictionary = new Dictionary();
       
      
      private var signals:Dictionary;
      
      public function SignalHub()
      {
         this.signals = new Dictionary();
         super();
      }
      
      public static function getHub(param1:* = "defaultInstance") : SignalHub
      {
         var _loc2_:SignalHub = instances[param1];
         if(!_loc2_)
         {
            _loc2_ = instances[param1] = new SignalHub();
         }
         return _loc2_;
      }
      
      public function defineSignal(param1:*, ... rest) : PrioritySignal
      {
         var _loc3_:PrioritySignal = this.signals[param1];
         if(!_loc3_)
         {
            _loc3_ = this.signals[param1] = new PrioritySignal();
         }
         _loc3_.valueClasses = rest;
         return _loc3_;
      }
      
      public function add(param1:*, param2:Function) : PrioritySignal
      {
         var _loc3_:PrioritySignal = this.signals[param1];
         if(!_loc3_)
         {
            _loc3_ = this.signals[param1] = new PrioritySignal();
         }
         _loc3_.add(param2);
         return _loc3_;
      }
      
      public function addOnce(param1:*, param2:Function) : PrioritySignal
      {
         var _loc3_:PrioritySignal = this.signals[param1];
         if(!_loc3_)
         {
            _loc3_ = this.signals[param1] = new PrioritySignal();
         }
         _loc3_.addOnce(param2);
         return _loc3_;
      }
      
      public function remove(param1:*, param2:Function) : PrioritySignal
      {
         var _loc3_:PrioritySignal = this.signals[param1];
         if(_loc3_)
         {
            _loc3_.remove(param2);
         }
         return _loc3_;
      }
      
      public function dispatch(param1:*, ... rest) : PrioritySignal
      {
         var _loc3_:PrioritySignal = this.signals[param1];
         if(param1 === "DartMonkeyUpgrades")
         {
            if(!_loc3_)
            {
            }
         }
         if(_loc3_)
         {
            _loc3_.dispatch.apply(null,rest);
         }
         return _loc3_;
      }
      
      public function getSignal(param1:*) : PrioritySignal
      {
         var _loc2_:PrioritySignal = this.signals[param1];
         if(!_loc2_)
         {
            _loc2_ = this.signals[param1] = new PrioritySignal();
         }
         return _loc2_;
      }
      
      public function removeAllObservers() : void
      {
         var _loc1_:PrioritySignal = null;
         for each(_loc1_ in this.signals)
         {
            _loc1_.removeAll();
         }
      }
   }
}
