package assets.ui
{
   import flash.display.MovieClip;
   
   public dynamic class BountyCardFlipLeadin extends MovieClip
   {
       
      
      public function BountyCardFlipLeadin()
      {
         super();
         addFrameScript(29,this.frame30);
      }
      
      function frame30() : *
      {
         stop();
         if(parent && parent.contains(this))
         {
            this.parent.removeChild(this);
         }
      }
   }
}
