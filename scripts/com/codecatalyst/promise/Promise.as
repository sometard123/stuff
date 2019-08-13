package com.codecatalyst.promise
{
   public class Promise
   {
      
      private static const adapters:Array = [];
       
      
      private var resolver:Resolver;
      
      public function Promise(param1:Resolver)
      {
         super();
         this.resolver = param1;
      }
      
      public static function when(param1:*) : Promise
      {
         var _loc2_:Function = null;
         var _loc3_:Deferred = null;
         var _loc4_:Promise = null;
         for each(_loc2_ in adapters)
         {
            _loc4_ = _loc2_(param1) as Promise;
            if(_loc4_)
            {
               return _loc4_;
            }
         }
         _loc3_ = new Deferred();
         _loc3_.resolve(param1);
         return _loc3_.promise;
      }
      
      public static function registerAdapter(param1:Function) : void
      {
         if(adapters.indexOf(param1) == -1)
         {
            adapters.push(param1);
         }
      }
      
      public static function unregisterAdapter(param1:Function) : void
      {
         var _loc2_:int = adapters.indexOf(param1);
         if(_loc2_ > -1)
         {
            adapters.splice(_loc2_,1);
         }
      }
      
      public function then(param1:Function = null, param2:Function = null) : Promise
      {
         return this.resolver.then(param1,param2);
      }
   }
}
