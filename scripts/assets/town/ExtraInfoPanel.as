package assets.town
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class ExtraInfoPanel extends MovieClip
   {
       
      
      public var extraInfoContainer:ExtraInfoContainer;
      
      public function ExtraInfoPanel()
      {
         super();
         addFrameScript(7,this.frame8,14,this.frame15);
      }
      
      function frame8() : *
      {
         this.dispatchEvent(new Event("ExtraInfoRevealed"));
      }
      
      function frame15() : *
      {
         this.dispatchEvent(new Event(Event.COMPLETE));
      }
   }
}
