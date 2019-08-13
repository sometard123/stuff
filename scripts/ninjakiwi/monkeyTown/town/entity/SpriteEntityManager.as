package ninjakiwi.monkeyTown.town.entity
{
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   
   public class SpriteEntityManager extends EntityManager
   {
       
      
      public function SpriteEntityManager()
      {
         super();
         validType = SpriteEntity;
      }
      
      public function render(param1:BitmapData, param2:Rectangle) : void
      {
         var _loc3_:int = 0;
         while(_loc3_ < _items.length)
         {
            SpriteEntity(_items[_loc3_]).render(param1,param2);
            _loc3_++;
         }
      }
   }
}
