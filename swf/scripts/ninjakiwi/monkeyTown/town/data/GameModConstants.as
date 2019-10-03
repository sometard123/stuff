package ninjakiwi.monkeyTown.town.data
{
   import org.osflash.signals.Signal;
   
   public class GameModConstants
   {
      
      public static const CASH_EARNED_MOD:String = "cashEarnMod";
      
      public static const BLOONSTONES_EARN_MOD:String = "bloonstonesEarnMod";
      
      public static const XP_EARN_MOD:String = "xpEarnMod";
      
      public static const BLOONTONIUM_EARN_MOD:String = "bloontoniumEarnMod";
      
      public static const BLOONTONIUM_GENERATOR_SPEED_MOD:String = "bloontoniumGeneratorSpeedMod";
      
      public static const FARM_SPEED_MOD:String = "farmSpeedMod";
      
      public static const BUILD_SPEED_MOD:String = "buildSpeedMod";
      
      public static const UPGRADE_SPEED_MOD:String = "upgradeSpeedMod";
      
      public static const requestHasModifierSignal:Signal = new Signal(String,Function);
      
      public static const dataIsReadySignal:Signal = new Signal();
       
      
      public function GameModConstants()
      {
         super();
      }
   }
}
