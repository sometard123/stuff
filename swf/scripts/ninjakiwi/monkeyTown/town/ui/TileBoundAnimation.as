package ninjakiwi.monkeyTown.town.ui
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldView;
   
   public class TileBoundAnimation extends Sprite implements ISimulateClickable
   {
       
      
      protected var _clip:MovieClip = null;
      
      public function TileBoundAnimation(param1:MovieClip)
      {
         super();
         this._clip = param1;
         addChild(this._clip);
         WorldView.addOverlayItem(this);
      }
      
      public function updateToTile(param1:Tile) : void
      {
         this.x = param1.positionTilespace.x * MonkeySystem.getInstance().TOWN_GRID_UNIT_SIZE;
         this.y = param1.positionTilespace.y * MonkeySystem.getInstance().TOWN_GRID_UNIT_SIZE;
      }
      
      public function die() : void
      {
         if(this._clip != null && contains(this._clip))
         {
            removeChild(this._clip);
         }
         WorldView.removeOverlayItem(this);
      }
      
      public function simulateClick() : void
      {
      }
      
      public function hover() : void
      {
      }
   }
}
