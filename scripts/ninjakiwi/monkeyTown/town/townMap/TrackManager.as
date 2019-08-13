package ninjakiwi.monkeyTown.town.townMap
{
   import flash.utils.getDefinitionByName;
   import ninjakiwi.monkeyTown.common.LevelDefData;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.tile.TileDefinitions;
   import org.osflash.signals.Signal;
   
   public class TrackManager
   {
      
      public static const unlockedCountChangedSignal:Signal = new Signal(int);
      
      private static var instance:TrackManager;
       
      
      private const _tracks:Vector.<TrackData> = new Vector.<TrackData>();
      
      private const _unlockedTrack:Vector.<String> = new Vector.<String>();
      
      public function TrackManager(param1:SingletonEnforcer#885)
      {
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use ReplayTrackManager.getInstance() instead of new.");
         }
         MonkeyCityMain.globalResetSignal.add(this.onReset);
      }
      
      public static function getInstance() : TrackManager
      {
         if(instance == null)
         {
            instance = new TrackManager(new SingletonEnforcer#885());
         }
         return instance;
      }
      
      public function loadAllTracks() : void
      {
         var i:int = 0;
         var terrainID:String = null;
         var cityIndex:int = 0;
         var levelDefs:Array = null;
         var j:int = 0;
         var trackNameLength:int = 0;
         var possibleTrackName:String = null;
         var track:TrackData = null;
         var thumbClassName:String = null;
         this._tracks.length = 0;
         this._unlockedTrack.length = 0;
         var refTerrains:Array = TileDefinitions.getInstance().terrainDefinitions;
         var terrains:Array = new Array();
         i = 0;
         while(i < refTerrains.length)
         {
            terrains.push(refTerrains[i]);
            i++;
         }
         terrains.push(TileDefinitions.getInstance().CAVES_DEFINITION);
         i = 0;
         while(i < terrains.length)
         {
            terrainID = terrains[i].id;
            if(terrainID != TileDefinitions.getInstance().RUINS)
            {
               cityIndex = MonkeySystem.getInstance().city.cityIndex;
               levelDefs = LevelDefData.getLevelDefNamesByTerrain(terrainID,cityIndex);
               if(levelDefs != null)
               {
                  j = 0;
                  while(j < levelDefs.length)
                  {
                     trackNameLength = (levelDefs[j] as String).length;
                     possibleTrackName = (levelDefs[j] as String).substr(0,trackNameLength - 3);
                     try
                     {
                        track = new TrackData();
                        track.trackName = possibleTrackName;
                        thumbClassName = "assets.maps." + track.trackName + "_png_thumb";
                        track.displayClass = getDefinitionByName(thumbClassName);
                        track.terrainID = terrains[i].id;
                        track.terrainName = terrains[i].name;
                        track.trackDefName = levelDefs[j] as String;
                        track.played = true;
                        this._tracks.push(track);
                     }
                     catch(e:Error)
                     {
                     }
                     j++;
                  }
               }
            }
            i++;
         }
         unlockedCountChangedSignal.dispatch(0);
      }
      
      public function get tracks() : Vector.<TrackData>
      {
         return this._tracks;
      }
      
      public function get totalUnlocked() : int
      {
         return this._unlockedTrack.length;
      }
      
      public function unlockTrack(param1:String, param2:Boolean = false) : void
      {
         var _loc3_:TrackData = null;
         if(param1 != null && this._unlockedTrack.indexOf(param1) == -1)
         {
            this._unlockedTrack.push(param1);
            _loc3_ = this.findTrack(param1);
            if(_loc3_ != null)
            {
               _loc3_.unlocked = true;
               if(param2 == false)
               {
                  _loc3_.played = false;
                  unlockedCountChangedSignal.dispatch(this.getNewUnlockedTrackCount(0,this._tracks.length));
               }
            }
         }
      }
      
      public function trackPlayed(param1:TrackData) : void
      {
         param1.played = true;
         unlockedCountChangedSignal.dispatch(this.getNewUnlockedTrackCount(0,this._tracks.length));
      }
      
      public function getNewUnlockedTrackCount(param1:int = 0, param2:int = 0) : int
      {
         var _loc5_:TrackData = null;
         var _loc3_:int = 0;
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param1 + param2 >= this._tracks.length)
         {
            param2 = this._tracks.length - param1;
         }
         var _loc4_:int = 0;
         while(_loc4_ < param2)
         {
            _loc5_ = this._tracks[param1 + _loc4_];
            if(_loc5_.played == false)
            {
               _loc3_++;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function findTrack(param1:String) : TrackData
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._tracks.length)
         {
            if(this._tracks[_loc2_].trackName == param1 || this._tracks[_loc2_].trackDefName == param1)
            {
               return this._tracks[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function findTrackByDefName(param1:String) : TrackData
      {
         var _loc2_:String = param1.substr(0,param1.length - 3);
         return this.findTrack(_loc2_);
      }
      
      public function dispatchUnlockedCount() : void
      {
         unlockedCountChangedSignal.dispatch(this.getNewUnlockedTrackCount(0,this._tracks.length));
      }
      
      public function getRandomTrack() : TrackData
      {
         return this._tracks[int(this._tracks.length * Math.random())];
      }
      
      public function getTrackBasedOnID(param1:int) : TrackData
      {
         var _loc2_:int = param1 % this._tracks.length;
         return this._tracks[_loc2_];
      }
      
      private function onReset() : void
      {
         var _loc1_:TrackData = null;
         for each(_loc1_ in this._tracks)
         {
            _loc1_.destory();
         }
         this._tracks.length = 0;
         this._unlockedTrack.length = 0;
      }
   }
}

class SingletonEnforcer#885
{
    
   
   function SingletonEnforcer#885()
   {
      super();
   }
}
