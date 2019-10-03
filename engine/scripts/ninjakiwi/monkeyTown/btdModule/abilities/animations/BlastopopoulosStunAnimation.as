package ninjakiwi.monkeyTown.btdModule.abilities.animations
{
   import assets.effects.BlastopopoulisStunEffectClip;
   import display.Clip;
   
   public class BlastopopoulosStunAnimation extends Clip
   {
       
      
      private var _previousFrameIndex:int = -1;
      
      public function BlastopopoulosStunAnimation()
      {
         super();
         initialise(BlastopopoulisStunEffectClip,1,false);
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
