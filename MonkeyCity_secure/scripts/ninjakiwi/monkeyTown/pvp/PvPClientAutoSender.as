package ninjakiwi.monkeyTown.pvp
{
   public class PvPClientAutoSender
   {
       
      
      public function PvPClientAutoSender()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         PvPSignals.sendPVPAttack.add(this.pvpSendAttack);
      }
      
      private function pvpSendAttack(param1:PvPAttackDefinition, param2:Function) : void
      {
         PvPClient.sendAttack(param1,param1.defenderID,param1.defenderUserName,param1.defenderUserClan,param1.defenderCityIndex,param1.defenderCityLevel,param1.isRevenge,param2);
      }
   }
}
