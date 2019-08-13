package ninjakiwi.monkeyTown.persistence
{
   import ninjakiwi.monkeyTown.net.kloud.CoreDataPersistence;
   
   public class Preferences
   {
      
      private static var _preferences:Object = null;
      
      public static const MUSIC_MUTED:String = "musicMuted";
      
      public static const SFX_MUTED:String = "sfxMuted";
      
      {
         init();
      }
      
      public function Preferences()
      {
         super();
      }
      
      private static function init() : void
      {
         _preferences = getDefaultPreferences();
      }
      
      public static function populateFromData(param1:Object) : void
      {
         var _loc2_:* = null;
         for(_loc2_ in param1)
         {
            _preferences[_loc2_] = param1[_loc2_];
         }
      }
      
      public static function setPreferences(param1:Array) : void
      {
         var _loc2_:String = null;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc6_:Object = null;
         var _loc5_:Boolean = false;
         var _loc7_:int = 0;
         while(_loc7_ < param1.length)
         {
            _loc6_ = param1[_loc7_];
            if(!(!_loc6_.hasOwnProperty("key") || !_loc6_.hasOwnProperty("value")))
            {
               _loc2_ = _loc6_.key;
               _loc3_ = _loc6_.value;
               _loc4_ = _preferences[_loc2_];
               if(_loc4_ !== _loc3_)
               {
                  _preferences[_loc2_] = _loc3_;
                  _loc5_ = true;
               }
            }
            _loc7_++;
         }
         if(_loc5_)
         {
            saveToKloud();
         }
      }
      
      public static function setPreference(param1:String, param2:*) : void
      {
         var _loc3_:* = _preferences[param1];
         if(_loc3_ !== param2)
         {
            _preferences[param1] = param2;
            saveToKloud();
         }
      }
      
      public static function getPreference(param1:String) : *
      {
         if(_preferences.hasOwnProperty(param1))
         {
            return _preferences[param1];
         }
         return null;
      }
      
      private static function saveToKloud() : void
      {
         CoreDataPersistence.getInstance().saveValue(CoreDataPersistence.PREFERENCES_KEY,_preferences);
      }
      
      private static function getDefaultPreferences() : Object
      {
         return {
            "musicMuted":false,
            "sfxMuted":false
         };
      }
   }
}
