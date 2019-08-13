package ninjakiwi.monkeyTown.mouseManager
{
   import com.lgrey.signal.SignalHub;
   import org.osflash.signals.Signal;
   
   public class MouseManagerSignals
   {
       
      
      private const _signalHub:SignalHub = SignalHub.getHub();
      
      public const validClickSignal:Signal = this._signalHub.defineSignal("validClickSignal",Number,Number);
      
      public const mouseMoveSignal:Signal = this._signalHub.defineSignal("mouseMoveSignal",Number,Number);
      
      public const dragStartSignal:Signal = this._signalHub.defineSignal("dragStartSignal",Number,Number);
      
      public const dragEndSignal:Signal = this._signalHub.defineSignal("dragEndSignal",Number,Number);
      
      public const dragUpdateSignal:Signal = this._signalHub.defineSignal("dragUpdateSignal",Number,Number);
      
      public function MouseManagerSignals()
      {
         super();
      }
   }
}
