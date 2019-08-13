package ninjakiwi.monkeyTown.userServices
{
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.common.ConfigureDeployConstants;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.userServices.kong.Kong;
   
   public class UserServicesHelper
   {
      
      private static var _rootDisplayObject:DisplayObjectContainer = null;
       
      
      public function UserServicesHelper()
      {
         super();
      }
      
      public static function configure(param1:DisplayObjectContainer) : void
      {
         _rootDisplayObject = param1;
         var _loc2_:Object = param1.root.loaderInfo.parameters;
         switch(_loc2_.userServices)
         {
            case "kong":
               if(Constants.DEPLOY_STATE == ConfigureDeployConstants.PRODUCTION)
               {
                  Constants.DEPLOY_STATE = ConfigureDeployConstants.PRODUCTION_KONG;
                  ConfigureDeployConstants.configure(Constants.DEPLOY_STATE);
               }
               Constants.USER_SERVICES = Constants.USER_SERVICES_KONG;
               Kong.initialise(param1);
               break;
            default:
               Constants.USER_SERVICES = Constants.USER_SERVICES_NK;
         }
      }
   }
}
