package ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.sandStorm
{
   import assets.maps.sandstorm.AbilityDust1;
   import display.Clip;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   
   public class SandstormAbilityGust extends Entity
   {
      
      private static const dustClasses:Array = [AbilityDust1,AbilityDust1,AbilityDust1];
      
      private static const SCENE_WIDTH:int = 800;
      
      private static const SCENE_HEIGHT:int = 600;
       
      
      private var _active:Boolean = false;
      
      private var _animationClass:Class = null;
      
      public var clip:Clip;
      
      private var dust:MovieClip;
      
      public function SandstormAbilityGust()
      {
         this.clip = new Clip();
         super();
         this.initView();
      }
      
      public function activate() : void
      {
         this._active = true;
         this.respawn();
      }
      
      public function deactivate() : void
      {
         this._active = false;
      }
      
      private function initView() : void
      {
         this._animationClass = dustClasses[int(Math.random() * dustClasses.length)];
         this.clip.initialise(this._animationClass,1);
         this.clip.gotoAndStop(0);
         this.clip.usePauseFrame = true;
         this.clip.pauseTimeMax = this.clip.frameCount - 1;
      }
      
      override public function process(param1:Number) : void
      {
         this.clip.process();
         if(this.clip.frameIndex === this.clip.frameCount - 1)
         {
            this.respawn();
         }
      }
      
      override public function draw(param1:BitmapData) : void
      {
         this.clip.quickDraw(param1,x,y);
      }
      
      public function respawn() : void
      {
         if(!this._active)
         {
            return;
         }
         x = Math.random() * SCENE_WIDTH;
         y = Math.random() * SCENE_HEIGHT;
         this.clip.gotoAndPlay(0);
         this._active = true;
      }
      
      public function disposeFrames() : void
      {
         Main.instance.frameFactory.destroyFrames(this._animationClass);
      }
   }
}
