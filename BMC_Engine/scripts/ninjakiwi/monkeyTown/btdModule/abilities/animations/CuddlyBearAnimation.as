package ninjakiwi.monkeyTown.btdModule.abilities.animations
{
   import assests.effects.CuddlyBearFullScreenAnimation;
   import display.Clip;
   import flash.display.BitmapData;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   
   public class CuddlyBearAnimation extends Entity
   {
       
      
      private var _cuddlyBearFullScreenEffectClip:Clip;
      
      private var _visible:Boolean = false;
      
      public function CuddlyBearAnimation()
      {
         this._cuddlyBearFullScreenEffectClip = new Clip();
         super();
         z = int.MAX_VALUE;
         this.init();
      }
      
      private function init() : void
      {
         this._cuddlyBearFullScreenEffectClip.initialise(CuddlyBearFullScreenAnimation,1);
      }
      
      public function activate() : void
      {
         this._visible = true;
         this._cuddlyBearFullScreenEffectClip.gotoAndPlay(0);
      }
      
      public function deactivate() : void
      {
         this._visible = false;
         this._cuddlyBearFullScreenEffectClip.stop();
      }
      
      override public function process(param1:Number) : void
      {
         if(this._visible)
         {
            this._cuddlyBearFullScreenEffectClip.process();
         }
      }
      
      override public function draw(param1:BitmapData) : void
      {
         if(this._visible)
         {
            this._cuddlyBearFullScreenEffectClip.quickDraw(param1,x,y);
         }
      }
      
      public function disposeFrames() : void
      {
         Main.instance.frameFactory.destroyFrames(CuddlyBearFullScreenAnimation);
      }
   }
}
