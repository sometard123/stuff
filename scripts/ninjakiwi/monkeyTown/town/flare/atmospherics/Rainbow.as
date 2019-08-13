package ninjakiwi.monkeyTown.town.flare.atmospherics
{
   import ninjakiwi.monkeyTown.town.entity.SpriteEntity;
   
   public class Rainbow extends SpriteEntity
   {
       
      
      private var _fadeDirection:int = 0;
      
      private var _age:int;
      
      private var _lifespan:Number = 8.0;
      
      private var _lifespanInFrames:int;
      
      public function Rainbow()
      {
         this._lifespanInFrames = this._lifespan * 30;
         super();
         setGraphicByClassName("assets.flare.RainbowClip");
         clip.gotoAndStop(clip.totalFrames);
         this.fadeIn();
      }
      
      public function setAlpha(param1:Number) : void
      {
         clip.gotoAndStop(int((1 - param1) * clip.totalFrames) + 1);
      }
      
      public function fadeOut() : void
      {
         this._fadeDirection = 1;
      }
      
      public function fadeIn() : void
      {
         this._fadeDirection = -1;
      }
      
      override public function tick() : void
      {
         var _loc1_:Number = 30;
         if(this._fadeDirection != 0)
         {
            clip.gotoAndStop(clip.currentFrame + this._fadeDirection);
            if(this._fadeDirection == -1 && clip.currentFrame == 1)
            {
               this._fadeDirection = 0;
            }
            if(this._fadeDirection == 1 && clip.currentFrame == clip.totalFrames)
            {
               dieOnNextTick();
            }
         }
         this._age++;
         if(this._age == int(this._lifespanInFrames))
         {
            this.fadeOut();
         }
      }
   }
}
