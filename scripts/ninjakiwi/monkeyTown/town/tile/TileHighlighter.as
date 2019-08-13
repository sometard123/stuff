package ninjakiwi.monkeyTown.town.tile
{
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.townMap.TownMap;
   import ninjakiwi.monkeyTown.utils.IntPoint2D;
   
   public class TileHighlighter
   {
       
      
      private var _system:MonkeySystem;
      
      private var _villagePosition:IntPoint2D;
      
      private var _topLeft:IntPoint2D;
      
      private var _positions:Array;
      
      public function TileHighlighter()
      {
         this._system = MonkeySystem.getInstance();
         this._villagePosition = new IntPoint2D(this._system.VILLAGE_POSITION_X,this._system.VILLAGE_POSITION_Y);
         this._topLeft = new IntPoint2D();
         this._positions = [new IntPoint2D(0,0),new IntPoint2D(1,0),new IntPoint2D(2,0),new IntPoint2D(3,0),new IntPoint2D(4,0),new IntPoint2D(0,1),new IntPoint2D(0,2),new IntPoint2D(0,3),new IntPoint2D(0,4),new IntPoint2D(1,4),new IntPoint2D(2,4),new IntPoint2D(3,4),new IntPoint2D(4,4),new IntPoint2D(4,3),new IntPoint2D(4,2)];
         super();
         this._topLeft.x = this._villagePosition.x - 1;
         this._topLeft.y = this._villagePosition.y - 1;
      }
      
      public function setPulsateStateSecondSet(param1:Boolean = true) : void
      {
         var _loc3_:Tile = null;
         var _loc2_:TownMap = this._system.map;
         var _loc4_:IntPoint2D = new IntPoint2D();
         var _loc5_:int = 0;
         while(_loc5_ < this._positions.length)
         {
            _loc4_.copy(this._positions[_loc5_]);
            _loc4_.addPoint(this._topLeft);
            _loc3_ = _loc2_.tileAtPoint(_loc4_);
            if(param1)
            {
               TilePulsator.setPulsateState(_loc3_,true);
               _loc3_.lockHover();
            }
            else
            {
               _loc3_.unlockHover();
               TilePulsator.setPulsateState(_loc3_,false);
            }
            _loc5_++;
         }
      }
   }
}
