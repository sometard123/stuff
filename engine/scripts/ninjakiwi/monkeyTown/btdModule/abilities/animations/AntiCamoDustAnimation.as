package ninjakiwi.monkeyTown.btdModule.abilities.animations
{
   import assests.effects.AntiCamoDustFullScreenAnim;
   import display.Clip;
   import flash.display.BitmapData;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   
   public class AntiCamoDustAnimation extends Entity
   {
       
      
      private var _antiCamoDustFullScreenEffectClip:Clip;
      
      private var _visible:Boolean = false;
      
      public function AntiCamoDustAnimation()
      {
         this._antiCamoDustFullScreenEffectClip = new Clip();
         super();
         z = int.MAX_VALUE;
         this.init();
      }
      
      private function init() : void
      {
         this._antiCamoDustFullScreenEffectClip.initialise(AntiCamoDustFullScreenAnim,1);
         this._antiCamoDustFullScreenEffectClip.looping = true;
      }
      
      public function activate() : void
      {
         this._visible = true;
         this._antiCamoDustFullScreenEffectClip.gotoAndPlay(0);
      }
      
      public function deactivate() : void
      {
         this._antiCamoDustFullScreenEffectClip.stop();
         this._visible = false;
      }
      
      override public function process(param1:Number) : void
      {
         if(this._visible)
         {
            this._antiCamoDustFullScreenEffectClip.process();
         }
      }
      
      override public function draw(param1:BitmapData) : void
      {
         if(this._visible)
         {
            this._antiCamoDustFullScreenEffectClip.quickDraw(param1,x,y);
         }
      }
      
      public function disposeFrames() : void
      {
         Main.instance.frameFactory.destroyFrames(AntiCamoDustFullScreenAnim);
      }
   }
}
