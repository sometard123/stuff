package ninjakiwi.monkeyTown.town.townMap
{
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   
   public class CapturedTilesByType extends TilesByType
   {
       
      
      public function CapturedTilesByType()
      {
         super();
      }
      
      override public function populate(param1:Vector.<Tile>) : void
      {
         var _loc3_:Tile = null;
         var _loc4_:String = null;
         clear();
         var _loc2_:int = param1.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_ = param1[_loc5_];
            if(false !== _loc3_.isCaptured)
            {
               _loc4_ = _loc3_.terrainDefinition.id;
               if(_loc4_ == tileDefinitions.FOREST)
               {
                  lightForest.push(_loc3_);
               }
               else if(_loc4_ == tileDefinitions.HEAVY_FOREST)
               {
                  heavyForest.push(_loc3_);
               }
               else if(_loc4_ == tileDefinitions.HILLS)
               {
                  hills.push(_loc3_);
               }
               else if(_loc4_ == tileDefinitions.JUNGLE)
               {
                  jungle.push(_loc3_);
               }
               else if(_loc4_ == tileDefinitions.LAKE)
               {
                  lakes.push(_loc3_);
               }
               else if(_loc4_ == tileDefinitions.DESERT)
               {
                  desert.push(_loc3_);
               }
               else if(_loc4_ == tileDefinitions.RIVER)
               {
                  river.push(_loc3_);
               }
               else if(_loc4_ == tileDefinitions.SNOW)
               {
                  snow.push(_loc3_);
               }
               else if(_loc4_ == tileDefinitions.VOLCANO)
               {
                  volcanoes.push(_loc3_);
               }
               else if(_loc4_ == tileDefinitions.MOUNTAINS)
               {
                  mountains.push(_loc3_);
               }
               else if(_loc4_ == tileDefinitions.DESERT_BADLANDS)
               {
                  desertBadlands.push(_loc3_);
               }
               else if(_loc4_ == tileDefinitions.DESERT_HIGHLANDS)
               {
                  desertHighlands.push(_loc3_);
               }
               else if(_loc4_ == tileDefinitions.DESERT_ARID_GRASSLANDS)
               {
                  desertAridGrasslands.push(_loc3_);
               }
               if(_loc3_.terrainDefinition.groundType !== tileDefinitions.WATER_GROUND)
               {
                  landTiles.push(_loc3_);
               }
               else
               {
                  waterTiles.push(_loc3_);
               }
            }
            _loc5_++;
         }
      }
   }
}
