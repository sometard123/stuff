package ninjakiwi.monkeyTown.town.ui.pvp.attack
{
   import assets.town.PvPAdvancedAttackClipNewVersion;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.town.quests.QuestCounter;
   import ninjakiwi.monkeyTown.town.ui.contestedTerritory.ContestedTerritoryPanel;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   import ninjakiwi.monkeyTown.userServices.kong.Kong;
   import org.osflash.signals.Signal;
   
   public class PvPAttackBase
   {
       
      
      protected var _clip:PvPAdvancedAttackClipNewVersion;
      
      protected const _resourceStore:ResourceStore = ResourceStore.getInstance();
      
      public const changedSignal:Signal = new Signal();
      
      public function PvPAttackBase(param1:PvPAdvancedAttackClipNewVersion)
      {
         super();
         this._clip = param1;
      }
      
      public function sync() : void
      {
      }
      
      public function refresh() : void
      {
      }
      
      protected function needSync() : void
      {
         this.changedSignal.dispatch();
      }
   }
}
