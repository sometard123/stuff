package ninjakiwi.monkeyTown.net.kloud
{
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import ninjakiwi.monkeyTown.common.Constants;
   
   public class FriendsListLoader
   {
       
      
      private var urlreq:URLRequest;
      
      private var loader:URLLoader;
      
      private var onCompleteCallback:Function = null;
      
      public function FriendsListLoader(param1:String, param2:Function)
      {
         super();
         this.onCompleteCallback = param2;
         this.load(param1);
      }
      
      private function load(param1:String) : void
      {
         this.urlreq = new URLRequest(Constants.FRIENDS_LIST_API_URL + param1 + "/friends");
         this.urlreq.method = URLRequestMethod.GET;
         this.loader = new URLLoader(this.urlreq);
         this.loader.dataFormat = URLLoaderDataFormat.TEXT;
         this.loader.addEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
         this.loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.securityErrorHandler);
         this.loader.addEventListener(Event.COMPLETE,this.onLoaded);
         this.loader.load(this.urlreq);
      }
      
      private function removeListeners() : void
      {
         this.loader.removeEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
         this.loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.securityErrorHandler);
         this.loader.removeEventListener(Event.COMPLETE,this.onLoaded);
      }
      
      private function destroy() : void
      {
         this.removeListeners();
         this.urlreq = null;
         this.loader = null;
         this.onCompleteCallback = null;
      }
      
      private function onIOError(param1:IOErrorEvent) : void
      {
         this.callCallback([]);
         this.destroy();
      }
      
      private function securityErrorHandler(param1:SecurityErrorEvent) : void
      {
         this.callCallback([]);
         this.destroy();
      }
      
      private function onLoaded(param1:Event) : void
      {
         var e:Event = param1;
         var data:Object = [];
         try
         {
            data = JSON.parse(this.loader.data);
         }
         catch(e:Error)
         {
         }
         if(data === null)
         {
            this.callCallback([]);
         }
         else
         {
            this.callCallback(data);
         }
         this.destroy();
      }
      
      private function callCallback(param1:Object) : void
      {
         this.onCompleteCallback(param1);
      }
   }
}
