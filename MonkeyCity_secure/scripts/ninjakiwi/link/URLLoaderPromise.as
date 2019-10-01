package ninjakiwi.link
{
   import com.codecatalyst.promise.Deferred;
   import com.codecatalyst.promise.Promise;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class URLLoaderPromise
   {
       
      
      private var _request:URLRequest;
      
      public function URLLoaderPromise(param1:URLRequest)
      {
         super();
         this._request = param1;
      }
      
      public function load() : Promise
      {
         var deferred:Deferred = null;
         deferred = new Deferred();
         var loader:URLLoader = new URLLoader();
         loader.addEventListener(Event.COMPLETE,function(param1:Event):void
         {
            var _loc2_:URLLoader = URLLoader(param1.target);
            deferred.resolve(_loc2_.data);
         },false,0,true);
         loader.addEventListener(IOErrorEvent.IO_ERROR,function(param1:IOErrorEvent):void
         {
            deferred.reject(new Error("IO Error"));
         },false,0,true);
         loader.load(this._request);
         return deferred.promise;
      }
   }
}
