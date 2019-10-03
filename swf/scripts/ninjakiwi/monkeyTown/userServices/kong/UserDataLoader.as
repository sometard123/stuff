package ninjakiwi.monkeyTown.userServices.kong
{
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import ninjakiwi.monkeyTown.smallEvents.bloonstoneSpendEvent.BloonstoneSpendRewardDef;
   
   public class UserDataLoader
   {
      
      private static const _instances:Array = [];
       
      
      private var _friendListloader:URLLoader = null;
      
      private var _callback:Function = null;
      
      public function UserDataLoader(param1:Function)
      {
         super();
         this._callback = param1;
         var _loc2_:* = "https://api.kongregate.com/api/user_info.json?user_id=" + Kong.getKongUserId() + "&friends=true";
         var _loc3_:URLRequest = new URLRequest(_loc2_);
         _loc3_.method = URLRequestMethod.GET;
         this._friendListloader = new URLLoader(_loc3_);
         this._friendListloader.dataFormat = URLLoaderDataFormat.TEXT;
         this._friendListloader.addEventListener(IOErrorEvent.IO_ERROR,this.onIOError,false,0,true);
         this._friendListloader.addEventListener(Event.COMPLETE,this.onLoadComplete,false,0,true);
         this._friendListloader.load(_loc3_);
         this.retain();
      }
      
      private function onLoadComplete(param1:Event) : void
      {
         var data:Object = null;
         var e:Event = param1;
         try
         {
            data = JSON.parse(this._friendListloader.data);
         }
         catch(e:Error)
         {
            _callback(null);
            release();
            return;
         }
         this._callback(data);
         this.release();
      }
      
      private function onIOError(param1:IOErrorEvent) : void
      {
         this.release();
      }
      
      private function retain() : void
      {
         _instances.push(this);
      }
      
      private function release() : void
      {
         this._callback = null;
         this._friendListloader = null;
         var _loc1_:int = _instances.indexOf(this);
         if(_loc1_ >= 0)
         {
            _instances.splice(_loc1_,1);
         }
      }
   }
}
