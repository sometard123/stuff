package ninjakiwi.monkeyTown.town.specialItems
{
   import assets.town.BlankSpecialItemIcon;
   import assets.town.FakeSpecialItemIcon;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.town.specialItems.definition.SpecialItemDefinition;
   import ninjakiwi.monkeyTown.town.specialItems.logics.AntiCamoDust;
   import ninjakiwi.monkeyTown.town.specialItems.logics.BossBaneLogicDef;
   import ninjakiwi.monkeyTown.town.specialItems.logics.BossBlastLogicDef;
   import ninjakiwi.monkeyTown.town.specialItems.logics.BossChillLogicDef;
   import ninjakiwi.monkeyTown.town.specialItems.logics.BossWeakenLogicDef;
   import ninjakiwi.monkeyTown.town.specialItems.logics.CuddlyBear;
   import ninjakiwi.monkeyTown.town.specialItems.logics.MonkeyBoostLogicDef;
   import ninjakiwi.monkeyTown.town.specialItems.logics.RedHotSpikesLogicDef;
   import ninjakiwi.monkeyTown.town.specialItems.logics.SpecialItemBananaReplicator;
   import ninjakiwi.monkeyTown.town.specialItems.logics.SpecialItemBlessedDart;
   import ninjakiwi.monkeyTown.town.specialItems.logics.SpecialItemBottleRocket;
   import ninjakiwi.monkeyTown.town.specialItems.logics.SpecialItemCityCash;
   import ninjakiwi.monkeyTown.town.specialItems.logics.SpecialItemDarkTempleIdol;
   import ninjakiwi.monkeyTown.town.specialItems.logics.SpecialItemEnchantedBoomerang;
   import ninjakiwi.monkeyTown.town.specialItems.logics.SpecialItemEpicMagicCoinPurse;
   import ninjakiwi.monkeyTown.town.specialItems.logics.SpecialItemExtraStickySubstance;
   import ninjakiwi.monkeyTown.town.specialItems.logics.SpecialItemLogisticalBoots;
   import ninjakiwi.monkeyTown.town.specialItems.logics.SpecialItemMagicBananaBag;
   import ninjakiwi.monkeyTown.town.specialItems.logics.SpecialItemMagicCoinPurse;
   import ninjakiwi.monkeyTown.town.specialItems.logics.SpecialItemMagicSpanner;
   import ninjakiwi.monkeyTown.town.specialItems.logics.SpecialItemNinjaScrolls;
   import ninjakiwi.monkeyTown.town.specialItems.logics.SpecialItemPortableDartMonkey;
   import ninjakiwi.monkeyTown.town.specialItems.logics.SpecialItemRevengeStick;
   import ninjakiwi.monkeyTown.town.specialItems.logics.SpecialItemShardOfEverfrost;
   import ninjakiwi.monkeyTown.utils.DefinitionPopulator;
   
   public class SpecialItemData
   {
      
      public static var instance:SpecialItemData;
       
      
      public const CASH:String = "cash";
      
      public const ITEM:String = "item";
      
      public const CASH_ID:int = 1;
      
      public const ITEM_ID:int = 2;
      
      public const itemPlacementData:Array = [{
         "ring":3,
         "type":"cash"
      },{
         "ring":4,
         "type":"item"
      },{
         "ring":5,
         "type":"cash"
      },{
         "ring":6,
         "type":"item"
      },{
         "ring":7,
         "type":"cash"
      },{
         "ring":8,
         "type":"item"
      },{
         "ring":9,
         "type":"item"
      },{
         "ring":10,
         "type":"item"
      },{
         "ring":11,
         "type":"item"
      },{
         "ring":13,
         "type":"item"
      },{
         "ring":15,
         "type":"item"
      },{
         "ring":17,
         "type":"item"
      },{
         "ring":19,
         "type":"item"
      },{
         "ring":21,
         "type":"item"
      }];
      
      public const MAGIC_BANANA_BAG:SpecialItemDefinition = new SpecialItemDefinition().Id("MagicBananaBag").Logic(SpecialItemMagicBananaBag).IconGraphicClass(BlankSpecialItemIcon);
      
      public const BLESSED_DART:SpecialItemDefinition = new SpecialItemDefinition().Id("BlessedDart").Logic(SpecialItemBlessedDart).IconGraphicClass(FakeSpecialItemIcon);
      
      public const BANANA_REPLICATOR:SpecialItemDefinition = new SpecialItemDefinition().Id("BananaReplicator").Logic(SpecialItemBananaReplicator).IconGraphicClass(BlankSpecialItemIcon);
      
      public const REVENGE_STICK:SpecialItemDefinition = new SpecialItemDefinition().Id("RevengeStick").Logic(SpecialItemRevengeStick).IconGraphicClass(BlankSpecialItemIcon);
      
      public const PORTABLE_DART_MONKEY:SpecialItemDefinition = new SpecialItemDefinition().Id("PortableDartMonkey").Logic(SpecialItemPortableDartMonkey).IconGraphicClass(BlankSpecialItemIcon);
      
      public const MAGIC_COIN_PURSE:SpecialItemDefinition = new SpecialItemDefinition().Id("MagicCoinPurse").Logic(SpecialItemMagicCoinPurse).IconGraphicClass(BlankSpecialItemIcon);
      
      public const EPIC_MAGIC_COIN_PURSE:SpecialItemDefinition = new SpecialItemDefinition().Id("EpicMagicCoinPurse").Logic(SpecialItemEpicMagicCoinPurse).IconGraphicClass(BlankSpecialItemIcon);
      
      public const LOGISTICAL_BOOTS:SpecialItemDefinition = new SpecialItemDefinition().Id("LogisticalBoots").Logic(SpecialItemLogisticalBoots).IconGraphicClass(BlankSpecialItemIcon);
      
      public const MAGIC_SPANNER:SpecialItemDefinition = new SpecialItemDefinition().Id("MagicSpanner").Logic(SpecialItemMagicSpanner).IconGraphicClass(BlankSpecialItemIcon);
      
      public const DARK_TEMPLE_IDOL:SpecialItemDefinition = new SpecialItemDefinition().Id("DarkTempleIdol").Logic(SpecialItemDarkTempleIdol).IconGraphicClass(BlankSpecialItemIcon);
      
      public const BOTTLE_ROCKET:SpecialItemDefinition = new SpecialItemDefinition().Id("BottleRocket").Logic(SpecialItemBottleRocket).IconGraphicClass(BlankSpecialItemIcon);
      
      public const CITY_CASH:SpecialItemDefinition = new SpecialItemDefinition().Id("CityCash").Logic(SpecialItemCityCash).IconGraphicClass(BlankSpecialItemIcon);
      
      public const PORTAL_ARTIFACT1:SpecialItemDefinition = new SpecialItemDefinition().Id("PortalArtifact1").Logic(SpecialItem).IconGraphicClass(BlankSpecialItemIcon);
      
      public const PORTAL_ARTIFACT2:SpecialItemDefinition = new SpecialItemDefinition().Id("PortalArtifact2").Logic(SpecialItem).IconGraphicClass(BlankSpecialItemIcon);
      
      public const PORTAL_ARTIFACT3:SpecialItemDefinition = new SpecialItemDefinition().Id("PortalArtifact3").Logic(SpecialItem).IconGraphicClass(BlankSpecialItemIcon);
      
      public const PORTAL_ARTIFACT4:SpecialItemDefinition = new SpecialItemDefinition().Id("PortalArtifact4").Logic(SpecialItem).IconGraphicClass(BlankSpecialItemIcon);
      
      public const PORTAL_ARTIFACT5:SpecialItemDefinition = new SpecialItemDefinition().Id("PortalArtifact5").Logic(SpecialItem).IconGraphicClass(BlankSpecialItemIcon);
      
      public const ENCHANTED_BOOMERANG:SpecialItemDefinition = new SpecialItemDefinition().Id(Constants.ENCHANTED_BOOMERANG_ID).Logic(SpecialItemEnchantedBoomerang).IconGraphicClass(BlankSpecialItemIcon);
      
      public const NINJASCROLLS:SpecialItemDefinition = new SpecialItemDefinition().Id(Constants.NINJASCROLLS_ID).Logic(SpecialItemNinjaScrolls).IconGraphicClass(BlankSpecialItemIcon);
      
      public const SHARD_OF_EVERFROST:SpecialItemDefinition = new SpecialItemDefinition().Id(Constants.SHARD_OF_EVERFROST_ID).Logic(SpecialItemShardOfEverfrost).IconGraphicClass(BlankSpecialItemIcon);
      
      public const EXTRA_STICKY_SUBSTANCE:SpecialItemDefinition = new SpecialItemDefinition().Id(Constants.EXTRA_STICKY_SUBSTANCE_ID).Logic(SpecialItemExtraStickySubstance).IconGraphicClass(BlankSpecialItemIcon);
      
      public const CUDDLY_BEAR:SpecialItemDefinition = new SpecialItemDefinition().Id(Constants.CUDDLY_BEAR_ID).Logic(CuddlyBear).IconGraphicClass(BlankSpecialItemIcon);
      
      public const ANTI_CAMO_DUST:SpecialItemDefinition = new SpecialItemDefinition().Id(Constants.ANTI_CAMO_DUST_ID).Logic(AntiCamoDust).IconGraphicClass(BlankSpecialItemIcon);
      
      public const BOSS_CHILL:SpecialItemDefinition = new SpecialItemDefinition().Id(Constants.BOSS_CHILL_ID).Logic(BossChillLogicDef).IconGraphicClass(BlankSpecialItemIcon);
      
      public const BOSS_BANE:SpecialItemDefinition = new SpecialItemDefinition().Id(Constants.BOSS_BANE_ID).Logic(BossBaneLogicDef).IconGraphicClass(BlankSpecialItemIcon);
      
      public const BOSS_BLAST:SpecialItemDefinition = new SpecialItemDefinition().Id(Constants.BOSS_BLAST_ID).Logic(BossBlastLogicDef).IconGraphicClass(BlankSpecialItemIcon);
      
      public const BOSS_WEAKEN:SpecialItemDefinition = new SpecialItemDefinition().Id(Constants.BOSS_WEAKEN_ID).Logic(BossWeakenLogicDef).IconGraphicClass(BlankSpecialItemIcon);
      
      public const RED_HOT_SPIKES:SpecialItemDefinition = new SpecialItemDefinition().Id(Constants.RED_HOT_SPIKES_ID).Logic(RedHotSpikesLogicDef).IconGraphicClass(BlankSpecialItemIcon);
      
      public const MONKEY_BOOSTS:SpecialItemDefinition = new SpecialItemDefinition().Id(Constants.MONKEY_BOOSTS_ID).Logic(MonkeyBoostLogicDef).IconGraphicClass(BlankSpecialItemIcon);
      
      public var consumableDefinitions:Vector.<SpecialItemDefinition>;
      
      public const consumableAntiBossDefinitions:Vector.<SpecialItemDefinition> = new <SpecialItemDefinition>[this.BOSS_CHILL,this.BOSS_BANE,this.BOSS_BLAST,this.BOSS_WEAKEN];
      
      public const treasureChestDefinitions:Vector.<SpecialItemDefinition> = new <SpecialItemDefinition>[this.MAGIC_BANANA_BAG,this.BLESSED_DART,this.BANANA_REPLICATOR,this.REVENGE_STICK,this.PORTABLE_DART_MONKEY,this.MAGIC_COIN_PURSE,this.EPIC_MAGIC_COIN_PURSE,this.LOGISTICAL_BOOTS,this.MAGIC_SPANNER,this.DARK_TEMPLE_IDOL,this.BOTTLE_ROCKET,this.CITY_CASH,this.ANTI_CAMO_DUST];
      
      public const missionDefinitions:Vector.<SpecialItemDefinition> = new <SpecialItemDefinition>[this.ENCHANTED_BOOMERANG,this.NINJASCROLLS,this.SHARD_OF_EVERFROST,this.EXTRA_STICKY_SUBSTANCE,this.CUDDLY_BEAR];
      
      public const artifactDefinitions:Vector.<SpecialItemDefinition> = new <SpecialItemDefinition>[this.PORTAL_ARTIFACT1,this.PORTAL_ARTIFACT2,this.PORTAL_ARTIFACT3,this.PORTAL_ARTIFACT4,this.PORTAL_ARTIFACT5];
      
      public const allDefinitions:Vector.<SpecialItemDefinition> = new Vector.<SpecialItemDefinition>();
      
      private var _chanceRangeAccumulator:int = 0;
      
      private const _definitionsByID:Object = new Object();
      
      public function SpecialItemData(param1:SingletonEnforcer#933)
      {
         this.consumableDefinitions = new <SpecialItemDefinition>[this.RED_HOT_SPIKES,this.MONKEY_BOOSTS];
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use SpecialItemData.getInstance() instead of new.");
         }
         this.init();
      }
      
      public static function getInstance() : SpecialItemData
      {
         if(instance == null)
         {
            instance = new SpecialItemData(new SingletonEnforcer#933());
         }
         return instance;
      }
      
      public function initItemDataFromObject(param1:Object) : void
      {
         var _loc3_:SpecialItemDefinition = null;
         var _loc4_:Object = null;
         var _loc2_:DefinitionPopulator = new DefinitionPopulator();
         var _loc5_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < this.consumableDefinitions.length)
         {
            _loc3_ = this.consumableDefinitions[_loc5_];
            _loc4_ = param1[_loc3_.id];
            if(_loc4_ != null)
            {
               _loc2_.populateDefinitionFromObject(_loc3_,_loc4_);
               this._definitionsByID[_loc3_.id] = _loc3_;
            }
            this.allDefinitions.push(_loc3_);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < this.treasureChestDefinitions.length)
         {
            _loc3_ = this.treasureChestDefinitions[_loc5_];
            _loc4_ = param1[_loc3_.id];
            if(_loc4_ != null)
            {
               _loc2_.populateDefinitionFromObject(_loc3_,_loc4_);
               this._definitionsByID[_loc3_.id] = _loc3_;
            }
            this.allDefinitions.push(_loc3_);
            _loc3_.ChanceRangeStart(this._chanceRangeAccumulator);
            this._chanceRangeAccumulator = this._chanceRangeAccumulator + _loc3_.rarity;
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < this.missionDefinitions.length)
         {
            _loc3_ = this.missionDefinitions[_loc5_];
            _loc4_ = param1[_loc3_.id];
            if(_loc4_ != null)
            {
               _loc2_.populateDefinitionFromObject(_loc3_,_loc4_);
               this._definitionsByID[_loc3_.id] = _loc3_;
            }
            this.allDefinitions.push(_loc3_);
            _loc5_++;
         }
      }
      
      public function get chanceRangeAccumulator() : int
      {
         return this._chanceRangeAccumulator;
      }
      
      public function getDefinitionByID(param1:String) : SpecialItemDefinition
      {
         return this._definitionsByID[param1] || null;
      }
      
      private function init() : void
      {
         if(Constants.ENABLE_ANTI_BOSS_ABILITIES)
         {
            this.consumableDefinitions = this.consumableAntiBossDefinitions.concat(this.consumableDefinitions);
         }
      }
   }
}

class SingletonEnforcer#933
{
    
   
   function SingletonEnforcer#933()
   {
      super();
   }
}
