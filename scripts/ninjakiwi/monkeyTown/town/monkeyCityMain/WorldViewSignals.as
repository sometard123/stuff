package ninjakiwi.monkeyTown.town.monkeyCityMain
{
   import com.lgrey.signal.SignalHub;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.utils.SignalAlias;
   import org.osflash.signals.Signal;
   
   public class WorldViewSignals
   {
      
      private static const _hub:SignalHub = SignalHub.getHub("world_view");
      
      public static const buildWorldStartSignal:Signal = _hub.defineSignal("buildWorldStartSignal");
      
      public static const buildWorldWithNameStartSignal:Signal = _hub.defineSignal("buildWorldWithNameStartSignal",String);
      
      public static const buildWorldEndSignal:Signal = _hub.defineSignal("buildWorldEndSignal");
      
      public static const clearWorldCompleteSignal:Signal = _hub.defineSignal("clearWorldCompleteSignal");
      
      public static const generateNewWorldCompleteSignal:Signal = _hub.defineSignal("generateNewWorldCompleteSignal");
      
      public static const userClickedTileSignal:Signal = _hub.defineSignal("userClickedTileSignal");
      
      public static const requestBTDGameSignal:Signal = _hub.defineSignal("requestBTDGameSignal");
      
      public static const requestBeaconGameSignal:Signal = _hub.defineSignal("requestBeaconGameSignal");
      
      public static const worldIsNowVisibleSignal:Signal = _hub.defineSignal("worldIsNowVisible");
      
      public static const buildProgressBarEndSignal:Signal = _hub.defineSignal("buildProgressBarEndSignal");
      
      public static const initialMVMDataReceived:Signal = _hub.defineSignal("initialMVMDataReceived");
      
      public static const createWorldEndSignal:Signal = _hub.defineSignal("createWorldEndSignal");
      
      public static const mouseEnteredNewTile:Signal = _hub.defineSignal("mouseEnteredNewTile");
      
      public static const reportOnMouseEnterNewTile:Signal = _hub.defineSignal("reportOnMouseEnterNewTile",String);
      
      public static const mouseHoveredBuilding:Signal = new Signal(Building);
      
      public static const buildWorldProgressSignal:SignalAlias = new SignalAlias();
      
      public static const buildingWasPlacedSignal:SignalAlias = new SignalAlias();
      
      public static const buildingWasPlacedWithoutShiftSignal:SignalAlias = new SignalAlias();
      
      public static const requestGenericConfirmation:Signal = _hub.defineSignal("requestGenericConfirmation",String,String,Function);
       
      
      public function WorldViewSignals()
      {
         super();
      }
   }
}
