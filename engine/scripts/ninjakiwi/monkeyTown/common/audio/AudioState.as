package ninjakiwi.monkeyTown.common.audio
{
   import flash.net.SharedObject;
   import org.osflash.signals.Signal;
   
   public class AudioState
   {
      
      public static const SFX_MUTE_STATE_CHANGED:Signal = new Signal(Boolean);
      
      public static const MUSIC_MUTE_STATE_CHANGED:Signal = new Signal(Boolean);
      
      public static const REQUEST_STATE_SYNC:Signal = new Signal();
      
      private static var _sfxIsMuted:Boolean = false;
      
      private static var _musicIsMuted:Boolean = false;
      
      private static const USE_LSO:Boolean = true;
      
      private static var lockLSO:Boolean = false;
      
      {
         if(USE_LSO)
         {
            loadStateFromLSO();
         }
      }
      
      public function AudioState()
      {
         super();
      }
      
      public static function get sfxIsMuted() : Boolean
      {
         return _sfxIsMuted;
      }
      
      public static function set sfxIsMuted(param1:Boolean) : void
      {
         if(_sfxIsMuted === param1)
         {
            return;
         }
         _sfxIsMuted = param1;
         if(USE_LSO)
         {
            saveState();
         }
         SFX_MUTE_STATE_CHANGED.dispatch(param1);
      }
      
      public static function get musicIsMuted() : Boolean
      {
         return _musicIsMuted;
      }
      
      public static function set musicIsMuted(param1:Boolean) : void
      {
         if(_musicIsMuted == param1)
         {
            return;
         }
         _musicIsMuted = param1;
         if(USE_LSO)
         {
            saveState();
         }
         MUSIC_MUTE_STATE_CHANGED.dispatch(param1);
      }
      
      private static function loadStateFromLSO() : void
      {
         lockLSO = true;
         var _loc1_:SharedObject = SharedObject.getLocal("monkey_city_audio_preferences");
         if(_loc1_.data.hasOwnProperty("sfxIsMuted"))
         {
            sfxIsMuted = _loc1_.data.sfxIsMuted;
         }
         if(_loc1_.data.hasOwnProperty("musicIsMuted"))
         {
            musicIsMuted = _loc1_.data.musicIsMuted;
         }
         lockLSO = false;
         REQUEST_STATE_SYNC.dispatch();
      }
      
      private static function saveState() : void
      {
         saveStateToLSO();
      }
      
      private static function saveStateToKloud() : void
      {
      }
      
      private static function saveStateToLSO() : void
      {
         if(lockLSO)
         {
            return;
         }
         var _loc1_:SharedObject = SharedObject.getLocal("monkey_city_audio_preferences");
         _loc1_.data.sfxIsMuted = sfxIsMuted;
         _loc1_.data.musicIsMuted = musicIsMuted;
         _loc1_.flush();
      }
   }
}
