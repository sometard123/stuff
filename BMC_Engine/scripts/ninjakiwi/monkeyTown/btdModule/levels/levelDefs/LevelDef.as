package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import flash.display.Bitmap;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   
   public class LevelDef
   {
       
      
      public var id:String;
      
      public var name:String;
      
      public var description:String;
      
      public var swfName:String = "Don\'t forget to add the swfName";
      
      public var assetClassName:String;
      
      public var terrainClassName:String;
      
      public var mainPath:Vector.<Tile>;
      
      private var _previewBMP:Bitmap;
      
      public var music:Class;
      
      public function LevelDef()
      {
         super();
      }
   }
}
