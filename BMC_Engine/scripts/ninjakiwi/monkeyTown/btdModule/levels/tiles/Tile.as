package ninjakiwi.monkeyTown.btdModule.levels.tiles
{
   import com.lgrey.vectors.LGVector2D;
   import flash.display.MovieClip;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.entities.BloonTrap;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class Tile
   {
      
      public static var backgroundSource:MovieClip;
      
      public static const road:int = 0;
      
      public static const underpass:int = 1;
      
      public static const teleport:int = 2;
      
      public static const stickysap:int = 3;
      
      public static const max:int = 4;
      
      public static var currentBloonMovement:LGVector2D = new LGVector2D();
      
      public static var processWindDirection:Boolean = false;
      
      public static var windDirection:LGVector2D = new LGVector2D(-1,0);
      
      public static var windStrength:Number = 0.5;
       
      
      public var transitionType:int = 0;
      
      public var layer:int = 0;
      
      public var nextTileIndices:Vector.<int>;
      
      public var nextTiles:Vector.<Tile>;
      
      public var previousTiles:Vector.<Tile>;
      
      protected const maxSectionLength:Number = 1;
      
      public var tileLength:Number;
      
      public var sectionLength:Number;
      
      public var wayPoints:Vector.<Vector2>;
      
      private var pathAlternator:int = 0;
      
      public var initialised:Boolean = false;
      
      public var isWind:Boolean = false;
      
      private var precalculatedAllPreviousTiles:Vector.<Tile>;
      
      public var distanceAtTileStart:Number = -1;
      
      private var precalculatedDistancetoEnd:Number = -1;
      
      private var precalculatedDistancetoStart:Number = -1;
      
      public function Tile()
      {
         this.nextTileIndices = new Vector.<int>();
         this.nextTiles = new Vector.<Tile>();
         this.previousTiles = new Vector.<Tile>();
         super();
      }
      
      public function ini_nextTileIndices(param1:Vector.<int>) : Tile
      {
         this.nextTileIndices = param1;
         return this;
      }
      
      public function ini_transitionType(param1:int) : Tile
      {
         this.transitionType = param1;
         return this;
      }
      
      public function ini_layer(param1:int) : Tile
      {
         this.layer = param1;
         return this;
      }
      
      public function initialise(param1:Vector.<Tile>) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Tile = null;
         if(this.initialised)
         {
            return;
         }
         for each(_loc2_ in this.nextTileIndices)
         {
            if(_loc2_ < 0)
            {
            }
            _loc3_ = param1[_loc2_];
            this.nextTiles.push(_loc3_);
            _loc3_.previousTiles.push(this);
         }
         this.initialised = true;
      }
      
      public function updateBloonPosition(param1:Bloon) : void
      {
         var _loc8_:Number = NaN;
         var _loc9_:Tile = null;
         var _loc10_:Number = NaN;
         var _loc11_:Tile = null;
         var _loc2_:Number = 0;
         if(param1.tileProgress < 0)
         {
            if(this.previousTiles.length != 0)
            {
               _loc9_ = this.previousTiles[0];
               if(_loc9_.transitionType != teleport)
               {
                  param1.tileProgress = param1.tileProgress + _loc9_.tileLength;
               }
               param1.tile = _loc9_;
               _loc9_.updateBloonPosition(param1);
            }
            else
            {
               param1.x = -5000;
            }
            return;
         }
         if(this.transitionType == teleport)
         {
            param1.tileProgress = param1.tileProgress + this.tileLength;
         }
         if(processWindDirection)
         {
            _loc10_ = windDirection.dot(param1.movementDirection);
            _loc2_ = 1 + _loc10_ * windStrength;
            if(_loc2_ < 0.1)
            {
               _loc2_ = 0.1;
            }
            param1.windDirectionSpeedScale = _loc2_;
         }
         var _loc3_:int = Math.floor((this.wayPoints.length - 1) * param1.tileProgress / this.tileLength);
         var _loc4_:Number = (param1.tileProgress - _loc3_ * this.sectionLength) / this.sectionLength;
         if(_loc3_ >= this.wayPoints.length - 1)
         {
            param1.tileProgress = param1.tileProgress - this.tileLength;
            if(this.nextTiles.length != 0)
            {
               this.pathAlternator++;
               _loc11_ = this.nextTiles[this.pathAlternator % this.nextTiles.length];
               if(param1.tile.isWind)
               {
                  param1.overallProgress = this.getOverallProgress();
               }
               param1.tile = _loc11_;
               _loc11_.updateBloonPosition(param1);
            }
            else
            {
               param1.completePath();
            }
            return;
         }
         var _loc5_:Vector2 = this.wayPoints[_loc3_];
         var _loc6_:Vector2 = this.wayPoints[_loc3_ + 1];
         var _loc7_:Number = _loc5_.x + (_loc6_.x - _loc5_.x) * _loc4_;
         _loc8_ = _loc5_.y + (_loc6_.y - _loc5_.y) * _loc4_;
         param1.movementDirection.x = _loc7_ - param1.x;
         param1.movementDirection.y = _loc8_ - param1.y;
         param1.movementDirection.normalize(1);
         param1.x = _loc7_;
         param1.y = _loc8_;
      }
      
      public function updateBloonTrapPosition(param1:BloonTrap) : void
      {
         var _loc6_:Tile = null;
         var _loc7_:Tile = null;
         if(param1.tileProgress < 0)
         {
            if(this.previousTiles.length != 0)
            {
               _loc6_ = this.previousTiles[0];
               if(_loc6_.transitionType != teleport)
               {
                  param1.tileProgress = param1.tileProgress + _loc6_.tileLength;
               }
               param1.tile = _loc6_;
               _loc6_.updateBloonTrapPosition(param1);
            }
            else
            {
               param1.x = -5000;
            }
            return;
         }
         if(this.transitionType == teleport)
         {
            param1.tileProgress = param1.tileProgress + this.tileLength;
         }
         var _loc2_:int = Math.floor((this.wayPoints.length - 1) * param1.tileProgress / this.tileLength);
         var _loc3_:Number = (param1.tileProgress - _loc2_ * this.sectionLength) / this.sectionLength;
         if(_loc2_ >= this.wayPoints.length - 1)
         {
            param1.tileProgress = param1.tileProgress - this.tileLength;
            if(this.nextTiles.length != 0)
            {
               this.pathAlternator++;
               _loc7_ = this.nextTiles[this.pathAlternator % this.nextTiles.length];
               param1.tile = _loc7_;
               _loc7_.updateBloonTrapPosition(param1);
            }
            else
            {
               param1.completePath();
            }
            return;
         }
         var _loc4_:Vector2 = this.wayPoints[_loc2_];
         var _loc5_:Vector2 = this.wayPoints[_loc2_ + 1];
         param1.x = _loc4_.x + (_loc5_.x - _loc4_.x) * _loc3_;
         param1.y = _loc4_.y + (_loc5_.y - _loc4_.y) * _loc3_;
      }
      
      public function get startAngle() : Number
      {
         return 0;
      }
      
      public function get endAngle() : Number
      {
         return 0;
      }
      
      public function get startX() : Number
      {
         return 0;
      }
      
      public function get startY() : Number
      {
         return 0;
      }
      
      public function get endX() : Number
      {
         return 0;
      }
      
      public function get endY() : Number
      {
         return 0;
      }
      
      public function getAllPreviousTiles(param1:Vector.<Tile>) : void
      {
         var _loc2_:Tile = null;
         if(this.precalculatedAllPreviousTiles)
         {
            for each(_loc2_ in this.precalculatedAllPreviousTiles)
            {
               param1.push(_loc2_);
            }
            return;
         }
         for each(_loc2_ in this.previousTiles)
         {
            _loc2_.getAllPreviousTiles(param1);
            if(_loc2_.transitionType == road)
            {
               param1.push(_loc2_);
            }
         }
         this.precalculatedAllPreviousTiles = new Vector.<Tile>();
         for each(_loc2_ in param1)
         {
            this.precalculatedAllPreviousTiles.push(_loc2_);
         }
      }
      
      public function getOverallProgress() : Number
      {
         if(this.distanceAtTileStart == -1)
         {
            this.distanceAtTileStart = 0;
            if(this.previousTiles.length != 0)
            {
               this.distanceAtTileStart = this.previousTiles[0].getOverallProgress();
               this.distanceAtTileStart = this.distanceAtTileStart + this.previousTiles[0].tileLength;
            }
         }
         return this.distanceAtTileStart;
      }
      
      public function getDistanceToEnd() : Number
      {
         if(this.precalculatedDistancetoEnd != -1)
         {
            return this.precalculatedDistancetoEnd;
         }
         var _loc1_:Number = this.transitionType == 2?Number(0):Number(this.tileLength);
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc4_:int = 0;
         while(_loc4_ < this.nextTiles.length)
         {
            _loc3_ = this.nextTiles[_loc4_].getDistanceToEnd();
            if(_loc3_ > _loc2_)
            {
               _loc2_ = _loc3_;
            }
            _loc4_++;
         }
         _loc1_ = _loc1_ + _loc2_;
         this.precalculatedDistancetoEnd = _loc1_;
         return _loc1_;
      }
      
      public function getDistanceToStart() : Number
      {
         if(this.precalculatedDistancetoStart != -1)
         {
            return this.precalculatedDistancetoStart;
         }
         var _loc1_:Number = this.transitionType == 2?Number(0):Number(this.tileLength);
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc4_:int = 0;
         while(_loc4_ < this.previousTiles.length)
         {
            _loc3_ = this.previousTiles[_loc4_].getDistanceToStart();
            if(_loc3_ > _loc2_)
            {
               _loc2_ = _loc3_;
            }
            _loc4_++;
         }
         _loc1_ = _loc1_ + _loc3_;
         this.precalculatedDistancetoStart = _loc1_;
         return _loc1_;
      }
   }
}
