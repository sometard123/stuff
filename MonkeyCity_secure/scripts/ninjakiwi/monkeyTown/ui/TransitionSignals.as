package ninjakiwi.monkeyTown.ui
{
   import org.osflash.signals.Signal;
   
   public class TransitionSignals
   {
      
      public static const beganLoadingBTDGame:Signal = new Signal();
      
      public static const beganLoadingContestedGame:Signal = new Signal();
      
      public static const btdGameIsNowReady:Signal = new Signal();
      
      public static const trackSwfLoadComplete:Signal = new Signal();
      
      public static const beginTransitionFromBTDToCity:Signal = new Signal(Boolean,Boolean);
      
      public static const endTransitionFromBTDToCity:Signal = new Signal();
      
      public static const closeCurtainCompleteSignal:Signal = new Signal();
      
      public static const raiseCurtainCompleteSignal:Signal = new Signal();
      
      public static const gameSwfLoadProgressSignal:Signal = new Signal(Number);
       
      
      public function TransitionSignals()
      {
         super();
      }
   }
}
