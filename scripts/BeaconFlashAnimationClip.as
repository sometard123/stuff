package
{
   import flash.display.MovieClip;
   
   public dynamic class BeaconFlashAnimationClip extends MovieClip
   {
       
      
      public function BeaconFlashAnimationClip()
      {
         super();
         addFrameScript(30,this.frame31);
      }
      
      function frame31() : *
      {
         if(this.parent && this.parent.contains(this))
         {
            this.parent.removeChild(this);
         }
      }
   }
}
