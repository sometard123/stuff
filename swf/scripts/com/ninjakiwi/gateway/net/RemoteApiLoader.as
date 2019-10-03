package com.ninjakiwi.gateway.net
{
   import com.codecatalyst.promise.Deferred;
   import com.codecatalyst.promise.Promise;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.system.Security;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BloonWeightsDefinition;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.townMap.bloonPredictor.BloonPredictor;
   import ninjakiwi.monkeyTown.utils.Calculator;
   
   public class RemoteApiLoader
   {
       
      
      protected const _config:RemoteApiLoaderConfig = new RemoteApiLoaderConfig();
      
      public function RemoteApiLoader(param1:String, param2:Object, param3:String = null)
      {
         super();
         if(param1 == null || param2 == null)
         {
            throw new UninitializedError("RemoteApiLoader::RemoteApiLoader( ) - required argument was null");
         }
         this._config.url = param1;
         this._config.urlParams = this.parseParams(param2);
         this._config.policyUrl = param3;
      }
      
      private function parseParams(param1:Object) : URLVariables
      {
         var _loc3_:* = null;
         var _loc2_:URLVariables = new URLVariables();
         for(_loc3_ in param1)
         {
            _loc2_[_loc3_] = param1[_loc3_];
         }
         return _loc2_;
      }
      
      public function load() : Promise
      {
         var result:Deferred = null;
         var loader:Loader = null;
         result = new Deferred();
         try
         {
            Security.allowDomain(this._config.url);
         }
         catch(err:Error)
         {
         }
         if(this._config.policyUrl != null)
         {
            Security.loadPolicyFile(this._config.policyUrl);
         }
         var request:URLRequest = new URLRequest(this._config.url);
         request.data = this._config.urlParams;
         var newAppDomain:ApplicationDomain = new ApplicationDomain();
         var context:LoaderContext = new LoaderContext(false,newAppDomain);
         loader = new Loader();
         loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function loadComplete(param1:Event):void
         {
            result.resolve(loader.content);
         });
         with({})
         {
            
            loadFailed = function(param1:IOErrorEvent):void
            {
               result.reject(param1);
            };
         }
         loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,function(param1:IOErrorEvent):void
         {
            result.reject(param1);
         });
         loader.load(request,context);
         return result.promise;
      }
   }
}

class RemoteApiLoaderConfig
{
    
   
   public var url:String;
   
   public var urlParams:Object;
   
   public var policyUrl:String;
   
   function RemoteApiLoaderConfig()
   {
      super();
   }
}
