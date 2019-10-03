package ninjakiwi.monkeyTown.btdModule.ingame
{
   import assets.btdmodule.MVMTryPanelClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.dancingShadows.DancingShadows;
   import ninjakiwi.dancingShadows.INumber;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.btdModule.game.Game;
   import ninjakiwi.monkeyTown.ui.HideRevealViewSimple;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.buttons.TickBox;
   import org.osflash.signals.Signal;
   
   public class MvMRetryPanel extends HideRevealViewSimple
   {
       
      
      private const _clip:MVMTryPanelClip = new MVMTryPanelClip();
      
      private const _cancelButton:ButtonControllerBase = new ButtonControllerBase(this._clip.cancelButton);
      
      private const _tryAgainButton:ButtonControllerBase = new ButtonControllerBase(this._clip.tryAgainButton);
      
      private const _bonusCashTickbox:TickBox = new TickBox(this._clip.bonusCashClip.bonusCashTickBox);
      
      public const changedSignal:Signal = new Signal();
      
      private var _notEnoughBloonstonesPanel:InGameNotEnoughBloonstonesPanel;
      
      private var _onTryAgainFunction:Function;
      
      private var _onCancelFunction:Function;
      
      private var _startWithBonusCash:INumber;
      
      private var _bloonstonesCharged:INumber;
      
      public function MvMRetryPanel(param1:DisplayObjectContainer, param2:InGameNotEnoughBloonstonesPanel, param3:Function, param4:Function)
      {
         this._startWithBonusCash = DancingShadows.getOne();
         this._bloonstonesCharged = DancingShadows.getOne();
         super(param1);
         this._onTryAgainFunction = param3;
         this._onCancelFunction = param4;
         this._notEnoughBloonstonesPanel = param2;
         this.addChild(this._clip);
         this._cancelButton.setClickFunction(this.onCancel);
         this._tryAgainButton.setClickFunction(this.onTryAgain);
         this._bonusCashTickbox.changedSignal.add(this.onBonusCashTicked);
         enableDefaultOnResize(this._clip);
         this._clip.tryAgainButton.bloonStones_txt.text = String(Game.RETRY_BLOONSTONES_FOR_MVM);
         this._clip.bonusCashClip.bloonStones_txt.text = String(Game.RETRY_BLOONSTONES_EXTRA_CASH);
         this.reset();
      }
      
      public function reset() : void
      {
         this._startWithBonusCash.value = 0;
         this._bonusCashTickbox.reset();
         this._bonusCashTickbox.ticked = false;
         this._bonusCashTickbox.enabled = true;
      }
      
      private function onCancel() : void
      {
         hide();
         this._onCancelFunction();
      }
      
      private function onTryAgain() : void
      {
         this._bloonstonesCharged.value = this._bloonstonesCharged.value + Game.RETRY_BLOONSTONES_FOR_MVM;
         if(this._startWithBonusCash.value)
         {
            this._bloonstonesCharged.value = this._bloonstonesCharged.value + Game.RETRY_BLOONSTONES_EXTRA_CASH;
         }
         Game.GAME_REQUEST_BLOONSTONES_SIGNAL.dispatch(this.bloonstonesCharged.value,this.onBloonstonesCharged,true);
      }
      
      private function onBloonstonesCharged(param1:Boolean, param2:int) : void
      {
         if(param1)
         {
            this._onTryAgainFunction();
            hide();
         }
         else
         {
            this._notEnoughBloonstonesPanel.onHideSignal.addOnce(this.reveal);
            this._notEnoughBloonstonesPanel.setRequiredBloonstones(this._bloonstonesCharged.value - param2);
            this._notEnoughBloonstonesPanel.parentPanel = this;
            this._notEnoughBloonstonesPanel.reveal();
         }
      }
      
      private function onBonusCashTicked(param1:Boolean) : void
      {
         if(param1)
         {
            this._startWithBonusCash.value = 1;
         }
         else
         {
            this._startWithBonusCash.value = 0;
         }
      }
      
      override public function reveal(param1:Number = 0.5) : void
      {
         this._bloonstonesCharged.value = 0;
         this._startWithBonusCash.value = 0;
         super.reveal();
         this._bonusCashTickbox.ticked = Main.instance.game.gameRequest.isBonusCashMode;
         this.updateBonusCash(Main.instance.game.bonusStartingCash);
         this.setActive(true);
      }
      
      public function setActive(param1:Boolean) : void
      {
         if(param1)
         {
            this._cancelButton.unlock();
            this._tryAgainButton.unlock();
            this._bonusCashTickbox.enabled = true;
         }
         else
         {
            this._cancelButton.lock();
            this._tryAgainButton.lock();
            this._bonusCashTickbox.enabled = false;
         }
      }
      
      private function updateBonusCash(param1:INumber) : void
      {
         this._clip.bonusCashClip.description.text = LocalisationConstants.ADD_START_CASH_MVM_TEXT.split("<added>").join(String(param1.value));
      }
      
      public function get bonusCashTickbox() : TickBox
      {
         return this._bonusCashTickbox;
      }
      
      public function get bloonstonesCharged() : INumber
      {
         return this._bloonstonesCharged;
      }
      
      public function get notEnoughBloonstonesPanel() : InGameNotEnoughBloonstonesPanel
      {
         return this._notEnoughBloonstonesPanel;
      }
   }
}
