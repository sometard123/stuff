package ninjakiwi.monkeyTown.town.ui
{
   import assets.town.PvPLoseInfoPanelClip;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import ninjakiwi.monkeyTown.pvp.Friend;
   import ninjakiwi.monkeyTown.pvp.IncomingRaid;
   import ninjakiwi.monkeyTown.pvp.PvPMain;
   import ninjakiwi.monkeyTown.pvp.PvPSignals;
   import ninjakiwi.monkeyTown.town.ui.avatar.AvatarModule;
   import ninjakiwi.monkeyTown.ui.HideRevealViewPopup;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   import org.osflash.signals.Signal;
   
   public class PvPLoseInfoPanel extends HideRevealViewPopup
   {
       
      
      private const _clip:PvPLoseInfoPanelClip = new PvPLoseInfoPanelClip();
      
      private const _cancelButton:ButtonControllerBase = new ButtonControllerBase(this._clip.cancelButton);
      
      private const _revengeButton:ButtonControllerBase = new ButtonControllerBase(this._clip.revengeButton);
      
      private const _damagedBuildingsMessage:MovieClip = this._clip.damagedBuildingsMessage;
      
      private var _incomingRaid:IncomingRaid;
      
      private var _opponent:Friend;
      
      private const _avatarModule:AvatarModule = new AvatarModule(this._clip.avatarModule);
      
      private var _honorModule:HonourDisplayModule;
      
      public var closedSignal:Signal;
      
      public function PvPLoseInfoPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         this.closedSignal = new Signal();
         super(param1,param2);
         this._clip.addChild(this._avatarModule);
         addChild(this._clip);
         enableDefaultOnResize(this._clip);
         this.isModal = true;
         this._honorModule = new HonourDisplayModule(this._clip.honourSymbol,this._clip.honourField);
         this._cancelButton.setClickFunction(this.onOkButton);
         this._revengeButton.setClickFunction(this.onRevengeButtonClicked);
         this._damagedBuildingsMessage.visible = false;
         setAutoPlayStopClipsArray([this._clip.skull1,this._clip.skull2]);
      }
      
      public function resetResult() : void
      {
         this._clip.moneyLostTxt.text = "";
         this._clip.bloontoniumSalvagedText.text = "";
         this._damagedBuildingsMessage.visible = false;
         this._clip.defeatMessageField.text = "";
         this._clip.attackBackText.text = "";
         this._incomingRaid = null;
      }
      
      public function setResult(param1:Friend, param2:int, param3:int, param4:Boolean, param5:IncomingRaid, param6:Boolean = true) : void
      {
         this._incomingRaid = param5;
         this._clip.moneyLostTxt.text = String(param2);
         this._clip.bloontoniumSalvagedText.text = String(param3);
         this._damagedBuildingsMessage.visible = param4;
         this._opponent = param1;
         this._avatarModule.syncPlayer(param1.userID.toString(),this._incomingRaid.cityLevel,param1.clan,PvPMain.getMatchingCity(param1.cities,this._incomingRaid.attack.attackerCityIndex).honour);
         this._clip.defeatMessageField.text = param1.name + "\'s bloons swept through your defenses!";
         this._clip.attackBackText.text = "Attack " + param1.name + " back, and get your revenge!";
         if(param6)
         {
            this._revengeButton.unlock(1);
         }
         else
         {
            this._revengeButton.lock(3);
         }
      }
      
      public function setHonor(param1:int) : void
      {
         this._honorModule.setHonour(param1);
      }
      
      private function onRevengeButtonClicked() : void
      {
         PanelManager.getInstance().removePanel(TownUI.getInstance().myTowersPanel);
         var _loc1_:int = this._incomingRaid !== null?int(this._incomingRaid.attack.attackerCityIndex):0;
         PvPSignals.requestRevengeAttack.dispatch(this._opponent,_loc1_);
         this.hide();
      }
      
      private function onOkButton() : void
      {
         this.hide();
         PvPSignals.revengeOpportunityNotTaken.dispatch();
      }
      
      override public function hide(param1:Number = 0.2) : void
      {
         super.hide(param1);
         this.closedSignal.dispatch();
      }
   }
}
