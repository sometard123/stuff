package ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.vortex
{
   import assets.PortalOpeningClip;
   import display.Clip;
   import flash.display.BitmapData;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import org.osflash.signals.Signal;
   
   public class VortexOpeningAnimation extends Entity
   {
       
      
      private var _clip:Clip;
      
      private var _currentFrame:int = 0;
      
      private var _playDirection:int = 1;
      
      private var _playing:Boolean = false;
      
      public const pop:Signal = new Signal();
      
      public const complete:Signal = new Signal();
      
      public var visible:Boolean = true;
      
      public function VortexOpeningAnimation()
      {
         this._clip = new Clip();
         super();
         this.init();
      }
      
      private function init() : void
      {
         this._clip.initialise(PortalOpeningClip,1);
         z = 100000000;
         Main.instance.game.level.addEntity(this);
      }
      
      public function playForward() : void
      {
         this._playDirection = 1;
         this._clip.gotoAndPlay(0);
      }
      
      public function playBackward() : void
      {
         this._playDirection = -1;
         this._clip.gotoAndStop(this._clip.frameCount - 1);
      }
      
      override public function draw(param1:BitmapData) : void
      {
         if(this.visible === false)
         {
            return;
         }
         this._clip.gotoAndStop(this._currentFrame);
         this._clip.quickDraw(param1,x,y);
         if(this._currentFrame == 4)
         {
            this.pop.dispatch();
         }
         else if(this._playDirection > 0 && this._currentFrame === 8)
         {
            this.complete.dispatch();
            this.visible = false;
         }
         else if(this._playDirection < 0 && this._currentFrame === 0)
         {
            this.complete.dispatch();
            this.visible = false;
         }
         this._currentFrame = this._currentFrame + this._playDirection;
         if(this._currentFrame < 0)
         {
            this._currentFrame = 0;
         }
         else if(this._currentFrame >= this._clip.frameCount - 1)
         {
            this._currentFrame = this._clip.frameCount - 1;
            this.visible = false;
         }
      }
      
      override public function destroy() : void
      {
         Main.instance.game.level.cull(this);
         super.destroy();
      }
   }
}
