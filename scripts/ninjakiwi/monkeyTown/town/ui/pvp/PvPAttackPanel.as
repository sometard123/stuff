package ninjakiwi.monkeyTown.town.ui.pvp
{
   import assets.town.PvPAdvancedAttackClipNewVersion;
   import flash.display.DisplayObjectContainer;
   import flash.text.TextField;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.analytics.StatsDataManager;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.pvp.Friend;
   import ninjakiwi.monkeyTown.pvp.PvPAttackDefinition;
   import ninjakiwi.monkeyTown.pvp.PvPMain;
   import ninjakiwi.monkeyTown.pvp.PvPSignals;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.data.BuildingData;
   import ninjakiwi.monkeyTown.town.quests.QuestCounter;
   import ninjakiwi.monkeyTown.town.townMap.TownMap;
   import ninjakiwi.monkeyTown.town.ui.PvPNotEnoughResourcesPanel;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.town.ui.avatar.AvatarModule;
   import ninjakiwi.monkeyTown.town.ui.pvp.attack.PvPAttackBase;
   import ninjakiwi.monkeyTown.town.ui.pvp.attack.PvPAttackBloonTypeSlider;
   import ninjakiwi.monkeyTown.town.ui.pvp.attack.PvPAttackOptions;
   import ninjakiwi.monkeyTown.town.ui.pvp.attack.PvPAttackStrengthSlider;
   import ninjakiwi.monkeyTown.town.ui.warning.MissingSomethingPanel;
   import ninjakiwi.monkeyTown.ui.HideRevealViewPopup;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   import org.osflash.signals.Signal;
   
   public class PvPAttackPanel extends HideRevealViewPopup
   {
       
      
      private const _clip:PvPAdvancedAttackClipNewVersion = new PvPAdvancedAttackClipNewVersion();
      
      private const _closeButton:ButtonControllerBase = new ButtonControllerBase(this._clip.closeButton);
      
      private const _goButton:ButtonControllerBase = new ButtonControllerBase(this._clip.go_btn);
      
      private const _useMaxButton:ButtonControllerBase = new ButtonControllerBase(this._clip.useMaxButton);
      
      private const _writeButton:ButtonControllerBase = new ButtonControllerBase(this._clip.writeMessageButton);
      
      private const _title_txt:TextField = this._clip.title_txt;
      
      private const _difficulty_txt:TextField = this._clip.difficultyTxt;
      
      private const _bloontoniumInvestedField:TextField = this._clip.bloontonium_txt;
      
      private const _bloonstonesInvestedField:TextField = this._clip.bloonStones_txt;
      
      private var _notEnoughResourcesPanel:PvPNotEnoughResourcesPanel;
      
      private const _avatarModule:AvatarModule = new AvatarModule(this._clip.avatarModule);
      
      private const _resourceStore:ResourceStore = ResourceStore.getInstance();
      
      private var _availableBloonstones:int;
      
      private var _availableBloontonium:int;
      
      private var _targetOpponent:Friend = null;
      
      private var _isRevenge:Boolean = false;
      
      private var _map:TownMap;
      
      private var _targetCityIndex:int = 0;
      
      private const _modules:Vector.<PvPAttackBase> = new Vector.<PvPAttackBase>();
      
      private var _strengthSlider:PvPAttackStrengthSlider;
      
      private var _bloonTypeSlider:PvPAttackBloonTypeSlider;
      
      private var _options:PvPAttackOptions;
      
      public const closeSignal:Signal = new Signal();
      
      private const _messagePopup:WriteMessagePanel = new WriteMessagePanel(TownUI.getInstance().popupLayer);
      
      public function PvPAttackPanel(param1:DisplayObjectContainer, param2:TownMap)
      {
         super(param1);
         this._map = param2;
         this._closeButton.setClickFunction(this.closeButtonClicked);
         this._goButton.setClickFunction(this.goButtonClicked);
         this._useMaxButton.setClickFunction(this.useMaxButtonClicked);
         this._writeButton.setClickFunction(this.writeMessageClicked);
         this._resourceStore.bloontoniumChangedDiffSignal.add(this.setBloontonium);
         this._notEnoughResourcesPanel = new PvPNotEnoughResourcesPanel(this);
         this._strengthSlider = new PvPAttackStrengthSlider(this._clip);
         this._bloonTypeSlider = new PvPAttackBloonTypeSlider(this._clip);
         this._options = new PvPAttackOptions(this._clip);
         this._modules.push(this._strengthSlider);
         this._modules.push(this._bloonTypeSlider);
         this._modules.push(this._options);
         this._strengthSlider.changedSignal.add(this.syncAll);
         this._bloonTypeSlider.changedSignal.add(this.syncOptions);
         this._options.changedSignal.add(this.syncTexts);
         isModal = true;
         enableDefaultOnResize(this._clip);
         this.setTitleText("Attack User");
         addChild(this._clip);
         this._clip.addChild(this._avatarModule);
      }
      
      override public function centerOnStage() : void
      {
         if(!_flashClip)
         {
            return;
         }
         _flashClip.x = int(_system.flashStage.stageWidth * 0.5);
         _flashClip.y = int(_system.flashStage.stageHeight * 0.5) - 10;
      }
      
      private function setBloontonium(param1:int) : void
      {
         this.syncTexts();
      }
      
      private function setTitleText(param1:String) : void
      {
         this._title_txt.text = param1;
      }
      
      private function closeButtonClicked() : void
      {
         this.hide();
      }
      
      private function useMaxButtonClicked() : void
      {
         this._strengthSlider.setInvestedBloontonium(this._resourceStore.bloontonium + this._resourceStore.getTempOverage());
      }
      
      override public function hide(param1:Number = 0.2) : void
      {
         this._isRevenge = false;
         super.hide(param1);
         this._resourceStore.discardBloontoniumOverage();
         this._bloonTypeSlider.disableTooltips();
         this.closeSignal.dispatch();
         this._targetOpponent = null;
         TownUI.getInstance().useBloonstonesConfirmPanel.okSignal.remove(this.tryToSendAttack);
      }
      
      public function canSendAttack() : Boolean
      {
         if(!_system.city.buildingManager.hasCompletedBuilding(BuildingData.getInstance().BLOON_INFLATION_AND_DEPLOYMENT_FACTORY.id))
         {
            TownUI.getInstance().missingSomethingPanel.setMessage(LocalisationConstants.STRING_BUILDING_NEEDED_FOR_PVP_ATTACK.split("<building name>").join(BuildingData.getInstance().BLOON_INFLATION_AND_DEPLOYMENT_FACTORY.name),MissingSomethingPanel.TYPE_BUILDING);
            PanelManager.getInstance().showFreePanel(TownUI.getInstance().missingSomethingPanel);
            return false;
         }
         return true;
      }
      
      public function checkMiniumBloonType(param1:Friend, param2:int) : Boolean
      {
         var _loc4_:String = null;
         var _loc3_:int = this._strengthSlider.getLeastDifficulty(param1,param2);
         if(this._bloonTypeSlider.isSelectedBloonTypeAvailable(_loc3_) == false)
         {
            _loc4_ = this._bloonTypeSlider.getSelectedBloonResearchName(_loc3_);
            TownUI.getInstance().missingSomethingPanel.setMessage(LocalisationConstants.STRING_BLOON_RESEARCH_WARNING.split("<min research name>").join(_loc4_).split("<player name>").join(param1.name),MissingSomethingPanel.TYPE_RESEARCH);
            PanelManager.getInstance().showFreePanel(TownUI.getInstance().missingSomethingPanel);
            return false;
         }
         return true;
      }
      
      private function goButtonClicked() : void
      {
         var _loc2_:String = null;
         if(this._bloonTypeSlider.isSelectedBloonTypeAvailable(this._strengthSlider.getDifficultyForInvestment()) == false)
         {
            _loc2_ = this._bloonTypeSlider.getSelectedBloonResearchName(this._strengthSlider.getDifficultyForInvestment());
            TownUI.getInstance().missingSomethingPanel.setMessage(LocalisationConstants.STRING_BLOON_RESEARCH_WARNING.split("<min research name>").join(_loc2_).split("<player name>").join(this._targetOpponent.name),MissingSomethingPanel.TYPE_RESEARCH);
            PanelManager.getInstance().showFreePanel(TownUI.getInstance().missingSomethingPanel);
            return;
         }
         var _loc1_:int = this.getInvestedBloonstones();
         if(_loc1_ > 0)
         {
            TownUI.getInstance().useBloonstonesConfirmPanel.okSignal.addOnce(this.tryToSendAttack);
            PanelManager.getInstance().showFreePanel(TownUI.getInstance().useBloonstonesConfirmPanel);
         }
         else
         {
            this.tryToSendAttack();
         }
      }
      
      private function tryToSendAttack() : void
      {
         var requiredBloonstones:int = 0;
         var attackDefinition:PvPAttackDefinition = null;
         var bloonstones:int = this.getInvestedBloonstones();
         if(this._resourceStore.bloonstones < bloonstones)
         {
            requiredBloonstones = bloonstones - this._resourceStore.bloonstones;
            this._notEnoughResourcesPanel.setRequiredBloonstones(requiredBloonstones,LocalisationConstants.BLOONSTONES_FOR_PVP_ATTACK.split("<bloonstones>").join(String(requiredBloonstones)));
            PanelManager.getInstance().showFreePanel(this._notEnoughResourcesPanel);
         }
         else
         {
            PanelManager.getInstance().showFreePanel(TownUI.getInstance().loading);
            attackDefinition = this.describeAttack();
            PvPSignals.sendPVPAttack.dispatch(attackDefinition,function(param1:Object):void
            {
               sendAttackCallback(param1,attackDefinition);
            });
         }
      }
      
      private function sendAttackCallback(param1:Object, param2:PvPAttackDefinition) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         TownUI.getInstance().loading.hide(0);
         if(param1.success != null && param1.success == true)
         {
            _loc3_ = this.getInvestedBloonstones();
            this._resourceStore.bloonstones = this._resourceStore.bloonstones - _loc3_;
            _loc4_ = this._strengthSlider.getInvestedBloontonium() - this._resourceStore.getTempOverage();
            if(_loc4_ < 0)
            {
               _loc4_ = 0;
            }
            this._resourceStore.bloontonium = this._resourceStore.bloontonium - _loc4_;
            this._resourceStore.spendTempOverage(this._resourceStore.getTempOverage());
            if(_loc3_ > 0)
            {
               GameSignals.MVM_OVERCLOCKED_WITH_BLOONSTONES.dispatch(_loc3_,param2);
            }
            PvPSignals.requestRefeshPvPData.dispatch();
            PanelManager.getInstance().showFreePanel(TownUI.getInstance().pvpAttackDeployedPanel);
            if(this._isRevenge)
            {
               this._isRevenge = false;
               PvPSignals.revengeAttackLaunched.dispatch();
            }
            this.hide();
            PvPSignals.sendMVMAttackSucceeded.dispatch(param2);
            StatsDataManager.getInstance().attackSent();
         }
         else
         {
            if(param1.error != null)
            {
               TownUI.getInstance().attackFailedPanel.setState(param1.state);
            }
            else
            {
               TownUI.getInstance().attackFailedPanel.setState("");
            }
            PanelManager.getInstance().showFreePanel(TownUI.getInstance().attackFailedPanel);
         }
      }
      
      override public function reveal(param1:Number = 0.5) : void
      {
         var _loc2_:PvPAttackBase = null;
         if(this.canSendAttack())
         {
            super.reveal(param1);
            for each(_loc2_ in this._modules)
            {
               _loc2_.refresh();
            }
            this.syncBloonTypes(true);
            this._options.reset();
            this.syncAll();
            this._bloonTypeSlider.enableTooltips();
            this._messagePopup.resetMessage();
            this.useMaxButtonClicked();
         }
      }
      
      private function syncTexts() : void
      {
         var _loc1_:Object = null;
         this._availableBloontonium = this._resourceStore.bloontonium + this._resourceStore.getTempOverage();
         this._availableBloonstones = this._resourceStore.bloonstones;
         if(this._targetOpponent != null)
         {
            _loc1_ = this.getCityData();
            if(_loc1_ != null)
            {
               this._difficulty_txt.text = "Strength: " + this._map.getDifficultyDescriptionByRank(this._map.getPVPRank(this._strengthSlider.getDifficultyForInvestment(),_loc1_.level,"",null));
            }
         }
         if(this._availableBloontonium < this._strengthSlider.getInvestedBloontonium())
         {
            this._bloontoniumInvestedField.text = this._availableBloontonium.toString() + " + " + (this._strengthSlider.getInvestedBloontonium() - this._availableBloontonium);
         }
         else
         {
            this._bloontoniumInvestedField.text = this._strengthSlider.getInvestedBloontonium().toString();
         }
         this._bloonstonesInvestedField.text = this.getInvestedBloonstones().toString();
      }
      
      private function syncBloonTypes(param1:Boolean = false) : void
      {
         this._bloonTypeSlider.syncBloonType(this._strengthSlider.getInvestedAttackLevel(),this._strengthSlider.getDifficultyForInvestment(),param1);
      }
      
      private function syncOptions() : void
      {
         this._options.syncTickboxes(this._bloonTypeSlider.isRedBloonAttack(),this._bloonTypeSlider.doesUseLead(),this._bloonTypeSlider.doesUseMoab());
      }
      
      private function syncAll() : void
      {
         if(this._targetOpponent == null)
         {
            return;
         }
         this.syncTexts();
         this.syncBloonTypes();
         this.syncOptions();
      }
      
      private function getInvestedBloonstones() : int
      {
         return this._options.getTotalCosts(this._strengthSlider.getInvestedBloontonium()) + this.getBloonstonesForOverage();
      }
      
      private function getBloonstonesForOverage() : int
      {
         var _loc1_:int = this._strengthSlider.getInvestedBloontonium() - (this._resourceStore.bloontonium + this._resourceStore.getTempOverage());
         if(_loc1_ < 0)
         {
            _loc1_ = 0;
         }
         return _loc1_ / Constants.BLOONTONIUM_PER_BLOONSTONE;
      }
      
      private function describeAttack() : PvPAttackDefinition
      {
         return new PvPAttackDefinition().Difficulty(this._strengthSlider.getDifficultyForInvestment()).MoreRegens(this._options.getRegenDescription()).MoreLeads(this._options.getLeadDescription()).MoreCamos(this._options.getCamoDescription()).MoreMoabs(this._options.getMoabDescription()).StrongestBloonType(this._bloonTypeSlider.getStrongestBloonType()).AttackerID(_system.nkGatewayUser.loginInfo.id).AttackerCityIndex(_system.city.cityIndex).DefenderID(this._targetOpponent.userID).DefenderUserName(this._targetOpponent.name).DefenderUserClan(this._targetOpponent.clan).DefenderCityIndex(this._targetCityIndex).DefenderCityLevel(this.getCityData().level != null?int(this.getCityData().level):-1).InvestedBloontonium(this._strengthSlider.getInvestedBloontonium()).MaximumCashPillage(_system.city.bankManager.getMaximumPillage()).IsRevenge(this._isRevenge).MessageToOpponent(this._messagePopup.getMessage()).QuickMatchID(this._targetOpponent.quickMatchID);
      }
      
      public function syncToOpponent(param1:Friend, param2:int) : void
      {
         this._targetOpponent = param1;
         this._targetCityIndex = param2;
         this.setTitleText("Attack " + param1.name);
         this._strengthSlider.setOpponent(this._targetOpponent,param2);
         this.syncTexts();
         var _loc3_:Object = PvPMain.getMatchingCity(param1.cities,param2);
         this._avatarModule.syncPlayer(this._targetOpponent.userID,_loc3_.level,this._targetOpponent.clan,_loc3_.honour);
      }
      
      private function getCityData() : Object
      {
         var _loc1_:Object = PvPMain.getMatchingCity(this._targetOpponent.cities,this._targetCityIndex);
         return _loc1_;
      }
      
      private function canAttackOpponent(param1:Friend, param2:int) : Boolean
      {
         var _loc3_:Number = this._strengthSlider.getLeastDifficulty(param1,param2);
         return this._bloonTypeSlider.canAttackLevel(_loc3_);
      }
      
      private function getLeastResearchName(param1:Friend, param2:int) : String
      {
         var _loc3_:Number = this._strengthSlider.getLeastDifficulty(param1,param2);
         return this._bloonTypeSlider.getLeastResearchLabNameForAttackLevel(_loc3_);
      }
      
      public function setUpRevengeAttack(param1:Friend, param2:int) : void
      {
         this._isRevenge = true;
         this.syncToOpponent(param1,param2);
         PvPSignals.setRevengeAttack.dispatch();
      }
      
      private function writeMessageClicked() : void
      {
         PanelManager.getInstance().showFreePanel(this._messagePopup);
      }
   }
}
