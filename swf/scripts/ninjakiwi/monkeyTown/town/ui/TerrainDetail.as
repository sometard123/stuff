package ninjakiwi.monkeyTown.town.ui
{
   import assets.ui.TerrainDetailClip;
   import flash.display.MovieClip;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.specialMissions.SpecialMissionsManager;
   import ninjakiwi.monkeyTown.town.specialMissions.definition.SpecialMissionDefinition;
   import ninjakiwi.monkeyTown.town.tile.TileDefinitions;
   import ninjakiwi.monkeyTown.town.townMap.bloonPredictor.BloonPredictor;
   import ninjakiwi.monkeyTown.town.ui.bloon.BloonTypeIcon;
   
   public class TerrainDetail
   {
      
      public static const TERRAIN_INFO:uint = 1;
      
      public static const DIFFICULTY:uint = 16;
      
      public static const COST:uint = 256;
      
      public static const STARTING_CASH:uint = 4096;
      
      public static const ASSAULT:uint = 65536;
      
      public static const STRONGEST:uint = 1048576;
       
      
      private var _type:uint;
      
      private var _linkedClip:TerrainDetailClip;
      
      private var _assaultClips:Vector.<MovieClip>;
      
      private var _bloonType:BloonTypeIcon;
      
      private const _resourceStore:ResourceStore = ResourceStore.getInstance();
      
      private const _system:MonkeySystem = MonkeySystem.getInstance();
      
      public function TerrainDetail(param1:TerrainDetailClip, param2:uint = 0)
      {
         this._assaultClips = new Vector.<MovieClip>();
         super();
         this._linkedClip = param1;
         var _loc3_:Vector.<Number> = new Vector.<Number>();
         _loc3_.push(this._linkedClip.terrainInfoGroup.y);
         _loc3_.push(this._linkedClip.difficultyPipsGroup.y);
         _loc3_.push(this._linkedClip.costGroup.y);
         _loc3_.push(this._linkedClip.startingCashGroup.y);
         _loc3_.push(this._linkedClip.highestBloonGroup.y);
         this._linkedClip.terrainInfoGroup.visible = false;
         this._linkedClip.difficultyPipsGroup.visible = false;
         this._linkedClip.costGroup.visible = false;
         this._linkedClip.startingCashGroup.visible = false;
         this._linkedClip.option1.visible = false;
         this._linkedClip.option2.visible = false;
         this._linkedClip.highestBloonGroup.visible = false;
         this._assaultClips.push(this._linkedClip.option1);
         this._assaultClips.push(this._linkedClip.option2);
         this._type = param2;
         var _loc4_:int = 0;
         if((param2 & STRONGEST) == STRONGEST)
         {
            this._linkedClip.highestBloonGroup.visible = true;
            this._linkedClip.highestBloonGroup.y = _loc4_ < _loc3_.length?Number(_loc3_[_loc4_++]):Number(0);
            this._bloonType = new BloonTypeIcon();
            this._linkedClip.highestBloonGroup.addChild(this._bloonType);
            this._bloonType.x = this._linkedClip.highestBloonGroup.bloonType.x;
            this._bloonType.y = this._linkedClip.highestBloonGroup.bloonType.y;
            this._linkedClip.highestBloonGroup.bloonType.visible = false;
         }
         if((param2 & DIFFICULTY) == DIFFICULTY)
         {
            this._linkedClip.difficultyPipsGroup.visible = true;
            this._linkedClip.difficultyPipsGroup.y = _loc4_ < _loc3_.length?Number(_loc3_[_loc4_++]):Number(0);
            if((param2 & ASSAULT) == ASSAULT)
            {
               this._linkedClip.option1.y = this._linkedClip.difficultyPipsGroup.y - 5;
               this._linkedClip.option2.y = this._linkedClip.difficultyPipsGroup.y - 5;
            }
         }
         if((param2 & TERRAIN_INFO) == TERRAIN_INFO)
         {
            this._linkedClip.terrainInfoGroup.visible = true;
            this._linkedClip.terrainInfoGroup.y = _loc4_ < _loc3_.length?Number(_loc3_[_loc4_++]):Number(0);
         }
         if((param2 & COST) == COST)
         {
            this._linkedClip.costGroup.visible = true;
            this._linkedClip.costGroup.y = _loc4_ < _loc3_.length?Number(_loc3_[_loc4_++]):Number(0);
         }
         if((param2 & STARTING_CASH) == STARTING_CASH)
         {
            this._linkedClip.startingCashGroup.visible = true;
            this._linkedClip.startingCashGroup.y = _loc4_ < _loc3_.length?Number(_loc3_[_loc4_++]):Number(0);
         }
      }
      
      public function destroy() : void
      {
         this._assaultClips.length = 0;
         this._linkedClip = null;
      }
      
      public function swapRow(param1:int, param2:int) : void
      {
         var _loc5_:int = 0;
         var _loc3_:MovieClip = this.getClipByFlag(param1);
         var _loc4_:MovieClip = this.getClipByFlag(param2);
         if(_loc3_ != null && _loc4_ != null)
         {
            _loc5_ = _loc3_.y;
            _loc3_.y = _loc4_.y;
            _loc4_.y = _loc5_;
            if((param1 & DIFFICULTY) == DIFFICULTY)
            {
               this._linkedClip.option1.y = _loc3_.y - 5;
               this._linkedClip.option2.y = _loc3_.y - 5;
            }
            if((param2 & DIFFICULTY) == DIFFICULTY)
            {
               this._linkedClip.option1.y = _loc4_.y - 5;
               this._linkedClip.option2.y = _loc4_.y - 5;
            }
         }
      }
      
      private function getClipByFlag(param1:int) : MovieClip
      {
         if((param1 & STRONGEST) == STRONGEST)
         {
            return this._linkedClip.highestBloonGroup;
         }
         if((param1 & DIFFICULTY) == DIFFICULTY)
         {
            return this._linkedClip.difficultyPipsGroup;
         }
         if((param1 & TERRAIN_INFO) == TERRAIN_INFO)
         {
            return this._linkedClip.terrainInfoGroup;
         }
         if((param1 & COST) == COST)
         {
            return this._linkedClip.costGroup;
         }
         if((param1 & STARTING_CASH) == STARTING_CASH)
         {
            return this._linkedClip.startingCashGroup;
         }
         return null;
      }
      
      public function setDetails(param1:Tile, param2:int = 0, param3:int = 0, param4:int = 0) : void
      {
         var _loc7_:SpecialMissionDefinition = null;
         var _loc8_:int = 0;
         if((this._type & TERRAIN_INFO) == TERRAIN_INFO)
         {
            if(this._linkedClip.terrainInfoGroup.terrainInfoTxt != null)
            {
               _loc7_ = SpecialMissionsManager.getInstance().findSpecialMission(param1);
               if(_loc7_ == null)
               {
                  this._linkedClip.terrainInfoGroup.terrainInfoTxt.text = param1.terrainDefinition.name + " " + LocalisationConstants.TERRAIN;
               }
               else
               {
                  this._linkedClip.terrainInfoGroup.terrainInfoTxt.text = _loc7_.name;
               }
            }
            if(this._linkedClip.terrainInfoGroup.terrainIcon != null)
            {
               this._linkedClip.terrainInfoGroup.terrainIcon.gotoAndStop(this.getSymbolFrame(param1));
            }
         }
         var _loc5_:int = this._system.map.getRank(param1);
         var _loc6_:int = MonkeySystem.getInstance().map.getDifficultyAtTile(param1);
         if((this._type & STRONGEST) == STRONGEST)
         {
            if(this._linkedClip.highestBloonGroup != null)
            {
               if(this._bloonType != null)
               {
                  this._bloonType.setBloonType(BloonPredictor.getWeightsDefinition(_loc6_,true,param1.variantHint).strongestBloonType);
               }
            }
         }
         this._linkedClip.option1.visible = false;
         this._linkedClip.option2.visible = false;
         if((this._type & DIFFICULTY) == DIFFICULTY)
         {
            this.setDifficultyPips(_loc5_);
            _loc8_ = 0;
            if((this._type & ASSAULT) == ASSAULT)
            {
               if(param1.isCamoTile)
               {
                  if(this._assaultClips.length > _loc8_)
                  {
                     this._assaultClips[_loc8_].visible = true;
                     this._assaultClips[_loc8_].gotoAndStop(3);
                     _loc8_++;
                  }
               }
               else if(_loc6_ >= Constants.DIFFICULTY_REQUIRED_BEFORE_CAMO)
               {
                  if(this._assaultClips.length > _loc8_)
                  {
                     this._assaultClips[_loc8_].visible = true;
                     this._assaultClips[_loc8_].gotoAndStop(1);
                     _loc8_++;
                  }
               }
               if(param1.isRegenTile)
               {
                  if(this._assaultClips.length > _loc8_)
                  {
                     this._assaultClips[_loc8_].visible = true;
                     this._assaultClips[_loc8_].gotoAndStop(4);
                     _loc8_++;
                  }
               }
               else if(_loc6_ >= Constants.DIFFICULTY_REQUIRED_BEFORE_REGEN)
               {
                  if(this._assaultClips.length > _loc8_)
                  {
                     this._assaultClips[_loc8_].visible = true;
                     this._assaultClips[_loc8_].gotoAndStop(2);
                     _loc8_++;
                  }
               }
            }
         }
         if((this._type & COST) == COST)
         {
            if(this._linkedClip.costGroup.costToAttackTxt != null)
            {
               this._linkedClip.costGroup.costToAttackTxt.text = LocalisationConstants.MONEY_SYMBOL + param2;
            }
         }
         if((this._type & STARTING_CASH) == STARTING_CASH)
         {
            this.setStartingCash(param3,param4);
         }
      }
      
      public function setStrongest(param1:String) : void
      {
         if((this._type & STRONGEST) == STRONGEST)
         {
            if(this._linkedClip.highestBloonGroup != null)
            {
               if(this._bloonType != null)
               {
                  this._bloonType.setBloonType(param1);
               }
            }
         }
      }
      
      public function setDifficultyVisible(param1:Boolean) : void
      {
         if(this._linkedClip.difficultyPipsGroup.indicator != null)
         {
            this._linkedClip.difficultyPipsGroup.indicator.visible = param1;
         }
         if(this._linkedClip.difficultyPipsGroup.difficultyTxt != null)
         {
            this._linkedClip.difficultyPipsGroup.difficultyTxt.visible = param1;
         }
         if(param1 == true)
         {
            this._type = this._type | DIFFICULTY;
         }
         else
         {
            this._type = this._type & (286331153 ^ DIFFICULTY);
         }
         this._linkedClip.option1.visible = param1;
         this._linkedClip.option2.visible = param1;
         this._linkedClip.difficultyPipsGroup.visible = param1;
      }
      
      public function setStartingCash(param1:int, param2:int = 0) : void
      {
         if(this._linkedClip.startingCashGroup.startingCash != null)
         {
            this._linkedClip.startingCashGroup.startingCash.text = LocalisationConstants.MONEY_SYMBOL + param1;
            if(param2 > 0)
            {
               this._linkedClip.startingCashGroup.startingCash.text = this._linkedClip.startingCashGroup.startingCash.text + (" + " + LocalisationConstants.MONEY_SYMBOL + param2);
            }
         }
      }
      
      public function setTerrainDetail(param1:String, param2:String) : void
      {
         this._linkedClip.terrainInfoGroup.terrainInfoTxt.text = param1 + " " + LocalisationConstants.TERRAIN;
         if(this._linkedClip.terrainInfoGroup.terrainIcon != null)
         {
            this._linkedClip.terrainInfoGroup.terrainIcon.gotoAndStop(this.findTerrainSymbolFrame(param2));
         }
         this.findTerrainSymbolFrame(param2);
      }
      
      public function setDifficultyPips(param1:int) : void
      {
         if(this._linkedClip.difficultyPipsGroup.indicator != null)
         {
            this._linkedClip.difficultyPipsGroup.indicator.gotoAndStop(param1 + 1);
         }
         if(this._linkedClip.difficultyPipsGroup.difficultyTxt != null)
         {
            this._linkedClip.difficultyPipsGroup.difficultyTxt.text = this._system.map.getDifficultyDescriptionByRank(param1);
         }
      }
      
      private function getSymbolFrame(param1:Tile) : int
      {
         var _loc2_:String = null;
         if(param1.terrainSpecialProperty != null)
         {
            _loc2_ = param1.terrainSpecialProperty.id;
            if(_loc2_ == TileDefinitions.getInstance().TRANQUIL_GLADE)
            {
               return 13;
            }
            if(_loc2_ == TileDefinitions.getInstance().PHASE_CRYSTAL)
            {
               return 14;
            }
            if(_loc2_ == TileDefinitions.getInstance().MOAB_GRAVEYARD)
            {
               return 15;
            }
            if(_loc2_ == TileDefinitions.getInstance().STICKY_SAP_PLANT)
            {
               return 16;
            }
            if(_loc2_ == TileDefinitions.getInstance().CONSECRATED_GROUND)
            {
               return 17;
            }
            if(_loc2_ == TileDefinitions.getInstance().CAVES)
            {
               return 18;
            }
            if(_loc2_ == TileDefinitions.getInstance().WATTLE_TREES)
            {
               return 19;
            }
            if(_loc2_ == TileDefinitions.getInstance().SHIPWRECK)
            {
               return 20;
            }
            if(_loc2_ == TileDefinitions.getInstance().GLACIER)
            {
               return 21;
            }
            if(_loc2_ == TileDefinitions.getInstance().SANDSTORM)
            {
               return 25;
            }
            if(_loc2_ == TileDefinitions.getInstance().DRY_AS_A_BONE)
            {
               return 26;
            }
            if(_loc2_ == TileDefinitions.getInstance().ZZZZOMG)
            {
               return 27;
            }
            return 1;
         }
         return this.findTerrainSymbolFrame(param1.terrainDefinition.id);
      }
      
      private function findTerrainSymbolFrame(param1:String) : int
      {
         var _loc2_:String = param1;
         if(_loc2_ == TileDefinitions.getInstance().GRASS)
         {
            return 1;
         }
         if(_loc2_ == TileDefinitions.getInstance().FOREST)
         {
            return 2;
         }
         if(_loc2_ == TileDefinitions.getInstance().HEAVY_FOREST)
         {
            return 3;
         }
         if(_loc2_ == TileDefinitions.getInstance().HILLS)
         {
            return 4;
         }
         if(_loc2_ == TileDefinitions.getInstance().VOLCANO)
         {
            return 5;
         }
         if(_loc2_ == TileDefinitions.getInstance().DESERT)
         {
            return 6;
         }
         if(_loc2_ == TileDefinitions.getInstance().JUNGLE)
         {
            return 7;
         }
         if(_loc2_ == TileDefinitions.getInstance().RUINS)
         {
            return 8;
         }
         if(_loc2_ == TileDefinitions.getInstance().MOUNTAINS)
         {
            return 9;
         }
         if(_loc2_ == TileDefinitions.getInstance().SNOW)
         {
            return 10;
         }
         if(_loc2_ == TileDefinitions.getInstance().RIVER)
         {
            return 11;
         }
         if(_loc2_ == TileDefinitions.getInstance().LAKE)
         {
            return 12;
         }
         if(_loc2_ == TileDefinitions.getInstance().DESERT_HIGHLANDS)
         {
            return 22;
         }
         if(_loc2_ == TileDefinitions.getInstance().DESERT_BADLANDS)
         {
            return 23;
         }
         if(_loc2_ == TileDefinitions.getInstance().DESERT_ARID_GRASSLANDS)
         {
            return 24;
         }
         return 1;
      }
   }
}
