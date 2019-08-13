package ninjakiwi.monkeyTown.town.ui.pvp
{
   import assets.ui.MVMAttackFailedPanelClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.town.ui.HonourDisplayModule;
   import ninjakiwi.monkeyTown.town.ui.avatar.AvatarModule;
   import ninjakiwi.monkeyTown.ui.HideRevealViewPopup;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class MvMAttackFailedPanel extends HideRevealViewPopup
   {
       
      
      private const _clip:MVMAttackFailedPanelClip = new MVMAttackFailedPanelClip();
      
      private const _okButton:ButtonControllerBase = new ButtonControllerBase(this._clip.okButton);
      
      private var _honorModule:HonourDisplayModule;
      
      private const _avatarModule:AvatarModule = new AvatarModule(this._clip.avatarModule);
      
      public function MvMAttackFailedPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         super(param1,param2);
         this.isModal = true;
         this.enableDefaultOnResize(this._clip);
         this._clip.addChild(this._avatarModule);
         this.addChild(this._clip);
         this._honorModule = new HonourDisplayModule(this._clip.honourSymbol,this._clip.honourField);
         this._okButton.setClickFunction(hide);
      }
      
      public function syncToData(param1:Object) : void
      {
         this._avatarModule.syncPlayer(param1.target.userID,param1.target.cityLevel,param1.target.clan,param1.target.honour);
         this._clip.defeatMessageField.text = LocalisationConstants.STRING_PVP_LOSE_DESCRIPTION.split("<player name>").join(param1.target.name);
         this._okButton.setClickFunction(hide);
         this._honorModule.setHonour(param1.sender.honourChange);
      }
   }
}
