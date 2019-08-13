package ninjakiwi.monkeyTown.town.ui
{
   import assets.ui.EarningInfoClip;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.btd.definitions.TileAttackDefinition;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.town.specialItems.SpecialItemStore;
   import ninjakiwi.monkeyTown.town.specialMissions.SpecialMissionsManager;
   import ninjakiwi.monkeyTown.town.specialMissions.definition.SpecialMissionDefinition;
   import ninjakiwi.monkeyTown.town.tile.TileDefinitions;
   import ninjakiwi.monkeyTown.town.townMap.TownMap;
   import ninjakiwi.monkeyTown.utils.Calculator;
   
   public class EarnRewardModule
   {
       
      
      private var _linkedClip:EarningInfoClip;
      
      private var _moneyRewardBase:int = 0;
      
      private var _canEarnExtraCash:Boolean = false;
      
      public function EarnRewardModule(param1:EarningInfoClip)
      {
         super();
         this._linkedClip = param1;
      }
      
      public function setMessagewithAttackDefinition(param1:TownMap, param2:TileAttackDefinition) : void
      {
         this.setMessage(param1,param1.tileAtPoint(param2.attackAtLocation),param2.difficultyLevel,param2.difficultyRankRelativeToMTL);
      }
      
      public function setMessage(param1:TownMap, param2:Tile, param3:int, param4:int) : void
      {
         var _loc9_:SpecialMissionDefinition = null;
         this.hideAll();
         var _loc5_:int = Calculator.getXPFromAttack(param1,param3,param4);
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         this._canEarnExtraCash = true;
         var _loc8_:int = Calculator.getCashFromAttack(param3);
         if(param2 != null)
         {
            if(TileDefinitions.getInstance().isVolcano(param2))
            {
               _loc6_ = _loc6_ + Calculator.getBloonstoneFromVolcano(param3);
            }
            else if(TileDefinitions.getInstance().isCave(param2))
            {
               _loc8_ = _loc8_ + Calculator.getCashFromCave(param3);
               _loc6_ = _loc6_ + Calculator.getBloonstoneFromCave(param3);
            }
            else
            {
               _loc9_ = SpecialMissionsManager.getInstance().findSpecialMission(param2);
               if(_loc9_ != null)
               {
                  _loc8_ = _loc9_.rewardCash;
                  _loc5_ = _loc9_.rewardXP;
                  if(!SpecialItemStore.getInstance().hasSpecialItem(_loc9_.rewardSpecialItemId))
                  {
                     this._linkedClip.earnsSpecialItemClip.visible = true;
                     return;
                  }
                  this._canEarnExtraCash = false;
                  _loc6_ = _loc6_ + _loc9_.rewardBloonstones;
                  _loc7_ = _loc7_ + _loc9_.rewardBloontoniums;
               }
            }
         }
         this._linkedClip.xpRewardTxt.text = String(_loc5_);
         this._linkedClip.moneyBonusTxt.text = LocalisationConstants.MONEY_SYMBOL + String(_loc8_);
         if(this._canEarnExtraCash)
         {
            this._linkedClip.moneyBonusTxt.text = this._linkedClip.moneyBonusTxt.text + "+";
         }
         this.showDefaultReward();
         this._moneyRewardBase = _loc8_;
         if(_loc6_ > 0)
         {
            this._linkedClip.bloonStoneBonusTxt.text = String(_loc6_);
            this.showBS();
         }
         if(_loc7_ > 0)
         {
            this._linkedClip.bloontoniumText.text = String(_loc7_);
            this.showBT();
         }
      }
      
      public function hideAll() : void
      {
         this._linkedClip.earnsSpecialItemClip.visible = false;
         this._linkedClip.moneyBonusTxt.visible = false;
         this._linkedClip.cashIcon.visible = false;
         this._linkedClip.bloonStoneBonusTxt.visible = false;
         this._linkedClip.bloonstoneIcon.visible = false;
         this._linkedClip.xpRewardTxt.visible = false;
         this._linkedClip.xpIcon.visible = false;
         this._linkedClip.bloontoniumText.visible = false;
         this._linkedClip.bloontoniumIcon.visible = false;
      }
      
      public function setHardcoreState(param1:Boolean) : void
      {
         var _loc2_:Number = !!param1?Number(Constants.HARDCORE_MODE_MODIFIER):Number(1);
         this._linkedClip.moneyBonusTxt.text = String(this._moneyRewardBase * _loc2_);
         if(this._canEarnExtraCash)
         {
            this._linkedClip.moneyBonusTxt.text = this._linkedClip.moneyBonusTxt.text + "+";
         }
      }
      
      private function showSpecial() : void
      {
         this._linkedClip.earnsSpecialItemClip.visible = true;
      }
      
      private function showDefaultReward() : void
      {
         this._linkedClip.moneyBonusTxt.visible = true;
         this._linkedClip.cashIcon.visible = true;
         this._linkedClip.xpRewardTxt.visible = true;
         this._linkedClip.xpIcon.visible = true;
      }
      
      private function showBS() : void
      {
         this._linkedClip.bloonStoneBonusTxt.visible = true;
         this._linkedClip.bloonstoneIcon.visible = true;
      }
      
      private function showBT() : void
      {
         this._linkedClip.bloontoniumText.visible = true;
         this._linkedClip.bloontoniumIcon.visible = true;
      }
   }
}
