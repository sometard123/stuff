package ninjakiwi.monkeyTown.ui.monkeyKnowledge
{
   import assets.town.PVPPanelClip;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import ninjakiwi.monkeyTown.analytics.AnalyticsUtil;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.monkeyKnowledge.KnowledgeBounty;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledge;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgeBuffData;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgePathDefinition;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgeToken;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgeTree;
   import ninjakiwi.monkeyTown.monkeyKnowledge.SecretAwarder;
   import ninjakiwi.monkeyTown.net.Squeeze;
   import ninjakiwi.monkeyTown.pvp.Friend;
   import ninjakiwi.monkeyTown.pvp.IncomingRaid;
   import ninjakiwi.monkeyTown.pvp.PvPAttackDefinition;
   import ninjakiwi.monkeyTown.pvp.PvPMain;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.data.load.UserDataLoader;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.town.ui.pvp.SortByDropdown;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.utils.WeightingManager;
   import org.osflash.signals.Signal;
   
   public class MonkeyKnowledgePack
   {
      
      static var _state:MonkeyPackState = new MonkeyPackState();
      
      private static const TOKEN_QUALITY:Array = [{
         "quality":MonkeyKnowledge.COMMON.valueOf(),
         "points":10
      },{
         "quality":MonkeyKnowledge.UNCOMMON.valueOf(),
         "points":30
      },{
         "quality":MonkeyKnowledge.RARE.valueOf(),
         "points":80
      },{
         "quality":MonkeyKnowledge.LEGENDARY.valueOf(),
         "points":250
      }];
      
      private static const COMMON_QUALITY:int = 0;
      
      private static const UNCOMMON_QUALITY:int = 1;
      
      private static const RARE_QUALITY:int = 2;
      
      private static const LEGENDARY_QUALITY:int = 3;
      
      private static const COMMON_PROBABILITY:Number = 0.6;
      
      private static const UNCOMMON_PROBABILITY:Number = 0.3;
      
      private static const RARE_PROBABILITY:Number = 0.09;
      
      private static const LEGENDARY_PROBABILITY:Number = 0.01;
      
      private static const ANCIENT_UNCOMMON_PROBABILITY:Number = 0.6;
      
      private static const ANCIENT_RARE_PROBABILITY:Number = 0.3;
      
      private static const ANCIENT_LEGENDARY_PROBABILITY:Number = 0.1;
      
      private static const WILD_COMMON_PROBABILITY:Number = 0.57;
      
      private static const WILD_UNCOMMON_PROBABILITY:Number = 0.3;
      
      private static const WILD_RARE_PROBABILITY:Number = 0.11;
      
      private static const WILD_LEGENDARY_PROBABILITY:Number = 0.02;
      
      private static const BOUNTY_PROBABILITY:Number = 0.1;
      
      private static const BOUNTY_ANCIENT_PROBABILITY:Number = 0.2;
      
      private static const RANDOM_PACK:int = -1;
      
      public static const STANDARD_PACK:int = 0;
      
      public static const ANCIENT_PACK:int = 1;
      
      public static const WILDCARD_PACK:int = 2;
      
      public static const STANDARD_PACK_KEY:String = "standard_pack";
      
      public static const ANCIENT_PACK_KEY:String = "ancient_pack";
      
      public static const WILDCARD_PACK_KEY:String = "wildcard_pack";
      
      public static const TOKENS_PER_PACK:int = 4;
      
      public static const THREE_GOOD_MAX_RATE:int = 5;
      
      public static const FOUR_GOOD_MAX_RATE:int = 20;
      
      public static var USE_FLAT_DEBUG_PROBABILITIES:Boolean = false;
      
      public static var DEBUG_ALL_BOUNTY:Boolean = false;
      
      public static var DEBUG_ALL_SECRET:Boolean = false;
      
      public static var DEBUG_MIX_BOUNTY:Boolean = false;
      
      private static const _qualityWeights:WeightingManager = new WeightingManager();
       
      
      public var tokens:Vector.<MonkeyKnowledgeToken>;
      
      public var packQuality:int = 0;
      
      private var _hasBeenAwarded:Boolean = false;
      
      public function MonkeyKnowledgePack(param1:int = 0)
      {
         this.tokens = new Vector.<MonkeyKnowledgeToken>();
         super();
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         this.packQuality = param1;
         this.setUpProbabilities();
         _state.storeCurves();
         while(false === _loc2_)
         {
            if(param1 === WILDCARD_PACK)
            {
               this.generateWildcardPack();
               _loc2_ = this.validateWildcardPack();
            }
            else
            {
               this.generate();
               _loc2_ = this.validatePack();
            }
            _loc3_++;
            if(_loc3_ > 100)
            {
               break;
            }
         }
         this.shuffleArray(this.tokens);
         _state.stepCurves();
         _state.save();
      }
      
      public static function resetState() : void
      {
      }
      
      public static function setSaveData(param1:Object) : void
      {
         _state.setSaveData(param1);
      }
      
      private function setUpProbabilities() : void
      {
         _qualityWeights.clear();
         switch(this.packQuality)
         {
            case STANDARD_PACK:
               this.addStandardProbabilities();
               break;
            case ANCIENT_PACK:
               this.addAncientProbabilities();
               break;
            case WILDCARD_PACK:
               this.addWildProbabilities();
         }
      }
      
      private function generate() : void
      {
         var _loc3_:MonkeyKnowledgeToken = null;
         this.tokens.length = 0;
         switch(this.packQuality)
         {
            case STANDARD_PACK:
               this.tokens[0] = this.generateToken(RARE_QUALITY);
               break;
            case ANCIENT_PACK:
               this.tokens[0] = this.generateToken(LEGENDARY_QUALITY);
               break;
            case WILDCARD_PACK:
               this.tokens[0] = this.generateToken(RARE_QUALITY);
         }
         var _loc1_:MonkeyKnowledgeToken = this.getBounty();
         if(_loc1_ !== null)
         {
            this.tokens.push(_loc1_);
         }
         var _loc2_:int = this.tokens.length;
         while(_loc2_ < TOKENS_PER_PACK)
         {
            _loc3_ = this.generateToken();
            this.tokens.push(_loc3_);
            _loc2_++;
         }
         if(0 != GameEventManager.getInstance().getActiveEvents("wildRare").length)
         {
            this.tokens[0].type = MonkeyKnowledgeCard.WILDCARD;
         }
      }
      
      private function getBounty() : MonkeyKnowledgeToken
      {
         var _loc2_:String = null;
         var _loc3_:MonkeyKnowledgeToken = null;
         var _loc1_:Number = this.packQuality === ANCIENT_PACK?Number(BOUNTY_ANCIENT_PROBABILITY):Number(BOUNTY_PROBABILITY);
         if(Math.random() < _loc1_ + _state.bountyCurve.bonusProbability)
         {
            _loc2_ = KnowledgeBounty.getRandomBountyID();
            if(_loc2_ === null)
            {
               return null;
            }
            _loc3_ = new MonkeyKnowledgeToken();
            _loc3_.type = _loc3_.quality = MonkeyKnowledgeCard.BOUNTY_CARD;
            _loc3_.subType = _loc2_;
            if(_loc3_.subType === KnowledgeBounty.BOUNTY_SECRET_TYPE)
            {
               _loc3_.quality = KnowledgeBounty.BOUNTY_SECRET_TYPE;
            }
            _state.bountyCurve.hit();
            return _loc3_;
         }
         return null;
      }
      
      private function generateWildcardPack() : void
      {
         var _loc2_:MonkeyKnowledgeToken = null;
         this.generate();
         var _loc1_:int = 0;
         while(_loc1_ < this.tokens.length)
         {
            _loc2_ = this.tokens[_loc1_];
            if(_loc2_.type === MonkeyKnowledgeCard.BOUNTY_CARD)
            {
               if(_loc2_.subType !== KnowledgeBounty.BOUNTY_SECRET_TYPE)
               {
                  _loc2_.subType = KnowledgeBounty.BOUNTY_WKP2_TYPE;
               }
            }
            else
            {
               _loc2_.type = MonkeyKnowledgeCard.WILDCARD;
            }
            _loc1_++;
         }
      }
      
      private function validateWildcardPack() : Boolean
      {
         return true;
      }
      
      private function generateToken(param1:int = -1) : MonkeyKnowledgeToken
      {
         var _loc2_:MonkeyKnowledgeToken = new MonkeyKnowledgeToken();
         var _loc3_:Vector.<MonkeyKnowledgePathDefinition> = MonkeyKnowledgeBuffData.getInstance().pathDefinitions;
         if(param1 < 0)
         {
            param1 = _qualityWeights.getRandomItem();
         }
         var _loc4_:Object = TOKEN_QUALITY[param1];
         var _loc5_:MonkeyKnowledgePathDefinition = _loc3_[Math.floor(Math.random() * _loc3_.length)];
         _loc2_.type = _loc2_.subType = _loc5_.id;
         _loc2_.quality = _loc4_.quality;
         _loc2_.points = _loc4_.points;
         if(_loc2_.quality === MonkeyKnowledge.LEGENDARY)
         {
            _state.legendaryCurve.hit();
         }
         return _loc2_;
      }
      
      private function addStandardProbabilities() : void
      {
         _qualityWeights.addWeightedItem(COMMON_QUALITY,COMMON_PROBABILITY);
         _qualityWeights.addWeightedItem(UNCOMMON_QUALITY,UNCOMMON_PROBABILITY);
         _qualityWeights.addWeightedItem(RARE_QUALITY,RARE_PROBABILITY);
         _qualityWeights.addWeightedItem(LEGENDARY_QUALITY,LEGENDARY_PROBABILITY + _state.legendaryCurve.bonusProbability);
      }
      
      private function addAncientProbabilities() : void
      {
         _qualityWeights.addWeightedItem(UNCOMMON_QUALITY,ANCIENT_UNCOMMON_PROBABILITY);
         _qualityWeights.addWeightedItem(RARE_QUALITY,ANCIENT_RARE_PROBABILITY);
         _qualityWeights.addWeightedItem(LEGENDARY_QUALITY,ANCIENT_LEGENDARY_PROBABILITY + _state.legendaryCurve.bonusProbability);
      }
      
      private function addWildProbabilities() : void
      {
         _qualityWeights.addWeightedItem(COMMON_QUALITY,WILD_COMMON_PROBABILITY);
         _qualityWeights.addWeightedItem(UNCOMMON_QUALITY,WILD_UNCOMMON_PROBABILITY);
         _qualityWeights.addWeightedItem(RARE_QUALITY,WILD_RARE_PROBABILITY);
         _qualityWeights.addWeightedItem(LEGENDARY_QUALITY,WILD_LEGENDARY_PROBABILITY + _state.legendaryCurve.bonusProbability);
      }
      
      private function validatePack() : Boolean
      {
         var _loc5_:MonkeyKnowledgeToken = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Boolean = true;
         var _loc4_:int = 0;
         for each(_loc5_ in this.tokens)
         {
            if(_loc5_.quality === MonkeyKnowledge.RARE || _loc5_.quality === MonkeyKnowledge.LEGENDARY)
            {
               _loc1_++;
            }
            if(_loc5_.quality === MonkeyKnowledge.LEGENDARY)
            {
               _loc2_++;
            }
            if(_loc5_.type == MonkeyKnowledgeCard.WILDCARD)
            {
               _loc4_++;
            }
         }
         switch(_loc1_)
         {
            case 3:
               if(_state.packsSinceThreeGood < THREE_GOOD_MAX_RATE)
               {
                  if(Math.random() < 0.6)
                  {
                     _loc3_ = false;
                  }
               }
               break;
            case 4:
               if(_state.packsSinceFourGood < FOUR_GOOD_MAX_RATE)
               {
                  if(Math.random() < 0.8)
                  {
                     _loc3_ = false;
                  }
               }
         }
         if(_loc4_ > 1)
         {
            _loc3_ = false;
         }
         if(_loc3_)
         {
            _state.incrementAllCounters();
            switch(_loc1_)
            {
               case 3:
                  _state.packsSinceThreeGood = 0;
                  break;
               case 4:
                  _state.packsSinceFourGood = 0;
            }
            _state.totalPacks++;
         }
         else
         {
            _state.rollBackCurves();
         }
         return _loc3_;
      }
      
      public function award() : void
      {
         var _loc5_:MonkeyKnowledgeToken = null;
         if(this._hasBeenAwarded)
         {
            return;
         }
         var _loc1_:Object = {};
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MonkeyKnowledgeTree = MonkeyKnowledgeTree.getInstance();
         _loc4_.syncDisplayData();
         for each(_loc5_ in this.tokens)
         {
            if(_loc5_.type == MonkeyKnowledgeCard.WILDCARD)
            {
               _loc4_.addWildcard(_loc5_);
            }
            else
            {
               _loc4_.awardPoints(_loc5_.type,_loc5_.points);
            }
            if(_loc5_.quality === MonkeyKnowledge.LEGENDARY)
            {
               _loc3_++;
            }
            else if(_loc5_.quality === MonkeyKnowledge.RARE)
            {
               _loc2_++;
            }
            if(_loc5_.type == MonkeyKnowledgeCard.BOUNTY_CARD)
            {
               if(_loc5_.subType == KnowledgeBounty.BOUNTY_SECRET_TYPE)
               {
                  SecretAwarder.givePoints();
               }
               else
               {
                  KnowledgeBounty.giveBounty(_loc5_);
               }
            }
         }
         AnalyticsUtil.track("knowledge_pack_opened",JSON.stringify({
            "rare":_loc2_,
            "legendary":_loc3_,
            "cityLevel":ResourceStore.getInstance().townLevel,
            "cityIndex":MonkeySystem.getInstance().city.cityIndex,
            "packQuality":this.packQuality
         }));
         this._hasBeenAwarded = true;
      }
      
      private function shuffleArray(param1:*) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:int = 0;
         var _loc2_:int = param1.length;
         while(_loc2_)
         {
            _loc4_ = Math.floor(Math.random() * _loc2_--);
            _loc3_ = param1[_loc2_];
            param1[_loc2_] = param1[_loc4_];
            param1[_loc4_] = _loc3_;
         }
         return param1;
      }
   }
}
