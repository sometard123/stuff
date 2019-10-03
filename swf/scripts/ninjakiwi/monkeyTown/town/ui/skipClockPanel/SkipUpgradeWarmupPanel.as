package ninjakiwi.monkeyTown.town.ui.skipClockPanel
{
   import assets.icons.BlankUpgradeIcon;
   import assets.ui.CTRewardPanelUnlockedEffect;
   import com.lgrey.utils.LGDisplayListUtil;
   import flash.display.DisplayObjectContainer;
   import flash.utils.getDefinitionByName;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledge;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.data.definitions.BloonResearchLabUpgrade;
   import ninjakiwi.monkeyTown.town.data.definitions.UpgradePathStateDefinition;
   import ninjakiwi.monkeyTown.town.data.definitions.UpgradePathTierDefinition;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.Awarder;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.ui.clock.Clock;
   import ninjakiwi.monkeyTown.town.upgrades.UpgradeSignals;
   import ninjakiwi.monkeyTown.ui.VideoAdPanelController;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.MonkeyKnowledgeCard;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.MonkeyKnowledgePack;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.MonkeyKnowledgePanel;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.MonkeyKnowledgeTestPanel;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.MonkeyKnowlegeMorePacksTip;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.WildCardFront;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   import ninjakiwi.sharedFrameAnalyser.AnimationSharedFramesMap;
   
   public class SkipUpgradeWarmupPanel extends SkipClockPanel
   {
       
      
      private var _targetPath:UpgradePathStateDefinition = null;
      
      private var _targetBloonResearchLabUpgrade:BloonResearchLabUpgrade = null;
      
      private const _resourceStore:ResourceStore = ResourceStore.getInstance();
      
      private var _costBSToSkipBloonResearchLabUpgrade:int;
      
      private var _videoAdPanelController:VideoAdPanelController;
      
      public function SkipUpgradeWarmupPanel(param1:DisplayObjectContainer)
      {
         super(param1);
         isModal = true;
         UpgradeSignals.requestSkipPathWarmup.add(this.onRequestSkipPathWarmupSignal);
         UpgradeSignals.passiveUpgradeClockClicked.add(this.onRequestSkipPathWarmupSignal);
         UpgradeSignals.requestBloonResearchLabSkip.add(this.onRequestBloonResearchLabSkipSignal);
         skipNowTitleText = "Finish Upgrading";
         GameSignals.UPGRADE_WARMUP_COMPLETE.add(this.onUpgradeWarmupCompleteSignal);
         UpgradeSignals.bloonResearchLabUpgradeComplete.add(this.onBloonResearchLabUpgradeComplete);
         _clip.iconBuilding.visible = false;
         _clip.iconUpgrade.visible = true;
         _clip.resourceBuildingIcons.visible = false;
         this._videoAdPanelController = new VideoAdPanelController(_clip.watchVideoPanel,this);
      }
      
      private function onBloonResearchLabUpgradeComplete() : void
      {
         if(isRevealed)
         {
            this.hide();
         }
      }
      
      private function onUpgradeWarmupCompleteSignal(param1:UpgradePathTierDefinition, param2:UpgradePathStateDefinition) : void
      {
         if(isRevealed && this._targetPath === param2)
         {
            this.hide();
         }
      }
      
      override public function requestSkipForClock(param1:Clock) : void
      {
      }
      
      private function onRequestSkipPathWarmupSignal(param1:UpgradePathStateDefinition) : void
      {
         var defClass:Class = null;
         var qualifiedIconClassName:String = null;
         var path:UpgradePathStateDefinition = param1;
         var requiredBloonstones:int = path.getBloonstonesRequiredToSkip();
         skipNowTitleText = "Finish Upgrading";
         _clip.title.text = skipNowTitleText;
         this._targetPath = path;
         _clip.costField.text = requiredBloonstones.toString();
         var pathTierDef:UpgradePathTierDefinition = this._targetPath.getUpgradePathTierDefinitionAtTier(this._targetPath.unlockedTo);
         LGDisplayListUtil.getInstance().removeAllChildren(_clip.iconUpgrade.container);
         if(pathTierDef != null)
         {
            try
            {
               qualifiedIconClassName = "assets.icons." + pathTierDef.iconClassName;
               defClass = getDefinitionByName(qualifiedIconClassName) as Class;
            }
            catch(error:Error)
            {
               defClass = BlankUpgradeIcon;
            }
            _clip.iconUpgrade.container.addChild(new defClass());
         }
         if(pathTierDef != null)
         {
            _clip.description.text = pathTierDef.name + "?";
         }
         else
         {
            _clip.description.text = "";
         }
         this.reveal();
         _okButton.setClickFunction(this.onSkipPathOKButtonClicked);
      }
      
      private function onRequestBloonResearchLabSkipSignal(param1:BloonResearchLabUpgrade, param2:int) : void
      {
         var defClass:Class = null;
         var qualifiedIconClassName:String = null;
         var upgrade:BloonResearchLabUpgrade = param1;
         var requiredBloonstones:int = param2;
         skipNowTitleText = "Finish Researching";
         this._targetBloonResearchLabUpgrade = upgrade;
         this._costBSToSkipBloonResearchLabUpgrade = requiredBloonstones;
         _clip.title.text = skipNowTitleText;
         _clip.costField.text = requiredBloonstones.toString();
         LGDisplayListUtil.getInstance().removeAllChildren(_clip.iconUpgrade.container);
         if(upgrade != null)
         {
            try
            {
               qualifiedIconClassName = "assets.icons." + upgrade.iconClassName;
               defClass = getDefinitionByName(qualifiedIconClassName) as Class;
            }
            catch(error:Error)
            {
               defClass = BlankUpgradeIcon;
            }
            _clip.iconUpgrade.container.addChild(new defClass());
         }
         if(upgrade != null)
         {
            _clip.description.text = upgrade.name + "?";
         }
         else
         {
            _clip.description.text = "";
         }
         PanelManager.getInstance().showFreePanel(this);
         _okButton.setClickFunction(this.onSkipBloonResearchLabUpgradeOKButtonClicked);
      }
      
      protected function onSkipPathOKButtonClicked() : void
      {
         if(this._targetPath == null)
         {
            this.hide();
            return;
         }
         var _loc1_:Number = this._targetPath.getBloonstonesRequiredToSkip();
         if(_loc1_ > 0 && canAfford(_loc1_,"to skip upgrade time."))
         {
            _loc1_ = this._targetPath.getBloonstonesRequiredToSkip();
            if(_loc1_ > 0)
            {
               this._resourceStore.bloonstones = this._resourceStore.bloonstones - this._targetPath.getBloonstonesRequiredToSkip();
               UpgradeSignals.purchasedSkipPathWarmup.dispatch(this._targetPath,_loc1_,this._targetPath.pathNumber,this._targetPath.unlockedTo);
            }
         }
         this.hide();
      }
      
      protected function onSkipBloonResearchLabUpgradeOKButtonClicked() : void
      {
         if(this._targetBloonResearchLabUpgrade === null)
         {
            this.hide();
            return;
         }
         if(this._costBSToSkipBloonResearchLabUpgrade > 0 && canAfford(this._costBSToSkipBloonResearchLabUpgrade,"to skip upgrade time."))
         {
            this._resourceStore.bloonstones = this._resourceStore.bloonstones - this._costBSToSkipBloonResearchLabUpgrade;
            UpgradeSignals.purchasedBloonResearchLabSkipWarmup.dispatch(this._targetBloonResearchLabUpgrade,this._costBSToSkipBloonResearchLabUpgrade);
         }
         this.hide();
      }
      
      override protected function onCancelButtonClicked() : void
      {
         this.hide();
      }
      
      override public function hide(param1:Number = 0.5) : void
      {
         this._targetPath = null;
         this._targetBloonResearchLabUpgrade = null;
         _okButton.setClickFunction(null);
         super.hide(param1);
      }
      
      override public function reveal(param1:Number = 0.5) : void
      {
         super.reveal(param1);
         this._videoAdPanelController.doVideoAvailableCheck();
      }
   }
}
