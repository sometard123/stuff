package ninjakiwi.monkeyTown.town.ui.bananaFarm
{
   import com.lgrey.signal.SignalHub;
   import com.lgrey.vectors.LGVector2D;
   import org.osflash.signals.Signal;
   
   public class BananaFarmSignals
   {
      
      private static const _hub:SignalHub = SignalHub.getHub("BananaFarm");
      
      public static const moneyCollected:Signal = _hub.defineSignal("moneyCollected",LGVector2D,int);
       
      
      public function BananaFarmSignals()
      {
         super();
      }
   }
}
