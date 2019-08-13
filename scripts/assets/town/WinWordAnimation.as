package assets.town
{
   import flash.display.MovieClip;
   
   public dynamic class WinWordAnimation extends MovieClip
   {
       
      
      public function WinWordAnimation()
      {
         super();
         addFrameScript(49,this.frame50);
      }
      
      function frame50() : *
      {
         gotoAndStop(1);
         if(parent && parent.contains(this))
         {
            parent.removeChild(this);
         }
      }
   }
}
