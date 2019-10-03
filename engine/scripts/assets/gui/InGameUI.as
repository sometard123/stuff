package assets.gui
{
   import assets.btdmodule.BottomUIPanel;
   import assets.ui.AntiBossAbilitiesPane;
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class InGameUI extends MovieClip
   {
       
      
      public var antiBossAbilitiesPane:AntiBossAbilitiesPane;
      
      public var cancel_btn:cancelbutton;
      
      public var divider:MovieClip;
      
      public var healthBar:MovieClip;
      
      public var nextRoundButton:GoButtonClip;
      
      public var nonstopCheckbox:NonstopCheckboxClip;
      
      public var uiPanels:BottomUIPanel;
      
      public var wave_txt:TextField;
      
      public function InGameUI()
      {
         super();
      }
   }
}
