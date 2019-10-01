package ninjakiwi.monkeyTown.friends
{
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.smallEvents.monkeyMerchant.MonkeyMerchantWare;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.AncientKnowledgePackAwarder;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.Awarder;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.BloonstonesAwarder;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.BossBaneAwarder;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.BossBlastAwarder;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.BossChillAwarder;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.BossWeakenAwarder;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.CashAwarder;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.CratesAwarder;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.KnowledgePackAwarder;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.MonkeyBoostAwarder;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.RedHotSpikesAwarder;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.WildcardKnowledgePackAwarder;
   import ninjakiwi.monkeyTown.town.specialItems.SpecialItemStore;
   
   public class UserInformationLoader
   {
       
      
      private var _urlreq:URLRequest;
      
      private var _loader:URLLoader;
      
      private var _callback:Function;
      
      public function UserInformationLoader(param1:String, param2:Function)
      {
         super();
         this._callback = param2;
         this.loadInformation(param1);
      }
      
      private function loadInformation(param1:String) : void
      {
         this._urlreq = new URLRequest(Constants.USER_INFORMATION_PATH_SERVICE + param1);
         this._urlreq.method = URLRequestMethod.GET;
         this._loader = new URLLoader(this._urlreq);
         this._loader.dataFormat = URLLoaderDataFormat.TEXT;
         this._loader.addEventListener(IOErrorEvent.IO_ERROR,this.onIOError,false,0,true);
         this._loader.addEventListener(Event.COMPLETE,this.onLoadURL,false,0,true);
         this._loader.load(this._urlreq);
      }
      
      private function onIOError(param1:IOErrorEvent) : void
      {
         this.destroy();
      }
      
      private function onLoadURL(param1:Event) : void
      {
         var data:Object = null;
         var e:Event = param1;
         try
         {
            data = JSON.parse(this._loader.data);
         }
         catch(e:Error)
         {
            data = null;
         }
         this.callCallback(data);
         this.destroy();
      }
      
      private function callCallback(param1:Object) : void
      {
         if(this._callback !== null)
         {
            this._callback(param1);
            this._callback = null;
         }
      }
      
      private function destroy() : void
      {
         this._loader.addEventListener(Event.COMPLETE,this.onLoadURL);
         this._loader.removeEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
         this._callback = null;
         this._urlreq = null;
         this._loader = null;
      }
   }
}
