package assets.ui
{
   import flash.display.MovieClip;
   
   public dynamic class RarePostFlip extends MovieClip
   {
       
      
      public function RarePostFlip()
      {
         super();
         addFrameScript(15,this.frame16);
      }
      
      function frame16() : *
      {
         stop();
         if(parent && parent.contains(this))
         {
            parent.removeChild(this);
         }
      }
   }
}
