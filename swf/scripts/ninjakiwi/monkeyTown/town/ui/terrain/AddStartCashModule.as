package ninjakiwi.monkeyTown.town.ui.terrain
{
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.town.ui.NotEnoughBloonstonesPanel;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.buttons.TickBox;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   import org.osflash.signals.Signal;
   
   public class AddStartCashModule
   {
      
      public static var enableTickBox:Boolean = true;
       
      
      private var _bonusStartingCash:int = 0;
      
      private var _linkedClip:MovieClip;
      
      private var _bonusCashTickbox:TickBox;
      
      private var _notEnoughBloonstonesPanel:NotEnoughBloonstonesPanel;
      
      private var _possibleBonusCash:int;
      
      public var testMissionButton:ButtonControllerBase;
      
      private const _resourceStore:ResourceStore = ResourceStore.getInstance();
      
      public const changedSignal:Signal = new Signal();
      
      private var _testButtonClip:MovieClip;
      
      public function AddStartCashModule(param1:MovieClip)
      {
         super();
         this._linkedClip = param1;
         this._bonusCashTickbox = new TickBox(this._linkedClip.bonusCashTickBox);
         this._bonusCashTickbox.changedSignal.add(this.onBonusCashSignalChangedSignal);
         this._testButtonClip = this._linkedClip.testMissionButton;
         if(this._testButtonClip)
         {
            this._testButtonClip.parent.removeChild(this._testButtonClip);
            this.testMissionButton = new ButtonControllerBase(this._testButtonClip);
         }
         this._linkedClip.bloonStones_txt.text = String(Constants.BS_COST_TO_GET_BONUS_STARTING_CASH);
      }
      
      public function enableWarningPanel(param1:DisplayObjectContainer) : void
      {
         this._notEnoughBloonstonesPanel = new NotEnoughBloonstonesPanel(param1);
      }
      
      public function reset() : void
      {
         this.updatePossibleBonusCash();
         this._bonusCashTickbox.reset();
         if(!enableTickBox)
         {
            this._bonusCashTickbox.enabled = false;
         }
         else
         {
            this._bonusCashTickbox.enabled = true;
         }
         this._bonusStartingCash = 0;
         if(this._testButtonClip && (Constants.RELEASE_TEST || Constants.USE_DEV_MAGIC))
         {
            this._linkedClip.addChild(this._testButtonClip);
         }
      }
      
      public function get bonusStartingCash() : int
      {
         return this._bonusStartingCash;
      }
      
      public function get possibleBonusCash() : int
      {
         return this._possibleBonusCash;
      }
      
      public function get bonusCashTickbox() : TickBox
      {
         return this._bonusCashTickbox;
      }
      
      private function onBonusCashSignalChangedSignal(param1:Boolean) : void
      {
         switch(param1)
         {
            case true:
               this.updatePossibleBonusCash();
               this._bonusStartingCash = this._possibleBonusCash;
               break;
            case false:
               this._bonusStartingCash = 0;
         }
         this.changedSignal.dispatch();
      }
      
      private function updatePossibleBonusCash() : void
      {
         this._possibleBonusCash = this.calculatePossibleBonusCash();
         this._linkedClip.description.text = LocalisationConstants.ADD_START_CASH_TEXT.split("<added>").join(String(this._possibleBonusCash));
      }
      
      public function calculatePossibleBonusCash() : Number
      {
         var _loc1_:Number = 0;
         var _loc2_:int = 200;
         var _loc3_:Number = this._resourceStore.btdStartingMoney * 0.2;
         var _loc4_:Number = _loc3_;
         _loc3_ = _loc3_ * 0.01 * 2;
         _loc4_ = Math.round(_loc3_);
         _loc4_ = _loc4_ * 0.5 * 100;
         if(_loc4_ < _loc2_)
         {
            _loc4_ = _loc2_;
         }
         _loc1_ = _loc4_;
         return _loc1_;
      }
      
      public function canAfford() : Boolean
      {
         var _loc1_:int = 0;
         if(this._bonusCashTickbox.ticked && this._resourceStore.bloonstones < Constants.BS_COST_TO_GET_BONUS_STARTING_CASH)
         {
            if(this._notEnoughBloonstonesPanel != null)
            {
               _loc1_ = Constants.BS_COST_TO_GET_BONUS_STARTING_CASH - this._resourceStore.bloonstones;
               this._notEnoughBloonstonesPanel.setRequiredBloonstones(_loc1_,LocalisationConstants.BLOONSTONES_FOR_STARTING_CASH.split("<bloonstones>").join(String(_loc1_)));
               PanelManager.getInstance().showPanelOverlay(this._notEnoughBloonstonesPanel);
            }
            return false;
         }
         return true;
      }
      
      public function apply() : Boolean
      {
         if(this._bonusCashTickbox.ticked == true && this.canAfford())
         {
            this._resourceStore.bloonstones = this._resourceStore.bloonstones - Constants.BS_COST_TO_GET_BONUS_STARTING_CASH;
            return true;
         }
         return false;
      }
   }
}
