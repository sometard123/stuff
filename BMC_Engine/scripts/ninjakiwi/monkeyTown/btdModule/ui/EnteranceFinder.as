package ninjakiwi.monkeyTown.btdModule.ui
{
   import assets.btdmodule.tutorial.ArrowEnterance;
   import flash.display.DisplayObjectContainer;
   import flash.geom.Rectangle;
   import ninjakiwi.monkeyTown.btdModule.ingame.InGameMenu;
   import ninjakiwi.monkeyTown.btdModule.levels.levelDefs.LevelDef;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.ArcTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.common.Constants;
   
   public class EnteranceFinder
   {
      
      private static const _container:DisplayObjectContainer = Main.instance.arrowLayer;
      
      private static const _mapArea:Rectangle = Main.mapArea;
      
      private static const _playArea:Rectangle = Main.playArea;
      
      private static var _arrowEnteranceList:Vector.<ArrowEnterance> = new Vector.<ArrowEnterance>();
       
      
      public function EnteranceFinder()
      {
         super();
      }
      
      public static function setEnteranceArrow(param1:LevelDef, param2:InGameMenu) : void
      {
         var _loc5_:Tile = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc24_:int = 0;
         var _loc25_:ArcTile = null;
         var _loc26_:int = 0;
         var _loc27_:ArrowEnterance = null;
         var _loc28_:Tile = null;
         removeEnteranceArrows();
         var _loc3_:int = 1;
         if(param1.mainPath.length > 0)
         {
            if(param1.mainPath[0].nextTiles.length > 1)
            {
               _loc3_ = param1.mainPath[0].nextTiles.length;
            }
         }
         var _loc4_:int = 0;
         for(; _loc4_ < param1.mainPath.length; _loc4_++)
         {
            _loc5_ = param1.mainPath[_loc4_];
            if(_loc5_.startX < _mapArea.left || _loc5_.startX > _mapArea.right || _loc5_.startY < _mapArea.top || _loc5_.startY > _mapArea.bottom)
            {
               if(_loc5_.endX > _mapArea.left && _loc5_.endX < _mapArea.right && _loc5_.endY > _mapArea.top && _loc5_.endY < _mapArea.bottom)
               {
                  _loc6_ = _loc5_.startX;
                  _loc7_ = _loc5_.startY;
                  _loc8_ = _loc5_.endX;
                  _loc9_ = _loc5_.endY;
                  _loc10_ = _loc8_;
                  _loc11_ = _loc9_;
                  _loc12_ = _loc6_;
                  _loc13_ = _loc7_;
                  if(_loc5_ is ArcTile)
                  {
                     _loc25_ = _loc5_ as ArcTile;
                     if(_loc25_.wayPoints != null)
                     {
                        _loc26_ = 0;
                        while(_loc26_ < _loc25_.wayPoints.length)
                        {
                           if(_loc25_.wayPoints[_loc26_].x > 0 && _loc25_.wayPoints[_loc26_].y > 0)
                           {
                              _loc12_ = _loc25_.wayPoints[_loc26_].x;
                              _loc13_ = _loc25_.wayPoints[_loc26_].y;
                              break;
                           }
                           _loc26_++;
                        }
                     }
                  }
                  _loc17_ = _loc10_ - _loc12_;
                  _loc18_ = _loc11_ - _loc13_;
                  if(_loc17_ == 0)
                  {
                     _loc14_ = 1;
                     _loc16_ = -_loc10_;
                     _loc15_ = 0;
                  }
                  else if(_loc18_ == 0)
                  {
                     _loc14_ = 0;
                     _loc16_ = _loc11_;
                     _loc15_ = -1;
                  }
                  else
                  {
                     _loc14_ = _loc18_ / _loc17_;
                     _loc16_ = (_loc10_ * _loc13_ - _loc12_ * _loc11_) / _loc17_;
                     _loc15_ = -1;
                  }
                  _loc21_ = 0;
                  _loc22_ = 1;
                  _loc23_ = 1;
                  _loc24_ = -1;
                  if(_loc6_ < _mapArea.left)
                  {
                     _loc20_ = -(_loc16_ + _loc14_ * _mapArea.left) / _loc15_;
                     if(_loc20_ < _mapArea.top)
                     {
                        _loc24_ = 2;
                     }
                     else if(_loc20_ > _mapArea.bottom)
                     {
                        _loc24_ = 3;
                     }
                     else
                     {
                        _loc24_ = 0;
                     }
                  }
                  else if(_loc6_ > _mapArea.right)
                  {
                     _loc20_ = -(_loc16_ + _loc14_ * _mapArea.right) / _loc15_;
                     if(_loc20_ < _mapArea.top)
                     {
                        _loc24_ = 2;
                     }
                     else if(_loc20_ > _mapArea.bottom)
                     {
                        _loc24_ = 3;
                     }
                     else
                     {
                        _loc24_ = 1;
                     }
                  }
                  else if(_loc7_ < _mapArea.top)
                  {
                     _loc24_ = 2;
                  }
                  else if(_loc7_ > _mapArea.bottom)
                  {
                     _loc24_ = 3;
                  }
                  if(_loc24_ != -1)
                  {
                     if(_loc24_ == 0)
                     {
                        _loc20_ = -(_loc16_ + _loc14_ * _mapArea.left) / _loc15_;
                        _loc19_ = _mapArea.left;
                     }
                     else if(_loc24_ == 1)
                     {
                        _loc20_ = -(_loc16_ + _loc14_ * _mapArea.right) / _loc15_;
                        _loc19_ = _mapArea.right;
                        _loc22_ = -1;
                     }
                     else if(_loc24_ == 2)
                     {
                        _loc19_ = -(_loc16_ + _loc15_ * _mapArea.top) / _loc14_;
                        _loc20_ = _mapArea.top;
                        _loc21_ = 90;
                     }
                     else
                     {
                        _loc19_ = -(_loc16_ + _loc15_ * _mapArea.bottom) / _loc14_;
                        _loc20_ = _mapArea.bottom;
                        _loc21_ = -90;
                        _loc23_ = -1;
                     }
                     if(_loc5_.transitionType == Tile.underpass || _loc5_.transitionType == Tile.teleport)
                     {
                        _loc28_ = findNextTileOfType(_loc5_,Tile.road);
                        if(_loc28_ === null)
                        {
                           continue;
                        }
                        _loc19_ = _loc28_.startX;
                        _loc20_ = _loc28_.startY;
                     }
                     _loc27_ = new ArrowEnterance();
                     _arrowEnteranceList.push(_loc27_);
                     _loc27_.x = _loc19_;
                     _loc27_.y = _loc20_;
                     _loc27_.rotation = _loc21_;
                     _loc27_.scaleX = _loc22_;
                     _loc27_.scaleY = _loc23_;
                     _container.addChild(_loc27_);
                     if(_arrowEnteranceList.length >= _loc3_)
                     {
                        break;
                     }
                     continue;
                  }
                  continue;
               }
               continue;
            }
         }
         if(param1.id == Constants.GLACIER)
         {
            _loc4_ = 0;
            while(_loc4_ < _arrowEnteranceList.length)
            {
               _arrowEnteranceList[_loc4_].x = _arrowEnteranceList[_loc4_].x + 20;
               _loc4_++;
            }
         }
         if(param1.id == "DesertGrasslands3")
         {
            _arrowEnteranceList[0].rotation = 90;
         }
      }
      
      private static function findNextTileOfType(param1:Tile, param2:int) : Tile
      {
         var testTiles:Array = null;
         var tile:Tile = null;
         var startTile:Tile = param1;
         var transitionType:int = param2;
         var test:Function = function(param1:Tile):Tile
         {
            var _loc3_:Tile = null;
            var _loc2_:int = 0;
            while(_loc2_ < param1.nextTiles.length)
            {
               _loc3_ = param1.nextTiles[_loc2_];
               if(_loc3_.transitionType === transitionType)
               {
                  return _loc3_;
               }
               testTiles.push(_loc3_);
               _loc2_++;
            }
            return null;
         };
         testTiles = [startTile];
         if(startTile.nextTiles === null)
         {
            return startTile;
         }
         while(testTiles.length > 0)
         {
            tile = test(testTiles.shift());
            if(tile !== null)
            {
               return tile;
            }
         }
         return null;
      }
      
      public static function removeEnteranceArrows() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < _arrowEnteranceList.length)
         {
            if(_container.contains(_arrowEnteranceList[_loc1_]))
            {
               _container.removeChild(_arrowEnteranceList[_loc1_]);
            }
            _loc1_++;
         }
         _arrowEnteranceList = new Vector.<ArrowEnterance>();
      }
   }
}
