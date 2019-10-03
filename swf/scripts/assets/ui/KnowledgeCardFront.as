package assets.ui
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   
   public dynamic class KnowledgeCardFront extends MovieClip
   {
       
      
      public var aztecLines:MovieClip;
      
      public var backgroundColor:MovieClip;
      
      public var banner:MovieClip;
      
      public var cardTitle:MovieClip;
      
      public var descriptionField:TextField;
      
      public var diagonalMask:MovieClip;
      
      public var dropdownValueBackground:MovieClip;
      
      public var maskAboveLayer:MovieClip;
      
      public var pointsDisplay:MovieClip;
      
      public var portraitContainer:MovieClip;
      
      public var portraitContainerAbove:MovieClip;
      
      public var rarityTitle:MovieClip;
      
      public function KnowledgeCardFront()
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
