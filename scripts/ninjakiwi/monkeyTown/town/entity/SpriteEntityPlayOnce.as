package ninjakiwi.monkeyTown.town.entity
{
   public class SpriteEntityPlayOnce extends SpriteEntity
   {
       
      
      public var onDieCallback:Function = null;
      
      public function SpriteEntityPlayOnce(param1:String, param2:Function = null)
      {
         super();
         this.onDieCallback = param2;
         setGraphicByClassName(param1);
         clip.onLoopFunction = this.die;
      }
      
      override public function die() : void
      {
         super.die();
         if(this.onDieCallback != null)
         {
            this.onDieCallback(this);
         }
      }
   }
}
