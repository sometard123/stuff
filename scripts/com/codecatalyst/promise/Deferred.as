package com.codecatalyst.promise
{
   public class Deferred
   {
       
      
      protected var resolver:Resolver;
      
      public function Deferred()
      {
         super();
         this.resolver = new Resolver();
      }
      
      public function get promise() : Promise
      {
         return this.resolver.promise;
      }
      
      public function resolve(param1:*) : void
      {
         this.resolver.resolve(param1);
      }
      
      public function reject(param1:*) : void
      {
         this.resolver.reject(param1);
      }
   }
}
