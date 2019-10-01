package ninjakiwi.monkeyTown.btd.definitions
{
   import ninjakiwi.data.NKDefinition;
   import ninjakiwi.monkeyTown.utils.IntPoint2D;
   
   public class TileAttackDefinition extends NKDefinition
   {
      
      protected static const _propertyNames:Array = ["terrainType","monkeyTownLevel","difficultyLevel","difficultyRankRelativeToMTL","attackAtLocation","difficultyDescription","costToAttack","bonusStartingCash","isBonusCashMode","message","isHardcore","crates","isBloonBeacon"];
       
      
      public var terrainType:String;
      
      public var monkeyTownLevel:int;
      
      public var difficultyLevel:int;
      
      public var difficultyRankRelativeToMTL:int;
      
      public var attackAtLocation:IntPoint2D;
      
      public var difficultyDescription:String;
      
      public var costToAttack:int;
      
      public var bonusStartingCash:int = 0;
      
      public var isBonusCashMode:Boolean = false;
      
      public var message:String;
      
      public var isHardcore:Boolean = false;
      
      public var crates:Array;
      
      public var isBloonBeacon:Boolean = false;
      
      public function TileAttackDefinition()
      {
         this.attackAtLocation = new IntPoint2D();
         this.crates = [];
         super();
      }
      
      public function TerrainType(param1:String) : TileAttackDefinition
      {
         this.terrainType = param1;
         return this;
      }
      
      public function MonkeyTownLevel(param1:int) : TileAttackDefinition
      {
         this.monkeyTownLevel = param1;
         return this;
      }
      
      public function DifficultyLevel(param1:int) : TileAttackDefinition
      {
         this.difficultyLevel = param1;
         return this;
      }
      
      public function DifficultyRankRelativeToMTL(param1:int) : TileAttackDefinition
      {
         this.difficultyRankRelativeToMTL = param1;
         return this;
      }
      
      public function AttackAtLocation(param1:IntPoint2D) : TileAttackDefinition
      {
         this.attackAtLocation = param1;
         return this;
      }
      
      public function DifficultyDescription(param1:String) : TileAttackDefinition
      {
         this.difficultyDescription = param1;
         return this;
      }
      
      public function CostToAttack(param1:int) : TileAttackDefinition
      {
         this.costToAttack = param1;
         return this;
      }
      
      public function BonusStartingCash(param1:int) : TileAttackDefinition
      {
         this.bonusStartingCash = param1;
         return this;
      }
      
      public function IsBonusCashMode(param1:Boolean) : TileAttackDefinition
      {
         this.isBonusCashMode = param1;
         return this;
      }
      
      public function Message(param1:String) : TileAttackDefinition
      {
         this.message = param1;
         return this;
      }
      
      public function IsHardcore(param1:Boolean) : TileAttackDefinition
      {
         this.isHardcore = param1;
         return this;
      }
      
      public function Crates(param1:Array) : TileAttackDefinition
      {
         this.crates = param1;
         return this;
      }
      
      public function IsBloonBeacon(param1:Boolean) : TileAttackDefinition
      {
         this.isBloonBeacon = param1;
         return this;
      }
   }
}
