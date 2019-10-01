package ninjakiwi.monkeyTown.town.tileProps
{
   public class RiverTileSet
   {
      
      private static var _instance:RiverTileSet;
       
      
      public const leftToRight:String = "assets.tiles.RiverLeftToRight";
      
      public const rightToLeft:String = "assets.tiles.RiverRightToLeft";
      
      public const topToBottom:String = "assets.tiles.RiverTopToBottom";
      
      public const leftToBottom:String = "assets.tiles.RiverCornerLeftToBottom";
      
      public const rightToBottom:String = "assets.tiles.RiverCornerRightToBottom";
      
      public const topToLeft:String = "assets.tiles.RiverCornerTopToLeft";
      
      public const topToRight:String = "assets.tiles.RiverCornerTopToRight";
      
      public const orientationIDs:Object = {
         "assets.tiles.RiverTopToBottom":0,
         "assets.tiles.RiverRightToLeft":1,
         "assets.tiles.RiverLeftToRight":2,
         "assets.tiles.RiverCornerLeftToBottom":3,
         "assets.tiles.RiverCornerTopToRight":4,
         "assets.tiles.RiverCornerTopToLeft":5,
         "assets.tiles.RiverCornerRightToBottom":6
      };
      
      public function RiverTileSet()
      {
         super();
      }
      
      public static function getInstance() : RiverTileSet
      {
         if(_instance == null)
         {
            _instance = new RiverTileSet();
         }
         return _instance;
      }
   }
}
