package ninjakiwi.monkeyTown.town.flare.atmospherics
{
   import flash.geom.ColorTransform;
   import ninjakiwi.monkeyTown.town.entity.SpriteEntity;
   
   public class RainDrop extends SpriteEntity
   {
       
      
      public var cloud:Cloud = null;
      
      public function RainDrop(param1:Cloud)
      {
         super();
         this.cloud = param1;
         clip.addAnimation("assets.flare.RainDropAnimation",null,1,false,false,true,new ColorTransform(1,1,1,0.5));
         clip.onLoopFunction = this.onAnimationComplete;
      }
      
      private function onAnimationComplete() : void
      {
         clip.stop();
         this.cloud.onDropHitGround(this);
      }
   }
}
