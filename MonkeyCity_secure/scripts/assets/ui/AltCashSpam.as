package assets.ui
{
   import flash.display.MovieClip;
   
   public dynamic class AltCashSpam extends MovieClip
   {
       
      
      public var rewardCash:MovieClip;
      
      public function AltCashSpam()
      {
         super();
         addFrameScript(21,this.frame22);
      }
      
      function frame22() : *
      {
         stop();
         if(this.parent && this.parent.contains(this))
         {
            this.parent.removeChild(this);
         }
      }
   }
}
