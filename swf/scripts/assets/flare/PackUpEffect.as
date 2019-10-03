package assets.flare
{
   import flash.display.MovieClip;
   
   public dynamic class PackUpEffect extends MovieClip
   {
       
      
      public function PackUpEffect()
      {
         super();
         addFrameScript(29,this.frame30);
      }
      
      function frame30() : *
      {
         gotoAndStop(1);
         if(parent && parent.contains(this))
         {
            parent.removeChild(this);
         }
      }
   }
}
