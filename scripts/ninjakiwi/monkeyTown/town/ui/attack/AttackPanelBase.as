package ninjakiwi.monkeyTown.town.ui.attack
{
   import assets.ui.AddStartCashClip;
   import assets.ui.EarningInfoClip;
   import assets.ui.TerrainDetailClip;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import ninjakiwi.monkeyTown.btd.definitions.TileAttackDefinition;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.town.townMap.TownMap;
   import ninjakiwi.monkeyTown.town.ui.EarnRewardModule;
   import ninjakiwi.monkeyTown.town.ui.TerrainDetail;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.town.ui.terrain.AddStartCashModule;
   import ninjakiwi.monkeyTown.ui.HideRevealViewPopup;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   import org.osflash.signals.Signal;
   
   public class AttackPanelBase extends HideRevealViewPopup
   {
       
      
      protected var _startCashOption:AddStartCashModule;
      
      private var _details:TerrainDetail;
      
      protected var _earns:EarnRewardModule;
      
      private var _cancelButton:ButtonControllerBase;
      
      private var _attackButton:ButtonControllerBase;
      
      private const _resourceStore:ResourceStore = ResourceStore.getInstance();
      
      public const attackConfirmSignal:Signal = new Signal(Boolean);
      
      public function AttackPanelBase(param1:DisplayObjectContainer, param2:AddStartCashClip = null, param3:TerrainDetailClip = null, param4:EarningInfoClip = null, param5:MovieClip = null, param6:MovieClip = null)
      {
         super(param1);
         this.isModal = true;
         if(param2 != null)
         {
            this._startCashOption = new AddStartCashModule(param2);
            this._startCashOption.enableWarningPanel(param1);
            this._startCashOption.changedSignal.add(this.onOptionChanged);
            this._startCashOption.testMissionButton.setClickFunction(this.onTestMission);
         }
         if(param4 != null)
         {
            this._earns = new EarnRewardModule(param4);
         }
         if(param3 != null)
         {
            this._details = new TerrainDetail(param3,TerrainDetail.TERRAIN_INFO | TerrainDetail.DIFFICULTY | TerrainDetail.STARTING_CASH | TerrainDetail.ASSAULT | TerrainDetail.STRONGEST);
         }
         if(param5 != null)
         {
            this._cancelButton = new ButtonControllerBase(param5);
            this._cancelButton.setClickFunction(this.onCancel);
         }
         if(param6 != null)
         {
            this._attackButton = new ButtonControllerBase(param6);
            this._attackButton.setClickFunction(this.onAttack);
         }
      }
      
      protected function onOptionChanged() : void
      {
         if(this._details != null)
         {
            this._details.setStartingCash(this._resourceStore.btdStartingMoney,this._resourceStore.btdBonusStartingMoney + this._startCashOption.bonusStartingCash);
         }
      }
      
      public function get bonusStartingCash() : int
      {
         if(this._startCashOption == null)
         {
            return 0;
         }
         return this._startCashOption.bonusStartingCash;
      }
      
      public function get startCashOption() : AddStartCashModule
      {
         return this._startCashOption;
      }
      
      public function get isHardcore() : Boolean
      {
         return false;
      }
      
      public function get cratesTicked() : int
      {
         return 0;
      }
      
      public function get cratesTickedArray() : Array
      {
         return [0,0,0];
      }
      
      public function setMessage(param1:TownMap, param2:TileAttackDefinition) : void
      {
         if(this._startCashOption != null)
         {
            this._startCashOption.reset();
         }
         var _loc3_:Tile = param1.tileAtPoint(param2.attackAtLocation);
         if(_loc3_ == null)
         {
            return;
         }
         if(this._details != null)
         {
            this._details.setDetails(_loc3_,param2.costToAttack,this._resourceStore.btdStartingMoney,this._resourceStore.btdBonusStartingMoney + this._startCashOption.bonusStartingCash);
         }
         if(this._earns != null)
         {
            this._earns.setMessagewithAttackDefinition(param1,param2);
         }
      }
      
      private function onCancel() : void
      {
         hide();
         this.attackConfirmSignal.dispatch(false);
      }
      
      private function onAttack() : void
      {
         if(this._startCashOption.canAfford())
         {
            this.attackConfirmSignal.dispatch(true);
            this._startCashOption.apply();
            hide();
         }
      }
      
      private function onTestMission() : void
      {
         TownUI.getInstance().testMissionPanel.setAttackSignal(this.attackConfirmSignal);
         PanelManager.getInstance().showPanel(TownUI.getInstance().testMissionPanel);
         hide();
      }
   }
}
