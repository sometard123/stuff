package com.ninjakiwi.gateway.net
{
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import ninjakiwi.data.DGData;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.sku.urlLoader;
   
   public class Api
   {
       
      
      protected var _api:Object;
      
      public function Api(param1:Object)
      {
         super();
         this._api = param1;
      }
      
      public function getProperty(param1:String) : *
      {
         var _loc2_:ObjectNamePair = this.resolve(this._api,param1);
         return _loc2_.object[_loc2_.name];
      }
      
      public function setProperty(param1:String, param2:*) : void
      {
         var _loc3_:ObjectNamePair = this.resolve(this._api,param1);
         _loc3_.object[_loc3_.name] = param2;
      }
      
      public function call(param1:String, ... rest) : *
      {
         var _loc3_:ObjectNamePair = this.resolve(this._api,param1);
         var _loc4_:Function = _loc3_.object[_loc3_.name];
         return _loc4_.apply(_loc3_.object,rest);
      }
      
      private function resolve(param1:Object, param2:String) : ObjectNamePair
      {
         var _loc6_:String = null;
         var _loc3_:* = param1;
         var _loc4_:Array = param2.split(".");
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.length - 1)
         {
            _loc6_ = _loc4_[_loc5_];
            _loc3_ = _loc3_[_loc6_];
            _loc5_++;
         }
         return new ObjectNamePair(_loc3_,_loc4_[_loc4_.length - 1]);
      }
      
      private function callFunctionOnObject(param1:*, param2:String, param3:Array) : *
      {
         var _loc4_:Function = param1[param2];
         return _loc4_.apply(param1,param3);
      }
   }
}

class ObjectNamePair
{
    
   
   public var object:Object;
   
   public var name:String;
   
   function ObjectNamePair(param1:Object, param2:String)
   {
      super();
      this.object = param1;
      this.name = param2;
   }
}
