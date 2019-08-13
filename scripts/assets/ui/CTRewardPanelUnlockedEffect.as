package assets.ui
{
   import flash.display.MovieClip;
   
   public dynamic class CTRewardPanelUnlockedEffect extends MovieClip
   {
       
      
      public function CTRewardPanelUnlockedEffect()
      {
         super();
         addFrameScript(25,this.frame26);
      }
      
      function frame26() : *
      {
         if(this.parent && this.parent.contains(this))
         {
            this.parent.removeChild(this);
         }
      }
   }
}
