package ninjakiwi.monkeyTown.btdModule.levels.terrain
{
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   
   public class TowerTerrain
   {
       
      
      public var tower:Tower;
      
      public var terrain:TerrainType;
      
      public function TowerTerrain(param1:Tower, param2:TerrainType)
      {
         super();
         this.tower = param1;
         this.terrain = param2;
      }
   }
}
