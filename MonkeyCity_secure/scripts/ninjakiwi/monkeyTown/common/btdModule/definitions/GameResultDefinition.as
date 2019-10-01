package ninjakiwi.monkeyTown.common.btdModule.definitions
{
   import ninjakiwi.data.NKDefinition;
   
   public class GameResultDefinition extends NKDefinition
   {
      
      protected static const _propertyNames:Array = ["success","cancelledGame","roundReached","roundsNeededToWin","startingLives","livesLost","didPlayerLoseALife","fractionOfTotalBloonsPopped","bloonsPopped","durationOfGame","trackPlayed","difficultyRankRelativeToMTL","bloonTypeList","tutorialSave","wasHardcore","wasContestedTerritory","roundsCompleted","numOfRetries","contestedTerritoryExpired","advancedTracking","canHaveMonkeyTeamReward","bossBattleResult","skippedTrivial"];
       
      
      public var success:Boolean = false;
      
      public var cancelledGame:Boolean = false;
      
      public var roundReached:int;
      
      public var roundsNeededToWin:int;
      
      public var startingLives:int;
      
      public var livesLost:int;
      
      public var didPlayerLoseALife:Boolean = false;
      
      public var fractionOfTotalBloonsPopped:Number = 0;
      
      public var bloonsPopped:BloonsPoppedReport = null;
      
      public var durationOfGame:Number = 0;
      
      public var trackPlayed:String = "no_track_played";
      
      public var difficultyRankRelativeToMTL:int = 0;
      
      public var bloonTypeList:Array;
      
      public var tutorialSave:Object;
      
      public var wasHardcore:Boolean = false;
      
      public var wasContestedTerritory:Boolean = false;
      
      public var roundsCompleted:int = 0;
      
      public var numOfRetries:int = 0;
      
      public var contestedTerritoryExpired:Boolean = false;
      
      public var advancedTracking:Object;
      
      public var canHaveMonkeyTeamReward:Boolean = false;
      
      public var bossBattleResult:BossBattleResultDefinition;
      
      public var skippedTrivial:Boolean = false;
      
      public function GameResultDefinition()
      {
         this.tutorialSave = {};
         super();
      }
      
      public function Success(param1:Boolean) : GameResultDefinition
      {
         this.success = param1;
         return this;
      }
      
      public function CancelledGame(param1:Boolean) : GameResultDefinition
      {
         this.cancelledGame = param1;
         return this;
      }
      
      public function RoundReached(param1:int) : GameResultDefinition
      {
         this.roundReached = param1;
         return this;
      }
      
      public function RoundsNeededToWin(param1:int) : GameResultDefinition
      {
         this.roundsNeededToWin = param1;
         return this;
      }
      
      public function StartingLives(param1:int) : GameResultDefinition
      {
         this.startingLives = param1;
         return this;
      }
      
      public function LivesLost(param1:int) : GameResultDefinition
      {
         this.livesLost = param1;
         return this;
      }
      
      public function DidPlayerLoseALife(param1:Boolean) : GameResultDefinition
      {
         this.didPlayerLoseALife = param1;
         return this;
      }
      
      public function FractionOfTotalBloonsPopped(param1:Number) : GameResultDefinition
      {
         this.fractionOfTotalBloonsPopped = param1;
         return this;
      }
      
      public function BloonsPopped(param1:BloonsPoppedReport) : GameResultDefinition
      {
         this.bloonsPopped = param1;
         return this;
      }
      
      public function DurationOfGame(param1:Number) : GameResultDefinition
      {
         this.durationOfGame = param1;
         return this;
      }
      
      public function TrackPlayed(param1:String) : GameResultDefinition
      {
         this.trackPlayed = param1;
         return this;
      }
      
      public function DifficultyRankRelativeToMTL(param1:int) : GameResultDefinition
      {
         this.difficultyRankRelativeToMTL = param1;
         return this;
      }
      
      public function BloonTypeList(param1:Array) : GameResultDefinition
      {
         this.bloonTypeList = param1;
         return this;
      }
      
      public function TutorialSave(param1:Object) : GameResultDefinition
      {
         this.tutorialSave = param1;
         return this;
      }
      
      public function WasHardcore(param1:Boolean) : GameResultDefinition
      {
         this.wasHardcore = param1;
         return this;
      }
      
      public function WasContestedTerritory(param1:Boolean) : GameResultDefinition
      {
         this.wasContestedTerritory = param1;
         return this;
      }
      
      public function RoundsCompleted(param1:int) : GameResultDefinition
      {
         this.roundsCompleted = param1;
         return this;
      }
      
      public function NumOfRetries(param1:int) : GameResultDefinition
      {
         this.numOfRetries = param1;
         return this;
      }
      
      public function ContestedTerritoryExpired(param1:Boolean) : GameResultDefinition
      {
         this.contestedTerritoryExpired = param1;
         return this;
      }
      
      public function AdvancedTracking(param1:Object) : GameResultDefinition
      {
         this.advancedTracking = param1;
         return this;
      }
      
      public function CanHaveMonkeyTeamReward(param1:Boolean) : GameResultDefinition
      {
         this.canHaveMonkeyTeamReward = param1;
         return this;
      }
      
      public function BossBattleResult(param1:BossBattleResultDefinition) : GameResultDefinition
      {
         this.bossBattleResult = param1;
         return this;
      }
      
      public function SkippedTrivial(param1:Boolean) : GameResultDefinition
      {
         this.skippedTrivial = param1;
         return this;
      }
   }
}
