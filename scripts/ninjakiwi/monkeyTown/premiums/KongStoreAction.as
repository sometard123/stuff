package ninjakiwi.monkeyTown.premiums
{
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.data.definitions.UpgradePathStateDefinition;
   import ninjakiwi.monkeyTown.town.data.definitions.UpgradeStateDefinition;
   import ninjakiwi.monkeyTown.userServices.kong.Kong;
   
   public class KongStoreAction
   {
      
      private static const _instances:Array = [];
       
      
      public var items:Array;
      
      public var result = null;
      
      public var success:Boolean = false;
      
      private var _callback:Function = null;
      
      public function KongStoreAction(param1:Array, param2:Function)
      {
         super();
         this.items = param1;
         this._callback = param2;
         Kong.purchaseItems(param1,this.onComplete);
         this.retain();
      }
      
      public function onComplete(param1:*) : void
      {
         t.obj(param1);
         this.result = param1;
         this.success = param1.success;
         this._callback(this);
         this.release();
      }
      
      private function retain() : void
      {
         _instances.push(this);
      }
      
      private function release() : void
      {
         var _loc1_:int = _instances.indexOf(this);
         if(_loc1_ >= 0)
         {
            _instances.splice(_loc1_,1);
         }
      }
   }
}
