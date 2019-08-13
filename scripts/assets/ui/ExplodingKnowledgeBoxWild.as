package assets.ui
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class ExplodingKnowledgeBoxWild extends MovieClip
   {
       
      
      public var hover:MovieClip;
      
      public function ExplodingKnowledgeBoxWild()
      {
         super();
         addFrameScript(52,this.frame53,67,this.frame68);
      }
      
      function frame53() : *
      {
         this.dispatchEvent(new Event("explode"));
      }
      
      function frame68() : *
      {
         this.dispatchEvent(new Event(Event.COMPLETE));
         stop();
      }
   }
}
