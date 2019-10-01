package ninjakiwi.monkeyTown.common
{
   import com.lgrey.utils.Enumerator;
   import ninjakiwi.monkeyTown.utils.ErrorReporter;
   
   public class ConfigureDeployConstants
   {
      
      public static const LOCAL_SERVER_STAGING_LOGIN:int = Enumerator.getID(ConfigureDeployConstants);
      
      public static const LOCAL_SERVER_PRODUCTION_LOGIN:int = Enumerator.getID(ConfigureDeployConstants);
      
      public static const KAIPARASOFT_STAGING:int = Enumerator.getID(ConfigureDeployConstants);
      
      public static const KAIPARASOFT_LIVE:int = Enumerator.getID(ConfigureDeployConstants);
      
      public static const STAGING:int = Enumerator.getID(ConfigureDeployConstants);
      
      public static const STAGING_STANDALONE:int = Enumerator.getID(ConfigureDeployConstants);
      
      public static const INTRANET_STAGING_LOGIN:int = Enumerator.getID(ConfigureDeployConstants);
      
      public static const INTRANET_LIVE_LOGIN:int = Enumerator.getID(ConfigureDeployConstants);
      
      public static const LOCAL_MULTICITY:int = Enumerator.getID(ConfigureDeployConstants);
      
      public static const DEVELOPMENT_STAGING:int = Enumerator.getID(ConfigureDeployConstants);
      
      public static const DEVELOPMENT_LIVE:int = Enumerator.getID(ConfigureDeployConstants);
      
      public static const BAR_TEST:int = Enumerator.getID(ConfigureDeployConstants);
      
      public static const CUSTOM_IP_STAGING_LOGIN:int = Enumerator.getID(ConfigureDeployConstants);
      
      public static const CUSTOM_IP_PRODUCTION_LOGIN:int = Enumerator.getID(ConfigureDeployConstants);
      
      public static const KONG_TEST_STAGING:int = Enumerator.getID(ConfigureDeployConstants);
      
      public static const PRODUCTION:int = Enumerator.getID(ConfigureDeployConstants);
      
      public static const PRODUCTION_KONG:int = Enumerator.getID(ConfigureDeployConstants);
      
      public static const PRODUCTION_STANDALONE:int = Enumerator.getID(ConfigureDeployConstants);
       
      
      public function ConfigureDeployConstants()
      {
         super();
      }
      
      public static function configure(param1:int) : void
      {
         ErrorReporter.externalLog("Build is DEBUG:",false);
         switch(param1)
         {
            case PRODUCTION:
               ErrorReporter.externalLog("Using Production environment");
               Constants.BTD_MODULE_URL = "btd_module_secure.swf";
               Constants.NK_BAR_URL = "https://assets.nkstatic.com/nklogin/nkBar.swf";
               Constants.NK_LOGIN_URL = "https://www.ninjakiwi.com/logged_in";
               Constants.NK_STORE_URL = "https://www.ninjakiwi.com/getcoins/";
               Constants.USER_INFORMATION_PATH_SERVICE = "https://www.ninjakiwi.com/api/v1/users/";
               Constants.FRIENDS_LIST_API_URL = "https://www.ninjakiwi.com/api/v1/users/";
               Constants.PROFILE_URL_BASE = "https://www.ninjakiwi.com/profile/";
               Constants.BASE_PATH = "https://assets.nkstatic.com/Games/gameswfs/monkeycity/";
               Constants.KLOUD_HOST = "https://web-monkey-city.ninjakiwi.com/monkeycity/";
               Constants.AUDIO_PATH = "https://assets.nkstatic.com/Games/gameswfs/monkeycity/audio/";
               Constants.SERVER_STATUS_URL = "https://static-api.ninjakiwi.com/appdocs/7/appdocs/server_status.json";
               Constants.MODIFIER_DATA_URL = "https://static-api.ninjakiwi.com/appdocs/7/appdocs/modifiers.json";
               Constants.SKU_URL = Constants.SKU_URL_PRODUCTION;
               Constants.ENABLE_REQUEST_LOGGING = false;
               break;
            case PRODUCTION_KONG:
               ErrorReporter.externalLog("Using Production environment");
               Constants.BTD_MODULE_URL = "btd_module_secure.swf";
               Constants.NK_BAR_URL = "https://assets.nkstatic.com/nklogin/nkBar.swf";
               Constants.NK_LOGIN_URL = "https://www.ninjakiwi.com/logged_in";
               Constants.NK_STORE_URL = "https://www.ninjakiwi.com/getcoins/";
               Constants.USER_INFORMATION_PATH_SERVICE = "https://www.ninjakiwi.com/api/v1/users/";
               Constants.FRIENDS_LIST_API_URL = "https://www.ninjakiwi.com/api/v1/users/";
               Constants.PROFILE_URL_BASE = "https://www.ninjakiwi.com/profile/";
               Constants.BASE_PATH = "https://assets.nkstatic.com/Games/gameswfs/monkeycity/";
               Constants.KLOUD_HOST = "https://web-monkey-city.ninjakiwi.com/monkeycity/";
               Constants.AUDIO_PATH = "https://assets.nkstatic.com/Games/gameswfs/monkeycity/audio/";
               Constants.SERVER_STATUS_URL = "https://static-api.ninjakiwi.com/appdocs/7/appdocs/server_status.json";
               Constants.MODIFIER_DATA_URL = "https://static-api.ninjakiwi.com/appdocs/7/appdocs/modifiers.json";
               Constants.SKU_URL = Constants.SKU_URL_PRODUCTION;
               Constants.ENABLE_REQUEST_LOGGING = false;
               break;
            case PRODUCTION_STANDALONE:
               ErrorReporter.externalLog("Using Production standalone environment");
               Constants.BTD_MODULE_URL = "btd_module.swf";
               Constants.NK_BAR_URL = "https://assets.nkstatic.com/nklogin/nkBar.swf";
               Constants.NK_LOGIN_URL = "https://www.ninjakiwi.com/logged_in";
               Constants.NK_STORE_URL = "https://www.ninjakiwi.com/getcoins/";
               Constants.USER_INFORMATION_PATH_SERVICE = "https://www.ninjakiwi.com/api/v1/users/";
               Constants.FRIENDS_LIST_API_URL = "https://www.ninjakiwi.com/api/v1/users/";
               Constants.PROFILE_URL_BASE = "https://www.ninjakiwi.com/profile/";
               Constants.KLOUD_HOST = "https://web-monkey-city.ninjakiwi.com/monkeycity/";
               Constants.BASE_PATH = "./";
               Constants.AUDIO_PATH = "./audio/";
               Constants.SERVER_STATUS_URL = "./server_status.json";
               Constants.MODIFIER_DATA_URL = "https://nkapi-user-documents-production.s3.amazonaws.com/appdocs/7/appdocs/modifiers.json";
               Constants.SKU_URL = Constants.SKU_URL_PRODUCTION;
               Constants.ENABLE_REQUEST_LOGGING = true;
               Constants.SKU_URL = Constants.SKU_URL_PRODUCTION;
               break;
            case STAGING:
               ErrorReporter.externalLog("Using Staging environment");
               Constants.BASE_PATH = "https://assets.nkstatic.com/Games/gameswfs/mc45/";
               Constants.NK_BAR_URL = "https://assets.nkstatic.com/nklogin/staging-nkBar.swf";
               Constants.NK_LOGIN_URL = "https://staging.ninjakiwi.com/logged_in";
               Constants.NK_STORE_URL = "https://staging.ninjakiwi.com/getcoins/";
               Constants.USER_INFORMATION_PATH_SERVICE = "https://staging.ninjakiwi.com/api/v1/users/";
               Constants.SERVER_STATUS_URL = "https://static-api.ninjakiwi.com/appdocs/7/appdocs/server_status_staging.json";
               Constants.MODIFIER_DATA_URL = "https://static-api-staging.ninjakiwi.com/appdocs/7/appdocs/modifiers.json";
               Constants.BTD_MODULE_URL = "btd_module_secure.swf";
               Constants.AUDIO_PATH = "https://assets.nkstatic.com/Games/gameswfs/mc45/audio/";
               Constants.FRIENDS_LIST_API_URL = "https://staging.ninjakiwi.com/api/v1/users/";
               Constants.PROFILE_URL_BASE = "https://staging.ninjakiwi.com/profile/";
               Constants.ENABLE_REQUEST_LOGGING = true;
               Constants.KLOUD_HOST = "https://web-monkey-city-staging.ninjakiwi.com/monkeycity/";
               Constants.NEWS_DATA_URL = Constants.NEWS_DATA_STAGING_URL;
               Constants.SKU_URL = Constants.SKU_URL_STAGING;
               break;
            case STAGING_STANDALONE:
               ErrorReporter.externalLog("Using Staging standalone environment");
               Constants.BASE_PATH = "./";
               Constants.BTD_MODULE_URL = "btd_module.swf";
               Constants.NK_BAR_URL = "https://assets.nkstatic.com/nklogin/staging-nkBar.swf";
               Constants.NK_LOGIN_URL = "https://staging.ninjakiwi.com/logged_in";
               Constants.NK_STORE_URL = "https://staging.ninjakiwi.com/getcoins/";
               Constants.USER_INFORMATION_PATH_SERVICE = "https://staging.ninjakiwi.com/api/v1/users/";
               Constants.SERVER_STATUS_URL = "./server_status.json";
               Constants.MODIFIER_DATA_URL = "https://static-api-staging.ninjakiwi.com/appdocs/7/appdocs/modifiers.json";
               Constants.AUDIO_PATH = "./audio/";
               Constants.FRIENDS_LIST_API_URL = "https://staging.ninjakiwi.com/api/v1/users/";
               Constants.PROFILE_URL_BASE = "https://staging.ninjakiwi.com/profile/";
               Constants.KLOUD_HOST = "https://web-monkey-city-staging.ninjakiwi.com/monkeycity/";
               Constants.SKU_URL = Constants.SKU_URL_PRODUCTION;
               Constants.NEWS_DATA_URL = Constants.NEWS_DATA_STAGING_URL;
               Constants.ENABLE_REQUEST_LOGGING = true;
               break;
            case KONG_TEST_STAGING:
               ErrorReporter.externalLog("Using Staging standalone environment");
               Constants.BASE_PATH = "./";
               Constants.BTD_MODULE_URL = "btd_module.swf";
               Constants.NK_BAR_URL = "https://assets.nkstatic.com/nklogin/staging-nkBar.swf";
               Constants.NK_LOGIN_URL = "https://staging.ninjakiwi.com/logged_in";
               Constants.NK_STORE_URL = "https://staging.ninjakiwi.com/getcoins/";
               Constants.USER_INFORMATION_PATH_SERVICE = "https://staging.ninjakiwi.com/api/v1/users/";
               Constants.SERVER_STATUS_URL = "https://static-api.ninjakiwi.com/appdocs/7/appdocs/server_status_staging.json";
               Constants.MODIFIER_DATA_URL = "https://static-api-staging.ninjakiwi.com/appdocs/7/appdocs/modifiers.json";
               Constants.AUDIO_PATH = "./audio/";
               Constants.FRIENDS_LIST_API_URL = "https://staging.ninjakiwi.com/api/v1/users/";
               Constants.PROFILE_URL_BASE = "https://staging.ninjakiwi.com/profile/";
               Constants.KLOUD_HOST = "https://web-monkey-city-staging.ninjakiwi.com/monkeycity/";
               Constants.SKU_URL = Constants.SKU_URL_PRODUCTION;
               Constants.NEWS_DATA_URL = Constants.NEWS_DATA_STAGING_URL;
               Constants.ENABLE_REQUEST_LOGGING = true;
               break;
            case INTRANET_STAGING_LOGIN:
               ErrorReporter.externalLog("Using Intranet Staging environment");
               Constants.BASE_PATH = "./";
               Constants.BTD_MODULE_URL = "btd_module.swf";
               Constants.NK_BAR_URL = "https://assets.nkstatic.com/nklogin/staging-nkBar.swf";
               Constants.NK_LOGIN_URL = "https://staging.ninjakiwi.com/logged_in";
               Constants.NK_STORE_URL = "https://staging.ninjakiwi.com/getcoins/";
               Constants.USER_INFORMATION_PATH_SERVICE = "https://staging.ninjakiwi.com/api/v1/users/";
               Constants.SERVER_STATUS_URL = "./server_status.json";
               Constants.MODIFIER_DATA_URL = "https://nkapi-user-documents-staging.s3.amazonaws.com/appdocs/7/appdocs/modifiers.json";
               Constants.AUDIO_PATH = "./audio/";
               Constants.FRIENDS_LIST_API_URL = "https://staging.ninjakiwi.com/api/v1/users/";
               Constants.PROFILE_URL_BASE = "https://staging.ninjakiwi.com/profile/";
               Constants.KLOUD_HOST = "https://" + Constants.KLOUD_HOST_IP + ":" + Constants.KLOUD_HOST_INTRANET_PORT + "/monkeycity/";
               Constants.ENABLE_REQUEST_LOGGING = true;
               Constants.SKU_URL = Constants.SKU_URL_STAGING;
               Constants.NEWS_DATA_URL = Constants.NEWS_DATA_STAGING_URL;
               Constants.BUST_STRING = "?bust=" + Math.floor(Math.random() * int.MAX_VALUE);
               break;
            case INTRANET_LIVE_LOGIN:
               ErrorReporter.externalLog("Using Intranet Live login environment");
               Constants.BASE_PATH = "./";
               Constants.BTD_MODULE_URL = "btd_module.swf";
               Constants.NK_BAR_URL = "https://assets.nkstatic.com/nklogin/nkBar.swf";
               Constants.NK_LOGIN_URL = "https://www.ninjakiwi.com/logged_in";
               Constants.NK_STORE_URL = "https://www.ninjakiwi.com/getcoins/";
               Constants.USER_INFORMATION_PATH_SERVICE = "https://www.ninjakiwi.com/api/v1/users/";
               Constants.SERVER_STATUS_URL = "./server_status.json";
               Constants.MODIFIER_DATA_URL = "https://nkapi-user-documents-staging.s3.amazonaws.com/appdocs/7/appdocs/modifiers.json";
               Constants.AUDIO_PATH = "./audio/";
               Constants.FRIENDS_LIST_API_URL = "https://www.ninjakiwi.com/api/v1/users/";
               Constants.PROFILE_URL_BASE = "https://www.ninjakiwi.com/profile/";
               Constants.KLOUD_HOST = "https://" + Constants.KLOUD_HOST_IP + ":" + Constants.KLOUD_HOST_INTRANET_PORT + "/monkeycity/";
               Constants.ENABLE_REQUEST_LOGGING = true;
               Constants.SKU_URL = Constants.SKU_URL_STAGING;
               Constants.NEWS_DATA_URL = Constants.NEWS_DATA_STAGING_URL;
               break;
            case KAIPARASOFT_STAGING:
               ErrorReporter.externalLog("Using Kaiparasoft Staging environment");
               Constants.BASE_PATH = "./";
               Constants.BTD_MODULE_URL = "btd_module.swf";
               Constants.NK_BAR_URL = "https://assets.nkstatic.com/nklogin/staging-nkBar.swf";
               Constants.NK_LOGIN_URL = "https://staging.ninjakiwi.com/logged_in";
               Constants.NK_STORE_URL = "https://staging.ninjakiwi.com/getcoins/";
               Constants.USER_INFORMATION_PATH_SERVICE = "https://staging.ninjakiwi.com/api/v1/users/";
               Constants.SERVER_STATUS_URL = "./server_status.json";
               Constants.MODIFIER_DATA_URL = "https://nkapi-user-documents-staging.s3.amazonaws.com/appdocs/7/appdocs/modifiers.json";
               Constants.AUDIO_PATH = "./audio/";
               Constants.FRIENDS_LIST_API_URL = "https://staging.ninjakiwi.com/api/v1/users/";
               Constants.PROFILE_URL_BASE = "https://staging.ninjakiwi.com/profile/";
               Constants.KLOUD_HOST = "https://web-monkey-city-staging.ninjakiwi.com/monkeycity/";
               Constants.ENABLE_REQUEST_LOGGING = true;
               Constants.SKU_URL = Constants.SKU_URL_PRODUCTION;
               Constants.NEWS_DATA_URL = Constants.NEWS_DATA_STAGING_URL;
               break;
            case KAIPARASOFT_LIVE:
               ErrorReporter.externalLog("Using Kaiparasoft Live environment");
               Constants.BTD_MODULE_URL = "btd_module.swf";
               Constants.NK_BAR_URL = "https://assets.nkstatic.com/nklogin/nkBar.swf";
               Constants.NK_LOGIN_URL = "https://www.ninjakiwi.com/logged_in";
               Constants.NK_STORE_URL = "https://www.ninjakiwi.com/getcoins/";
               Constants.USER_INFORMATION_PATH_SERVICE = "https://www.ninjakiwi.com/api/v1/users/";
               Constants.FRIENDS_LIST_API_URL = "https://www.ninjakiwi.com/api/v1/users/";
               Constants.PROFILE_URL_BASE = "https://www.ninjakiwi.com/profile/";
               Constants.KLOUD_HOST = "https://23.23.169.238:80/monkeycity/";
               Constants.BASE_PATH = "./";
               Constants.AUDIO_PATH = "./audio/";
               Constants.SERVER_STATUS_URL = "./server_status.json";
               Constants.MODIFIER_DATA_URL = "https://nkapi-user-documents-staging.s3.amazonaws.com/appdocs/7/appdocs/modifiers.json";
               Constants.ENABLE_REQUEST_LOGGING = true;
               Constants.SKU_URL = Constants.SKU_URL_PRODUCTION;
               Constants.NEWS_DATA_URL = Constants.NEWS_DATA_STAGING_URL;
               break;
            case LOCAL_SERVER_STAGING_LOGIN:
               ErrorReporter.externalLog("Using Local server with staging login environment");
               Constants.BASE_PATH = "./";
               Constants.BTD_MODULE_URL = "btd_module.swf";
               Constants.NK_BAR_URL = "https://assets.nkstatic.com/nklogin/staging-nkBar.swf";
               Constants.NK_LOGIN_URL = "https://staging.ninjakiwi.com/logged_in";
               Constants.NK_STORE_URL = "https://staging.ninjakiwi.com/getcoins/";
               Constants.USER_INFORMATION_PATH_SERVICE = "https://staging.ninjakiwi.com/api/v1/users/";
               Constants.SERVER_STATUS_URL = "./server_status.json";
               Constants.MODIFIER_DATA_URL = "https://nkapi-user-documents-staging.s3.amazonaws.com/appdocs/7/appdocs/modifiers.json";
               Constants.AUDIO_PATH = "./audio/";
               Constants.FRIENDS_LIST_API_URL = "https://staging.ninjakiwi.com/api/v1/users/";
               Constants.PROFILE_URL_BASE = "https://staging.ninjakiwi.com/profile/";
               Constants.KLOUD_HOST = "https://" + Constants.KLOUD_HOST_IP + ":" + Constants.KLOUD_HOST_LOCAL_PORT + "/monkeycity/";
               Constants.ENABLE_REQUEST_LOGGING = true;
               Constants.SKU_URL = Constants.SKU_URL_PRODUCTION;
               Constants.NEWS_DATA_URL = Constants.NEWS_DATA_STAGING_URL;
               break;
            case LOCAL_MULTICITY:
               ErrorReporter.externalLog("Using Local Multicity environment");
               Constants.BASE_PATH = "./";
               Constants.BTD_MODULE_URL = "btd_module.swf";
               Constants.NK_BAR_URL = "https://assets.nkstatic.com/nklogin/staging-nkBar.swf";
               Constants.NK_LOGIN_URL = "https://staging.ninjakiwi.com/logged_in";
               Constants.NK_STORE_URL = "https://staging.ninjakiwi.com/getcoins/";
               Constants.USER_INFORMATION_PATH_SERVICE = "https://staging.ninjakiwi.com/api/v1/users/";
               Constants.SERVER_STATUS_URL = "./server_status.json";
               Constants.MODIFIER_DATA_URL = "https://nkapi-user-documents-staging.s3.amazonaws.com/appdocs/7/appdocs/modifiers.json";
               Constants.AUDIO_PATH = "./audio/";
               Constants.FRIENDS_LIST_API_URL = "https://staging.ninjakiwi.com/api/v1/users/";
               Constants.PROFILE_URL_BASE = "https://staging.ninjakiwi.com/profile/";
               Constants.KLOUD_HOST = "https://54.91.119.86/monkeycity/";
               Constants.ENABLE_REQUEST_LOGGING = true;
               Constants.SKU_URL = Constants.SKU_URL_PRODUCTION;
               Constants.NEWS_DATA_URL = Constants.NEWS_DATA_STAGING_URL;
               break;
            case DEVELOPMENT_STAGING:
               ErrorReporter.externalLog("Using Development Staging environment");
               Constants.BASE_PATH = "./";
               Constants.BTD_MODULE_URL = "btd_module.swf";
               Constants.NK_BAR_URL = "https://assets.nkstatic.com/nklogin/nkBar.swf";
               Constants.NK_LOGIN_URL = "https://www.ninjakiwi.com/logged_in";
               Constants.NK_STORE_URL = "https://www.ninjakiwi.com/getcoins/";
               Constants.USER_INFORMATION_PATH_SERVICE = "https://www.ninjakiwi.com/api/v1/users/";
               Constants.SERVER_STATUS_URL = "./server_status.json";
               Constants.MODIFIER_DATA_URL = "https://nkapi-user-documents-staging.s3.amazonaws.com/appdocs/7/appdocs/modifiers.json";
               Constants.AUDIO_PATH = "./audio/";
               Constants.FRIENDS_LIST_API_URL = "https://www.ninjakiwi.com/api/v1/users/";
               Constants.PROFILE_URL_BASE = "https://www.ninjakiwi.com/profile/";
               Constants.KLOUD_HOST = "https://23.23.169.238:80/monkeycity/";
               Constants.ENABLE_REQUEST_LOGGING = true;
               Constants.SKU_URL = Constants.SKU_URL_PRODUCTION;
               Constants.NEWS_DATA_URL = Constants.NEWS_DATA_STAGING_URL;
               break;
            case DEVELOPMENT_LIVE:
               ErrorReporter.externalLog("Using Local Development Live environment");
               Constants.BASE_PATH = "./";
               Constants.BTD_MODULE_URL = "btd_module.swf";
               Constants.NK_BAR_URL = "https://assets.nkstatic.com/nklogin/nkBar.swf";
               Constants.NK_LOGIN_URL = "https://www.ninjakiwi.com/logged_in";
               Constants.NK_STORE_URL = "https://www.ninjakiwi.com/getcoins/";
               Constants.USER_INFORMATION_PATH_SERVICE = "https://www.ninjakiwi.com/api/v1/users/";
               Constants.SERVER_STATUS_URL = "./server_status.json";
               Constants.MODIFIER_DATA_URL = "https://nkapi-user-documents-staging.s3.amazonaws.com/appdocs/7/appdocs/modifiers.json";
               Constants.AUDIO_PATH = "./audio/";
               Constants.FRIENDS_LIST_API_URL = "https://www.ninjakiwi.com/api/v1/users/";
               Constants.PROFILE_URL_BASE = "https://www.ninjakiwi.com/profile/";
               Constants.KLOUD_HOST = "https://23.23.169.238:80/monkeycity/";
               Constants.ENABLE_REQUEST_LOGGING = true;
               Constants.SKU_URL = Constants.SKU_URL_PRODUCTION;
               break;
            case CUSTOM_IP_STAGING_LOGIN:
               ErrorReporter.externalLog("Using Staging standalone environment");
               Constants.BASE_PATH = "https://assets.nkstatic.com/Games/gameswfs/mc45/";
               Constants.NK_BAR_URL = "https://assets.nkstatic.com/nklogin/staging-nkBar.swf";
               Constants.NK_LOGIN_URL = "https://staging.ninjakiwi.com/logged_in";
               Constants.NK_STORE_URL = "https://staging.ninjakiwi.com/getcoins/";
               Constants.USER_INFORMATION_PATH_SERVICE = "https://staging.ninjakiwi.com/api/v1/users/";
               Constants.SERVER_STATUS_URL = "https://static-api.ninjakiwi.com/appdocs/7/appdocs/server_status_staging.json";
               Constants.MODIFIER_DATA_URL = "https://static-api-staging.ninjakiwi.com/appdocs/7/appdocs/modifiers.json";
               Constants.BTD_MODULE_URL = "btd_module.swf";
               Constants.AUDIO_PATH = "https://assets.nkstatic.com/Games/gameswfs/mc45/audio/";
               Constants.FRIENDS_LIST_API_URL = "https://staging.ninjakiwi.com/api/v1/users/";
               Constants.PROFILE_URL_BASE = "https://staging.ninjakiwi.com/profile/";
               Constants.KLOUD_HOST = "https://" + "54.85.214.12" + "/monkeycity/";
               Constants.SKU_URL = Constants.SKU_URL_PRODUCTION;
               Constants.NEWS_DATA_URL = Constants.NEWS_DATA_STAGING_URL;
               Constants.ENABLE_REQUEST_LOGGING = true;
               break;
            case CUSTOM_IP_PRODUCTION_LOGIN:
               ErrorReporter.externalLog("Using Production server with custom IP environment");
               Constants.BASE_PATH = "./";
               Constants.BTD_MODULE_URL = "btd_module.swf";
               Constants.NK_BAR_URL = "https://assets.nkstatic.com/nklogin/nkBar.swf";
               Constants.NK_LOGIN_URL = "https://www.ninjakiwi.com/logged_in";
               Constants.NK_STORE_URL = "https://www.ninjakiwi.com/getcoins/";
               Constants.USER_INFORMATION_PATH_SERVICE = "https://www.ninjakiwi.com/api/v1/users/";
               Constants.SERVER_STATUS_URL = "./server_status.json";
               Constants.MODIFIER_DATA_URL = "https://nkapi-user-documents-staging.s3.amazonaws.com/appdocs/7/appdocs/modifiers.json";
               Constants.AUDIO_PATH = "./audio/";
               Constants.FRIENDS_LIST_API_URL = "https://www.ninjakiwi.com/api/v1/users/";
               Constants.PROFILE_URL_BASE = "https://www.ninjakiwi.com/profile/";
               Constants.KLOUD_HOST = "https://" + "52.91.133.76" + "/monkeycity/";
               Constants.ENABLE_REQUEST_LOGGING = true;
               Constants.SKU_URL = Constants.SKU_URL_PRODUCTION;
               break;
            case LOCAL_SERVER_PRODUCTION_LOGIN:
            default:
               ErrorReporter.externalLog("Using Local server with production login environment");
               Constants.BASE_PATH = "./";
               Constants.BTD_MODULE_URL = "btd_module.swf";
               Constants.NK_BAR_URL = "https://assets.nkstatic.com/nklogin/nkBar.swf";
               Constants.NK_LOGIN_URL = "https://www.ninjakiwi.com/logged_in";
               Constants.NK_STORE_URL = "https://www.ninjakiwi.com/getcoins/";
               Constants.USER_INFORMATION_PATH_SERVICE = "https://www.ninjakiwi.com/api/v1/users/";
               Constants.SERVER_STATUS_URL = "./server_status.json";
               Constants.MODIFIER_DATA_URL = "https://nkapi-user-documents-staging.s3.amazonaws.com/appdocs/7/appdocs/modifiers.json";
               Constants.AUDIO_PATH = "./audio/";
               Constants.FRIENDS_LIST_API_URL = "https://www.ninjakiwi.com/api/v1/users/";
               Constants.PROFILE_URL_BASE = "https://www.ninjakiwi.com/profile/";
               Constants.KLOUD_HOST = "http://" + Constants.KLOUD_HOST_IP + "/monkeycity/";
               Constants.ENABLE_REQUEST_LOGGING = true;
               Constants.SKU_URL = Constants.SKU_URL_PRODUCTION;
         }
      }
   }
}
