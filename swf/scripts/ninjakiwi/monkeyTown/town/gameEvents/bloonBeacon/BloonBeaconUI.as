package ninjakiwi.monkeyTown.town.gameEvents.bloonBeacon
{
   import com.codecatalyst.promise.Promise;
   import flash.display.Sprite;
   import ninjakiwi.monkeyTown.town.gameEvents.bloonBeacon.ui.BloonBeaconEventPanel;
   import ninjakiwi.monkeyTown.town.gameEvents.bloonBeacon.ui.BloonBeaconRechargePanel;
   import ninjakiwi.monkeyTown.town.gameEvents.bloonBeacon.ui.BloonBeaconTutorialPanel;
   import ninjakiwi.monkeyTown.town.gameEvents.bloonBeacon.ui.BloonBeaconVictoryPanel;
   import ninjakiwi.monkeyTown.town.gameEvents.bloonBeacon.ui.BloonBeaconVictoryPanelBoss;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   
   public class BloonBeaconUI
   {
       
      
      private var _bloonBeaconRechargePanel:BloonBeaconRechargePanel = null;
      
      private var _bloonBeaconEventPanel:BloonBeaconEventPanel = null;
      
      private var _bloonBeaconTutorialPanel:BloonBeaconTutorialPanel = null;
      
      private var _bloonBeaconVictoryPanel:BloonBeaconVictoryPanel = null;
      
      private var _bloonBeaconVictoryPanelBoss:BloonBeaconVictoryPanelBoss = null;
      
      public function BloonBeaconUI()
      {
         super();
         var _loc1_:Sprite = TownUI.getInstance().tutorialLayer;
         var _loc2_:Sprite = TownUI.getInstance().popupLayer;
         this._bloonBeaconRechargePanel = new BloonBeaconRechargePanel(_loc2_);
         this._bloonBeaconEventPanel = new BloonBeaconEventPanel(_loc2_);
         this._bloonBeaconTutorialPanel = new BloonBeaconTutorialPanel(_loc1_);
         this._bloonBeaconVictoryPanel = new BloonBeaconVictoryPanel(_loc2_);
         this._bloonBeaconVictoryPanelBoss = new BloonBeaconVictoryPanelBoss(_loc2_);
      }
      
      public function get bloonBeaconRechargePanel() : BloonBeaconRechargePanel
      {
         return this._bloonBeaconRechargePanel;
      }
      
      public function get bloonBeaconEventPanel() : BloonBeaconEventPanel
      {
         return this._bloonBeaconEventPanel;
      }
      
      public function get bloonBeaconTutorialPanel() : BloonBeaconTutorialPanel
      {
         return this._bloonBeaconTutorialPanel;
      }
      
      public function get bloonBeaconVictoryPanel() : BloonBeaconVictoryPanel
      {
         return this._bloonBeaconVictoryPanel;
      }
      
      public function get bloonBeaconVictoryPanelBoss() : BloonBeaconVictoryPanelBoss
      {
         return this._bloonBeaconVictoryPanelBoss;
      }
   }
}
