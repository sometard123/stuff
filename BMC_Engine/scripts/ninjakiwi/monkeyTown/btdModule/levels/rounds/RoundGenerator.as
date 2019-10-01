package ninjakiwi.monkeyTown.btdModule.levels.rounds
{
   import com.lgrey.utils.LGMathUtil;
   import ninjakiwi.dancingShadows.DancingShadows;
   import ninjakiwi.dancingShadows.INumber;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.levels.Level;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.monkeyTown.debugView.DebugView;
   import ninjakiwi.monkeyTown.graphing.Graphing;
   import ninjakiwi.monkeyTown.utils.Random;
   import ninjakiwi.monkeyTown.utils.WeightingManager;
   import org.osflash.signals.Signal;
   
   public class RoundGenerator
   {
      
      public static const camoModifierSet:Signal = new Signal(Function);
      
      private static const RND:Random = new Random();
      
      public static const roundStartSignal:Signal = new Signal(int);
      
      public static var rbeModifier:Number = 1;
       
      
      protected var _level:Level;
      
      protected var _rounds:Vector.<Round>;
      
      protected var _currentRoundIndex:INumber;
      
      public const signals:RoundGeneratorSignals = new RoundGeneratorSignals();
      
      protected var _totalRounds:INumber;
      
      protected var _spacingWeightManager:WeightingManager;
      
      protected const LGMath:LGMathUtil = LGMathUtil.getInstance();
      
      protected var _debugView:DebugView;
      
      protected var _debugGraph:Graphing;
      
      public var totalRBE:int = 0;
      
      public var totalBloons:int = 0;
      
      public var extraRounds:int = -1;
      
      protected const SHOW_ROUND_RBE_DATA_GRAPH:Boolean = false;
      
      protected const SHOW_GROUPS_DATA_GRAPH:Boolean = false;
      
      protected const MOAB_RBE:int = RoundGeneratorData.rbeByTypeMoabClass[0];
      
      protected const BFB_RBE:int = RoundGeneratorData.rbeByTypeMoabClass[1];
      
      protected const ZOMG_RBE:int = RoundGeneratorData.rbeByTypeMoabClass[2];
      
      protected const MOAB_RBE_ACTUAL_USE:int = RoundGeneratorData.rbeByTypeMoabActualUse[0];
      
      protected const BFB_RBE_ACTUAL_USE:int = RoundGeneratorData.rbeByTypeMoabActualUse[1];
      
      protected const ZOMG_RBE_ACTUAL_USE:int = RoundGeneratorData.rbeByTypeMoabActualUse[2];
      
      protected const DDT_RBE_ACTUAL_USE:int = RoundGeneratorData.rbeByTypeMoabActualUse[2];
      
      protected const MOAB_RBE_THRESHOLD:int = this.MOAB_RBE * 3;
      
      protected const BFB_RBE_THRESHOLD:int = this.BFB_RBE_ACTUAL_USE * 2;
      
      protected const ZOMG_RBE_THRESHOLD:int = this.ZOMG_RBE_ACTUAL_USE;
      
      protected const DDT_RBE_THRESHOLD:int = this.DDT_RBE_ACTUAL_USE;
      
      protected const MOAB_THRESHOLD_LIST:Array = [this.MOAB_RBE_THRESHOLD,this.BFB_RBE_THRESHOLD,this.ZOMG_RBE_THRESHOLD];
      
      private const CHANCE_OF_ZOMG_ALTERNATE:Number = 0.5;
      
      public function RoundGenerator(param1:Level)
      {
         this._rounds = new Vector.<Round>();
         this._currentRoundIndex = DancingShadows.getOne();
         this._totalRounds = DancingShadows.getOne();
         this._spacingWeightManager = new WeightingManager();
         this._debugView = DebugView.instance;
         this._debugGraph = DebugView.instance.graph;
         super();
         this._level = param1;
         this.init();
      }
      
      public function clear() : void
      {
      }
      
      protected function init() : void
      {
         this._spacingWeightManager.addWeightedItem(RoundGeneratorData.SPACING_CLOSE,RoundGeneratorData.SPACING_CLOSE_PROBABILITY);
         this._spacingWeightManager.addWeightedItem(RoundGeneratorData.SPACING_NORMAL,RoundGeneratorData.SPACING_NORMAL_PROBABILITY);
         this._spacingWeightManager.addWeightedItem(RoundGeneratorData.SPACING_SUPER_CLOSE,RoundGeneratorData.SPACING_SUPER_CLOSE_PROBABILITY);
         this._spacingWeightManager.addWeightedItem(RoundGeneratorData.SPACING_ULTRA_CLOSE,RoundGeneratorData.SPACING_ULTRA_CLOSE_PROBABILITY);
         this._spacingWeightManager.addWeightedItem(RoundGeneratorData.SPACING_LOOSE,RoundGeneratorData.SPACING_LOOSE_PROBABILITY);
      }
      
      public function generateTotalRoundsTestGraph() : void
      {
         var _loc1_:Array = [];
         var _loc2_:int = 0;
         while(_loc2_ < 100)
         {
            _loc1_.push(this.getTotalRounds(_loc2_));
            _loc2_++;
         }
         this._debugView.reveal();
         this._debugGraph.rangeX = 100;
         this._debugGraph.rangeY = 50;
         var _loc3_:uint = 11141290;
         this._debugGraph.drawData(_loc1_,_loc3_);
      }
      
      public function process(param1:Number) : void
      {
         this._rounds[this._currentRoundIndex.value].update(param1);
      }
      
      public function startRound(param1:int) : void
      {
         if(param1 < 0 || param1 >= this._rounds.length)
         {
            return;
         }
         this._currentRoundIndex.value = param1;
         var _loc2_:Round = this._rounds[this._currentRoundIndex.value];
         _loc2_.startRound();
         RoundGenerator.roundStartSignal.dispatch(this._currentRoundIndex.value);
      }
      
      public function get currentRound() : Round
      {
         if(this._currentRoundIndex.value >= 0 && this._currentRoundIndex.value < this._rounds.length)
         {
            return this._rounds[this._currentRoundIndex.value];
         }
         return null;
      }
      
      public function hasCuedBloons() : Boolean
      {
         return this._rounds[this._currentRoundIndex.value].hasCuedBloons();
      }
      
      public function hasBloonsToGo() : Boolean
      {
         return this._level.hasBloonsInPlay() || this.hasCuedBloons();
      }
      
      public function roundsAreComplete() : Boolean
      {
         return this._currentRoundIndex.value === this._rounds.length - 1 && !Round(this._rounds[this._currentRoundIndex.value]).hasCuedBloons();
      }
      
      private function getSeededRandomNumberGenerator() : Random
      {
         return new Random(RND.nextInteger());
      }
      
      public function generate(param1:BTDGameRequest) : void
      {
         var i:int = 0;
         var j:int = 0;
         var difficulty:int = 0;
         var groupRBE:int = 0;
         var info:Object = null;
         var currentRound:int = 0;
         var currentGroup:int = 0;
         var currentBloon:int = 0;
         var totalRounds:int = 0;
         var totalGroups:int = 0;
         var bloonsInGroup:int = 0;
         var maxRankOfBloonsInRound:int = 0;
         var currentGroupRank:int = 0;
         var bloonRank:int = 0;
         var round:Round = null;
         var rbePool:int = 0;
         var canAffordMoabs:Boolean = false;
         var canAffordBFB:Boolean = false;
         var canAffordZOMG:Boolean = false;
         var canAffordMOABCluster:Boolean = false;
         var canAffordBFBCluster:Boolean = false;
         var canAffordDDT:Boolean = false;
         var moabProbability:Number = NaN;
         var generateMOABs:Boolean = false;
         var strongestBloonGroupDefinitions:Array = null;
         var minDifficultyToForceStrongestBloon:int = 0;
         var groupRBEList:Array = null;
         var minGroupRBE:int = 0;
         var totalMods:Number = NaN;
         var groupDefinition:GroupDefinition = null;
         var k:int = 0;
         var finalRoundBloonType:int = 0;
         var mostDifficultRBEPool:int = 0;
         var miniumForcedStrongestBloons:int = 0;
         var rbePerStrongestBloon:int = 0;
         var howManyCanAfford:int = 0;
         var howManyGroups:int = 0;
         var finalSpawnType:BloonSpawnType = null;
         var finalGroupDef:GroupDefinition = null;
         var moabBudget:int = 0;
         var canMakeMoreMOABS:Boolean = false;
         var firstZOMGRound:int = 0;
         var howManyMoabsList:Array = null;
         var strongestMOABfound:int = 0;
         var moabGroupDefinition:GroupDefinition = null;
         var cost:Number = NaN;
         var type:int = 0;
         var spacing:Number = NaN;
         var useCamo:Boolean = false;
         var useRegen:Boolean = false;
         var howManyToSpawn:int = 0;
         var strongestMOABfoundTrueIndex:int = 0;
         var costAdjustmentRounds:Number = NaN;
         var multiplierMin:Number = NaN;
         var multiplierMax:Number = NaN;
         var normalisedMultipler:Number = NaN;
         var costMultipler:Number = NaN;
         var moabSpawnType:BloonSpawnType = null;
         var chanceOfMegaCollapse:Number = NaN;
         var spacingType:String = null;
         var spacingDistance:Number = NaN;
         var moreCamoModifier:Number = NaN;
         var roundRequiredBeforeCamo:int = 0;
         var difficultyRequiredBeforeCamo:int = 0;
         var moreRegenModifier:Number = NaN;
         var roundRequiredBeforeRegen:int = 0;
         var difficultyRequiredBeforeRegen:int = 0;
         var unclampedBloonsInGroup:int = 0;
         var groupDefinitionFound:GroupDefinition = null;
         var bloonTypePromotion:int = 0;
         var scaleDown:int = 0;
         var minBloonsInGroup:int = 0;
         var bloonTypeDemotion:int = 0;
         var l:int = 0;
         var bloonTypeID:int = 0;
         var gameRequest:BTDGameRequest = param1;
         this.extraRounds = gameRequest.extensionRounds;
         difficulty = gameRequest.difficulty;
         var strongestBloonAllowed:int = gameRequest.bloonWeights.strongestBloonID;
         var isCamoTile:Boolean = gameRequest.isCamoTile;
         var isRegenTile:Boolean = gameRequest.isRegenTile;
         var isHardcore:Boolean = gameRequest.isHardcore;
         if(gameRequest.cityIndex === 1)
         {
            difficulty = difficulty * Constants.SECOND_CITY_DIFFICULTY_SCALAR;
         }
         RoundGeneratorData.setIsHardcore(isHardcore);
         var seed:int = gameRequest.seed;
         if(seed < 0)
         {
            seed = Math.random() * int.MAX_VALUE;
         }
         RND.setSeed(seed);
         var finalRoundRND:Random = this.getSeededRandomNumberGenerator();
         var moabRND:Random = this.getSeededRandomNumberGenerator();
         var megaCollapseRND:Random = this.getSeededRandomNumberGenerator();
         var camoRND:Random = this.getSeededRandomNumberGenerator();
         var regenRND:Random = this.getSeededRandomNumberGenerator();
         var groupVarianceRND:Random = this.getSeededRandomNumberGenerator();
         var strongestBloonsRND:Random = this.getSeededRandomNumberGenerator();
         var moabSpliceRND:Random = this.getSeededRandomNumberGenerator();
         var didMegaCollapse:Boolean = false;
         var allowMegaCollapseFirstRound:Number = 25;
         var constantMegaCollapse:int = 45;
         var megaCollapseMaxChance:Number = 0.7;
         var chanceOfMegaCollapseMax:Number = 0;
         var roundRBEList:Array = [];
         var groupDefinitions:Array = [];
         var moabGroupDefinitions:Array = [];
         var maxBloonsInGroup:int = 10;
         var chanceOfBloonsInGroupVaried:Number = 0.3;
         var bloonsInGroupVariationMin:Number = 0.1;
         var bloonsInGroupVariationMax:Number = 2;
         var easyMoneyRBE:Array = [20,40,80,90,100,80,40,20];
         var maxDifficultyForEasyMoney:Number = RoundGeneratorData.MAX_DIFFICULTY_FOR_EASY_MONEY;
         var easyMoneyDropOffStart:int = RoundGeneratorData.EASY_MONEY_DROPOFF_START;
         var easyMoneyDropOffRange:int = maxDifficultyForEasyMoney - easyMoneyDropOffStart + 1;
         var easyMoneyModifier:Number = 1;
         var zomgAlternate:int = Bloon.BOSS;
         if(strongestBloonAllowed > Bloon.BOSS)
         {
            zomgAlternate = strongestBloonAllowed;
            strongestBloonAllowed = Bloon.BOSS;
         }
         if(difficulty > easyMoneyDropOffStart)
         {
            easyMoneyModifier = 1 - (difficulty - easyMoneyDropOffStart) / easyMoneyDropOffRange;
            if(easyMoneyModifier < 0)
            {
               easyMoneyModifier = 0;
            }
         }
         var n:int = 0;
         while(n < easyMoneyRBE.length)
         {
            easyMoneyRBE[n] = easyMoneyRBE[n] / 100;
            easyMoneyRBE[n] = easyMoneyRBE[n] * easyMoneyModifier;
            n++;
         }
         this._rounds.length = 0;
         this._totalRounds.value = this.getTotalRounds(difficulty);
         roundRBEList = this.generateRBEPerRound(this._totalRounds.value,difficulty);
         this.totalRBE = 0;
         var m:int = 0;
         while(m < roundRBEList.length)
         {
            this.totalRBE = this.totalRBE + roundRBEList[m];
            m++;
         }
         var isFinalRound:Boolean = false;
         var roundAtWhichMOABisFirstAllowed:int = RoundGeneratorData.ROUND_REQUIRED_BEFORE_MOAB;
         if(difficulty >= RoundGeneratorData.ROUND_REQUIRED_BEFORE_MOAB)
         {
            roundAtWhichMOABisFirstAllowed = RoundGeneratorData.ROUND_REQUIRED_BEFORE_MOAB - Math.ceil((difficulty - RoundGeneratorData.ROUND_REQUIRED_BEFORE_MOAB) / 3);
            if(roundAtWhichMOABisFirstAllowed < 0)
            {
               roundAtWhichMOABisFirstAllowed = 0;
            }
         }
         if(strongestBloonAllowed < 0)
         {
            strongestBloonAllowed = Bloon.BOSS;
         }
         currentRound = 0;
         while(currentRound < this._totalRounds.value)
         {
            round = new Round(this._level);
            if(currentRound === this._totalRounds.value - 1)
            {
               isFinalRound = true;
            }
            this._rounds.push(round);
            rbePool = roundRBEList[currentRound];
            canAffordMoabs = rbePool >= this.MOAB_RBE_THRESHOLD;
            canAffordBFB = rbePool >= this.BFB_RBE_THRESHOLD;
            canAffordZOMG = rbePool >= this.ZOMG_RBE_THRESHOLD;
            canAffordMOABCluster = rbePool >= this.DDT_RBE_THRESHOLD;
            canAffordBFBCluster = rbePool >= this.DDT_RBE_THRESHOLD;
            canAffordDDT = rbePool >= this.DDT_RBE_THRESHOLD;
            moabProbability = (currentRound + difficulty) * 0.01;
            RND.setSeed(moabRND.nextInteger());
            generateMOABs = RND.nextNumber() < moabProbability;
            if(currentRound < roundAtWhichMOABisFirstAllowed)
            {
               generateMOABs = false;
            }
            if(isFinalRound && strongestBloonAllowed >= Bloon.MOAB)
            {
               generateMOABs = true;
            }
            if(strongestBloonAllowed < Bloon.MOAB)
            {
               generateMOABs = false;
            }
            strongestBloonGroupDefinitions = [];
            minDifficultyToForceStrongestBloon = 10;
            RND.setSeed(finalRoundRND.nextInteger());
            if(isFinalRound && difficulty >= minDifficultyToForceStrongestBloon)
            {
               if(Bloon.isHugeClass(strongestBloonAllowed))
               {
                  finalRoundBloonType = strongestBloonAllowed === Bloon.BOSS?int(zomgAlternate):int(strongestBloonAllowed);
                  howManyGroups = 1;
                  j = 0;
                  while(j < howManyGroups)
                  {
                     info = this.addZomgAlternative(finalRoundBloonType,moabGroupDefinitions,currentRound);
                     j++;
                  }
               }
               else
               {
                  mostDifficultRBEPool = rbePool * 0.1;
                  miniumForcedStrongestBloons = 3;
                  rbePerStrongestBloon = Bloon.rbeByType[strongestBloonAllowed];
                  mostDifficultRBEPool = Math.max(mostDifficultRBEPool,rbePerStrongestBloon * miniumForcedStrongestBloons);
                  howManyCanAfford = int(mostDifficultRBEPool / rbePerStrongestBloon);
                  howManyGroups = Math.ceil(howManyCanAfford / maxBloonsInGroup);
                  j = 0;
                  while(j < howManyGroups)
                  {
                     finalSpawnType = new BloonSpawnType(strongestBloonAllowed);
                     finalGroupDef = new GroupDefinition(finalSpawnType,maxBloonsInGroup - 3 + RND.nextNumber() * 7,1);
                     strongestBloonGroupDefinitions.push(finalGroupDef);
                     j++;
                  }
               }
            }
            RND.setSeed(moabRND.nextInteger());
            if(generateMOABs)
            {
               moabBudget = rbePool / 2 + 5;
               rbePool = rbePool / 2;
               canMakeMoreMOABS = true;
               firstZOMGRound = -1;
               while(canMakeMoreMOABS)
               {
                  strongestMOABfound = -1;
                  howManyMoabsList = RoundGeneratorData.howManyMOABSCanIMake(moabBudget);
                  i = 0;
                  while(i < howManyMoabsList.length)
                  {
                     if(howManyMoabsList[i] > 0)
                     {
                        strongestMOABfound = i;
                     }
                     i++;
                  }
                  if(strongestMOABfound > -1)
                  {
                     spacing = Constants.SPACING_NORMAL;
                     useCamo = false;
                     useRegen = false;
                     howManyToSpawn = howManyMoabsList[strongestMOABfound];
                     strongestMOABfoundTrueIndex = strongestMOABfound + Bloon.MOAB;
                     if(strongestMOABfoundTrueIndex > strongestBloonAllowed)
                     {
                        strongestMOABfound = strongestBloonAllowed - Bloon.MOAB;
                     }
                     if(strongestMOABfound == 1)
                     {
                        if(!canAffordBFB)
                        {
                           strongestMOABfound = 0;
                        }
                     }
                     else if(strongestMOABfound == 2)
                     {
                        if(!canAffordZOMG)
                        {
                           strongestMOABfound = 0;
                        }
                     }
                     howManyToSpawn = 1;
                     switch(strongestMOABfound)
                     {
                        case 0:
                           type = Bloon.MOAB;
                           howManyToSpawn = 1;
                           costAdjustmentRounds = 5;
                           multiplierMin = 1;
                           multiplierMax = 2;
                           normalisedMultipler = 1 - Math.min(costAdjustmentRounds,difficulty - RoundGeneratorData.ROUND_REQUIRED_BEFORE_MOAB) / costAdjustmentRounds;
                           costMultipler = this.LGMath.remapValueToRange(normalisedMultipler,0,1,multiplierMin,multiplierMax);
                           cost = this.MOAB_RBE_ACTUAL_USE * costMultipler;
                           break;
                        case 1:
                           if(canAffordBFB)
                           {
                              type = Bloon.BFB;
                              cost = this.BFB_RBE_ACTUAL_USE;
                              howManyToSpawn = 1;
                           }
                           break;
                        case 2:
                           if(!canAffordZOMG)
                           {
                              break;
                           }
                           if(RND.nextNumber() < this.CHANCE_OF_ZOMG_ALTERNATE)
                           {
                              info = this.addZomgAlternative(zomgAlternate,moabGroupDefinitions,currentRound);
                              cost = info.cost;
                              type = -1;
                           }
                           else
                           {
                              type = Bloon.BOSS;
                              cost = this.ZOMG_RBE_ACTUAL_USE;
                              howManyToSpawn = 1;
                           }
                           break;
                     }
                     if(type !== -1)
                     {
                        moabSpawnType = new BloonSpawnType(type);
                        moabSpawnType.spacing = spacing;
                        moabSpawnType.camo = useCamo;
                        moabSpawnType.regen = useRegen;
                        moabGroupDefinition = new GroupDefinition(moabSpawnType,howManyToSpawn,1);
                        moabGroupDefinitions.push(moabGroupDefinition);
                     }
                     moabBudget = moabBudget - cost;
                  }
                  else
                  {
                     canMakeMoreMOABS = false;
                  }
               }
               rbePool = rbePool + moabBudget;
            }
            groupRBEList = [];
            minGroupRBE = 5 * (currentRound + 1);
            groupRBEList = this.generateRBEGroups(rbePool,minGroupRBE);
            if(difficulty > 2)
            {
               groupRBEList = this.collapseGroups(groupRBEList,difficulty);
            }
            RND.setSeed(megaCollapseRND.nextInteger());
            if(currentRound >= allowMegaCollapseFirstRound)
            {
               chanceOfMegaCollapse = this.LGMath.remapValueToRange(currentRound,allowMegaCollapseFirstRound,constantMegaCollapse,0.1,megaCollapseMaxChance);
               if(RND.nextNumber() < chanceOfMegaCollapse)
               {
                  groupRBEList = this.megaCollapseGroups(groupRBEList,difficulty);
                  didMegaCollapse = true;
               }
            }
            totalGroups = groupRBEList.length;
            totalMods = 0;
            currentGroup = 0;
            while(currentGroup < totalGroups)
            {
               totalMods = 0;
               groupRBE = groupRBEList[currentGroup];
               spacingType = this._spacingWeightManager.getRandomItem(RND.nextNumber());
               spacingDistance = Constants.SPACING_NORMAL;
               if(spacingType === RoundGeneratorData.SPACING_LOOSE && currentRound <= 6)
               {
                  spacingType = RoundGeneratorData.SPACING_NORMAL;
               }
               if(!isHardcore && spacingType === RoundGeneratorData.SPACING_ULTRA_CLOSE && currentRound <= 10)
               {
                  spacingType = RoundGeneratorData.SPACING_NORMAL;
               }
               if(currentRound > 1 && difficulty > 1)
               {
                  switch(spacingType)
                  {
                     case RoundGeneratorData.SPACING_LOOSE:
                        groupRBE = groupRBE / RoundGeneratorData.SPACING_LOOSE_MOD;
                        totalMods = totalMods + RoundGeneratorData.SPACING_LOOSE_MOD;
                        spacingDistance = Constants.SPACING_LOOSE;
                        break;
                     case RoundGeneratorData.SPACING_CLOSE:
                        groupRBE = groupRBE / RoundGeneratorData.SPACING_CLOSE_MOD;
                        totalMods = totalMods + RoundGeneratorData.SPACING_CLOSE_MOD;
                        spacingDistance = Constants.SPACING_CLOSE;
                        break;
                     case RoundGeneratorData.SPACING_SUPER_CLOSE:
                        groupRBE = groupRBE / RoundGeneratorData.SPACING_SUPER_CLOSE_MOD;
                        totalMods = totalMods + RoundGeneratorData.SPACING_SUPER_CLOSE_MOD;
                        spacingDistance = Constants.SPACING_SUPER_CLOSE;
                        break;
                     case RoundGeneratorData.SPACING_ULTRA_CLOSE:
                        groupRBE = groupRBE / RoundGeneratorData.SPACING_ULTRA_CLOSE_MOD;
                        totalMods = totalMods + RoundGeneratorData.SPACING_ULTRA_CLOSE_MOD;
                        spacingDistance = Constants.SPACING_ULTRA_CLOSE;
                  }
               }
               RND.setSeed(camoRND.nextInteger());
               moreCamoModifier = 1;
               if(isCamoTile)
               {
                  moreCamoModifier = moreCamoModifier * RoundGeneratorData.CAMO_TILE_PROBABILITY_MODIFIER;
               }
               camoModifierSet.dispatch(function(param1:Number):void
               {
                  moreCamoModifier = moreCamoModifier * param1;
               });
               roundRequiredBeforeCamo = !!isCamoTile?0:int(RoundGeneratorData.ROUND_REQUIRED_BEFORE_CAMO);
               difficultyRequiredBeforeCamo = !!isCamoTile?int(Constants.MINIMUM_CAMO_TILE_DIFFICULTY):int(Constants.DIFFICULTY_REQUIRED_BEFORE_CAMO);
               useCamo = RND.nextNumber() < RoundGeneratorData.CAMO_PROBABILITY * moreCamoModifier * gameRequest.camoChanceModifier && currentRound >= roundRequiredBeforeCamo && difficulty >= difficultyRequiredBeforeCamo;
               if(useCamo)
               {
                  if(isCamoTile)
                  {
                     groupRBE = groupRBE / RoundGeneratorData.CAMO_TILE_CAMO_MOD;
                     totalMods = totalMods + RoundGeneratorData.CAMO_TILE_CAMO_MOD;
                  }
                  else
                  {
                     groupRBE = groupRBE / RoundGeneratorData.CAMO_MOD;
                     totalMods = totalMods + RoundGeneratorData.CAMO_MOD;
                  }
               }
               RND.setSeed(regenRND.nextInteger());
               moreRegenModifier = 1;
               if(isRegenTile)
               {
                  moreRegenModifier = moreRegenModifier * RoundGeneratorData.REGEN_TILE_PROBABILITY_MODIFIER;
               }
               roundRequiredBeforeRegen = !!isRegenTile?0:int(RoundGeneratorData.ROUND_REQUIRED_BEFORE_REGEN);
               difficultyRequiredBeforeRegen = !!isRegenTile?int(Constants.MINIMUM_REGEN_TILE_DIFFICULTY):int(Constants.DIFFICULTY_REQUIRED_BEFORE_REGEN);
               useRegen = RND.nextNumber() < RoundGeneratorData.REGEN_PROBABILITY * moreRegenModifier * gameRequest.regenChanceModifier && currentRound >= roundRequiredBeforeRegen && difficulty >= difficultyRequiredBeforeRegen;
               if(useRegen)
               {
                  if(isRegenTile)
                  {
                     groupRBE = groupRBE / RoundGeneratorData.REGEN_TILE_REGEN_MOD;
                     totalMods = totalMods + RoundGeneratorData.REGEN_TILE_REGEN_MOD;
                  }
                  else
                  {
                     groupRBE = groupRBE / RoundGeneratorData.REGEN_MOD;
                     totalMods = totalMods + RoundGeneratorData.REGEN_MOD;
                  }
               }
               RND.setSeed(groupVarianceRND.nextInteger());
               unclampedBloonsInGroup = 10 + currentRound / 3 + RND.nextNumber() * 5;
               bloonsInGroup = Math.min(unclampedBloonsInGroup,maxBloonsInGroup + RND.nextNumber() * (maxBloonsInGroup * 0.3));
               if(didMegaCollapse)
               {
                  bloonsInGroup = bloonsInGroup / 5;
               }
               if(RND.nextNumber() < chanceOfBloonsInGroupVaried)
               {
                  bloonsInGroup = bloonsInGroup * (RND.nextNumber() * (bloonsInGroupVariationMax - bloonsInGroupVariationMin) + bloonsInGroupVariationMin);
                  if(bloonsInGroup < 1)
                  {
                     bloonsInGroup = 1;
                  }
               }
               if(bloonsInGroup > groupRBE)
               {
                  bloonsInGroup = groupRBE;
               }
               groupDefinitionFound = this.getGroupDefinition(groupRBE,bloonsInGroup,strongestBloonAllowed,spacingDistance,useCamo,useRegen,gameRequest.moreLead,totalMods,isCamoTile,isRegenTile);
               bloonTypePromotion = 1;
               scaleDown = 3;
               minBloonsInGroup = 2;
               if(spacingType === RoundGeneratorData.SPACING_LOOSE)
               {
                  groupDefinitionFound.bloonSpawnType.type = groupDefinitionFound.bloonSpawnType.type + bloonTypePromotion;
                  if(groupDefinitionFound.bloonSpawnType.type > strongestBloonAllowed)
                  {
                     groupDefinitionFound.bloonSpawnType.type = strongestBloonAllowed;
                  }
                  if(Bloon.isMOABClass(groupDefinitionFound.bloonSpawnType.type))
                  {
                     groupDefinitionFound.bloonSpawnType.type = Bloon.MOAB - 1;
                  }
                  groupDefinitionFound.numberOfBloons = groupDefinitionFound.numberOfBloons / scaleDown;
                  if(groupDefinitionFound.numberOfBloons < minBloonsInGroup)
                  {
                     groupDefinitionFound.numberOfBloons = minBloonsInGroup;
                  }
               }
               bloonTypeDemotion = 1;
               if(spacingType === RoundGeneratorData.SPACING_SUPER_CLOSE || spacingType === RoundGeneratorData.SPACING_ULTRA_CLOSE)
               {
                  groupDefinitionFound.bloonSpawnType.type = groupDefinitionFound.bloonSpawnType.type - bloonTypePromotion;
                  if(groupDefinitionFound.bloonSpawnType.type < Bloon.RED)
                  {
                     groupDefinitionFound.bloonSpawnType.type = Bloon.RED;
                  }
                  if(groupDefinitionFound.bloonSpawnType.type === Bloon.RED && groupDefinitionFound.bloonSpawnType.regen)
                  {
                     groupDefinitionFound.bloonSpawnType.type++;
                  }
               }
               groupDefinitions.push(groupDefinitionFound);
               currentGroup++;
            }
            if(difficulty <= maxDifficultyForEasyMoney && currentRound < easyMoneyRBE.length && difficulty > 1)
            {
               this.addEasyMoneyGroups(groupDefinitions,easyMoneyRBE[currentRound] * rbePool,(currentRound + 1) / easyMoneyRBE.length);
            }
            RND.setSeed(strongestBloonsRND.nextInteger());
            groupDefinitions.sortOn("sortRank",Array.NUMERIC);
            while(strongestBloonGroupDefinitions.length > 0)
            {
               groupDefinitions.splice(int((RND.nextNumber() * 0.5 + 0.5) * groupDefinitions.length),0,strongestBloonGroupDefinitions.pop());
            }
            RND.setSeed(moabSpliceRND.nextInteger());
            while(moabGroupDefinitions.length > 0)
            {
               groupDefinitions.splice(int(RND.nextNumber() * groupDefinitions.length),0,moabGroupDefinitions.pop());
            }
            k = 0;
            while(k < groupDefinitions.length)
            {
               groupDefinition = groupDefinitions[k];
               l = 0;
               while(l < groupDefinition.numberOfBloons)
               {
                  round.queueBloon(groupDefinition.bloonSpawnType);
                  l++;
               }
               bloonTypeID = groupDefinition.bloonSpawnType.type;
               if(bloonTypeID < Bloon.rbeByType.length)
               {
                  if(bloonTypeID == Bloon.BFB)
                  {
                     this.totalBloons = this.totalBloons + this.BFB_RBE_ACTUAL_USE;
                  }
                  else if(bloonTypeID == Bloon.BOSS)
                  {
                     this.totalBloons = this.totalBloons + this.ZOMG_RBE_ACTUAL_USE;
                  }
                  else
                  {
                     this.totalBloons = this.totalBloons + groupDefinition.numberOfBloons * Bloon.rbeByType[groupDefinition.bloonSpawnType.type];
                  }
               }
               k++;
            }
            groupDefinitions.length = 0;
            moabGroupDefinitions.length = 0;
            round.finalise();
            currentRound++;
         }
      }
      
      private function addZomgAlternative(param1:int, param2:Array, param3:int) : Object
      {
         var _loc4_:Number = NaN;
         var _loc5_:int = param1;
         var _loc6_:Number = Constants.SPACING_NORMAL;
         var _loc7_:Boolean = false;
         var _loc8_:Boolean = false;
         var _loc9_:int = 1;
         if(param1 === Bloon.BOSS)
         {
            _loc5_ = Bloon.BOSS;
            _loc4_ = this.ZOMG_RBE_ACTUAL_USE;
            _loc9_ = 1;
         }
         else if(param1 === Constants.MOAB_CLUSTER_ID)
         {
            _loc5_ = Bloon.MOAB;
            _loc9_ = 20;
            _loc4_ = this.DDT_RBE_ACTUAL_USE / _loc9_;
            _loc6_ = 1.5 / _loc9_;
         }
         else if(param1 === Constants.BFB_CLUSTER_ID)
         {
            _loc5_ = Bloon.BFB;
            _loc9_ = 6;
            _loc4_ = this.DDT_RBE_ACTUAL_USE / _loc9_;
            _loc6_ = 1.5 / _loc9_;
         }
         else if(param1 === Constants.DDT_ID)
         {
            _loc5_ = Bloon.DDT;
            _loc9_ = 3;
            _loc4_ = this.DDT_RBE_ACTUAL_USE / _loc9_;
            _loc6_ = 0.5;
         }
         var _loc10_:BloonSpawnType = new BloonSpawnType(_loc5_);
         _loc10_.spacing = _loc6_;
         _loc10_.camo = _loc7_;
         _loc10_.regen = _loc8_;
         var _loc11_:GroupDefinition = new GroupDefinition(_loc10_,_loc9_,1);
         param2.push(_loc11_);
         return {"cost":_loc4_};
      }
      
      private function addEasyMoneyGroups(param1:Array, param2:int, param3:Number) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Number = NaN;
         var _loc9_:GroupDefinition = null;
         var _loc4_:int = 5;
         if(param2 < 10)
         {
            param2 = 10;
         }
         while(param2 >= 0)
         {
            _loc5_ = 1;
            if(RND.nextNumber() < param3)
            {
               _loc5_ = 2;
            }
            _loc6_ = 7 + RND.nextNumber() * 6;
            _loc7_ = _loc6_ * RoundGeneratorData.getRBEByType(_loc5_);
            if(_loc7_ > param2)
            {
               if(param2 < _loc4_)
               {
                  break;
               }
               _loc5_ = 0;
               _loc6_ = param2;
               if(_loc6_ < _loc4_)
               {
                  _loc6_ = _loc4_;
               }
               _loc7_ = _loc6_ * RoundGeneratorData.getRBEByType(_loc5_);
            }
            _loc8_ = 0;
            _loc9_ = new GroupDefinition(new BloonSpawnType(_loc5_),_loc6_,_loc8_);
            param1.push(_loc9_);
            param2 = param2 - _loc7_;
         }
      }
      
      protected function generateRBEPerRound(param1:int, param2:int, param3:Object = null) : Array
      {
         var _loc4_:Object = param3 || {};
         var _loc5_:Array = [];
         var _loc6_:int = int(_loc4_.roundRBE) || int(10 + param2 * 5);
         var _loc7_:Number = Number(_loc4_.roundRBEIncrement) || Number(10 + param2);
         var _loc8_:Number = Number(_loc4_.roundRBEIncrementGrowth) || Number(5 + param2 * 0.9);
         var _loc9_:int = 0;
         while(_loc9_ < param1)
         {
            _loc5_[_loc9_] = Number(_loc6_ * rbeModifier);
            _loc6_ = _loc6_ + _loc7_;
            _loc7_ = _loc7_ + _loc8_;
            _loc9_++;
         }
         if(this.SHOW_ROUND_RBE_DATA_GRAPH)
         {
            this._debugView.reveal();
            this._debugGraph.clear();
            this._debugGraph.rangeX = 50;
            this._debugGraph.rangeY = 14000;
            this._debugGraph.drawData(_loc5_);
         }
         return _loc5_;
      }
      
      private function generateRBERoundData() : void
      {
         var _loc1_:int = 1;
         while(_loc1_ <= 160)
         {
            this.generateRBEPerRound(this.getTotalRounds(_loc1_),_loc1_);
            _loc1_++;
         }
      }
      
      protected function generateRBEGroups(param1:int, param2:int) : Array
      {
         var _loc3_:Number = NaN;
         var _loc4_:Array = [];
         var _loc5_:int = 0;
         while(param1 > 0)
         {
            _loc3_ = param1 * 0.25;
            if(_loc3_ < param2)
            {
               _loc3_ = param2;
            }
            _loc4_.push(_loc3_);
            param1 = param1 - _loc3_;
            if(param1 <= param2)
            {
               _loc4_.push(param2);
               break;
            }
            _loc5_ = _loc5_ + _loc3_;
         }
         _loc4_.sort(Array.NUMERIC);
         return _loc4_;
      }
      
      protected function collapseGroups(param1:Array, param2:int) : Array
      {
         var _loc3_:Number = NaN;
         var _loc8_:Number = NaN;
         _loc3_ = 0.3;
         var _loc4_:Number = param1.length * (1 / _loc3_);
         var _loc5_:Array = [];
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         while(_loc7_ < param1.length)
         {
            _loc8_ = _loc7_ / _loc4_;
            if(RND.nextNumber() < _loc8_)
            {
               _loc6_ = _loc6_ + param1[_loc7_];
            }
            else
            {
               _loc5_.push(param1[_loc7_] + _loc6_);
               _loc6_ = 0;
            }
            _loc7_++;
         }
         if(_loc5_.length === 0)
         {
            _loc5_.push(_loc6_);
         }
         param1 = _loc5_;
         return param1;
      }
      
      protected function megaCollapseGroups(param1:Array, param2:int) : Array
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         _loc3_ = 0.7;
         _loc4_ = _loc3_ + RND.nextNumber() * (1 - _loc3_);
         var _loc5_:int = param1.length * _loc4_;
         var _loc6_:Array = [];
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         while(_loc8_ < param1.length)
         {
            if(_loc8_ < param1.length - _loc5_)
            {
               _loc6_.push(param1[_loc8_]);
            }
            else
            {
               _loc7_ = _loc7_ + param1[_loc8_];
            }
            _loc8_++;
         }
         _loc6_.push(_loc7_);
         param1 = _loc6_;
         return param1;
      }
      
      protected function getGroupDefinition(param1:int, param2:int, param3:int, param4:Number, param5:Boolean, param6:Boolean, param7:int, param8:Number, param9:Boolean, param10:Boolean) : GroupDefinition
      {
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc11_:int = 2;
         var _loc12_:int = Math.ceil(param1 / param2);
         if(_loc12_ < 1)
         {
            _loc12_ = 1;
            param2 = param1;
         }
         var _loc13_:Array = RoundGeneratorData.howManyCanIMake(_loc12_);
         _loc15_ = _loc13_.length - 1;
         while(_loc15_ >= 0)
         {
            if(_loc13_[_loc15_] > 0)
            {
               _loc14_ = _loc15_;
               break;
            }
            _loc15_--;
         }
         var _loc16_:int = _loc14_;
         if(_loc16_ > param3 && param3 !== -1)
         {
            _loc16_ = param3;
         }
         var _loc17_:Array = [];
         var _loc18_:Boolean = false;
         _loc15_ = _loc16_;
         while(_loc15_ >= 0)
         {
            if(_loc13_[_loc15_] > 0)
            {
               _loc17_.push(_loc15_);
               if(_loc15_ === Bloon.LEAD)
               {
                  _loc18_ = true;
               }
            }
            if(_loc17_.length === _loc11_)
            {
               break;
            }
            _loc15_--;
         }
         var _loc19_:int = _loc17_.length > 0?int(_loc17_[int(RND.nextNumber() * _loc17_.length)]):int(Bloon.RED);
         if(_loc18_ === true)
         {
            if(_loc19_ !== Bloon.LEAD && param7 === Constants.LOTS)
            {
               if(RND.nextNumber() < RoundGeneratorData.MORE_LEAD_PROBABILITY)
               {
                  _loc19_ = Bloon.LEAD;
               }
            }
            else if(param7 === Constants.NONE)
            {
            }
         }
         var _loc20_:BloonSpawnType = new BloonSpawnType(_loc19_).Spacing(Constants.SPACING_NORMAL);
         if(_loc20_.type < param3 || param9)
         {
            _loc20_.camo = param5;
         }
         if(_loc20_.type !== Bloon.RED)
         {
            if(_loc20_.type < param3 || param10)
            {
               _loc20_.regen = param6;
            }
         }
         param2 = param1 / Bloon.rbeByType[_loc20_.type];
         if(param2 < 1)
         {
            param2 = 1;
         }
         var _loc21_:int = 20;
         var _loc22_:int = 35;
         var _loc23_:int = 45;
         _loc20_.spacing = param4;
         if(param2 >= _loc23_)
         {
            _loc20_.spacing = Constants.SPACING_ULTRA_CLOSE;
            param2 = param2 * (1 / RoundGeneratorData.SPACING_ULTRA_CLOSE_MOD);
         }
         else if(param2 >= _loc22_)
         {
            _loc20_.spacing = Constants.SPACING_SUPER_CLOSE;
            param2 = param2 * (1 / RoundGeneratorData.SPACING_SUPER_CLOSE_MOD);
         }
         else if(param2 >= _loc21_)
         {
            _loc20_.spacing = Constants.SPACING_CLOSE;
            param2 = param2 * (1 / RoundGeneratorData.SPACING_CLOSE_MOD);
         }
         return new GroupDefinition(_loc20_,param2,param8 * _loc20_.type);
      }
      
      protected function getTotalRounds(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc2_:Number = 1;
         _loc3_ = int(2 + param1 * _loc2_);
         if(param1 == 1)
         {
            _loc3_ = 3;
         }
         var _loc4_:int = 25;
         if(_loc3_ > _loc4_)
         {
            _loc3_ = _loc4_ + Math.floor(param1 - 20) / 5;
         }
         if(_loc3_ > 30)
         {
            _loc3_ = 30;
         }
         if(this.extraRounds != -1)
         {
            _loc3_ = _loc3_ + this.extraRounds;
         }
         return _loc3_;
      }
      
      public function insertSpawnGroup(param1:GroupDefinition) : void
      {
         var _loc2_:Round = this._rounds[this._currentRoundIndex.value];
         _loc2_.insertSpawnGroup(param1);
      }
      
      public function get currentRoundDuration() : Number
      {
         if(this._rounds.length == 0)
         {
            return 0;
         }
         return this._rounds[this._currentRoundIndex.value].duration;
      }
      
      public function get roundIndex() : int
      {
         return this._currentRoundIndex.value;
      }
      
      public function get totalRounds() : int
      {
         return this._totalRounds.value;
      }
      
      public function get rounds() : Vector.<Round>
      {
         return this._rounds;
      }
      
      public function set currentRoundIndex(param1:int) : void
      {
         this._currentRoundIndex.value = param1;
      }
      
      public function setCustomRounds(param1:Vector.<Round>) : void
      {
         this._rounds = param1;
         this._totalRounds.value = this._rounds.length;
      }
      
      public function reset() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._rounds.length)
         {
            this.rounds[_loc1_].currentTimeStamp = 0;
            this.rounds[_loc1_].spawnIndex = 0;
            _loc1_++;
         }
      }
      
      public function get bloonTypeList() : Array
      {
         var _loc3_:Round = null;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc1_:Array = [];
         var _loc2_:int = 0;
         while(_loc2_ < this._rounds.length)
         {
            _loc3_ = this._rounds[_loc2_];
            _loc4_ = _loc3_.queuedBloons;
            _loc5_ = _loc4_.length;
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               if(_loc1_.indexOf(_loc4_[_loc6_].spawnType.type) == -1)
               {
                  _loc1_.push(_loc4_[_loc6_].spawnType.type);
               }
               _loc6_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
   }
}
