package ninjakiwi.monkeyTown.signals
{
   import org.osflash.signals.Signal;
   
   public class LoginSignals
   {
      
      public static const userHasLoggedIn:Signal = new Signal();
      
      public static const userHasLoggedOut:Signal = new Signal();
      
      public static const showLoginPrompt:Signal = new Signal();
      
      public static const showPlayPrompt:Signal = new Signal(Boolean);
       
      
      public function LoginSignals()
      {
         super();
      }
   }
}
