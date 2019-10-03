package ninjakiwi.monkeyTown.pvp
{
   import ninjakiwi.monkeyTown.common.btdModule.definitions.GameResultDefinition;
   import org.osflash.signals.PrioritySignal;
   import org.osflash.signals.Signal;
   
   public class PvPSignals
   {
      
      public static const sendPVPAttack:PrioritySignal = new PrioritySignal(PvPAttackDefinition,Function);
      
      public static const defendAttackComplete:PrioritySignal = new PrioritySignal(GameResultDefinition,IncomingRaid);
      
      public static const defendAttack:Signal = new Signal(IncomingRaid,Number,Boolean,Array);
      
      public static const defendAttackExpired:Signal = new Signal(int);
      
      public static const sendMVMAttackSucceeded:Signal = new Signal(PvPAttackDefinition);
      
      public static const attackExpired:PrioritySignal = new PrioritySignal(Object);
      
      public static const pvpExpiredByAttacker:PrioritySignal = new PrioritySignal(Object);
      
      public static const defendTileSignal:Signal = new Signal(IncomingRaid);
      
      public static const requestRefeshPvPData:Signal = new Signal();
      
      public static const pvpDataUpdatedSignal:PrioritySignal = new PrioritySignal(Object);
      
      public static const revengeAttackLaunched:PrioritySignal = new PrioritySignal();
      
      public static const revengeOpportunityNotTaken:Signal = new Signal();
      
      public static const selectBloontoniumScreenShown:Signal = new Signal();
      
      public static const damageCity:Signal = new Signal(int);
      
      public static const defendTileRevealed:Signal = new Signal();
      
      public static const updatePacifistModeUI:Signal = new Signal(Boolean);
      
      public static const setRevengeAttack:Signal = new Signal();
      
      public static const attackRemoved:Signal = new Signal(int);
      
      public static const rewardsEarned:Signal = new Signal(Object);
      
      public static const defenseRewards:Signal = new Signal(Object);
      
      public static const attackRewards:PrioritySignal = new PrioritySignal(Object);
      
      public static const attackWon:PrioritySignal = new PrioritySignal();
      
      public static const attackLost:PrioritySignal = new PrioritySignal();
      
      public static const attackResult:PrioritySignal = new PrioritySignal(Boolean,Object);
      
      public static const recievedNewPvPAttack:Signal = new Signal(Object);
      
      public static const requestRevengeAttack:Signal = new Signal(Friend,int);
      
      public static const requestReportMultipleNewPvPAttackVictories:Signal = new Signal();
      
      public static const requestReportNewPvPAttackVictory:Signal = new Signal(Object);
      
      public static const requestReportNewPvPAttackExpired:Signal = new Signal(Object);
       
      
      public function PvPSignals()
      {
         super();
      }
   }
}
