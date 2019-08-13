package assets.ui
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class MonkeyKnowledgeCardLayout extends MovieClip
   {
       
      
      public var card1:KnowledgeCardBack;
      
      public var card2:KnowledgeCardBack;
      
      public var card3:KnowledgeCardBack;
      
      public var card4:KnowledgeCardBack;
      
      public function MonkeyKnowledgeCardLayout()
      {
         super();
         addFrameScript(19,this.frame20);
      }
      
      function frame20() : *
      {
         stop();
         dispatchEvent(new Event(Event.COMPLETE));
      }
   }
}
