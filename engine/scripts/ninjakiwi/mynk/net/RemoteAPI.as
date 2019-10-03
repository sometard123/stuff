package ninjakiwi.mynk.net
{
   public class RemoteAPI extends RemoteLoader
   {
       
      
      public function RemoteAPI(param1:RemoteAPIParams)
      {
         super(param1.url,param1.urlParams,param1.container);
      }
      
      public function call(param1:String, ... rest) : *
      {
         var functionName:String = param1;
         var args:Array = rest;
         var result:* = undefined;
         try
         {
            result = this.callFunctionOnObject(_remoteAPI,functionName,args);
         }
         catch(e:Error)
         {
         }
         return result;
      }
      
      public function callNested(param1:String, ... rest) : *
      {
         var names:Array = null;
         var resolvedObject:* = undefined;
         var i:int = 0;
         var name:String = null;
         var propertyNames:String = param1;
         var args:Array = rest;
         var result:* = undefined;
         try
         {
            names = propertyNames.split(".");
            resolvedObject = _remoteAPI;
            i = 0;
            while(i < names.length - 1)
            {
               name = names[i];
               resolvedObject = resolvedObject[name];
               i++;
            }
            result = this.callFunctionOnObject(resolvedObject,names[names.length - 1],args);
         }
         catch(e:Error)
         {
         }
         return result;
      }
      
      private function callFunctionOnObject(param1:*, param2:String, param3:Array) : *
      {
         var _loc4_:* = undefined;
         var _loc5_:Function = param1[param2];
         _loc4_ = _loc5_.apply(param1,param3);
         return _loc4_;
      }
   }
}
