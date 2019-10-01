package assets.ui
{
   import assets.btdmodule.OrText;
   import assets.btdmodule.RestartButton;
   import assets.btdmodule.continueButton;
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class RetryPanelClip extends MovieClip
   {
       
      
      public var bonusCashClip:AddStartCashRestartclip;
      
      public var cancelButton:MovieClip;
      
      public var continueButton:continueButton;
      
      public var continuePatch:MovieClip;
      
      public var orText:OrText;
      
      public var restartButton:RestartButton;
      
      public var startingCash:TextField;
      
      public function RetryPanelClip()
      {
         super();
      }
   }
}
