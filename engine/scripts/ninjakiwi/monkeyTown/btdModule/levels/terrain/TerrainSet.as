package ninjakiwi.monkeyTown.btdModule.levels.terrain
{
   import display.Frame;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.StageQuality;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.TowerPlace;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   import ninjakiwi.monkeyTown.btdModule.utils.Rndm;
   
   public class TerrainSet
   {
      
      public static const TRACK:String = "track";
      
      public static const DEAD_ZONE:String = "deadZone";
      
      public static const WATER:String = "water";
      
      public static const LAND:String = "land";
      
      public static const TOWERS:String = "towers";
      
      public static const UNPLACEABLE_AREA:String = "unplaceableArea";
      
      public static const MANMADE_WATER:String = "manMadeWater";
      
      public static const MANMADE_LAND:String = "manMadeLand";
       
      
      public var terrainTypes:Dictionary = null;
      
      private var towerTestMapSource:MovieClip;
      
      public var towerMadeWater:Dictionary;
      
      public var towerMadeLand:Dictionary;
      
      public var platforms:Dictionary;
      
      public function TerrainSet(param1:Class = null)
      {
         var _loc6_:MovieClip = null;
         var _loc7_:TerrainType = null;
         var _loc8_:Bitmap = null;
         this.towerMadeWater = new Dictionary();
         this.towerMadeLand = new Dictionary();
         this.platforms = new Dictionary();
         super();
         if(param1 == null)
         {
            return;
         }
         var _loc2_:MovieClip = new param1();
         this.terrainTypes = new Dictionary();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.numChildren)
         {
            _loc6_ = MovieClip(_loc2_.getChildAt(_loc3_));
            _loc7_ = new TerrainType(_loc6_);
            this.terrainTypes[_loc6_.name] = _loc7_;
            _loc3_++;
         }
         if(this.terrainTypes[WATER] != null)
         {
            _loc8_ = new Bitmap(this.terrainTypes[WATER].inverseTestMap);
            _loc8_.scaleX = _loc8_.scaleY = 1 / TerrainType.STANDARD_PRECISION_SCALE;
         }
         else
         {
            _loc8_ = new Bitmap(new BitmapData(Main.mapArea.width,Main.mapArea.height,false,16764108));
         }
         var _loc4_:MovieClip = new MovieClip();
         _loc4_.addChild(_loc8_);
         var _loc5_:TerrainType = new TerrainType(_loc4_);
         this.terrainTypes[LAND] = _loc5_;
         this.generateTestMaps();
      }
      
      public function generateTestMaps(param1:TerrainType = null) : void
      {
         var _loc3_:Bitmap = null;
         var _loc4_:Bitmap = null;
         var _loc5_:Bitmap = null;
         var _loc2_:MovieClip = new MovieClip();
         if(this.terrainTypes[TRACK] != null)
         {
            _loc3_ = new Bitmap(this.terrainTypes[TRACK].testMap);
            _loc3_.scaleX = _loc3_.scaleY = 1 / TerrainType.STANDARD_PRECISION_SCALE;
            _loc2_.addChild(_loc3_);
         }
         if(this.terrainTypes[DEAD_ZONE] != null)
         {
            _loc4_ = new Bitmap(this.terrainTypes[DEAD_ZONE].testMap);
            _loc4_.scaleX = _loc4_.scaleY = 1 / TerrainType.STANDARD_PRECISION_SCALE;
            _loc2_.addChild(_loc4_);
         }
         if(param1 != null)
         {
            _loc5_ = new Bitmap(param1.testMap);
            _loc5_.scaleX = _loc5_.scaleY = 1 / TerrainType.STANDARD_PRECISION_SCALE;
            _loc2_.addChild(_loc5_);
         }
         if(this.towerTestMapSource != null)
         {
            _loc2_.addChild(this.towerTestMapSource);
         }
         this.terrainTypes[UNPLACEABLE_AREA] = new TerrainType(_loc2_);
      }
      
      public function addTower(param1:Tower, param2:Vector.<Tower>) : void
      {
         if(param1.def != null)
         {
            if(param1.def.changesTerrain != 0)
            {
               this.addTerrainChangingTower(param1);
            }
            if(param1.def.isPlatform)
            {
               this.platforms[param1] = new TowerTerrain(param1,new TerrainType(param1.occupiedSpace));
            }
            else
            {
               this.checkAndAddToPlatform(param1);
            }
         }
         this.updateTowerMap(param2);
      }
      
      public function removeTower(param1:Tower, param2:Vector.<Tower>) : void
      {
         if(param1.def.changesTerrain != 0)
         {
            this.removeTerrainChangingTower(param1);
         }
         if(param1.def.isPlatform)
         {
            delete this.platforms[param1];
         }
         else
         {
            this.checkAndRemoveFromPlatform(param1);
         }
         this.updateTowerMap(param2);
      }
      
      public function removeAllTowers(param1:Vector.<Tower>) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            if(param1[_loc2_].def.changesTerrain != 0)
            {
               this.removeTerrainChangingTower(param1[_loc2_]);
            }
            if(param1[_loc2_].def.isPlatform)
            {
               delete this.platforms[param1[_loc2_]];
            }
            else
            {
               this.checkAndRemoveFromPlatform(param1[_loc2_]);
            }
            _loc2_++;
         }
         this.updateTowerMap(param1);
      }
      
      public function updateTowerMap(param1:Vector.<Tower>) : void
      {
         var _loc2_:Tower = null;
         this.towerTestMapSource = null;
         for each(_loc2_ in param1)
         {
            if(!(_loc2_.def == null || _loc2_.def.isPlatform))
            {
               if(this.towerTestMapSource == null)
               {
                  this.towerTestMapSource = new MovieClip();
               }
               this.towerTestMapSource.addChild(_loc2_.occupiedSpace);
            }
         }
         this.generateTestMaps();
      }
      
      private function addTerrainChangingTower(param1:Tower) : void
      {
         switch(param1.def.changesTerrain)
         {
            case TowerDef.CHANGE_TERRAIN_TO_WATER:
               this.towerMadeWater[param1] = new TowerTerrain(param1,new TerrainType(param1.occupiedSpace));
               break;
            case TowerDef.CHANGE_TERRAIN_TO_LAND:
               this.towerMadeLand[param1] = new TowerTerrain(param1,new TerrainType(param1.occupiedSpace));
         }
      }
      
      private function removeTerrainChangingTower(param1:Tower) : void
      {
         switch(param1.def.changesTerrain)
         {
            case TowerDef.CHANGE_TERRAIN_TO_WATER:
               delete this.towerMadeWater[param1];
               break;
            case TowerDef.CHANGE_TERRAIN_TO_LAND:
               delete this.towerMadeLand[param1];
         }
      }
      
      private function checkAndAddToPlatform(param1:Tower) : void
      {
         var _loc3_:TowerTerrain = null;
         var _loc4_:Boolean = false;
         var _loc2_:MovieClip = param1.occupiedSpace;
         for each(_loc3_ in this.platforms)
         {
            _loc4_ = _loc3_.terrain.isWithin(_loc2_);
            if(_loc4_)
            {
               _loc3_.tower.addChildTower(param1);
               return;
            }
         }
      }
      
      private function checkAndRemoveFromPlatform(param1:Tower) : void
      {
         var _loc2_:TowerTerrain = null;
         for each(_loc2_ in this.platforms)
         {
            if(_loc2_.tower.ifRemovedChildTower(param1))
            {
               return;
            }
         }
      }
      
      public function canPlace(param1:MovieClip, param2:Boolean = false, param3:Boolean = false) : Boolean
      {
         var _loc4_:String = null;
         if(TowerPlace.USE_TOWERPLACE_FIX)
         {
            if(Frame.stage !== null)
            {
               _loc4_ = Frame.stage.quality;
               Frame.stage.quality = StageQuality.LOW;
            }
         }
         var _loc5_:Boolean = false;
         if(false == this.isInPlayArea(param1))
         {
            _loc5_ = false;
         }
         else if(param3)
         {
            _loc5_ = this.terrainTypes[UNPLACEABLE_AREA].isOutside(param1);
         }
         else if(param2)
         {
            _loc5_ = this.terrainTypes[UNPLACEABLE_AREA].isOutside(param1) && this.onWater(param1);
         }
         else
         {
            _loc5_ = this.terrainTypes[UNPLACEABLE_AREA].isOutside(param1) && this.onLand(param1);
         }
         if(TowerPlace.USE_TOWERPLACE_FIX)
         {
            if(Frame.stage !== null && _loc4_ !== StageQuality.LOW)
            {
               Frame.stage.quality = _loc4_;
            }
         }
         return _loc5_;
      }
      
      public function isInPlayArea(param1:MovieClip) : Boolean
      {
         var _loc2_:Rectangle = param1.getBounds(null);
         var _loc3_:Boolean = param1.x + _loc2_.x < Main.playArea.x || param1.y + _loc2_.y < Main.playArea.y || param1.x + _loc2_.right > Main.playArea.right || param1.y + _loc2_.bottom > Main.playArea.bottom;
         return false == _loc3_;
      }
      
      public function isOnTrack(param1:MovieClip) : Boolean
      {
         var _loc2_:Rectangle = param1.getBounds(null);
         if(param1.x + _loc2_.x < 0 || param1.y + _loc2_.y < 0 || param1.x + _loc2_.x + _loc2_.width > Main.playArea.width || param1.y + _loc2_.y + _loc2_.height > Main.playArea.height)
         {
            return false;
         }
         return !this.terrainTypes[TRACK].isOutside(param1);
      }
      
      public function onWater(param1:MovieClip) : Boolean
      {
         return (this.terrainTypes[WATER] != null && this.terrainTypes[WATER].isWithin(param1) || this.completelyOnTowerMadeWater(param1)) && !this.touchingTowerMadeLand(param1);
      }
      
      public function onLand(param1:MovieClip) : Boolean
      {
         return (this.terrainTypes[LAND].isWithin(param1) || this.completelyOnTowerMadeLand(param1)) && !this.touchingTowerMadeWater(param1);
      }
      
      private function completelyOnTowerMadeWater(param1:MovieClip) : Boolean
      {
         var _loc2_:TowerTerrain = null;
         var _loc3_:Boolean = false;
         for each(_loc2_ in this.towerMadeWater)
         {
            _loc3_ = _loc2_.terrain.isWithin(param1);
            if(_loc3_)
            {
               return true;
            }
         }
         return false;
      }
      
      private function completelyOnTowerMadeLand(param1:MovieClip) : Boolean
      {
         var _loc2_:TowerTerrain = null;
         var _loc3_:Boolean = false;
         for each(_loc2_ in this.towerMadeLand)
         {
            _loc3_ = _loc2_.terrain.isWithin(param1);
            if(_loc3_)
            {
               return true;
            }
         }
         return false;
      }
      
      private function touchingTowerMadeWater(param1:MovieClip) : Boolean
      {
         var _loc2_:TowerTerrain = null;
         var _loc3_:Boolean = false;
         for each(_loc2_ in this.towerMadeWater)
         {
            _loc3_ = _loc2_.terrain.isOutside(param1);
            if(!_loc3_)
            {
               return true;
            }
         }
         return false;
      }
      
      private function touchingTowerMadeLand(param1:MovieClip) : Boolean
      {
         var _loc2_:TowerTerrain = null;
         var _loc3_:Boolean = false;
         for each(_loc2_ in this.towerMadeLand)
         {
            _loc3_ = _loc2_.terrain.isOutside(param1);
            if(!_loc3_)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getValidPlacePositionInRadius(param1:MovieClip, param2:Vector2, param3:Number, param4:Boolean = false, param5:Boolean = false) : Vector2
      {
         var _loc7_:Vector2 = null;
         var _loc6_:int = 0;
         while(_loc6_ < 30)
         {
            _loc7_ = new Vector2();
            _loc7_.fromPolar(2 * Math.PI * Rndm.random(),param3 * Rndm.random());
            param1.x = param2.x + _loc7_.x;
            param1.y = param2.y + _loc7_.y;
            if(this.canPlace(param1,param4,param5))
            {
               return new Vector2(param1.x,param1.y);
            }
            _loc6_++;
         }
         return null;
      }
   }
}
