package assets.ui
{
   import flash.display.MovieClip;
   
   public dynamic class UncommonCardFlipLeadin extends MovieClip
   {
       
      
      public function UncommonCardFlipLeadin()
      {
         super();
         addFrameScript(27,this.frame28);
      }
      
      function frame28() : *
      {
         stop();
         if(parent && parent.contains(this))
         {
            this.parent.removeChild(this);
         }
      }
   }
}
