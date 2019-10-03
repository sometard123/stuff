package assets.ui
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class TreasurePanelClip extends MovieClip
   {
       
      
      public var closeButton:MovieClip;
      
      public var descriptionBackgroundClip:MovieClip;
      
      public var descriptionTxt:TextField;
      
      public var itemIcon:TreasureIconClip;
      
      public var knowledgePackInfo:MovieClip;
      
      public var titleTxt:TextField;
      
      public var treasureChest:TreasureChestClip;
      
      public function TreasurePanelClip()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {
         stop();
      }
   }
}
