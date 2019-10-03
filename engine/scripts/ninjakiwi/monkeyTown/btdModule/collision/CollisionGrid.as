package ninjakiwi.monkeyTown.btdModule.collision
{
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.framework.Processable;
   import ninjakiwi.monkeyTown.btdModule.levels.Level;
   import ninjakiwi.monkeyTown.btdModule.math.Intersection;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.SpecialTrackManager;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   
   public class CollisionGrid implements Processable
   {
      
      public static const cellSize:Number = 40;
      
      public static const proportionOfCell:Number = 1 / cellSize;
       
      
      public var rows:int = 0;
      
      public var columns:int = 0;
      
      public var cells:Vector.<Vector.<Bloon>>;
      
      public var adjacencyData:Vector.<Vector.<Vector.<Bloon>>>;
      
      public var level:Level = null;
      
      private var testPosition:Vector2;
      
      private var u:Vector2;
      
      private var v:Vector2;
      
      private var c:Vector2;
      
      public function CollisionGrid()
      {
         var _loc2_:int = 0;
         var _loc3_:Vector.<Vector.<Bloon>> = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:* = false;
         var _loc9_:* = false;
         var _loc10_:* = false;
         var _loc11_:* = false;
         this.cells = new Vector.<Vector.<Bloon>>();
         this.adjacencyData = new Vector.<Vector.<Vector.<Bloon>>>();
         this.testPosition = new Vector2();
         this.u = new Vector2();
         this.v = new Vector2();
         this.c = new Vector2();
         super();
         while(cellSize * this.columns < Main.mapArea.width)
         {
            this.columns++;
         }
         while(cellSize * this.rows < Main.mapArea.height)
         {
            this.rows++;
         }
         while(this.cells.length < this.columns * this.rows)
         {
            this.cells.push(new Vector.<Bloon>());
         }
         var _loc1_:int = 0;
         while(_loc1_ < this.rows)
         {
            _loc2_ = 0;
            while(_loc2_ < this.columns)
            {
               _loc3_ = new Vector.<Vector.<Bloon>>();
               _loc4_ = _loc1_ - 1;
               _loc5_ = _loc1_ + 1;
               _loc6_ = _loc2_ - 1;
               _loc7_ = _loc2_ + 1;
               _loc8_ = _loc4_ >= 0;
               _loc9_ = _loc5_ < this.rows;
               _loc10_ = _loc6_ >= 0;
               _loc11_ = _loc7_ < this.columns;
               if(_loc8_)
               {
                  if(_loc10_)
                  {
                     _loc3_.push(this.cells[_loc6_ + _loc4_ * this.columns]);
                  }
                  _loc3_.push(this.cells[_loc2_ + _loc4_ * this.columns]);
                  if(_loc11_)
                  {
                     _loc3_.push(this.cells[_loc7_ + _loc4_ * this.columns]);
                  }
               }
               if(_loc10_)
               {
                  _loc3_.push(this.cells[_loc6_ + _loc1_ * this.columns]);
               }
               _loc3_.push(this.cells[_loc2_ + _loc1_ * this.columns]);
               if(_loc11_)
               {
                  _loc3_.push(this.cells[_loc7_ + _loc1_ * this.columns]);
               }
               if(_loc9_)
               {
                  if(_loc10_)
                  {
                     _loc3_.push(this.cells[_loc6_ + _loc5_ * this.columns]);
                  }
                  _loc3_.push(this.cells[_loc2_ + _loc5_ * this.columns]);
                  if(_loc11_)
                  {
                     _loc3_.push(this.cells[_loc7_ + _loc5_ * this.columns]);
                  }
               }
               this.adjacencyData.push(_loc3_);
               _loc2_++;
            }
            _loc1_++;
         }
      }
      
      public function init(param1:Level) : void
      {
         this.level = param1;
      }
      
      public function clear() : void
      {
         var _loc1_:Vector.<Bloon> = null;
         for each(_loc1_ in this.cells)
         {
            _loc1_.length = 0;
         }
      }
      
      public function getCellIndex(param1:Number, param2:Number) : int
      {
         var _loc3_:int = int(param1 * proportionOfCell);
         var _loc4_:int = int(param2 * proportionOfCell);
         if(_loc3_ < 0 || _loc3_ >= this.columns || _loc4_ < 0 || _loc4_ >= this.rows)
         {
            return -1;
         }
         return _loc4_ * this.columns + _loc3_;
      }
      
      public function addToCell(param1:Bloon, param2:int) : void
      {
         var _loc3_:Vector.<Bloon> = null;
         if(param2 != -1)
         {
            if(param1.type < Bloon.MOAB)
            {
               this.cells[param2].push(param1);
            }
            else
            {
               for each(_loc3_ in this.adjacencyData[param2])
               {
                  _loc3_.push(param1);
               }
            }
         }
      }
      
      public function removeFromCell(param1:Bloon, param2:int) : void
      {
         var _loc3_:Vector.<Bloon> = null;
         var _loc4_:int = 0;
         if(param2 != -1)
         {
            for each(_loc3_ in this.adjacencyData[param2])
            {
               _loc4_ = _loc3_.indexOf(param1);
               if(_loc4_ != -1)
               {
                  _loc3_.splice(_loc4_,1);
               }
            }
         }
      }
      
      public function switchCells(param1:Bloon, param2:int, param3:int) : void
      {
         var _loc4_:Vector.<Bloon> = null;
         var _loc5_:int = 0;
         if(param2 != -1)
         {
            for each(_loc4_ in this.adjacencyData[param2])
            {
               _loc5_ = _loc4_.indexOf(param1);
               if(_loc5_ != -1)
               {
                  _loc4_.splice(_loc5_,1);
               }
            }
         }
         if(param3 != -1)
         {
            if(param1.type < Bloon.MOAB)
            {
               this.cells[param3].push(param1);
            }
            else
            {
               for each(_loc4_ in this.adjacencyData[param3])
               {
                  _loc4_.push(param1);
               }
            }
         }
      }
      
      public function getCellAndAdjacentCells(param1:Number, param2:Number) : Vector.<Vector.<Bloon>>
      {
         var _loc3_:int = this.getCellIndex(param1,param2);
         if(_loc3_ >= 0 && _loc3_ < this.adjacencyData.length)
         {
            return this.adjacencyData[_loc3_];
         }
         return new Vector.<Vector.<Bloon>>();
      }
      
      public function getCellsInRange(param1:Number, param2:Number, param3:Number) : Vector.<Vector.<Bloon>>
      {
         var _loc4_:int = Math.max(int((param2 - param3) * proportionOfCell),0);
         var _loc5_:int = Math.min(int((param2 + param3) * proportionOfCell),this.rows - 1);
         var _loc6_:int = Math.max(int((param1 - param3) * proportionOfCell),0);
         var _loc7_:int = Math.min(int((param1 + param3) * proportionOfCell),this.columns - 1);
         var _loc8_:Vector.<Vector.<Bloon>> = new Vector.<Vector.<Bloon>>();
         param1 = _loc6_;
         while(param1 <= _loc7_)
         {
            param2 = _loc4_;
            while(param2 <= _loc5_)
            {
               _loc8_.push(this.cells[param2 * this.columns + param1]);
               param2++;
            }
            param1++;
         }
         return _loc8_;
      }
      
      public function registerTower(param1:Tower) : void
      {
         if(param1 == null || param1.def == null)
         {
            return;
         }
         param1.collisionTestCells = this.getCellsInRange(param1.x,param1.y,param1.def.rangeOfVisibility);
      }
      
      public function deregisterTower(param1:Tower) : void
      {
         param1.collisionTestCells.splice(0,param1.collisionTestCells.length);
      }
      
      public function process(param1:Number) : void
      {
         this.processProjectileCollisions(param1);
         this.processTowerTargetting();
      }
      
      private function processTowerTargetting() : void
      {
         var _loc2_:Tower = null;
         var _loc3_:Vector.<Bloon> = null;
         var _loc1_:Vector2 = Pool.get(Vector2);
         for each(_loc2_ in this.level.allTowers)
         {
            if(!(!_loc2_.checkingForBloons || _loc2_.def == null))
            {
               _loc1_.x = _loc2_.x;
               _loc1_.y = _loc2_.y;
               _loc2_.targetsByPriority = new Vector.<Bloon>();
               for each(_loc3_ in _loc2_.collisionTestCells)
               {
                  this.getTargets(_loc1_,!!_loc2_.def.targetAll?Number(2000):Number(_loc2_.def.rangeOfVisibility),_loc2_.targetMask,_loc2_.targetsByPriority,_loc3_);
               }
               this.sortTargetsByPriority(_loc2_.targetPriority,_loc2_.targetsByPriority,_loc1_);
            }
         }
         Pool.release(_loc1_);
      }
      
      private function getTargets(param1:Vector2, param2:Number, param3:int, param4:Vector.<Bloon>, param5:Vector.<Bloon>) : void
      {
         var _loc6_:Bloon = null;
         var _loc7_:Boolean = false;
         var _loc8_:* = false;
         var _loc9_:* = false;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         for each(_loc6_ in param5)
         {
            _loc7_ = _loc6_.isInTunnel;
            _loc8_ = int(param3 & _loc6_.immunity) != 0;
            _loc9_ = _loc6_.type == -1;
            _loc10_ = param1.x - _loc6_.x;
            _loc11_ = param1.y - _loc6_.y;
            _loc12_ = _loc10_ * _loc10_ + _loc11_ * _loc11_;
            _loc13_ = param2 + _loc6_.targetAddon;
            _loc14_ = _loc13_ * _loc13_;
            if(_loc12_ <= _loc14_ && !_loc7_ && !_loc8_ && !_loc9_)
            {
               param4.push(_loc6_);
            }
         }
      }
      
      private function sortTargetsByPriority(param1:int, param2:Vector.<Bloon>, param3:Vector2) : void
      {
         switch(param1)
         {
            case Tower.TARGET_FIRST:
               param2.sort(this.sortFirstToLast);
               break;
            case Tower.TARGET_LAST:
               param2.sort(this.sortLastToFirst);
               break;
            case Tower.TARGET_CLOSE:
               this.testPosition.x = param3.x;
               this.testPosition.y = param3.y;
               param2.sort(this.sortByCloseness);
               break;
            case Tower.TARGET_STRONG:
               param2.sort(this.sortByStrength);
         }
      }
      
      private function processProjectileCollisions(param1:Number) : void
      {
         var _loc5_:Projectile = null;
         var _loc6_:Number = NaN;
         var _loc7_:Vector.<Vector.<Bloon>> = null;
         var _loc8_:int = 0;
         var _loc9_:Bloon = null;
         var _loc10_:Boolean = false;
         var _loc11_:* = false;
         var _loc12_:Bloon = null;
         var _loc13_:* = false;
         var _loc14_:Boolean = false;
         var _loc2_:Vector2 = Pool.get(Vector2);
         var _loc3_:Vector2 = Pool.get(Vector2);
         var _loc4_:Vector2 = Pool.get(Vector2);
         for each(_loc5_ in this.level.allProjectiles)
         {
            if(!(_loc5_.def == null || _loc5_.pierce <= 0))
            {
               _loc6_ = _loc5_.buffedRadius;
               if(_loc5_.stationary)
               {
                  if(_loc5_.testBloons == null)
                  {
                     _loc5_.testBloons = this.getCellsInRange(_loc5_.x,_loc5_.y,_loc6_);
                  }
                  _loc7_ = _loc5_.testBloons;
               }
               else
               {
                  if(_loc6_ > cellSize)
                  {
                     _loc7_ = this.cells;
                  }
                  else
                  {
                     _loc7_ = this.getCellAndAdjacentCells(_loc5_.x,_loc5_.y);
                  }
                  _loc8_ = 0;
                  while(_loc8_ < _loc7_.length)
                  {
                     for each(_loc9_ in _loc7_[_loc8_])
                     {
                        _loc2_.x = _loc5_.x;
                        _loc2_.y = _loc5_.y;
                        _loc3_.x = _loc5_.velocity.x * param1;
                        _loc3_.y = _loc5_.velocity.y * param1;
                        _loc4_.x = _loc9_.x;
                        _loc4_.y = _loc9_.y;
                        _loc10_ = _loc9_.isInTunnel;
                        _loc11_ = _loc9_.type < 0;
                        if(!(_loc10_ || _loc11_))
                        {
                           if(Intersection.testCircleCircle(_loc2_,_loc6_,_loc4_,_loc9_.radius) || Intersection.testCircleLine(_loc2_,_loc3_,_loc4_,_loc9_.radius))
                           {
                              _loc12_ = SpecialTrackManager.getInstance().getBoss();
                              _loc13_ = true;
                              if(_loc5_.effectMask != Bloon.IMMUNITY_ALL)
                              {
                                 if(_loc9_.type === Bloon.BOSS_DREADBLOON && _loc9_.isShielded)
                                 {
                                    _loc13_ = false;
                                 }
                                 else
                                 {
                                    _loc13_ = int(_loc5_.effectMask & _loc9_.immunity) != 0;
                                 }
                              }
                              if(!_loc13_)
                              {
                                 _loc14_ = _loc9_.hitPreviously(_loc5_);
                                 if(!_loc14_)
                                 {
                                    _loc9_.handleCollision(_loc5_);
                                    _loc5_.handleCollision();
                                    if(_loc5_.pierce <= 0 || _loc5_.def == null)
                                    {
                                       break;
                                    }
                                 }
                              }
                           }
                        }
                     }
                     if(_loc5_.pierce <= 0 || _loc5_.def == null)
                     {
                        break;
                     }
                     _loc8_++;
                  }
               }
            }
         }
         Pool.release(_loc2_);
         Pool.release(_loc3_);
         Pool.release(_loc4_);
      }
      
      public function sortFirstToLast(param1:Bloon, param2:Bloon) : int
      {
         if(param1.getDistanceToEnd() < param2.getDistanceToEnd())
         {
            return 1;
         }
         return -1;
      }
      
      public function sortLastToFirst(param1:Bloon, param2:Bloon) : int
      {
         if(param1.getDistanceToStart() < param2.getDistanceToStart())
         {
            return 1;
         }
         return -1;
      }
      
      public function sortByCloseness(param1:Bloon, param2:Bloon) : int
      {
         var _loc3_:Number = this.testPosition.x - param1.x;
         var _loc4_:Number = this.testPosition.y - param1.y;
         var _loc5_:Number = _loc3_ * _loc3_ + _loc4_ * _loc4_;
         _loc3_ = this.testPosition.x - param2.x;
         _loc4_ = this.testPosition.y - param2.y;
         var _loc6_:Number = _loc3_ * _loc3_ + _loc4_ * _loc4_;
         if(_loc5_ > _loc6_)
         {
            return -1;
         }
         return 1;
      }
      
      public function sortByStrength(param1:Bloon, param2:Bloon) : int
      {
         if(param1.type > param2.type)
         {
            return 1;
         }
         if(param2.type > param1.type)
         {
            return -1;
         }
         if(param1.health > param2.health)
         {
            return 1;
         }
         if(param2.health > param1.health)
         {
            return -1;
         }
         if(param1.overallProgress > param2.overallProgress)
         {
            return 1;
         }
         return -1;
      }
      
      public function getTargetsInRange(param1:Vector2, param2:Number, param3:int, param4:int, param5:Vector.<Bloon> = null) : Vector.<Bloon>
      {
         var _loc9_:Bloon = null;
         var _loc6_:Vector.<Bloon> = new Vector.<Bloon>();
         var _loc7_:Vector.<Vector.<Bloon>> = this.getCellsInRange(param1.x,param1.y,param2);
         var _loc8_:int = 0;
         while(_loc8_ < _loc7_.length)
         {
            for each(_loc9_ in _loc7_[_loc8_])
            {
               if(_loc9_.type != -1)
               {
                  if(int(param3 & _loc9_.immunity) == 0)
                  {
                     if(!_loc9_.isInTunnel)
                     {
                        if(!(param5 && param5.indexOf(_loc9_) != -1))
                        {
                           _loc6_.push(_loc9_);
                        }
                     }
                  }
               }
            }
            _loc8_++;
         }
         this.v.x = param1.x;
         this.v.y = param1.y;
         this.sortTargetsByPriority(param4,_loc6_,this.v);
         return _loc6_;
      }
      
      public function getTargetForProjectile(param1:Projectile, param2:Number, param3:int) : Bloon
      {
         var _loc7_:Bloon = null;
         var _loc4_:Vector.<Bloon> = new Vector.<Bloon>();
         var _loc5_:Vector.<Vector.<Bloon>> = this.getCellsInRange(param1.x,param1.y,param2);
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_.length)
         {
            for each(_loc7_ in _loc5_[_loc6_])
            {
               if(_loc7_.type != -1)
               {
                  if(int(param1.effectMask & _loc7_.immunity) == 0)
                  {
                     if(!_loc7_.isInTunnel)
                     {
                        if(!_loc7_.hitPreviously(param1))
                        {
                           _loc4_.push(_loc7_);
                        }
                     }
                  }
               }
            }
            _loc6_++;
         }
         this.v.x = param1.x;
         this.v.y = param1.y;
         this.sortTargetsByPriority(param3,_loc4_,this.v);
         if(_loc4_.length == 0)
         {
            return null;
         }
         return _loc4_[_loc4_.length - 1];
      }
   }
}
