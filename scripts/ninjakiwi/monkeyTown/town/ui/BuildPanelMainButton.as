package ninjakiwi.monkeyTown.town.ui
{
   import assets.ui.MoreSashForMainButton;
   import assets.ui.NewSash;
   import flash.display.MovieClip;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class BuildPanelMainButton extends ButtonControllerBase
   {
       
      
      private var _newSash:NewSash;
      
      private var _moreSash:MoreSashForMainButton = null;
      
      public function BuildPanelMainButton(param1:MovieClip, param2:Boolean = false)
      {
         this._newSash = new NewSash();
         super(param1);
         param1.parent.addChild(this._newSash);
         this._newSash.x = param1.x + 120;
         this._newSash.y = param1.y;
         this._newSash.mouseEnabled = false;
         this._newSash.mouseChildren = false;
         this._newSash.scaleX = this._newSash.scaleY = 0.75;
         if(param2)
         {
            this._moreSash = new MoreSashForMainButton();
            param1.parent.addChild(this._moreSash);
            this._moreSash.x = param1.x;
            this._moreSash.y = param1.y + 5;
            this._moreSash.mouseEnabled = false;
            this._moreSash.mouseChildren = false;
         }
         this.setMoreSashVisible(false);
      }
      
      public function setNewSashVisible(param1:Boolean) : void
      {
         this._newSash.visible = param1;
      }
      
      public function setMoreSashVisible(param1:Boolean) : void
      {
         if(this._moreSash !== null)
         {
            this._moreSash.visible = false;
         }
      }
   }
}
