package ninjakiwi.monkeyTown.town.ui
{
   import assets.ui.BuildingUpgradePanelClip;
   import com.lgrey.signal.SignalHub;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.buildings.customClasses.UpgradeableBuilding;
   import ninjakiwi.monkeyTown.town.data.BankTierData;
   import ninjakiwi.monkeyTown.town.data.BuildingData;
   import ninjakiwi.monkeyTown.town.data.UpgradeData;
   import ninjakiwi.monkeyTown.ui.HideRevealViewPopup;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   
   public class UpgradeBuildingPanel extends HideRevealViewPopup
   {
       
      
      private const _hubUI:SignalHub = SignalHub.getHub("ui");
      
      private const _clip:BuildingUpgradePanelClip = new BuildingUpgradePanelClip();
      
      private const _okButton:ButtonControllerBase = new ButtonControllerBase(this._clip.okButton);
      
      private const _upgradeButton:ButtonControllerBase = new ButtonControllerBase(this._clip.upgradeButton);
      
      private const _demolishButton:ButtonControllerBase = new ButtonControllerBase(this._clip.demolishButton);
      
      private const _fillBankButton:ButtonControllerBase = new ButtonControllerBase(this._clip.fillBankButton);
      
      private const _fillTankButton:ButtonControllerBase = new ButtonControllerBase(this._clip.fillTankButton);
      
      private var _upgradableBuilding:UpgradeableBuilding = null;
      
      private var _inspectingBuilding:Building = null;
      
      private const _upgradeInfoBox:MovieClip = this._clip.upgradeInfoBox;
      
      private const _costTextField:TextField = this._clip.upgradeInfoBox.moneyRequiredTxtgrey;
      
      private const _costCantAffordTextField:TextField = this._clip.upgradeInfoBox.moneyRequiredTxtCantAfford;
      
      private const _levelRequiredTextField:TextField = this._clip.upgradeInfoBox.levelRequiredTxt;
      
      private const _nextUpgradeTextField:TextField = this._clip.upgradeInfoBox.nextUpgradeTxt;
      
      private const _powerTextField:TextField = this._clip.powerInfoBox.powerTxt;
      
      private const _resourceBuildingIcons:MovieClip = this._clip.upgradeInfoBox.resourceBuildingIcons;
      
      private const _maxUpgradesMessage:MovieClip = this._clip.maxUpgradesMessage;
      
      private const _costTextColour:uint = this._clip.upgradeInfoBox.moneyRequiredTxtgrey.textColor;
      
      private const _costTextCantAffordColour:uint = this._clip.upgradeInfoBox.moneyRequiredTxtCantAfford.textColor;
      
      private const _levelTextColour:uint = this._clip.upgradeInfoBox.levelRequiredTxt.textColor;
      
      private const _upgradeData:UpgradeData = UpgradeData.getInstance();
      
      private const _resourceStore:ResourceStore = ResourceStore.getInstance();
      
      private const _currencySymbol:MovieClip = this._clip.currencySymbol;
      
      private const _powerText:MovieClip = this._clip.powerGeneratedText;
      
      public function UpgradeBuildingPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         super(param1,param2);
         this.isModal = true;
         addChild(this._clip);
         enableDefaultOnResize(this._clip);
         this._okButton.setClickFunction(this.hide);
         this._upgradeButton.setClickFunction(this.upgradeButtonClicked);
         this._demolishButton.setClickFunction(this.demolishButtonClicked);
         this._costCantAffordTextField.visible = false;
         this._maxUpgradesMessage.visible = false;
         this._fillBankButton.setClickFunction(this.onFillBanksButtonClick);
         this._fillTankButton.setClickFunction(this.onFillTanksButtonClick);
         setAutoPlayStopClipsArray([this._clip.fillTankButton.gem]);
         this._resourceBuildingIcons.gotoAndStop(1);
         this.initListeners();
      }
      
      private function initListeners() : void
      {
         this._resourceStore.townLevelChangedDiffSignal.add(this.reSync);
         this._resourceStore.monkeyMoneyChangedDiffSignal.add(this.reSync);
      }
      
      private function reSync(... rest) : void
      {
         if(isRevealed && this._upgradableBuilding !== null)
         {
            this.setInfo(this._upgradableBuilding);
         }
      }
      
      public function setInfo(param1:UpgradeableBuilding) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         this._inspectingBuilding = param1;
         this._upgradableBuilding = param1;
         this.checkDemolishable(param1,this._demolishButton);
         this._powerTextField.text = String(param1.definition.powerUsed);
         var _loc2_:* = param1.tier === param1.maximumTiers;
         var _loc3_:Boolean = param1.canGetUpgrade();
         this._clip.titleTxt.text = param1.definition.name;
         this._clip.levelIndicator.gotoAndStop(param1.tier);
         if(_loc3_)
         {
            this._upgradeButton.unlock();
         }
         else
         {
            this._upgradeButton.lock(3);
         }
         this._fillBankButton.target.visible = false;
         this._fillTankButton.target.visible = false;
         if(_loc2_)
         {
            this._upgradeInfoBox.visible = false;
            this._maxUpgradesMessage.visible = true;
            this._currencySymbol.visible = false;
            if(param1.definition.id === BuildingData.getInstance().WINDMILL.id || param1.definition.id === BuildingData.getInstance().WATERMILL.id)
            {
               this._powerText.visible = true;
               this._powerTextField.text = String(param1.nextUpgradeableValue);
            }
            else
            {
               this._powerText.visible = false;
            }
            if(param1.definition.id === "MonkeyBank")
            {
               this._fillBankButton.target.visible = true;
            }
            else if(param1.definition.id === "BananaFarm")
            {
               this._fillBankButton.target.visible = true;
            }
         }
         else
         {
            this._upgradeInfoBox.visible = true;
            this._maxUpgradesMessage.visible = false;
            if(param1.definition.id == BuildingData.getInstance().MONKEY_BANK.id)
            {
               this._nextUpgradeTextField.htmlText = "Next capacity:     " + BankTierData.getCapacityForTier(int(param1.tier + 1)) + "";
               this._currencySymbol.gotoAndStop(2);
               this._currencySymbol.x = 276;
            }
            else if(param1.definition.id == BuildingData.getInstance().BANANA_FARM.id)
            {
               this._nextUpgradeTextField.htmlText = "Next capacity:     " + param1.nextUpgradeableValue;
               this._currencySymbol.gotoAndStop(2);
               this._currencySymbol.x = 276;
            }
            else if(param1.definition.id == BuildingData.getInstance().WINDMILL.id || param1.definition.id == BuildingData.getInstance().WATERMILL.id)
            {
               this._nextUpgradeTextField.htmlText = "Increase to:      " + param1.nextUpgradeableValue;
               this._currencySymbol.gotoAndStop(1);
               this._currencySymbol.x = 258;
            }
            else
            {
               this._nextUpgradeTextField.htmlText = "Next capacity:      " + param1.nextUpgradeableValue + "";
               this._currencySymbol.gotoAndStop(3);
               this._currencySymbol.x = 278;
            }
            this._currencySymbol.visible = true;
            if(param1.definition.id === BuildingData.getInstance().WINDMILL.id || param1.definition.id === BuildingData.getInstance().WATERMILL.id)
            {
               this._powerText.visible = true;
               this._powerTextField.text = String(param1.upgradeableValue);
            }
            else
            {
               this._powerText.visible = false;
            }
            _loc4_ = param1.getUpgradeCostForTier(param1.tier + 1);
            this._costTextField.text = LocalisationConstants.MONEY_SYMBOL + _loc4_;
            _loc5_ = param1.getRequiredTownLevelForTier(param1.tier + 1);
            this._levelRequiredTextField.text = String(_loc5_);
            if(this._resourceStore.spendableMonkeyMoney < _loc4_)
            {
               this._costTextField.textColor = this._costTextCantAffordColour;
               this._costTextField.appendText(" (Can\'t afford)");
            }
            else
            {
               this._costTextField.textColor = this._costTextColour;
            }
            if(this._resourceStore.townLevel < _loc5_)
            {
               this._levelRequiredTextField.textColor = this._costTextCantAffordColour;
               this._levelRequiredTextField.appendText(" (Minimum city level)");
            }
            else
            {
               this._levelRequiredTextField.textColor = this._costTextColour;
            }
            this._resourceBuildingIcons.gotoAndStop(1);
            if(param1.definition.id === "BananaFarm")
            {
               if(param1.tier === 1)
               {
                  this._resourceBuildingIcons.gotoAndStop(1);
               }
               else if(param1.tier === 2)
               {
                  this._resourceBuildingIcons.gotoAndStop(9);
               }
               else if(param1.tier === 3)
               {
                  this._resourceBuildingIcons.gotoAndStop(10);
               }
               else if(param1.tier === 4)
               {
                  this._resourceBuildingIcons.gotoAndStop(11);
               }
               this._fillBankButton.target.visible = true;
            }
            else if(param1.definition.id === "MonkeyBank")
            {
               if(param1.tier === 1)
               {
                  this._resourceBuildingIcons.gotoAndStop(2);
               }
               else if(param1.tier === 2)
               {
                  this._resourceBuildingIcons.gotoAndStop(3);
               }
               else if(param1.tier === 3)
               {
                  this._resourceBuildingIcons.gotoAndStop(4);
               }
               else if(param1.tier === 4)
               {
                  this._resourceBuildingIcons.gotoAndStop(12);
               }
               else if(param1.tier === 5)
               {
                  this._resourceBuildingIcons.gotoAndStop(13);
               }
               else if(param1.tier === 6)
               {
                  this._resourceBuildingIcons.gotoAndStop(14);
               }
               else if(param1.tier === 7)
               {
                  this._resourceBuildingIcons.gotoAndStop(15);
               }
               this._fillBankButton.target.visible = true;
            }
            else if(param1.definition.id === "Windmill")
            {
               this._resourceBuildingIcons.gotoAndStop(5);
            }
            else if(param1.definition.id === "Watermill")
            {
               this._resourceBuildingIcons.gotoAndStop(6);
            }
            else if(param1.definition.id === "BloontoniumGenerator")
            {
               this._resourceBuildingIcons.gotoAndStop(7);
               this._fillTankButton.target.visible = true;
            }
            else if(param1.definition.id === "BloontoniumStorageTank")
            {
               this._resourceBuildingIcons.gotoAndStop(8);
            }
         }
      }
      
      private function upgradeButtonClicked() : void
      {
         if(this._upgradableBuilding == null)
         {
            this.hide();
            return;
         }
         if(this._upgradableBuilding.canGetUpgrade())
         {
            this._upgradableBuilding.upgrade();
         }
         this.hide();
      }
      
      private function demolishButtonClicked() : void
      {
         TownUI.getInstance().demolishConfirmPanel.confirmSignal.addOnce(this.demolishBuilding);
         PanelManager.getInstance().showFreePanel(TownUI.getInstance().demolishConfirmPanel);
      }
      
      private function demolishBuilding() : void
      {
         if(this._inspectingBuilding != null)
         {
            this._inspectingBuilding.demolish();
         }
         this.hide();
      }
      
      private function onFillBanksButtonClick() : void
      {
         this._hubUI.getSignal("requestBloonstonesToCashExchange").dispatch();
      }
      
      private function onFillTanksButtonClick() : void
      {
         this._hubUI.getSignal("requestBloonstonesToBloontoniumExchangeSignal").dispatch();
      }
      
      private function checkDemolishable(param1:Building, param2:ButtonControllerBase) : void
      {
         if(!param1.isDemolishable())
         {
            param2.lock(3);
         }
         else
         {
            param2.unlock();
         }
      }
      
      override public function hide(param1:Number = 0.2) : void
      {
         this._inspectingBuilding = null;
         this._upgradableBuilding = null;
         super.hide(param1);
      }
      
      private function onCashChangedSignal() : void
      {
         this.reSync();
      }
   }
}
