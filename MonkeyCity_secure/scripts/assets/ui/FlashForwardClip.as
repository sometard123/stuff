package assets.ui
{
   import flash.display.MovieClip;
   
   public dynamic class FlashForwardClip extends MovieClip
   {
       
      
      public function FlashForwardClip()
      {
         super();
         addFrameScript(5,this.frame6);
      }
      
      function frame6() : *
      {
         stop();
         if(this.parent && this.parent.contains(this))
         {
            this.parent.removeChild(this);
         }
      }
   }
}
