package com.codecatalyst.promise
{
   import com.codecatalyst.util.nextTick;
   
   class Resolver
   {
       
      
      private var _promise:Promise = null;
      
      private var onResolved:Function = null;
      
      private var onRejected:Function = null;
      
      private var pendingResolvers:Array;
      
      private var processed:Boolean = false;
      
      private var completed:Boolean = false;
      
      private var completionAction:String = null;
      
      private var completionValue;
      
      function Resolver(param1:Function = null, param2:Function = null)
      {
         this.pendingResolvers = [];
         super();
         this.onResolved = param1;
         this.onRejected = param2 || this.defaultRejectionHandler;
         this._promise = new Promise(this);
      }
      
      public function get promise() : Promise
      {
         return this._promise;
      }
      
      public function resolve(param1:*) : void
      {
         if(!this.processed)
         {
            this.process(this.onResolved,param1);
         }
      }
      
      public function reject(param1:*) : void
      {
         if(!this.processed)
         {
            this.process(this.onRejected,param1);
         }
      }
      
      public function then(param1:Function = null, param2:Function = null) : Promise
      {
         var _loc3_:Resolver = null;
         if(param1 != null || param2 != null)
         {
            _loc3_ = new Resolver(param1,param2);
            nextTick(this.schedule,[_loc3_]);
            return _loc3_.promise;
         }
         return this.promise;
      }
      
      private function propagate() : void
      {
         var _loc1_:Resolver = null;
         for each(_loc1_ in this.pendingResolvers)
         {
            _loc1_[this.completionAction](this.completionValue);
         }
         this.pendingResolvers = [];
      }
      
      private function schedule(param1:Resolver) : void
      {
         this.pendingResolvers.push(param1);
         if(this.completed)
         {
            this.propagate();
         }
      }
      
      private function complete(param1:String, param2:*) : void
      {
         this.onResolved = null;
         this.onRejected = null;
         this.completionAction = param1;
         this.completionValue = param2;
         this.completed = true;
         this.propagate();
      }
      
      private function completeResolved(param1:*) : void
      {
         this.complete("resolve",param1);
      }
      
      private function completeRejected(param1:*) : void
      {
         this.complete("reject",param1);
      }
      
      private function process(param1:Function, param2:*) : void
      {
         var callback:Function = param1;
         var value:* = param2;
         this.processed = true;
         try
         {
            if(callback != null)
            {
               value = callback.length == 0?callback():callback(value);
            }
            if(value != null && "then" in value && value.then is Function)
            {
               value.then(this.completeResolved,this.completeRejected);
            }
            else
            {
               this.completeResolved(value);
            }
            return;
         }
         catch(error:*)
         {
            completeRejected(error);
            return;
         }
      }
      
      private function defaultRejectionHandler(param1:*) : void
      {
         throw param1;
      }
   }
}
