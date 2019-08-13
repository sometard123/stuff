package assets.ui
{
   import flash.display.MovieClip;
   
   public dynamic class BountyPostFlip extends MovieClip
   {
       
      
      public function BountyPostFlip()
      {
         super();
         addFrameScript(21,this.frame22);
      }
      
      function frame22() : *
      {
         stop();
         if(parent && parent.contains(this))
         {
            parent.removeChild(this);
         }
      }
   }
}
