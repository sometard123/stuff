package ninjakiwi.monkeyTown.pvp
{
   import ninjakiwi.data.NKDefinition;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.TowerPlace;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradeDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradePathDef;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BossBattleAttackDefinition;
   
   public class PvPAttackDefinition extends NKDefinition
   {
      
      protected static const _propertyNames:Array = ["difficulty","moreRegens","moreLeads","moreCamos","moreMoabs","strongestBloonType","attackerID","attackerCityIndex","defenderID","defenderUserName","defenderUserClan","defenderCityIndex","defenderCityLevel","investedBloontonium","maximumCashPillage","isRevenge","messageToOpponent","quickMatchID"];
       
      
      public var difficulty:int = 1;
      
      public var moreRegens:int;
      
      public var moreLeads:int;
      
      public var moreCamos:int;
      
      public var moreMoabs:int;
      
      public var strongestBloonType:String = "";
      
      public var attackerID:String = "";
      
      public var attackerCityIndex:int = 0;
      
      public var defenderID:String = "";
      
      public var defenderUserName:String = "";
      
      public var defenderUserClan:String = "";
      
      public var defenderCityIndex:int = 0;
      
      public var defenderCityLevel:int = 1;
      
      public var investedBloontonium:int = 0;
      
      public var maximumCashPillage:int = 0;
      
      public var isRevenge:Boolean = false;
      
      public var messageToOpponent:String = "";
      
      public var quickMatchID:String = "";
      
      public function PvPAttackDefinition()
      {
         this.moreRegens = Constants.NORMAL;
         this.moreLeads = Constants.NORMAL;
         this.moreCamos = Constants.NORMAL;
         this.moreMoabs = Constants.NORMAL;
         super();
      }
      
      public function Difficulty(param1:int) : PvPAttackDefinition
      {
         this.difficulty = param1;
         return this;
      }
      
      public function MoreRegens(param1:int) : PvPAttackDefinition
      {
         this.moreRegens = param1;
         return this;
      }
      
      public function MoreLeads(param1:int) : PvPAttackDefinition
      {
         this.moreLeads = param1;
         return this;
      }
      
      public function MoreCamos(param1:int) : PvPAttackDefinition
      {
         this.moreCamos = param1;
         return this;
      }
      
      public function MoreMoabs(param1:int) : PvPAttackDefinition
      {
         this.moreMoabs = param1;
         return this;
      }
      
      public function StrongestBloonType(param1:String) : PvPAttackDefinition
      {
         this.strongestBloonType = param1;
         return this;
      }
      
      public function AttackerID(param1:String) : PvPAttackDefinition
      {
         this.attackerID = param1;
         return this;
      }
      
      public function AttackerCityIndex(param1:int) : PvPAttackDefinition
      {
         this.attackerCityIndex = param1;
         return this;
      }
      
      public function DefenderID(param1:String) : PvPAttackDefinition
      {
         this.defenderID = param1;
         return this;
      }
      
      public function DefenderUserName(param1:String) : PvPAttackDefinition
      {
         this.defenderUserName = param1;
         return this;
      }
      
      public function DefenderUserClan(param1:String) : PvPAttackDefinition
      {
         this.defenderUserClan = param1;
         return this;
      }
      
      public function DefenderCityIndex(param1:int) : PvPAttackDefinition
      {
         this.defenderCityIndex = param1;
         return this;
      }
      
      public function DefenderCityLevel(param1:int) : PvPAttackDefinition
      {
         this.defenderCityLevel = param1;
         return this;
      }
      
      public function InvestedBloontonium(param1:int) : PvPAttackDefinition
      {
         this.investedBloontonium = param1;
         return this;
      }
      
      public function MaximumCashPillage(param1:int) : PvPAttackDefinition
      {
         this.maximumCashPillage = param1;
         return this;
      }
      
      public function IsRevenge(param1:Boolean) : PvPAttackDefinition
      {
         this.isRevenge = param1;
         return this;
      }
      
      public function MessageToOpponent(param1:String) : PvPAttackDefinition
      {
         this.messageToOpponent = param1;
         return this;
      }
      
      public function QuickMatchID(param1:String) : PvPAttackDefinition
      {
         this.quickMatchID = param1;
         return this;
      }
   }
}
