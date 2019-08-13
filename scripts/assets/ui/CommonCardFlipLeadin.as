package assets.ui
{
   import flash.display.MovieClip;
   
   public dynamic class CommonCardFlipLeadin extends MovieClip
   {
       
      
      public function CommonCardFlipLeadin()
      {
         super();
         addFrameScript(19,this.frame20);
      }
      
      function frame20() : *
      {
         stop();
         if(parent && parent.contains(this))
         {
            this.parent.removeChild(this);
         }
      }
   }
}
