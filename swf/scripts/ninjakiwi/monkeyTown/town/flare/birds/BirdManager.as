package ninjakiwi.monkeyTown.town.flare.birds
{
   import com.lgrey.vectors.LGVector2D;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   
   public class BirdManager
   {
       
      
      private var _birdGroups:Vector.<BirdGroup>;
      
      private var camera:Rectangle = null;
      
      private const NUMBER_OF_GROUPS:int = 1;
      
      public function BirdManager()
      {
         this._birdGroups = new Vector.<BirdGroup>();
         super();
         this.init();
      }
      
      private function init() : void
      {
         var _loc1_:Number = MonkeySystem.getInstance().TOWN_GRID_UNIT_SIZE;
         var _loc2_:LGVector2D = new LGVector2D(_loc1_ * 30,_loc1_ * 25);
         var _loc3_:int = 0;
         while(_loc3_ < this.NUMBER_OF_GROUPS)
         {
            this._birdGroups[_loc3_] = new BirdGroup();
            if(Constants.IS_HALLOWEEN)
            {
               this._birdGroups[_loc3_].init(GhostBird,5);
            }
            else
            {
               this._birdGroups[_loc3_].init(Buzzard,5);
            }
            this._birdGroups[_loc3_].target.set(_loc2_.x + (Math.random() * 2 - 2) * 1000,_loc2_.y + (Math.random() * 2 - 2) * 1000);
            _loc3_++;
         }
      }
      
      public function render(param1:BitmapData, param2:Rectangle) : void
      {
         this.camera = param2;
         var _loc3_:int = 0;
         while(_loc3_ < this.NUMBER_OF_GROUPS)
         {
            this._birdGroups[_loc3_].render(param1,param2);
            _loc3_++;
         }
      }
   }
}
