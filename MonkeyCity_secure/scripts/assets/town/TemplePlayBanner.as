package assets.town
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class TemplePlayBanner extends MovieClip
   {
       
      
      public function TemplePlayBanner()
      {
         super();
         addFrameScript(8,this.frame9,12,this.frame13);
      }
      
      function frame9() : *
      {
         this.dispatchEvent(new Event("TemplePlayBannerRevealed"));
      }
      
      function frame13() : *
      {
         this.dispatchEvent(new Event("TemplePlayBannerHidden"));
      }
   }
}
