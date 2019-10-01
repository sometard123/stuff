package ninjakiwi.monkeyTown.town.tileProps.fence
{
   import com.lgrey.utils.Enumerator;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.town.townMap.TownMap;
   
   public class FenceBuilder
   {
       
      
      private var _map:TownMap;
      
      public const TOP_FULL_EDGE:int = Enumerator.getID("fence_asset");
      
      public const RIGHT_FULL_EDGE:int = Enumerator.getID("fence_asset");
      
      public const BOTTOM_FULL_EDGE:int = Enumerator.getID("fence_asset");
      
      public const LEFT_FULL_EDGE:int = Enumerator.getID("fence_asset");
      
      public const TOP_LEFT_CHUNK_EDGE:int = Enumerator.getID("fence_asset");
      
      public const TOP_RIGHT_CHUNK_EDGE:int = Enumerator.getID("fence_asset");
      
      public const RIGHT_TOP_CHUNK_EDGE:int = Enumerator.getID("fence_asset");
      
      public const RIGHT_BOTTOM_CHUNK_EDGE:int = Enumerator.getID("fence_asset");
      
      public const BOTTOM_RIGHT_CHUNK_EDGE:int = Enumerator.getID("fence_asset");
      
      public const BOTTOM_LEFT_CHUNK_EDGE:int = Enumerator.getID("fence_asset");
      
      public const LEFT_BOTTOM_CHUNK_EDGE:int = Enumerator.getID("fence_asset");
      
      public const LEFT_TOP_CHUNK_EDGE:int = Enumerator.getID("fence_asset");
      
      public const TOP_MIDDLE_EDGE:int = Enumerator.getID("fence_asset");
      
      public const RIGHT_MIDDLE_EDGE:int = Enumerator.getID("fence_asset");
      
      public const BOTTOM_MIDDLE_EDGE:int = Enumerator.getID("fence_asset");
      
      public const LEFT_MIDDLE_EDGE:int = Enumerator.getID("fence_asset");
      
      public const TOP_RIGHT_CORNER:int = Enumerator.getID("fence_asset");
      
      public const TOP_LEFT_CORNER:int = Enumerator.getID("fence_asset");
      
      public const BOTTOM_RIGHT_CORNER:int = Enumerator.getID("fence_asset");
      
      public const BOTTOM_LEFT_CORNER:int = Enumerator.getID("fence_asset");
      
      public function FenceBuilder(param1:TownMap)
      {
         super();
         this._map = param1;
      }
      
      public function updateFenceAroundLocation(param1:int, param2:int) : void
      {
         this.updateFenceAroundBlock(param1 - 1,param2 - 1,3,3);
         this._map.cacheTilesWithFences();
      }
      
      public function updateFenceAroundBlock(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc6_:int = 0;
         var _loc5_:int = param2;
         while(_loc5_ < param2 + param4)
         {
            _loc6_ = param1;
            while(_loc6_ < param1 + param3)
            {
               this.updateFenceForTileAtLocation(_loc6_,_loc5_);
               _loc6_++;
            }
            _loc5_++;
         }
         this._map.cacheTilesWithFences();
      }
      
      private function updateFenceForTileAtLocation(param1:int, param2:int) : void
      {
         var _loc3_:Tile = this._map.tileAt(param1,param2);
         if(!_loc3_)
         {
            return;
         }
         _loc3_.fence.reset();
         var _loc4_:Fence = _loc3_.fence;
         var _loc5_:Tile = this._map.tileAt(param1,param2 - 1);
         var _loc6_:Tile = this._map.tileAt(param1 + 1,param2);
         var _loc7_:Tile = this._map.tileAt(param1,param2 + 1);
         var _loc8_:Tile = this._map.tileAt(param1 - 1,param2);
         var _loc9_:Tile = this._map.tileAt(param1 + 1,param2 - 1);
         var _loc10_:Tile = this._map.tileAt(param1 - 1,param2 - 1);
         var _loc11_:Tile = this._map.tileAt(param1 + 1,param2 + 1);
         var _loc12_:Tile = this._map.tileAt(param1 - 1,param2 + 1);
         var _loc13_:Boolean = false;
         var _loc14_:Boolean = false;
         var _loc15_:Boolean = false;
         var _loc16_:Boolean = false;
         var _loc17_:EdgeState = new EdgeState();
         var _loc18_:EdgeState = new EdgeState();
         var _loc19_:EdgeState = new EdgeState();
         var _loc20_:EdgeState = new EdgeState();
         var _loc21_:Boolean = false;
         var _loc22_:Boolean = false;
         var _loc23_:Boolean = false;
         var _loc24_:Boolean = false;
         if(!_loc3_.isCaptured)
         {
            if(_loc5_ && _loc5_.isCaptured && _loc6_ && _loc6_.isCaptured)
            {
               _loc21_ = true;
            }
            if(_loc6_ && _loc6_.isCaptured && _loc7_ && _loc7_.isCaptured)
            {
               _loc22_ = true;
            }
            if(_loc7_ && _loc7_.isCaptured && _loc8_ && _loc8_.isCaptured)
            {
               _loc23_ = true;
            }
            if(_loc8_ && _loc8_.isCaptured && _loc5_ && _loc5_.isCaptured)
            {
               _loc24_ = true;
            }
         }
         else
         {
            if(_loc5_ && !_loc5_.isCaptured)
            {
               _loc13_ = true;
            }
            if(_loc6_ && !_loc6_.isCaptured)
            {
               _loc14_ = true;
            }
            if(_loc7_ && !_loc7_.isCaptured)
            {
               _loc15_ = true;
            }
            if(_loc8_ && !_loc8_.isCaptured)
            {
               _loc16_ = true;
            }
            if(_loc13_)
            {
               if(_loc10_ && _loc10_.isCaptured)
               {
                  _loc17_.fromCorner = false;
               }
               if(_loc9_ && _loc9_.isCaptured)
               {
                  _loc17_.toCorner = false;
               }
            }
            if(_loc14_)
            {
               if(_loc9_ && _loc9_.isCaptured)
               {
                  _loc18_.fromCorner = false;
               }
               if(_loc11_ && _loc11_.isCaptured)
               {
                  _loc18_.toCorner = false;
               }
            }
            if(_loc15_)
            {
               if(_loc11_ && _loc11_.isCaptured)
               {
                  _loc19_.fromCorner = false;
               }
               if(_loc12_ && _loc12_.isCaptured)
               {
                  _loc19_.toCorner = false;
               }
            }
            if(_loc16_)
            {
               if(_loc12_ && _loc12_.isCaptured)
               {
                  _loc20_.fromCorner = false;
               }
               if(_loc10_ && _loc10_.isCaptured)
               {
                  _loc20_.toCorner = false;
               }
            }
            if(_loc13_ && _loc14_)
            {
               _loc17_.toCorner = false;
               _loc18_.fromCorner = false;
               if(_loc9_ && !_loc9_.isCaptured)
               {
                  _loc21_ = true;
               }
            }
            if(_loc14_ && _loc15_)
            {
               _loc18_.toCorner = false;
               _loc19_.fromCorner = false;
               if(_loc11_ && !_loc11_.isCaptured)
               {
                  _loc22_ = true;
               }
            }
            if(_loc15_ && _loc16_)
            {
               _loc19_.toCorner = false;
               _loc20_.fromCorner = false;
               if(_loc12_ && !_loc12_.isCaptured)
               {
                  _loc23_ = true;
               }
            }
            if(_loc16_ && _loc13_)
            {
               _loc20_.toCorner = false;
               _loc17_.fromCorner = false;
               if(_loc10_ && !_loc10_.isCaptured)
               {
                  _loc24_ = true;
               }
            }
            if(_loc13_)
            {
               if(_loc17_.interesting)
               {
                  if(!_loc17_.fromCorner && !_loc17_.toCorner)
                  {
                     _loc4_.setTopEdge(this.getFenceAsset(_loc3_,_loc5_,this.TOP_MIDDLE_EDGE));
                  }
                  else if(_loc17_.fromCorner)
                  {
                     _loc4_.setTopEdge(this.getFenceAsset(_loc3_,_loc5_,this.TOP_LEFT_CHUNK_EDGE));
                  }
                  else
                  {
                     _loc4_.setTopEdge(this.getFenceAsset(_loc3_,_loc5_,this.TOP_RIGHT_CHUNK_EDGE));
                  }
               }
               else
               {
                  _loc4_.setTopEdge(this.getFenceAsset(_loc3_,_loc5_,this.TOP_FULL_EDGE));
               }
            }
            if(_loc14_)
            {
               if(_loc18_.interesting)
               {
                  if(!_loc18_.fromCorner && !_loc18_.toCorner)
                  {
                     _loc4_.setRightEdge(this.getFenceAsset(_loc3_,_loc6_,this.RIGHT_MIDDLE_EDGE));
                  }
                  else if(_loc18_.fromCorner)
                  {
                     _loc4_.setRightEdge(this.getFenceAsset(_loc3_,_loc6_,this.RIGHT_TOP_CHUNK_EDGE));
                  }
                  else
                  {
                     _loc4_.setRightEdge(this.getFenceAsset(_loc3_,_loc6_,this.RIGHT_BOTTOM_CHUNK_EDGE));
                  }
               }
               else
               {
                  _loc4_.setRightEdge(this.getFenceAsset(_loc3_,_loc6_,this.RIGHT_FULL_EDGE));
               }
            }
            if(_loc15_)
            {
               if(_loc19_.interesting)
               {
                  if(!_loc19_.fromCorner && !_loc19_.toCorner)
                  {
                     _loc4_.setBottomEdge(this.getFenceAsset(_loc3_,_loc7_,this.BOTTOM_MIDDLE_EDGE));
                  }
                  else if(_loc19_.fromCorner)
                  {
                     _loc4_.setBottomEdge(this.getFenceAsset(_loc3_,_loc7_,this.BOTTOM_RIGHT_CHUNK_EDGE));
                  }
                  else
                  {
                     _loc4_.setBottomEdge(this.getFenceAsset(_loc3_,_loc7_,this.BOTTOM_LEFT_CHUNK_EDGE));
                  }
               }
               else
               {
                  _loc4_.setBottomEdge(this.getFenceAsset(_loc3_,_loc7_,this.BOTTOM_FULL_EDGE));
               }
            }
            if(_loc16_)
            {
               if(_loc20_.interesting)
               {
                  if(!_loc20_.fromCorner && !_loc20_.toCorner)
                  {
                     _loc4_.setLeftEdge(this.getFenceAsset(_loc3_,_loc8_,this.LEFT_MIDDLE_EDGE));
                  }
                  else if(_loc20_.fromCorner)
                  {
                     _loc4_.setLeftEdge(this.getFenceAsset(_loc3_,_loc8_,this.LEFT_BOTTOM_CHUNK_EDGE));
                  }
                  else
                  {
                     _loc4_.setLeftEdge(this.getFenceAsset(_loc3_,_loc8_,this.LEFT_TOP_CHUNK_EDGE));
                  }
               }
               else
               {
                  _loc4_.setLeftEdge(this.getFenceAsset(_loc3_,_loc8_,this.LEFT_FULL_EDGE));
               }
            }
         }
         if(_loc21_)
         {
            _loc4_.setTopRightCorner(this.getFenceAsset(_loc3_,_loc5_,this.TOP_RIGHT_CORNER));
         }
         if(_loc22_)
         {
            _loc4_.setBottomRightCorner(this.getFenceAsset(_loc3_,_loc7_,this.BOTTOM_RIGHT_CORNER));
         }
         if(_loc23_)
         {
            _loc4_.setBottomLeftCorner(this.getFenceAsset(_loc3_,_loc7_,this.BOTTOM_LEFT_CORNER));
         }
         if(_loc24_)
         {
            _loc4_.setTopLeftCorner(this.getFenceAsset(_loc3_,_loc5_,this.TOP_LEFT_CORNER));
         }
         _loc4_.build();
      }
      
      public function getFenceAsset(param1:Tile, param2:Tile, param3:int) : String
      {
         var _loc6_:FenceAssetsDefinition = null;
         var _loc4_:FenceAssetsDefinition = param1.fenceAssets;
         var _loc5_:FenceAssetsDefinition = param2.fenceAssets;
         if(!param2)
         {
            _loc6_ = param1.fenceAssets;
         }
         else
         {
            _loc6_ = _loc4_.roShamBo > _loc5_.roShamBo?_loc4_:_loc5_;
         }
         switch(param3)
         {
            case this.TOP_FULL_EDGE:
               return _loc6_.topFullEdge;
            case this.RIGHT_FULL_EDGE:
               return _loc6_.rightFullEdge;
            case this.BOTTOM_FULL_EDGE:
               return _loc6_.bottomFullEdge;
            case this.LEFT_FULL_EDGE:
               return _loc6_.leftFullEdge;
            case this.TOP_LEFT_CHUNK_EDGE:
               return _loc6_.topLefChunkEdge;
            case this.TOP_RIGHT_CHUNK_EDGE:
               return _loc6_.topRightChunkEdge;
            case this.RIGHT_TOP_CHUNK_EDGE:
               return _loc6_.rightTopChunkEdge;
            case this.RIGHT_BOTTOM_CHUNK_EDGE:
               return _loc6_.rightBottomChunkEdge;
            case this.BOTTOM_RIGHT_CHUNK_EDGE:
               return _loc6_.bottomRightChunkEdge;
            case this.BOTTOM_LEFT_CHUNK_EDGE:
               return _loc6_.bottomLeftChunkEdge;
            case this.LEFT_BOTTOM_CHUNK_EDGE:
               return _loc6_.leftBottomChunkEdge;
            case this.LEFT_TOP_CHUNK_EDGE:
               return _loc6_.leftTopChunkEdge;
            case this.TOP_MIDDLE_EDGE:
               return _loc6_.topMiddleEdge;
            case this.RIGHT_MIDDLE_EDGE:
               return _loc6_.rightMiddleEdge;
            case this.BOTTOM_MIDDLE_EDGE:
               return _loc6_.bottomMiddleEdge;
            case this.LEFT_MIDDLE_EDGE:
               return _loc6_.leftMiddleEdge;
            case this.TOP_RIGHT_CORNER:
               return _loc6_.topRightCorner;
            case this.TOP_LEFT_CORNER:
               return _loc6_.topLeftCorner;
            case this.BOTTOM_RIGHT_CORNER:
               return _loc6_.bottomRightCorner;
            case this.BOTTOM_LEFT_CORNER:
               return _loc6_.bottomLeftCorner;
            default:
               return "";
         }
      }
   }
}

class EdgeState
{
    
   
   public var fromCorner:Boolean = true;
   
   public var toCorner:Boolean = true;
   
   function EdgeState()
   {
      super();
   }
   
   public function get interesting() : Boolean
   {
      return !this.fromCorner || !this.toCorner;
   }
}
