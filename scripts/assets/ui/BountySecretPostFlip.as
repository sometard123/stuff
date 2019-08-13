package assets.ui
{
   import flash.display.MovieClip;
   
   public dynamic class BountySecretPostFlip extends MovieClip
   {
       
      
      public function BountySecretPostFlip()
      {
         super();
         addFrameScript(25,this.frame26);
      }
      
      function frame26() : *
      {
         stop();
         if(parent && parent.contains(this))
         {
            parent.removeChild(this);
         }
      }
   }
}
