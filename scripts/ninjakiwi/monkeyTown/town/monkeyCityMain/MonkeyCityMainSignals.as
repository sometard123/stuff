package ninjakiwi.monkeyTown.town.monkeyCityMain
{
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.monkeyTown.utils.SignalAlias;
   import org.osflash.signals.Signal;
   
   public class MonkeyCityMainSignals
   {
       
      
      public const readySignal:Signal = new Signal();
      
      public const btdGameWonSignal:Signal = new Signal();
      
      public const btdGameLostSignal:Signal = new Signal();
      
      public const selectAttackTargetSignal:Signal = new Signal();
      
      public const cancelledAttackSignal:Signal = new Signal();
      
      public const btdVictoryDialogClosedSignal:Signal = new Signal();
      
      public const completedGameDialogClosedSignal:Signal = new Signal(Boolean);
      
      public const btdGameRequestSet:Signal = new Signal(BTDGameRequest);
      
      public const myTowersPanelOpenedSignal:SignalAlias = new SignalAlias();
      
      public const myTowersPanelClosedSignal:SignalAlias = new SignalAlias();
      
      public const buildPanelOpenedSignal:SignalAlias = new SignalAlias();
      
      public const buildPanelClosedSignal:SignalAlias = new SignalAlias();
      
      public const beginPlacingBuildingSignal:SignalAlias = new SignalAlias();
      
      public const cancelPlacingBuildingSignal:SignalAlias = new SignalAlias();
      
      public const cancelMovingBuildingSignal:SignalAlias = new SignalAlias();
      
      public const buildingWasSelectedSignal:SignalAlias = new SignalAlias();
      
      public const buildingWasSelectedForTileSignal:SignalAlias = new SignalAlias();
      
      public const buildWorldStartSignal:SignalAlias = new SignalAlias();
      
      public const loadCityAllCompleteSignal:SignalAlias = new SignalAlias();
      
      public function MonkeyCityMainSignals()
      {
         super();
      }
   }
}
