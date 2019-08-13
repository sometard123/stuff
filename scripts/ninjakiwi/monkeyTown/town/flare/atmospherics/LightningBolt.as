package ninjakiwi.monkeyTown.town.flare.atmospherics
{
   import ninjakiwi.monkeyTown.town.entity.SpriteEntity;
   
   public class LightningBolt extends SpriteEntity
   {
      
      private static var _animationsList:Array = ["LightningBoltClip1","LightningBoltClip2"];
       
      
      public function LightningBolt()
      {
         super();
         clip.addAnimation("assets.flare." + _animationsList[int(Math.random() * _animationsList.length)],null,1);
         clip.onLoopFunction = dieOnNextTick;
      }
   }
}
