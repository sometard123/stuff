package assets.town
{
   import assets.ui.NotificationNumber;
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class MyTracksPanelClip extends MovieClip
   {
       
      
      public var background:MovieClip;
      
      public var closeButton:MovieClip;
      
      public var myMonkeyButton:MovieClip;
      
      public var nextButton:MovieClip;
      
      public var numberOfArchivesInNextPage:NotificationNumber;
      
      public var numberOfArchivesInPrevPage:NotificationNumber;
      
      public var padding:MovieClip;
      
      public var page_Number:TextField;
      
      public var prevButton:MovieClip;
      
      public var specialItemsButton:MovieClip;
      
      public var stats_txt:TextField;
      
      public var trackLayer:MovieClip;
      
      public var unlockClip:MovieClip;
      
      public function MyTracksPanelClip()
      {
         super();
      }
   }
}
