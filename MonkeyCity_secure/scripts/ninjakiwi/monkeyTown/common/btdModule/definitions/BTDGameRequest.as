package ninjakiwi.monkeyTown.common.btdModule.definitions
{
   import ninjakiwi.data.NKDefinition;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.pvp.PvPAttackDefinition;
   
   public class BTDGameRequest extends NKDefinition
   {
      
      protected static const _propertyNames:Array = ["difficulty","trackSelectionBias","cityLevel","cityIndex","availableTowers","availableUpgrades","availableAgents","startingMoney","startingLives","terrainType","bloonWeights","tileUniqueData","isTutorial","pvpAttackDefinition","specialAbilities","specialMissionID","isCamoTile","isRegenTile","camoChanceModifier","regenChanceModifier","moreCamo","moreRegen","moreLead","moreMoabs","difficultyRankRelativeToMTL","difficultyDescription","timeLimit","isReplayMode","terrainName","seed","tutorialSave","isBonusCashMode","bonusCashAmount","isHardcore","crates","isContestedTerritory","contestedTerritoryRoundToBeat","contestedTerritoryForCapture","extensionRounds","timeLeftInWeek","allowRetry","extraRedHotSpikes","extraMonkeyBoosts","timeLaunched","ctEventsData","monkeyKnowledgeData","monkeyTeamTowers","isBloonBeacon","bossAttack"];
       
      
      public var difficulty:int = 1;
      
      public var trackSelectionBias:Number = 0.5;
      
      public var cityLevel:int = 1;
      
      public var cityIndex:int = 0;
      
      public var availableTowers:Object;
      
      public var availableUpgrades:Object;
      
      public var availableAgents:Object;
      
      public var startingMoney:int;
      
      public var startingLives:int;
      
      public var terrainType:String = "GrassTerrain";
      
      public var bloonWeights:BloonWeightsDefinition;
      
      public var tileUniqueData:TileUniqueDataDefinition;
      
      public var isTutorial:Boolean = false;
      
      public var pvpAttackDefinition:PvPAttackDefinition = null;
      
      public var specialAbilities:Object;
      
      public var specialMissionID:String = null;
      
      public var isCamoTile:Boolean = false;
      
      public var isRegenTile:Boolean = false;
      
      public var camoChanceModifier:Number = 1;
      
      public var regenChanceModifier:Number = 1;
      
      public var moreCamo:int;
      
      public var moreRegen:int;
      
      public var moreLead:int;
      
      public var moreMoabs:int;
      
      public var difficultyRankRelativeToMTL:int = 0;
      
      public var difficultyDescription:String = "";
      
      public var timeLimit:int = -1;
      
      public var isReplayMode:Boolean = false;
      
      public var terrainName:String = "";
      
      public var seed:int = -1;
      
      public var tutorialSave:Object = null;
      
      public var isBonusCashMode:Boolean = false;
      
      public var bonusCashAmount:Number = 0;
      
      public var isHardcore:Boolean = false;
      
      public var crates:Array;
      
      public var isContestedTerritory:Boolean = false;
      
      public var contestedTerritoryRoundToBeat:int = -1;
      
      public var contestedTerritoryForCapture:Boolean = false;
      
      public var extensionRounds:int = -1;
      
      public var timeLeftInWeek:Number = 0;
      
      public var allowRetry:Boolean = true;
      
      public var extraRedHotSpikes:int = 0;
      
      public var extraMonkeyBoosts:int = 0;
      
      public var timeLaunched:Number = 0;
      
      public var ctEventsData:Object = null;
      
      public var monkeyKnowledgeData:Object = null;
      
      public var monkeyTeamTowers:Array = null;
      
      public var isBloonBeacon:Boolean = false;
      
      public var bossAttack:BossBattleAttackDefinition = null;
      
      public function BTDGameRequest()
      {
         this.specialAbilities = {};
         this.moreCamo = Constants.NORMAL;
         this.moreRegen = Constants.NORMAL;
         this.moreLead = Constants.NORMAL;
         this.moreMoabs = Constants.NORMAL;
         this.crates = [false,false,false];
         super();
      }
      
      public function Difficulty(param1:int) : BTDGameRequest
      {
         this.difficulty = param1;
         return this;
      }
      
      public function TrackSelectionBias(param1:Number) : BTDGameRequest
      {
         this.trackSelectionBias = param1;
         return this;
      }
      
      public function CityLevel(param1:int) : BTDGameRequest
      {
         this.cityLevel = param1;
         return this;
      }
      
      public function CityIndex(param1:int) : BTDGameRequest
      {
         this.cityIndex = param1;
         return this;
      }
      
      public function AvailableTowers(param1:Object) : BTDGameRequest
      {
         this.availableTowers = param1;
         return this;
      }
      
      public function AvailableUpgrades(param1:Object) : BTDGameRequest
      {
         this.availableUpgrades = param1;
         return this;
      }
      
      public function AvailableAgents(param1:Object) : BTDGameRequest
      {
         this.availableAgents = param1;
         return this;
      }
      
      public function StartingMoney(param1:int) : BTDGameRequest
      {
         this.startingMoney = param1;
         return this;
      }
      
      public function StartingLives(param1:int) : BTDGameRequest
      {
         this.startingLives = param1;
         return this;
      }
      
      public function TerrainType(param1:String) : BTDGameRequest
      {
         this.terrainType = param1;
         return this;
      }
      
      public function BloonWeights(param1:BloonWeightsDefinition) : BTDGameRequest
      {
         this.bloonWeights = param1;
         return this;
      }
      
      public function TileUniqueData(param1:TileUniqueDataDefinition) : BTDGameRequest
      {
         this.tileUniqueData = param1;
         return this;
      }
      
      public function IsTutorial(param1:Boolean) : BTDGameRequest
      {
         this.isTutorial = param1;
         return this;
      }
      
      public function PvpAttackDefinition(param1:PvPAttackDefinition) : BTDGameRequest
      {
         this.pvpAttackDefinition = param1;
         return this;
      }
      
      public function SpecialAbilities(param1:Object) : BTDGameRequest
      {
         this.specialAbilities = param1;
         return this;
      }
      
      public function SpecialMissionID(param1:String) : BTDGameRequest
      {
         this.specialMissionID = param1;
         return this;
      }
      
      public function IsCamoTile(param1:Boolean) : BTDGameRequest
      {
         this.isCamoTile = param1;
         return this;
      }
      
      public function IsRegenTile(param1:Boolean) : BTDGameRequest
      {
         this.isRegenTile = param1;
         return this;
      }
      
      public function CamoChanceModifier(param1:Number) : BTDGameRequest
      {
         this.camoChanceModifier = param1;
         return this;
      }
      
      public function RegenChanceModifier(param1:Number) : BTDGameRequest
      {
         this.regenChanceModifier = param1;
         return this;
      }
      
      public function MoreCamo(param1:int) : BTDGameRequest
      {
         this.moreCamo = param1;
         return this;
      }
      
      public function MoreRegen(param1:int) : BTDGameRequest
      {
         this.moreRegen = param1;
         return this;
      }
      
      public function MoreLead(param1:int) : BTDGameRequest
      {
         this.moreLead = param1;
         return this;
      }
      
      public function MoreMoabs(param1:int) : BTDGameRequest
      {
         this.moreMoabs = param1;
         return this;
      }
      
      public function DifficultyRankRelativeToMTL(param1:int) : BTDGameRequest
      {
         this.difficultyRankRelativeToMTL = param1;
         return this;
      }
      
      public function DifficultyDescription(param1:String) : BTDGameRequest
      {
         this.difficultyDescription = param1;
         return this;
      }
      
      public function TimeLimit(param1:int) : BTDGameRequest
      {
         this.timeLimit = param1;
         return this;
      }
      
      public function IsReplayMode(param1:Boolean) : BTDGameRequest
      {
         this.isReplayMode = param1;
         return this;
      }
      
      public function TerrainName(param1:String) : BTDGameRequest
      {
         this.terrainName = param1;
         return this;
      }
      
      public function Seed(param1:int) : BTDGameRequest
      {
         this.seed = param1;
         return this;
      }
      
      public function TutorialSave(param1:Object) : BTDGameRequest
      {
         this.tutorialSave = param1;
         return this;
      }
      
      public function IsBonusCashMode(param1:Boolean) : BTDGameRequest
      {
         this.isBonusCashMode = param1;
         return this;
      }
      
      public function BonusCashAmount(param1:Number) : BTDGameRequest
      {
         this.bonusCashAmount = param1;
         return this;
      }
      
      public function IsHardcore(param1:Boolean) : BTDGameRequest
      {
         this.isHardcore = param1;
         return this;
      }
      
      public function Crates(param1:Array) : BTDGameRequest
      {
         this.crates = param1;
         return this;
      }
      
      public function IsContestedTerritory(param1:Boolean) : BTDGameRequest
      {
         this.isContestedTerritory = param1;
         return this;
      }
      
      public function ContestedTerritoryRoundToBeat(param1:int) : BTDGameRequest
      {
         this.contestedTerritoryRoundToBeat = param1;
         return this;
      }
      
      public function ContestedTerritoryForCapture(param1:Boolean) : BTDGameRequest
      {
         this.contestedTerritoryForCapture = param1;
         return this;
      }
      
      public function ExtensionRounds(param1:int) : BTDGameRequest
      {
         this.extensionRounds = param1;
         return this;
      }
      
      public function TimeLeftInWeek(param1:Number) : BTDGameRequest
      {
         this.timeLeftInWeek = param1;
         return this;
      }
      
      public function AllowRetry(param1:Boolean) : BTDGameRequest
      {
         this.allowRetry = param1;
         return this;
      }
      
      public function ExtraRedHotSpikes(param1:int) : BTDGameRequest
      {
         this.extraRedHotSpikes = param1;
         return this;
      }
      
      public function ExtraMonkeyBoosts(param1:int) : BTDGameRequest
      {
         this.extraMonkeyBoosts = param1;
         return this;
      }
      
      public function TimeLaunched(param1:Number) : BTDGameRequest
      {
         this.timeLaunched = param1;
         return this;
      }
      
      public function CtEventsData(param1:Object) : BTDGameRequest
      {
         this.ctEventsData = param1;
         return this;
      }
      
      public function MonkeyKnowledgeData(param1:Object) : BTDGameRequest
      {
         this.monkeyKnowledgeData = param1;
         return this;
      }
      
      public function MonkeyTeamTowers(param1:Array) : BTDGameRequest
      {
         this.monkeyTeamTowers = param1;
         return this;
      }
      
      public function IsBloonBeacon(param1:Boolean) : BTDGameRequest
      {
         this.isBloonBeacon = param1;
         return this;
      }
      
      public function BossAttack(param1:BossBattleAttackDefinition) : BTDGameRequest
      {
         this.bossAttack = param1;
         return this;
      }
   }
}
