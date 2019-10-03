package ninjakiwi.monkeyTown.town.gameEvents.bloonBeacon
{
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.pvp.PvPMain;
   
   public class BloonBeaconTilePicker
   {
       
      
      public function BloonBeaconTilePicker()
      {
         super();
      }
      
      public function pickTile() : Tile
      {
         var _loc1_:Tile = PvPMain.instance.townMapInvasionUtil.getValidInvasionTile();
         if(null == _loc1_)
         {
            _loc1_ = PvPMain.instance.townMapInvasionUtil.getValidInvasionTileOwned();
         }
         return _loc1_;
      }
      
      public function tileIsValid(param1:Tile) : Boolean
      {
         return PvPMain.instance.townMapInvasionUtil.canInvadeTile(param1);
      }
   }
}
