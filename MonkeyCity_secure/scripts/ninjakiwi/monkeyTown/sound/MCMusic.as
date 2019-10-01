package ninjakiwi.monkeyTown.sound
{
   import assets.music.MapMusic;
   import assets.music.MapMusicDesert;
   import assets.music.TitleMusic;
   import com.greensock.TweenLite;
   import ninjakiwi.monkeyTown.common.audio.AudioState;
   import ninjakiwi.monkeyTown.town.tile.TileDefinitions;
   import treefortress.sound.SoundAS;
   import treefortress.sound.SoundInstance;
   
   public class MCMusic
   {
      
      private static var _currentSoundInstance:SoundInstance = null;
      
      private static const TILE_DEFINITIONS:TileDefinitions = TileDefinitions.getInstance();
      
      public static const trackIDByTerrain:Object = {
         TILE_DEFINITIONS.FOREST.valueOf():SoundID.FOREST_DESERT_MUSIC,
         TILE_DEFINITIONS.HEAVY_FOREST.valueOf():SoundID.FOREST_DESERT_MUSIC,
         TILE_DEFINITIONS.DESERT.valueOf():SoundID.FOREST_DESERT_MUSIC,
         TILE_DEFINITIONS.GRASS.valueOf():SoundID.GRASS_HILLS_JUNGLE_MUSIC,
         TILE_DEFINITIONS.HILLS.valueOf():SoundID.GRASS_HILLS_JUNGLE_MUSIC,
         TILE_DEFINITIONS.JUNGLE.valueOf():SoundID.GRASS_HILLS_JUNGLE_MUSIC,
         TILE_DEFINITIONS.MOUNTAINS.valueOf():SoundID.MOUNTAIN_CAVE_SNOW_MUSIC,
         TILE_DEFINITIONS.VOLCANO.valueOf():SoundID.MOUNTAIN_CAVE_SNOW_MUSIC,
         TILE_DEFINITIONS.CAVES.valueOf():SoundID.MOUNTAIN_CAVE_SNOW_MUSIC,
         TILE_DEFINITIONS.SNOW.valueOf():SoundID.MOUNTAIN_CAVE_SNOW_MUSIC,
         TILE_DEFINITIONS.LAKE.valueOf():SoundID.RIVER_LAKE_MUSIC,
         TILE_DEFINITIONS.RIVER.valueOf():SoundID.RIVER_LAKE_MUSIC,
         TILE_DEFINITIONS.DESERT_BADLANDS.valueOf():SoundID.DESERT_BADLANDS_MUSIC,
         TILE_DEFINITIONS.DESERT_HIGHLANDS.valueOf():SoundID.DESERT_HIGHLANDS_MUSIC,
         TILE_DEFINITIONS.DESERT_ARID_GRASSLANDS.valueOf():SoundID.DESERT_ARID_GRASSLANDS_MUSIC
      };
      
      public static const INTERNAL_FILES:Array = [SoundID.TITLE_MUSIC,SoundID.MAP_MUSIC,SoundID.MAP_MUSIC_DESERT];
      
      public static const FADE_TIME:int = 1000;
      
      private static var _delayedTrackIsCued:Boolean = false;
      
      private static var _globalVolume:Number = 0.5;
      
      private static var _mapMusic:SoundInstance;
      
      private static var _externalMusic:ExternalMusicManager;
      
      private static var mapMusicIsPlaying:Boolean = false;
      
      private static var mapMusicPausePosition:Number = 0;
      
      private static var _currentSoundID:String = "";
      
      {
         init();
      }
      
      public function MCMusic()
      {
         super();
      }
      
      private static function init() : void
      {
         _externalMusic = new ExternalMusicManager();
         SoundAS.addSound(SoundID.TITLE_MUSIC,new TitleMusic());
         SoundAS.addSound(SoundID.MAP_MUSIC,new MapMusic());
         SoundAS.addSound(SoundID.MAP_MUSIC_DESERT,new MapMusicDesert());
         AudioState.MUSIC_MUTE_STATE_CHANGED.add(onMusicMuteStateChangedSignal);
         AudioState.REQUEST_STATE_SYNC.add(syncToAudioState);
         syncToAudioState();
      }
      
      public static function playTrack(param1:String) : void
      {
         if(param1 === _currentSoundID)
         {
            return;
         }
         var _loc2_:* = INTERNAL_FILES.indexOf(param1) !== -1;
         if(!_loc2_ && !_externalMusic.isTrackLoaded(param1))
         {
            return;
         }
         stopCurrentMusicTrack();
         playDelayedTrack(param1);
      }
      
      private static function playDelayedTrack(param1:String, param2:int = 1000) : void
      {
         TweenLite.killDelayedCallsTo(playTrack);
         TweenLite.delayedCall(Number(param2) / 1000,delayedTrackCallback,[param1]);
      }
      
      private static function delayedTrackCallback(param1:String) : void
      {
         _currentSoundInstance = SoundAS.playLoop(param1,_globalVolume);
         _currentSoundID = param1;
         if(AudioState.musicIsMuted)
         {
            _currentSoundInstance.volume = 0;
         }
      }
      
      public static function stopCurrentMusicTrack(param1:uint = 1000) : void
      {
         if(_currentSoundInstance !== null)
         {
            _currentSoundInstance.volume = _globalVolume;
            if(!AudioState.musicIsMuted)
            {
               _currentSoundInstance.fadeTo(0,param1,true);
            }
            else
            {
               _currentSoundInstance.stop();
            }
            _currentSoundInstance = null;
         }
         pauseMapMusic();
      }
      
      public static function playTitleMusic() : void
      {
         playTrack(SoundID.TITLE_MUSIC);
      }
      
      public static function playPVPMusic() : void
      {
         playTrack(SoundID.PVP_MUSIC);
      }
      
      public static function playMapMusic(param1:int = 0) : void
      {
         switch(param1 > 0)
         {
            case true:
               playTrack(SoundID.MAP_MUSIC_DESERT);
               break;
            default:
               playTrack(SoundID.MAP_MUSIC);
         }
      }
      
      private static function pauseMapMusic() : void
      {
         if(!mapMusicIsPlaying)
         {
            return;
         }
         if(_mapMusic !== null)
         {
            mapMusicPausePosition = _mapMusic.position;
            _mapMusic.fadeTo(0,FADE_TIME,true);
            _mapMusic = null;
         }
         mapMusicIsPlaying = false;
      }
      
      public static function loadTrack(param1:String) : LoadingSound
      {
         return _externalMusic.loadItem(param1);
      }
      
      public static function isTrackLoaded(param1:String) : Boolean
      {
         return _externalMusic.isTrackLoaded(param1);
      }
      
      public static function getProgressOfTrack(param1:String) : Number
      {
         return _externalMusic.getProgressOfTrack(param1);
      }
      
      public static function getTrackIDForTerrain(param1:String) : String
      {
         var _loc2_:String = trackIDByTerrain[param1];
         if(_loc2_ !== null)
         {
            return _loc2_;
         }
         return SoundID.GRASS_HILLS_JUNGLE_MUSIC;
      }
      
      private static function onMusicMuteStateChangedSignal(param1:Boolean) : void
      {
         syncToAudioState();
      }
      
      public static function syncToAudioState() : void
      {
         var _loc1_:Boolean = AudioState.musicIsMuted;
         if(!_loc1_)
         {
            if(_currentSoundInstance !== null)
            {
               _currentSoundInstance.fadeTo(_globalVolume,FADE_TIME,false);
            }
            else if(_mapMusic !== null)
            {
               _mapMusic.fadeTo(_globalVolume,FADE_TIME,false);
            }
         }
         else if(_currentSoundInstance !== null)
         {
            _currentSoundInstance.fadeTo(0,FADE_TIME,false);
         }
         else if(_mapMusic !== null)
         {
            _mapMusic.fadeTo(0,FADE_TIME,false);
         }
      }
   }
}
