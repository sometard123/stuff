package ninjakiwi.mynk.net
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.system.ApplicationDomain;
   import flash.system.Capabilities;
   import flash.system.LoaderContext;
   import flash.system.Security;
   
   public class RemoteLoader extends EventDispatcher
   {
       
      
      protected var _config:RemoteLoaderConfig;
      
      protected var _remoteAPI:DisplayObject;
      
      protected var _container:DisplayObjectContainer;
      
      public function RemoteLoader(param1:String, param2:Object, param3:DisplayObjectContainer)
      {
         super();
         this._config = new RemoteLoaderConfig();
         this._config.url = param1;
         this._config.urlParams = this.parseParams(param2);
         this._container = param3;
      }
      
      public function load() : void
      {
         if(Capabilities.playerType !== "Desktop")
         {
            Security.allowDomain(this._config.url);
         }
         var _loc1_:URLRequest = new URLRequest(this._config.url);
         _loc1_.data = this._config.urlParams;
         var _loc2_:ApplicationDomain = new ApplicationDomain();
         var _loc3_:LoaderContext = new LoaderContext(false,_loc2_);
         var _loc4_:Loader = new Loader();
         _loc4_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadComplete);
         _loc4_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.loadFailed);
         _loc4_.load(_loc1_,_loc3_);
         if(this._container != null)
         {
            this._container.addChild(_loc4_);
         }
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
      
      private function loadComplete(param1:Event) : void
      {
         var _loc2_:LoaderInfo = param1.target as LoaderInfo;
         this._remoteAPI = _loc2_.content;
         dispatchEvent(param1);
      }
      
      private function loadFailed(param1:IOErrorEvent) : void
      {
         dispatchEvent(param1);
      }
      
      override public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         super.addEventListener(param1,param2,param3,param4,param5);
         if(this._container != null)
         {
            this._container.addEventListener(param1,param2,param3,param4,param5);
         }
      }
      
      override public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         super.removeEventListener(param1,param2,param3);
         if(this._container != null)
         {
            this._container.removeEventListener(param1,param2,param3);
         }
      }
   }
}

import flash.net.URLVariables;

class RemoteLoaderConfig
{
    
   
   public var url:String;
   
   public var urlParams:URLVariables;
   
   function RemoteLoaderConfig()
   {
      super();
   }
}
