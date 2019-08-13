package assets.ui
{
   import flash.display.MovieClip;
   
   public dynamic class LegendaryCollect extends MovieClip
   {
       
      
      public function LegendaryCollect()
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
