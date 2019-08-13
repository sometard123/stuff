package ninjakiwi.monkeyTown.sound
{
   import flash.media.Sound;
   import ninjakiwi.monkeyTown.common.Constants;
   import treefortress.sound.SoundAS;
   
   public class ExternalMusicManager
   {
      
      public static const FOREST_DESERT_MUSIC_URL:String = "MCity_ForestHeavyforestDesert.mp3";
      
      public static const GRASS_HILLS_JUNGLE_MUSIC_URL:String = "MCity_GrassHillsJungle.mp3";
      
      public static const PVP_MUSIC_URL:String = "MCity_MvM.mp3";
      
      public static const MOUNTAIN_CAVE_SNOW_MUSIC_URL:String = "MCity_MountainCaveSnowVolcano.mp3";
      
      public static const RIVER_LAKE_MUSIC_URL:String = "MCity_RiverLake.mp3";
      
      public static const DESERT_MUSIC_URL:String = "MCity_DesertMap.mp3";
      
      public static const DESERT_BADLANDS_MUSIC_URL:String = "MCity_Badlands.mp3";
      
      public static const DESERT_GRASSLANDS_MUSIC_URL:String = "MCity_AridGrassland.mp3";
      
      public static const DESERT_HIGHLANDS_MUSIC_URL:String = "MCity_HighDesert.mp3";
      
      public static const EXTERNAL_FILES:Object = {
         "" + SoundID.FOREST_DESERT_MUSIC:FOREST_DESERT_MUSIC_URL,
         "" + SoundID.GRASS_HILLS_JUNGLE_MUSIC:GRASS_HILLS_JUNGLE_MUSIC_URL,
         "" + SoundID.PVP_MUSIC:PVP_MUSIC_URL,
         "" + SoundID.MOUNTAIN_CAVE_SNOW_MUSIC:MOUNTAIN_CAVE_SNOW_MUSIC_URL,
         "" + SoundID.RIVER_LAKE_MUSIC:RIVER_LAKE_MUSIC_URL,
         "" + SoundID.DESERT_BADLANDS_MUSIC:DESERT_BADLANDS_MUSIC_URL,
         "" + SoundID.DESERT_ARID_GRASSLANDS_MUSIC:DESERT_GRASSLANDS_MUSIC_URL,
         "" + SoundID.DESERT_HIGHLANDS_MUSIC:DESERT_HIGHLANDS_MUSIC_URL
      };
       
      
      private var _musicLoader:MusicLoader;
      
      public function ExternalMusicManager()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         this._musicLoader = new MusicLoader();
         this._musicLoader.progressSignal.add(this.onMusicLoadProgress);
         this._musicLoader.completeSignal.add(this.onMusicLoadComplete);
      }
      
      public function isTrackLoaded(param1:String) : Boolean
      {
         if(EXTERNAL_FILES.hasOwnProperty(param1))
         {
            return this._musicLoader.isMusicLoaded(param1);
         }
         return false;
      }
      
      public function loadItem(param1:String) : LoadingSound
      {
         var _loc2_:String = Constants.AUDIO_PATH + EXTERNAL_FILES[param1];
         if(_loc2_ === null)
         {
            return null;
         }
         return this._musicLoader.loadMusic(_loc2_,param1);
      }
      
      public function getProgressOfTrack(param1:String) : Number
      {
         return this._musicLoader.getProgressOfLoad(param1);
      }
      
      private function onMusicLoadProgress(param1:Number, param2:String) : void
      {
      }
      
      private function onMusicLoadComplete(param1:Sound, param2:String) : void
      {
         SoundAS.addSound(param2,param1);
      }
   }
}
