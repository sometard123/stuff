package ninjakiwi.monkeyTown.town.townMap
{
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import ninjakiwi.monkeyTown.display.bitClip.BitClipCustom;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.display.tileSystem.persistence.TileSaveDefinition;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.buildings.BuildingFactory;
   import ninjakiwi.monkeyTown.town.data.definitions.TownMapSaveDefinition;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldViewSignals;
   import ninjakiwi.monkeyTown.utils.SoftProcess;
   
   public class TownMapPersistenceUtility
   {
       
      
      private var system:MonkeySystem;
      
      private var _buildingFactory:BuildingFactory;
      
      private var _terrainCachingProgressRatio:Number = 0.5;
      
      public function TownMapPersistenceUtility()
      {
         this.system = MonkeySystem.getInstance();
         this._buildingFactory = BuildingFactory.getInstance();
         super();
      }
      
      public function getTownMapSaveDefinition(param1:TownMap, param2:Vector.<Tile>) : TownMapSaveDefinition
      {
         var _loc3_:TownMapSaveDefinition = new TownMapSaveDefinition();
         _loc3_.worldSeed = param1._worldSeed;
         _loc3_.tileSaveDefinitions = this.getTileSaveDefinitions(param1,param2);
         return _loc3_;
      }
      
      public function getTileSaveDefinitions(param1:TownMap, param2:Vector.<Tile>) : Vector.<TileSaveDefinition>
      {
         var _loc5_:TileSaveDefinition = null;
         var _loc3_:Vector.<TileSaveDefinition> = new Vector.<TileSaveDefinition>();
         var _loc4_:int = param2.length;
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_)
         {
            _loc5_ = param2[_loc6_].getSaveDefinition();
            if(_loc5_ != null)
            {
               _loc3_.push(_loc5_);
            }
            _loc6_++;
         }
         return _loc3_;
      }
      
      public function populateFromSaveDefinition(param1:TownMap, param2:TownMapSaveDefinition) : void
      {
         var townMap:TownMap = param1;
         var townMapSaveDefinition:TownMapSaveDefinition = param2;
         townMap._worldIsReady = false;
         townMap.clear();
         townMap.signals.beginBuildingFromSaveDefinition.dispatch();
         townMapSaveDefinition.worldSeed.randomiseSeeded(townMapSaveDefinition.worldSeed.metaSeed);
         TrackManager.getInstance().loadAllTracks();
         if(townMapSaveDefinition.terrainData !== null)
         {
            townMap.buildTerrainFromCompressedJSON(townMapSaveDefinition.terrainData,townMapSaveDefinition.worldSeed);
            this.populateTilesFromTileSaveDefinitions(townMap,townMapSaveDefinition.tileSaveDefinitions);
         }
         else
         {
            townMap.generateTerrain(function():void
            {
               system.yield(populateTilesFromTileSaveDefinitions,[townMap,townMapSaveDefinition.tileSaveDefinitions],this);
            },townMapSaveDefinition.worldSeed);
         }
      }
      
      public function populateTilesFromTileSaveDefinitions(param1:TownMap, param2:Vector.<TileSaveDefinition>) : void
      {
         var i:int = 0;
         var length:int = 0;
         var tile:Tile = null;
         var definition:TileSaveDefinition = null;
         var tilesUnderPvPAttack:Array = null;
         var townMap:TownMap = param1;
         var definitions:Vector.<TileSaveDefinition> = param2;
         GameSignals.REPORT_GAME_LAUNCH_STATE.dispatch("Building city...");
         length = definitions.length;
         var softProcess:SoftProcess = new SoftProcess();
         var buildingCachingProgressRatio:Number = 1 - this._terrainCachingProgressRatio;
         i = 0;
         softProcess.run(function():Boolean
         {
            definition = definitions[i];
            tile = townMap.tileAt(definition.x,definition.y);
            tile.populateFromSaveDefinition(definition);
            i++;
            if(tile.isCaptured === true)
            {
               if(tile.uniqueDataDefinition != null && tile.uniqueDataDefinition.trackClassName != null)
               {
                  TrackManager.getInstance().unlockTrack(tile.uniqueDataDefinition.trackClassName,true);
               }
            }
            var _loc1_:Number = _terrainCachingProgressRatio * (Number(i) / length);
            townMap.signals.buildProgress.dispatch(_loc1_);
            if(i < length)
            {
               return true;
            }
            return false;
         },null,16,function():void
         {
            populateMonkeyConstructions(townMap,definitions);
         });
      }
      
      private function populateMonkeyConstructions(param1:TownMap, param2:Vector.<TileSaveDefinition>) : void
      {
         var i:int = 0;
         var length:int = 0;
         var tile:Tile = null;
         var definition:TileSaveDefinition = null;
         var buildingCachingProgressRatio:Number = NaN;
         var buildingOrders:Dictionary = null;
         var townMap:TownMap = param1;
         var definitions:Vector.<TileSaveDefinition> = param2;
         length = definitions.length;
         var softProcess:SoftProcess = new SoftProcess();
         buildingCachingProgressRatio = 1 - this._terrainCachingProgressRatio;
         this.system.city.setIsActive(false);
         definitions.sort(this.sortByBuildTime);
         BitClipCustom.globalPlaying = false;
         i = 0;
         while(i < definitions.length)
         {
            definition = definitions[i];
            tile = townMap.tileAt(definition.x,definition.y);
            tile.isCaptured = definition.isCaptured;
            i++;
         }
         townMap.signals.territoryFlagsSet.dispatch();
         var timeBefore:Number = getTimer();
         townMap.fenceBuilder.updateFenceAroundBlock(0,0,this.system.TOWN_MAP_WIDTH_GRIDSPACE,this.system.TOWN_MAP_HEIGHT_GRIDSPACE);
         WorldViewSignals.worldIsNowVisibleSignal.dispatch();
         buildingOrders = new Dictionary();
         i = 0;
         softProcess.run(function():Boolean
         {
            var _loc1_:String = null;
            if(length == 0)
            {
               return false;
            }
            definition = definitions[i++];
            tile = townMap.tileAt(definition.x,definition.y);
            tile.terrainDefinition = townMap._tileDefinitions.getTerrainDefinitionByID(definition.terrainDefinitionID);
            tile.isCaptured = definition.isCaptured;
            if(definition.buildingSaveDef)
            {
               _loc1_ = definition.buildingSaveDef.id;
               if(buildingOrders.hasOwnProperty(_loc1_))
               {
                  buildingOrders[_loc1_]++;
               }
               else
               {
                  buildingOrders[_loc1_] = 0;
               }
               tile.building = _buildingFactory.getBuildingFromBuildingSaveDefinition(definition.buildingSaveDef,system.city,buildingOrders[_loc1_]);
               tile.building.placeOnMap(townMap,false,false);
            }
            tile.build();
            townMap.signals.buildProgress.dispatch(_terrainCachingProgressRatio + buildingCachingProgressRatio * (Number(i) / length));
            if(i < length)
            {
               return true;
            }
            return false;
         },null,16,function():void
         {
            townMap.addCitizens();
            townMap._worldIsReady = true;
            BitClipCustom.globalPlaying = true;
            townMap.signals.populateFromSaveDefinitionComplete.dispatch();
            system.city.setIsActive(true);
         });
      }
      
      private function sortByBuildTime(param1:TileSaveDefinition, param2:TileSaveDefinition) : int
      {
         if(param1.buildingSaveDef && param2.buildingSaveDef)
         {
            if(param1.buildingSaveDef.timeCreated < param2.buildingSaveDef.timeCreated)
            {
               return -1;
            }
            return 1;
         }
         if(param1.buildingSaveDef && !param2.buildingSaveDef)
         {
            return -1;
         }
         if(!param1.buildingSaveDef && param2.buildingSaveDef)
         {
            return 1;
         }
         return 0;
      }
   }
}
