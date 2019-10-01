package ninjakiwi.monkeyTown.town.townMap
{
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.town.tile.TileDefinitions;
   
   public class TilesByType
   {
       
      
      public var lightForest:Vector.<Tile>;
      
      public var heavyForest:Vector.<Tile>;
      
      public var hills:Vector.<Tile>;
      
      public var jungle:Vector.<Tile>;
      
      public var lakes:Vector.<Tile>;
      
      public var desert:Vector.<Tile>;
      
      public var desertBadlands:Vector.<Tile>;
      
      public var desertHighlands:Vector.<Tile>;
      
      public var desertAridGrasslands:Vector.<Tile>;
      
      public var river:Vector.<Tile>;
      
      public var snow:Vector.<Tile>;
      
      public var volcanoes:Vector.<Tile>;
      
      public var mountains:Vector.<Tile>;
      
      public var caves:Vector.<Tile>;
      
      public var ruins:Vector.<Tile>;
      
      public var landTiles:Vector.<Tile>;
      
      public var waterTiles:Vector.<Tile>;
      
      public const tileDefinitions:TileDefinitions = TileDefinitions.getInstance();
      
      public function TilesByType()
      {
         this.lightForest = new Vector.<Tile>();
         this.heavyForest = new Vector.<Tile>();
         this.hills = new Vector.<Tile>();
         this.jungle = new Vector.<Tile>();
         this.lakes = new Vector.<Tile>();
         this.desert = new Vector.<Tile>();
         this.desertBadlands = new Vector.<Tile>();
         this.desertHighlands = new Vector.<Tile>();
         this.desertAridGrasslands = new Vector.<Tile>();
         this.river = new Vector.<Tile>();
         this.snow = new Vector.<Tile>();
         this.volcanoes = new Vector.<Tile>();
         this.mountains = new Vector.<Tile>();
         this.caves = new Vector.<Tile>();
         this.ruins = new Vector.<Tile>();
         this.landTiles = new Vector.<Tile>();
         this.waterTiles = new Vector.<Tile>();
         super();
      }
      
      public function populate(param1:Vector.<Tile>) : void
      {
         var _loc3_:Tile = null;
         var _loc4_:String = null;
         this.clear();
         var _loc2_:int = param1.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_ = param1[_loc5_];
            _loc4_ = _loc3_.terrainDefinition.id;
            if(_loc4_ == this.tileDefinitions.FOREST)
            {
               this.lightForest.push(_loc3_);
            }
            else if(_loc4_ == this.tileDefinitions.HEAVY_FOREST)
            {
               this.heavyForest.push(_loc3_);
            }
            else if(_loc4_ == this.tileDefinitions.HILLS)
            {
               this.hills.push(_loc3_);
            }
            else if(_loc4_ == this.tileDefinitions.JUNGLE)
            {
               this.jungle.push(_loc3_);
            }
            else if(_loc4_ == this.tileDefinitions.LAKE)
            {
               this.lakes.push(_loc3_);
            }
            else if(_loc4_ == this.tileDefinitions.DESERT)
            {
               this.desert.push(_loc3_);
            }
            else if(_loc4_ == this.tileDefinitions.RIVER)
            {
               this.river.push(_loc3_);
            }
            else if(_loc4_ == this.tileDefinitions.SNOW)
            {
               this.snow.push(_loc3_);
            }
            else if(_loc4_ == this.tileDefinitions.VOLCANO)
            {
               this.volcanoes.push(_loc3_);
            }
            else if(_loc4_ == this.tileDefinitions.MOUNTAINS)
            {
               this.mountains.push(_loc3_);
            }
            else if(_loc4_ == this.tileDefinitions.DESERT_BADLANDS)
            {
               this.desertBadlands.push(_loc3_);
            }
            else if(_loc4_ == this.tileDefinitions.DESERT_HIGHLANDS)
            {
               this.desertHighlands.push(_loc3_);
            }
            else if(_loc4_ == this.tileDefinitions.DESERT_ARID_GRASSLANDS)
            {
               this.desertAridGrasslands.push(_loc3_);
            }
            if(_loc3_.terrainDefinition.groundType !== this.tileDefinitions.WATER_GROUND)
            {
               this.landTiles.push(_loc3_);
            }
            else
            {
               this.waterTiles.push(_loc3_);
            }
            _loc5_++;
         }
      }
      
      public function clear() : void
      {
         this.lightForest.length = 0;
         this.heavyForest.length = 0;
         this.hills.length = 0;
         this.jungle.length = 0;
         this.lakes.length = 0;
         this.desert.length = 0;
         this.river.length = 0;
         this.snow.length = 0;
         this.volcanoes.length = 0;
         this.mountains.length = 0;
         this.caves.length = 0;
         this.ruins.length = 0;
         this.desertBadlands.length = 0;
         this.desertHighlands.length = 0;
         this.desertAridGrasslands.length = 0;
      }
   }
}
