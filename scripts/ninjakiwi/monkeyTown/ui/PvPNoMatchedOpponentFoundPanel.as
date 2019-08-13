package ninjakiwi.monkeyTown.ui
{
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class PvPNoMatchedOpponentFoundPanel extends HideRevealViewCancelable
   {
       
      
      private var _clip:PVPQuckMatchNotFoundMessageClip;
      
      private var _okButton:ButtonControllerBase;
      
      public function PvPNoMatchedOpponentFoundPanel(param1:PVPQuckMatchNotFoundMessageClip, param2:DisplayObjectContainer, param3:* = null)
      {
         super(param2,param3);
         this._clip = param1;
         this.addChild(this._clip);
         this._okButton = new ButtonControllerBase(this._clip.okButton);
         this._okButton.setClickFunction(hide);
      }
   }
}
