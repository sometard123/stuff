package assets.ui
{
   import flash.display.MovieClip;
   
   public dynamic class BossMilestonelUnlockedEffect extends MovieClip
   {
       
      
      public function BossMilestonelUnlockedEffect()
      {
         super();
         addFrameScript(25,this.frame26);
      }
      
      function frame26() : *
      {
         if(this.parent && this.parent.contains(this))
         {
            this.parent.removeChild(this);
         }
      }
   }
}
