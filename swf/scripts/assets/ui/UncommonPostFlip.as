package assets.ui
{
   import flash.display.MovieClip;
   
   public dynamic class UncommonPostFlip extends MovieClip
   {
       
      
      public function UncommonPostFlip()
      {
         super();
         addFrameScript(19,this.frame20);
      }
      
      function frame20() : *
      {
         stop();
         if(parent && parent.contains(this))
         {
            parent.removeChild(this);
         }
      }
   }
}