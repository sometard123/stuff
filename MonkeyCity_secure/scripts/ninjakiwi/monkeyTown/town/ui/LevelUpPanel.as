package ninjakiwi.monkeyTown.town.ui
{
   import assets.ui.LevelUpPanelClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.ui.HideRevealViewPopup;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import org.osflash.signals.Signal;
   
   public class LevelUpPanel extends HideRevealViewPopup
   {
      
      public static const revealedSignal:Signal = new Signal();
       
      
      private const _clip:LevelUpPanelClip = new LevelUpPanelClip();
      
      private const _closeButton:ButtonControllerBase = new ButtonControllerBase(this._clip.closeButton);
      
      private const _okButton:ButtonControllerBase = new ButtonControllerBase(this._clip.okButton);
      
      public function LevelUpPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         super(param1,param2);
         this.addChild(this._clip);
         this._closeButton.setClickFunction(hide);
         this._okButton.setClickFunction(hide);
         this.isModal = true;
         this.enableDefaultOnResize(this._clip);
         setAutoPlayStopClipsArray([this._clip.monkeyKing,this._clip.gem]);
      }
      
      override public function reveal(param1:Number = 0.2) : void
      {
         super.reveal(param1);
         revealedSignal.dispatch();
      }
      
      public function reload() : Boolean
      {
         if(ResourceStore.getInstance().townLevel == 1)
         {
            return false;
         }
         if(!MonkeySystem.getInstance().city.getIsActive())
         {
            return false;
         }
         this._clip.titleTxt.text = LocalisationConstants.STRING_CURRENT_LEVEL_IS.split("<level>").join(String(ResourceStore.getInstance().townLevel));
         this._clip.moneyBonusTxt.text = String(ResourceStore.getInstance().rewardedMoney);
         this._clip.bloonStoneBonusTxt.text = String(ResourceStore.getInstance().rewardedBS);
         this._clip.startingCashTxt.text = String(ResourceStore.getInstance().btdStartingMoney);
         this._clip.startingLivesTxt.text = String(ResourceStore.getInstance().btdStartingLives);
         return true;
      }
   }
}
