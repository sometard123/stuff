package ninjakiwi.monkeyTown.common.bridges
{
   import org.osflash.signals.Signal;
   
   public class UpgradesBridge
   {
      
      public static const REQUEST_UPGRADE_INFORMATION:Signal = new Signal(String,int,int,Function);
       
      
      public function UpgradesBridge()
      {
         super();
      }
   }
}
