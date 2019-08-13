package assets.town
{
   import flash.display.MovieClip;
   
   public dynamic class NoMoneyAnimation extends MovieClip
   {
       
      
      public function NoMoneyAnimation()
      {
         super();
         addFrameScript(29,this.frame30);
      }
      
      function frame30() : *
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
