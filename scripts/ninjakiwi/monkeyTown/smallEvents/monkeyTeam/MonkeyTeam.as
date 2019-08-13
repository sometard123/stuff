package ninjakiwi.monkeyTown.smallEvents.monkeyTeam
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.sku.SkuSettingsLoader;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventSubManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.AncientKnowledgePackAwarder;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.Awarder;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.BloonstonesAwarder;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.BossBaneAwarder;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.BossBlastAwarder;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.BossChillAwarder;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.BossWeakenAwarder;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.CashAwarder;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.CratesAwarder;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.KnowledgePackAwarder;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.MonkeyBoostAwarder;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.RedHotSpikesAwarder;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.WildcardKnowledgePackAwarder;
   import ninjakiwi.monkeyTown.town.gameEvents.ui.RewardItem;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.EventsMenuButton;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.MonkeyKnowledgeCard;
   
   public class MonkeyTeam extends GameEventSubManager
   {
       
      
      private var _skuSettingsData:Object = null;
      
      private var _monkeyTeam:Array = null;
      
      private var _levels:Array = null;
      
      private var _awarders:Vector.<Awarder>;
      
      private var _rewardTypeIndices:Vector.<int>;
      
      public function MonkeyTeam()
      {
         this._awarders = new Vector.<Awarder>();
         this._rewardTypeIndices = new Vector.<int>();
         super();
         GameEventManager.gameEventManagerReadySignal.add(this.onGameEventManagerReady);
      }
      
      override public function get typeID() : String
      {
         return "monkeyTeam";
      }
      
      public function getCurrentActiveMonkeyTeam() : Array
      {
         return this._monkeyTeam;
      }
      
      public function reset(... rest) : void
      {
         this._monkeyTeam = null;
         this._levels = null;
         this._awarders.length = 0;
         this._rewardTypeIndices.length = 0;
         GameSignals.CITY_IS_FINALLY_READY.remove(this.onCityFinallyReady);
      }
      
      public function onGameEventManagerReady(... rest) : void
      {
         this.reset();
         var _loc2_:GameplayEvent = findCurrentEvent();
         if(null == _loc2_)
         {
            callWhenNextEventBecomesActive(this.onGameEventManagerReady);
            return;
         }
         SkuSettingsLoader.getGameEventDataByID("monkeyTeam",_loc2_.dataID,this.setGameEventData);
      }
      
      private function setGameEventData(param1:Object) : void
      {
         this._skuSettingsData = param1;
         if(null == param1 || false == param1.hasOwnProperty("towers") || false == param1.hasOwnProperty("levels") || false == param1.hasOwnProperty("rewards"))
         {
            this.reset();
            return;
         }
         if(MonkeySystem.getInstance().map.cityIsReady)
         {
            this.onCityFinallyReady();
         }
         else
         {
            GameSignals.CITY_IS_FINALLY_READY.add(this.onCityFinallyReady);
         }
      }
      
      private function onCityFinallyReady(... rest) : void
      {
         GameSignals.CITY_IS_FINALLY_READY.remove(this.onCityFinallyReady);
         this._monkeyTeam = this._skuSettingsData.towers;
         this._levels = this._skuSettingsData.levels;
         this.parseAwarders(this._skuSettingsData.rewards);
         callWhenCurrentEventEnds(this.reset);
      }
      
      private function parseAwarders(param1:Array) : void
      {
         var _loc3_:Object = null;
         this._awarders.length = 0;
         this._rewardTypeIndices.length = 0;
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = param1[_loc2_];
            if(_loc3_.hasOwnProperty("cash") && _loc3_.cash != 0)
            {
               this.addPossibleReward(new CashAwarder(_loc3_.cash),RewardItem.FRAME_CASH);
            }
            if(_loc3_.hasOwnProperty("bloonstones") && _loc3_.bloonstones != 0)
            {
               this.addPossibleReward(new BloonstonesAwarder(_loc3_.bloonstones),RewardItem.FRAME_BS);
            }
            if(_loc3_.hasOwnProperty("crates") && _loc3_.crates != 0)
            {
               this.addPossibleReward(new CratesAwarder(_loc3_.crates),RewardItem.FRAME_CRATE);
            }
            if(_loc3_.hasOwnProperty("boosts") && _loc3_.boosts != 0)
            {
               this.addPossibleReward(new MonkeyBoostAwarder(_loc3_.boosts),RewardItem.FRAME_BOOST);
            }
            if(_loc3_.hasOwnProperty("spikes") && _loc3_.spikes != 0)
            {
               this.addPossibleReward(new RedHotSpikesAwarder(_loc3_.spikes),RewardItem.FRAME_SPIKES);
            }
            if(ResourceStore.getInstance().townLevel >= 12)
            {
               if(_loc3_.hasOwnProperty("knowledgePack") && _loc3_.knowledgePack != 0)
               {
                  this.addPossibleReward(new KnowledgePackAwarder(_loc3_.knowledgePack),RewardItem.FRAME_KNOWLEDGE_PACK);
               }
               if(_loc3_.hasOwnProperty("ancientKnowledgePack") && _loc3_.ancientKnowledgePack != 0)
               {
                  this.addPossibleReward(new AncientKnowledgePackAwarder(_loc3_.ancientKnowledgePack),RewardItem.FRAME_ANCIENT_KNOWLEDGE_PACK);
               }
               if(_loc3_.hasOwnProperty("wildcardKnowledgePack") && _loc3_.wildcardKnowledgePack != 0)
               {
                  this.addPossibleReward(new WildcardKnowledgePackAwarder(_loc3_.wildcardKnowledgePack),RewardItem.FRAME_WILD_KNOWLEDGE_PACK);
               }
               if(_loc3_.hasOwnProperty("bossBanes") && _loc3_.bossBanes != 0)
               {
                  this.addPossibleReward(new BossBaneAwarder(_loc3_.bossBanes),RewardItem.FRAME_BOSS_BANE);
               }
               if(_loc3_.hasOwnProperty("bossChills") && _loc3_.bossChills != 0)
               {
                  this.addPossibleReward(new BossChillAwarder(_loc3_.bossChills),RewardItem.FRAME_BOSS_CHILL);
               }
               if(_loc3_.hasOwnProperty("bossBlasts") && _loc3_.bossBlasts != 0)
               {
                  this.addPossibleReward(new BossBlastAwarder(_loc3_.bossBlasts),RewardItem.FRAME_BOSS_BLAST);
               }
               if(_loc3_.hasOwnProperty("bossWeakens") && _loc3_.bossWeakens != 0)
               {
                  this.addPossibleReward(new BossWeakenAwarder(_loc3_.bossWeakens),RewardItem.FRAME_BOSS_WEAKEN);
               }
            }
            _loc2_++;
         }
      }
      
      private function addPossibleReward(param1:Awarder, param2:int) : void
      {
         this._awarders.push(param1);
         this._rewardTypeIndices.push(param2);
      }
      
      public function giveReward(param1:Object) : MonkeyTeamRewardDef
      {
         var _loc2_:MonkeyTeamRewardDef = new MonkeyTeamRewardDef().UiRewardIndex(-1).RewardAmount(0);
         if(0 == this._awarders.length || 0 == this._rewardTypeIndices.length)
         {
            return _loc2_;
         }
         var _loc3_:Awarder = this.findCurrentAwarder();
         var _loc4_:int = this.findCurrentRewardTypeIndex();
         if(RewardItem.FRAME_BS == _loc4_)
         {
            param1.bloonstonesEarned = param1.bloonstonesEarned + _loc3_.quantity;
         }
         else if(RewardItem.FRAME_CASH == _loc4_)
         {
            param1.cashEarned = param1.cashEarned + _loc3_.quantity;
         }
         else
         {
            _loc3_.award();
         }
         _loc2_.RewardAmount(_loc3_.quantity);
         _loc2_.UiRewardIndex(_loc4_);
         return _loc2_;
      }
      
      private function findCurrentAwarder() : Awarder
      {
         var _loc1_:Awarder = null;
         var _loc2_:int = 0;
         while(_loc2_ < this._awarders.length)
         {
            if(_loc2_ > this._levels.length)
            {
               break;
            }
            if(ResourceStore.getInstance().townLevel < this._levels[_loc2_])
            {
               _loc1_ = this._awarders[_loc2_];
               break;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function findCurrentRewardTypeIndex() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this._rewardTypeIndices.length)
         {
            if(_loc2_ > this._levels.length)
            {
               break;
            }
            if(ResourceStore.getInstance().townLevel < this._levels[_loc2_])
            {
               _loc1_ = this._rewardTypeIndices[_loc2_];
               break;
            }
            _loc2_++;
         }
         return _loc1_;
      }
   }
}
