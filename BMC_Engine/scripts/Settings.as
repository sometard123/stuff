package
{
   public class Settings
   {
      
      public static const GAME_NAME:String = "Battles";
      
      public static const KONG_API_KEY:String = "9d339ab4-e3ce-468e-bcf0-0003d09b9cd6";
      
      public static const PUBLISH_YEAR:String = "2012";
      
      public static const STAGE_WIDTH:Number = 800;
      
      public static const STAGE_HEIGHT:Number = 600;
      
      public static const TEST_MODE:Boolean = false;
      
      public static var SHOW_SPLASH:Boolean = true;
      
      public static var VERBOSE_TRACE:Boolean = false;
      
      public static var MOCHI_SERVICES_ENABLE:Boolean = true;
      
      public static var MOCHI_AD_ENABLE:Boolean = true;
      
      public static const DOMAIN_LOCK_TO:Array = ["ninjakiwi.com","ninjakiwifiles.com","kongregate.com"];
      
      public static const DOMAIN_LOCK_EXCLUDE:Array = [];
      
      {
         if(TEST_MODE)
         {
            SHOW_SPLASH = false;
            VERBOSE_TRACE = true;
            MOCHI_SERVICES_ENABLE = true;
            MOCHI_AD_ENABLE = true;
         }
      }
      
      public function Settings()
      {
         super();
      }
   }
}
