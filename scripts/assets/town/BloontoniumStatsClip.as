package assets.town
{
   import assets.building.BloonstonesCollect;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class BloontoniumStatsClip extends MovieClip
   {
       
      
      public var GlowBloon:MovieClip;
      
      public var StillBloon:MovieClip;
      
      public var collectBox:BloonstonesCollect;
      
      public var collectHit:MovieClip;
      
      public var fieldWrapper:MovieClip;
      
      public function BloontoniumStatsClip()
      {
         super();
         addFrameScript(0,this.frame1,8,this.frame9,14,this.frame15,50,this.frame51);
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame9() : *
      {
         stop();
         this.dispatchEvent(new Event("rolloverAnimationComplete"));
      }
      
      function frame15() : *
      {
         gotoAndStop(1);
      }
      
      function frame51() : *
      {
         this.dispatchEvent(new Event("burst_complete"));
         gotoAndStop(1);
      }
   }
}
