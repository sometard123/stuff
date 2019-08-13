package ninjakiwi.monkeyTown.net
{
   import flash.events.Event;
   import flash.net.URLRequestMethod;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.net.JSONRequest;
   
   public class PreBTDServerCheck extends MaintenanceChecker
   {
       
      
      public function PreBTDServerCheck(param1:Function)
      {
         super(param1);
      }
      
      override public function checkStatus() : void
      {
         _request = new JSONRequest(Constants.SERVER_STATUS_URL,null,function serverStatusCheckComplete(param1:Object):void
         {
            removeListeners();
            var _loc2_:* = param1.status === STATUS_PREMAINTENANCE || param1.enableMvM === false;
            var _loc3_:* = param1.status === STATUS_PREMAINTENANCE;
            var _loc4_:* = {
               "mvmIsDisabled":_loc2_,
               "preMaintenance":_loc3_
            };
            report(_loc4_);
         },URLRequestMethod.GET);
         _request.addEventListener(JSONRequest.FAILED,this.failureHandler);
         _request.go();
      }
      
      private function report(param1:Object) : void
      {
         if(_callback !== null)
         {
            _callback(param1);
         }
      }
      
      override protected function failureHandler(param1:Event) : void
      {
         removeListeners();
         this.report({
            "mvmIsDisabled":false,
            "preMaintenance":false
         });
      }
   }
}
