package ninjakiwi.monkeyTown.btdModule.abilities.animations
{
   import assets.effects.VortexStunEffectClip;
   import display.Clip;
   
   public class VortexStunAnimation extends Clip
   {
       
      
      private var _previousFrameIndex:int = -1;
      
      public function VortexStunAnimation()
      {
         super();
         initialise(VortexStunEffectClip,1,false);
      }
      
      override public function process() : void
      {
         super.process();
         if(frameIndex === frameCount - 1 || frameIndex < this._previousFrameIndex)
         {
            this.remove();
         }
         this._previousFrameIndex = frameIndex;
      }
      
      private function remove() : void
      {
         markForRemoval = true;
         stop();
      }
   }
}
