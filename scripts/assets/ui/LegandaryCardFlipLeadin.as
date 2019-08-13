package assets.ui
{
   import flash.display.MovieClip;
   
   public dynamic class LegandaryCardFlipLeadin extends MovieClip
   {
       
      
      public function LegandaryCardFlipLeadin()
      {
         super();
         addFrameScript(33,this.frame34);
      }
      
      function frame34() : *
      {
         stop();
         if(parent && parent.contains(this))
         {
            this.parent.removeChild(this);
         }
      }
   }
}
