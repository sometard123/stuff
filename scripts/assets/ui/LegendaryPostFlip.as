package assets.ui
{
   import flash.display.MovieClip;
   
   public dynamic class LegendaryPostFlip extends MovieClip
   {
       
      
      public function LegendaryPostFlip()
      {
         super();
         addFrameScript(17,this.frame18);
      }
      
      function frame18() : *
      {
         stop();
         if(parent && parent.contains(this))
         {
            parent.removeChild(this);
         }
      }
   }
}
