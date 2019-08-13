package ninjakiwi.monkeyTown.town.ui.pvp
{
   import assets.ui.MvMTutorialPanelClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.ui.HideRevealViewPopup;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class MvMTutorialPanel extends HideRevealViewPopup
   {
       
      
      private const _clip:MvMTutorialPanelClip = new MvMTutorialPanelClip();
      
      private const _okButton:ButtonControllerBase = new ButtonControllerBase(this._clip.okButton);
      
      public function MvMTutorialPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         super(param1,param2);
         this._okButton.setClickFunction(hide);
         this.isModal = true;
         addChild(this._clip);
         enableDefaultOnResize(this._clip);
         setAutoPlayStopClipsArray([this._clip.clipboardMonkey,this._clip.housesIcon]);
      }
   }
}
