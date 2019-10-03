package ninjakiwi.monkeyTown.town.gameEvents.ui
{
   import flash.display.DisplayObjectContainer;
   import flash.media.SoundMixer;
   import flash.media.SoundTransform;
   import ninjakiwi.monkeyTown.smallEvents.bloonstoneSpendEvent.BloonstoneSpendRewardPanel;
   import ninjakiwi.monkeyTown.town.gameEvents.boss.ui.BossMilestonesRewardPanel;
   
   public class GameEventsUIManager
   {
       
      
      private var _container:DisplayObjectContainer;
      
      private var _ctMilestonesRewardPanel:CTMilestonesRewardPanel;
      
      private var _ctOccupationRewardPanel:CTOccupationRewardPanel;
      
      private var _bloonstoneSpendRewardPanel:BloonstoneSpendRewardPanel;
      
      private var _bossMilestonesPanel:BossMilestonesRewardPanel;
      
      public function GameEventsUIManager(param1:DisplayObjectContainer)
      {
         super();
         this._container = param1;
         this.init();
      }
      
      private function init() : void
      {
         this._ctMilestonesRewardPanel = new CTMilestonesRewardPanel(this._container);
         this._ctOccupationRewardPanel = new CTOccupationRewardPanel(this._container);
         this._bloonstoneSpendRewardPanel = new BloonstoneSpendRewardPanel(this._container);
         this._bossMilestonesPanel = new BossMilestonesRewardPanel(this._container);
      }
      
      public function get ctMilestonesRewardPanel() : CTMilestonesRewardPanel
      {
         return this._ctMilestonesRewardPanel;
      }
      
      public function get ctOccupationRewardPanel() : CTOccupationRewardPanel
      {
         return this._ctOccupationRewardPanel;
      }
      
      public function get bloonstoneSpendRewardPanel() : BloonstoneSpendRewardPanel
      {
         return this._bloonstoneSpendRewardPanel;
      }
      
      public function get bossMilestonesPanel() : BossMilestonesRewardPanel
      {
         return this._bossMilestonesPanel;
      }
   }
}
