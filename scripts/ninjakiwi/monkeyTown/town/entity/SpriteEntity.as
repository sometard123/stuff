package ninjakiwi.monkeyTown.town.entity
{
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   import ninjakiwi.monkeyTown.display.bitClip.BitClipCustom;
   
   public class SpriteEntity extends Entity
   {
       
      
      public var clip:BitClipCustom;
      
      public function SpriteEntity()
      {
         this.clip = new BitClipCustom();
         super();
      }
      
      public function setGraphicByClassName(param1:String, param2:String = null, param3:int = 1) : void
      {
         this.clip.addAnimation(param1,null,1);
      }
      
      public function render(param1:BitmapData, param2:Rectangle) : void
      {
         this.clip.x = x - param2.x;
         this.clip.y = y - param2.y;
         this.clip.render(param1,param1.rect);
      }
      
      override public function die() : void
      {
         this.clip.stop();
         super.die();
      }
   }
}
