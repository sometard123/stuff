package ninjakiwi.monkeyTown.utils
{
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.net.URLRequest;
   
   public class LoadSwfUtil extends EventDispatcher
   {
       
      
      private var _loader:Loader = null;
      
      private var _progress:Number = 0;
      
      private var _callback:Function;
      
      private var _thisArg;
      
      public function LoadSwfUtil()
      {
         super();
      }
      
      public function load(param1:String, param2:Function = null, param3:* = null) : LoadSwfUtil
      {
         this._thisArg = param3;
         this._callback = param2;
         this.reset();
         this._loader = new Loader();
         var _loc4_:URLRequest = new URLRequest(param1);
         this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onCompleteHandler,false,0,true);
         this._loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.onProgressHandler,false,0,true);
         this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onIOError,false,0,true);
         this._loader.load(_loc4_);
         return this;
      }
      
      private function onIOError(param1:IOErrorEvent) : void
      {
      }
      
      private function onCompleteHandler(param1:Event) : void
      {
         if(this._callback !== null)
         {
            if(this._thisArg !== null)
            {
               this._callback.call(this._thisArg,param1.currentTarget.content);
            }
            else
            {
               this._callback(param1.currentTarget.content);
            }
         }
         this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onCompleteHandler);
         this._loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.onProgressHandler);
         this.dispatchEvent(param1);
      }
      
      private function onProgressHandler(param1:ProgressEvent) : void
      {
         this._progress = param1.bytesLoaded / param1.bytesTotal;
         this.dispatchEvent(param1);
      }
      
      private function reset() : void
      {
         if(this._loader)
         {
            this._loader.close();
         }
         this._loader = null;
         this._progress = 0;
      }
      
      public function get progress() : Number
      {
         return this._progress;
      }
   }
}
