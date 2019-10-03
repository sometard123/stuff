package ninjakiwi.monkeyTown.town.ui.skipClockPanel
{
   import assets.ui.SkipClockPanelClip;
   import com.greensock.TweenLite;
   import com.greensock.easing.Cubic;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.net.kloud.Kloud;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.data.definitions.FirstTimeTriggerDefinition;
   import ninjakiwi.monkeyTown.town.townMap.TrackData;
   import ninjakiwi.monkeyTown.town.ui.NotEnoughBloonstonesPanel;
   import ninjakiwi.monkeyTown.town.ui.clock.Clock;
   import ninjakiwi.monkeyTown.town.ui.clock.ClockManager;
   import ninjakiwi.monkeyTown.town.ui.pvp.attack.PvPAttackBase;
   import ninjakiwi.monkeyTown.ui.HideRevealViewPopup;
   import ninjakiwi.monkeyTown.ui.VideoAdPanelController;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge._state;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   import org.osflash.signals.Signal;
   
   public class SkipClockPanel extends HideRevealViewPopup
   {
       
      
      protected const _clip:SkipClockPanelClip = new SkipClockPanelClip();
      
      protected var _targetClock:Clock = null;
      
      protected const _okButton:ButtonControllerBase = new ButtonControllerBase(this._clip.okButton);
      
      protected const _cancelButton:ButtonControllerBase = new ButtonControllerBase(this._clip.cancelButton);
      
      protected const _doneButton:ButtonControllerBase = new ButtonControllerBase(this._clip.doneButton);
      
      protected const _repairAllButton:ButtonControllerBase = new ButtonControllerBase(this._clip.repairAllButton);
      
      private const _resourceStore:ResourceStore = ResourceStore.getInstance();
      
      public var skipNowTitleText:String = "Skip Now?";
      
      private var _buyBloonstonesPanel:NotEnoughBloonstonesPanel;
      
      private var _videoAdPanelController:VideoAdPanelController;
      
      public function SkipClockPanel(param1:DisplayObjectContainer)
      {
         super(param1);
         this.init();
         this._doneButton.target.visible = false;
         this._repairAllButton.target.visible = false;
         this._repairAllButton.stop();
         this._clip.repairIcon.visible = false;
         this._clip.repairIcon.stop();
         this._buyBloonstonesPanel = new NotEnoughBloonstonesPanel(param1);
         ClockManager.clockWasDestroyedSignal.add(this.onClockWasDestroyedSignal);
         setAutoPlayStopClipsArray([this._clip.gem]);
      }
      
      private function onClockWasDestroyedSignal(param1:Clock) : void
      {
         if(isRevealed && param1 === this._targetClock)
         {
            this.hide();
         }
      }
      
      public function requestSkipForClock(param1:Clock) : void
      {
         if(param1.isLocked())
         {
            return;
         }
         this._clip.title.text = this.skipNowTitleText;
         this._targetClock = param1;
         var _loc2_:int = param1.getBloonstonesRequiredToSkip();
         this._clip.costField.text = _loc2_.toString();
         this.reveal();
      }
      
      public function requestSkipForPassiveUpgradeClock() : void
      {
         this._clip.title.text = this.skipNowTitleText;
         this._targetClock = null;
         this._clip.costField.text = "??";
         this.reveal();
      }
      
      protected function init() : void
      {
         addChild(this._clip);
         this._okButton.setClickFunction(this.onOKButtonClicked);
         this._cancelButton.setClickFunction(this.onCancelButtonClicked);
         this._doneButton.setClickFunction(this.onCancelButtonClicked);
         this._repairAllButton.setClickFunction(this.onRepairAllFunction);
         enableDefaultOnResize(this._clip);
         this._videoAdPanelController = new VideoAdPanelController(this._clip.watchVideoPanel,this);
      }
      
      protected function onCancelButtonClicked() : void
      {
         this.hide();
      }
      
      protected function onRepairAllFunction() : void
      {
         var _loc1_:Boolean = false;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:Building = null;
         var _loc6_:int = 0;
         if(this._targetClock == null)
         {
            this.hide();
            return;
         }
         var _loc2_:Number = 0;
         if(this._targetClock !== null && !this._targetClock.isLocked())
         {
            _loc3_ = _system.city.buildingManager.getBuildingsOfType(this._targetClock.target.definition.id);
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               _loc5_ = _loc3_[_loc4_] as Building;
               if(_loc5_.damageClock != null)
               {
                  _loc2_ = _loc2_ + _loc5_.damageClock.getBloonstonesRequiredToSkip();
               }
               _loc4_++;
            }
            if(_loc2_ > 0)
            {
               _loc1_ = this.canAfford(_loc2_,"to skip construction time.");
               if(_loc1_)
               {
                  this._resourceStore.bloonstones = this._resourceStore.bloonstones - _loc2_;
                  _loc6_ = 0;
                  while(_loc6_ < _loc3_.length)
                  {
                     if((_loc3_[_loc6_] as Building).damageClock != null)
                     {
                        (_loc3_[_loc6_] as Building).damageClock.skip();
                     }
                     _loc6_++;
                  }
               }
            }
         }
         this.hide();
      }
      
      protected function canAfford(param1:int, param2:String = "") : Boolean
      {
         var requiredBloonstones:int = param1;
         var actionString:String = param2;
         if(this._resourceStore.bloonstones >= requiredBloonstones)
         {
            return true;
         }
         this._buyBloonstonesPanel.setRequiredBloonstones(requiredBloonstones - this._resourceStore.bloonstones,actionString);
         this._clip.visible = false;
         this._buyBloonstonesPanel.onHideSignal.addOnce(function(... rest):void
         {
            _clip.visible = true;
         });
         PanelManager.getInstance().showFreePanel(this._buyBloonstonesPanel);
         return false;
      }
      
      protected function onOKButtonClicked() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Number = NaN;
         if(this._targetClock == null)
         {
            this.hide();
            return;
         }
         if(this._targetClock !== null && !this._targetClock.isLocked())
         {
            _loc2_ = this._targetClock.getBloonstonesRequiredToSkip();
            if(_loc2_ > 0)
            {
               _loc1_ = this.canAfford(_loc2_,"to skip construction time.");
               if(_loc1_)
               {
                  this._resourceStore.bloonstones = this._resourceStore.bloonstones - _loc2_;
                  this._targetClock.skip();
                  this._targetClock = null;
               }
            }
         }
         this.hide();
      }
      
      override public function reveal(param1:Number = 0.5) : void
      {
         this._okButton.setClickFunction(this.onOKButtonClicked);
         super.reveal(param1);
         this._videoAdPanelController.doVideoAvailableCheck();
      }
      
      override public function hide(param1:Number = 0.5) : void
      {
         this._targetClock = null;
         this._okButton.setClickFunction(null);
         super.hide(param1);
      }
   }
}
