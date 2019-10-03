package assets.ui
{
   import assets.town.YesButtonClip;
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class ConfirmPanelClip extends MovieClip
   {
       
      
      public var background:MovieClip;
      
      public var cancelButton:MovieClip;
      
      public var messageField:TextField;
      
      public var noButton:MovieClip;
      
      public var okButton:MovieClip;
      
      public var titleText:TextField;
      
      public var yesButton:YesButtonClip;
      
      public function ConfirmPanelClip()
      {
         super();
      }
   }
}
