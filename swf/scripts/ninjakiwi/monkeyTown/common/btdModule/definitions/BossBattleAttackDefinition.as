package ninjakiwi.monkeyTown.common.btdModule.definitions
{
   import ninjakiwi.data.NKDefinition;
   
   public class BossBattleAttackDefinition extends NKDefinition
   {
      
      protected static const _propertyNames:Array = ["bossID","shortName","longName","bossType","timeLastAttacked","bossLevel","bossHitPoints","bossMaxHitPoints","specialTrackID","extraBossChills","extraBossBanes","extraBossBlasts","extraBossWeakens"];
       
      
      public var bossID:String = null;
      
      public var shortName:String = null;
      
      public var longName:String = null;
      
      public var bossType:int = 15;
      
      public var timeLastAttacked:Number = 1;
      
      public var bossLevel:int = 1;
      
      public var bossHitPoints:int = -1;
      
      public var bossMaxHitPoints:int = -1;
      
      public var specialTrackID:String = null;
      
      public var extraBossChills:int = 0;
      
      public var extraBossBanes:int = 0;
      
      public var extraBossBlasts:int = 0;
      
      public var extraBossWeakens:int = 0;
      
      public function BossBattleAttackDefinition()
      {
         super();
      }
      
      public function BossID(param1:String) : BossBattleAttackDefinition
      {
         this.bossID = param1;
         return this;
      }
      
      public function ShortName(param1:String) : BossBattleAttackDefinition
      {
         this.shortName = param1;
         return this;
      }
      
      public function LongName(param1:String) : BossBattleAttackDefinition
      {
         this.longName = param1;
         return this;
      }
      
      public function BossType(param1:int) : BossBattleAttackDefinition
      {
         this.bossType = param1;
         return this;
      }
      
      public function TimeLastAttacked(param1:Number) : BossBattleAttackDefinition
      {
         this.timeLastAttacked = param1;
         return this;
      }
      
      public function BossLevel(param1:int) : BossBattleAttackDefinition
      {
         this.bossLevel = param1;
         return this;
      }
      
      public function BossHitPoints(param1:int) : BossBattleAttackDefinition
      {
         this.bossHitPoints = param1;
         return this;
      }
      
      public function BossMaxHitPoints(param1:int) : BossBattleAttackDefinition
      {
         this.bossMaxHitPoints = param1;
         return this;
      }
      
      public function SpecialTrackID(param1:String) : BossBattleAttackDefinition
      {
         this.specialTrackID = param1;
         return this;
      }
      
      public function ExtraBossChills(param1:int) : BossBattleAttackDefinition
      {
         this.extraBossChills = param1;
         return this;
      }
      
      public function ExtraBossBanes(param1:int) : BossBattleAttackDefinition
      {
         this.extraBossBanes = param1;
         return this;
      }
      
      public function ExtraBossBlasts(param1:int) : BossBattleAttackDefinition
      {
         this.extraBossBlasts = param1;
         return this;
      }
      
      public function ExtraBossWeakens(param1:int) : BossBattleAttackDefinition
      {
         this.extraBossWeakens = param1;
         return this;
      }
   }
}
