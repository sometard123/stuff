package ninjakiwi.monkeyTown.town.townMap
{
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.common.LevelDefData;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.specialItems.SpecialItemData;
   import ninjakiwi.monkeyTown.utils.IntPoint2D;
   
   public class TileReporter
   {
       
      
      private var _resourceStore:ResourceStore;
      
      private var _specialItemData:SpecialItemData;
      
      public function TileReporter()
      {
         this._resourceStore = ResourceStore.getInstance();
         this._specialItemData = SpecialItemData.getInstance();
         super();
      }
      
      public function getTileReport(param1:Tile, param2:TownMap) : String
      {
         var _loc9_:Object = null;
         var _loc10_:String = null;
         if(!Constants.USE_DEV_MAGIC)
         {
            return "...";
         }
         var _loc3_:IntPoint2D = param1.positionTilespace;
         if(!param1)
         {
            return "";
         }
         var _loc4_:* = "";
         _loc4_ = _loc4_ + ("Coordinates: " + param1.positionTilespace.x + ", " + param1.positionTilespace.y + "<br/>");
         if(param1.building !== null)
         {
            _loc4_ = _loc4_ + ("Building: " + param1.building.definition.name);
            _loc4_ = _loc4_ + ("  ::  buildComplete: " + param1.building.buildComplete);
            _loc4_ = _loc4_ + ("  ::  clock: " + param1.building.buildClock + "<br/>");
         }
         var _loc5_:int = MonkeySystem.getInstance().city.cityIndex;
         var _loc6_:Number = LevelDefData.getActualTrackDifficultyRating(param1.type,param1.trackSelectionBias,_loc5_);
         var _loc7_:Number = param2.getDifficultyAtLocation(_loc3_.x,_loc3_.y);
         _loc4_ = _loc4_ + "tile difficulty: " + _loc7_.toFixed(2) + " - " + "natural difficulty: " + param2.getNaturalDifficultyAtLocation(param1.positionTilespace.x,param1.positionTilespace.y).toString() + "<br/>";
         if(param1.hasTreasureChest)
         {
            _loc4_ = _loc4_ + ("treasure type : " + param1.treasureType + "<br/>");
         }
         var _loc8_:Array = LevelDefData.getLevelDefNamesByTerrain(param1.type,_loc5_);
         if(_loc8_ !== null)
         {
            _loc9_ = LevelDefData.selectRandomTrackByDifficultyBias(_loc8_,param1.trackSelectionBias);
            _loc10_ = _loc8_[_loc9_.index];
            _loc4_ = _loc4_ + ("track: " + _loc10_ + " " + _loc9_.index + "<br/>");
         }
         return _loc4_;
      }
   }
}
