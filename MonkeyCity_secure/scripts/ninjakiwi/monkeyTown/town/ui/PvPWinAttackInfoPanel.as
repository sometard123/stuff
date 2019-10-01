package ninjakiwi.monkeyTown.town.ui
{
   import assets.ui.PvPWinAttackInfoPanelClip;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.town.data.GameModConstants;
   import ninjakiwi.monkeyTown.town.data.GameMods;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.ui.avatar.AvatarModule;
   import ninjakiwi.monkeyTown.ui.HideRevealViewPopup;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class PvPWinAttackInfoPanel extends HideRevealViewPopup
   {
       
      
      private var _clip:PvPWinAttackInfoPanelClip;
      
      private var _okButton:ButtonControllerBase;
      
      private const _avatarModule:AvatarModule = new AvatarModule(this._clip.avatarModule);
      
      private var _honorModule:HonourDisplayModule;
      
      private const _warmongerEventModule:MovieClip = this._clip.warmongerBonus;
      
      private const _warmongerEventModuleGoldText:TextField = this._warmongerEventModule.warmongerBonusTxt;
      
      public function PvPWinAttackInfoPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         this._clip = new PvPWinAttackInfoPanelClip();
         this._okButton = new ButtonControllerBase(this._clip.okButton);
         super(param1,param2);
         this.isModal = true;
         this._clip.addChild(this._avatarModule);
         addChild(this._clip);
         this._honorModule = new HonourDisplayModule(this._clip.honourSymbol,this._clip.honourField);
         setAutoPlayStopClipsArray([this._clip.monkeySalute,this._clip.shoutingMonkey]);
      }
      
      public function syncToData(param1:Object) : void
      {
         this._avatarModule.syncPlayer(param1.target.userID,param1.target.cityLevel,param1.target.clan,param1.target.honour);
         var _loc2_:Number = param1.cashPillage;
         if(param1.info != null && param1.info.attackerCashReward != null)
         {
            _loc2_ = int(param1.info.attackerCashReward);
         }
         var _loc3_:Number = GameEventManager.getInstance().warmonger.getBonusPillageAmount(_loc2_);
         _loc2_ = _loc2_ * GameMods.getModifier(GameModConstants.CASH_EARNED_MOD);
         this._clip.moneyBonusTxt.text = int(_loc2_).toString();
         if(_loc3_ != 0)
         {
            _loc3_ = _loc3_ * GameMods.getModifier(GameModConstants.CASH_EARNED_MOD);
            this._warmongerEventModule.visible = true;
            this._warmongerEventModuleGoldText.visible = true;
            this._warmongerEventModuleGoldText.text = _loc3_.toString();
         }
         else
         {
            this._warmongerEventModule.visible = false;
            this._warmongerEventModuleGoldText.visible = false;
         }
         this._clip.pvpDescriptionTxt.text = LocalisationConstants.STRING_PVP_WIN_DESCRIPTION.split("<player name>").join(param1.target.name);
         this._okButton.setClickFunction(hide);
         this._honorModule.setHonour(param1.sender.honourChange);
      }
      
      override public function reveal(param1:Number = 0.2) : void
      {
         if(Math.random() < 0.5)
         {
            this._clip.monkeySalute.visible = true;
            this._clip.shoutingMonkey.visible = false;
            this._clip.monkeySalute.gotoAndPlay(1);
         }
         else
         {
            this._clip.monkeySalute.visible = false;
            this._clip.shoutingMonkey.visible = true;
            this._clip.shoutingMonkey.gotoAndPlay(1);
         }
         super.reveal(param1);
      }
   }
}
