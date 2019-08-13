package assets.ui
{
   import flash.display.MovieClip;
   
   public dynamic class RareCardFlipLeadin extends MovieClip
   {
       
      
      public function RareCardFlipLeadin()
      {
         super();
         addFrameScript(24,this.frame25);
      }
      
      function frame25() : *
      {
         stop();
         if(parent && parent.contains(this))
         {
            this.parent.removeChild(this);
         }
      }
   }
}
