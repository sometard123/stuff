package ninjakiwi.monkeyTown.common.btdModule
{
   import flash.events.EventDispatcher;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import org.osflash.signals.PrioritySignal;
   import org.osflash.signals.Signal;
   
   public interface IBloonsTowerDefenseModule
   {
       
      
      function startGame(param1:BTDGameRequest) : String;
      
      function endGame() : void;
      
      function getVersion() : String;
      
      function contestedTerritoryLeadingScoreBeat(param1:Boolean, param2:String = "", param3:int = -1) : void;
      
      function setData(param1:String, param2:*) : void;
      
      function pauseGame() : void;
      
      function unPauseGame() : void;
      
      function setIsStandalone(param1:Boolean) : void;
      
      function get usedCrateSignal() : Signal;
      
      function get analyticsSignal() : Signal;
      
      function get contestedTerritoryRoundCompletedSignal() : PrioritySignal;
      
      function get requestOptionsPanelSignal() : Signal;
      
      function set blockTowerPlacing(param1:Boolean) : void;
      
      function set audioIsAudible(param1:Boolean) : void;
      
      function get eventBridge() : EventDispatcher;
      
      function get displayPremaintenanceSignal() : Signal;
   }
}
