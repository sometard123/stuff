package ninjakiwi.monkeyTown.monkeyKnowledge
{
   import assets.knowledgePortrait.bounty.AncientKnowledgeBountyClip;
   import assets.knowledgePortrait.bounty.BloonstonesBountyClip;
   import assets.knowledgePortrait.bounty.BossAbilityBountyClip;
   import assets.knowledgePortrait.bounty.CityCashBountyClip;
   import assets.knowledgePortrait.bounty.MonkeyBoostsBountyClip;
   import assets.knowledgePortrait.bounty.MonkeyKnowledgeBountyClip;
   import assets.knowledgePortrait.bounty.MonkeySecretBountyClip;
   import assets.knowledgePortrait.bounty.RedHotSpikesBountyClip;
   import assets.knowledgePortrait.bounty.SupplyCratesBountyClip;
   import assets.knowledgePortrait.bounty.WildKnowledgeBountyClip;
   import flash.display.MovieClip;
   import flash.utils.getQualifiedClassName;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.monkeyKnowledge.bountyAwarders.BountyAMKP1;
   import ninjakiwi.monkeyTown.monkeyKnowledge.bountyAwarders.BountyBloonstones30;
   import ninjakiwi.monkeyTown.monkeyKnowledge.bountyAwarders.BountyBossAbilities1;
   import ninjakiwi.monkeyTown.monkeyKnowledge.bountyAwarders.BountyCash20000;
   import ninjakiwi.monkeyTown.monkeyKnowledge.bountyAwarders.BountyCrates5;
   import ninjakiwi.monkeyTown.monkeyKnowledge.bountyAwarders.BountyMKP4;
   import ninjakiwi.monkeyTown.monkeyKnowledge.bountyAwarders.BountyMonkeyBoost5;
   import ninjakiwi.monkeyTown.monkeyKnowledge.bountyAwarders.BountyMonkeySecret;
   import ninjakiwi.monkeyTown.monkeyKnowledge.bountyAwarders.BountyRHS10;
   import ninjakiwi.monkeyTown.monkeyKnowledge.bountyAwarders.BountyWKP2;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.flare.birds.BirdGroup;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.Awarder;
   import ninjakiwi.monkeyTown.utils.DateTool;
   
   public class KnowledgeBounty
   {
      
      public static const SECRET_POINTS:int = 250;
      
      private static var cachedAwarderDataForLevel:Array = [];
      
      private static var lastLevelDataWasCached:int = -1;
      
      private static const awarderData:Array = [{
         "awarder":BountyMKP4,
         "minimumCityLevel":12,
         "avatarClass":MonkeyKnowledgeBountyClip,
         "description":"4x Monkey Knowledge Packs"
      },{
         "awarder":BountyWKP2,
         "minimumCityLevel":12,
         "avatarClass":WildKnowledgeBountyClip,
         "description":"2x Wild Knowledge Packs"
      },{
         "awarder":BountyAMKP1,
         "minimumCityLevel":12,
         "avatarClass":AncientKnowledgeBountyClip,
         "description":"1x Ancient Knowledge Pack"
      },{
         "awarder":BountyRHS10,
         "minimumCityLevel":12,
         "avatarClass":RedHotSpikesBountyClip,
         "description":"10x Red Hot Spikes"
      },{
         "awarder":BountyMonkeyBoost5,
         "minimumCityLevel":12,
         "avatarClass":MonkeyBoostsBountyClip,
         "description":"5x Monkey Boosts"
      },{
         "awarder":BountyCrates5,
         "minimumCityLevel":12,
         "avatarClass":SupplyCratesBountyClip,
         "description":"5x Supply Crates"
      },{
         "awarder":BountyBossAbilities1,
         "minimumCityLevel":12,
         "avatarClass":BossAbilityBountyClip,
         "description":"1x All Boss Abilities"
      },{
         "awarder":BountyCash20000,
         "minimumCityLevel":12,
         "avatarClass":CityCashBountyClip,
         "description":"20,000\nCity Cash"
      },{
         "awarder":BountyBloonstones30,
         "minimumCityLevel":15,
         "avatarClass":BloonstonesBountyClip,
         "description":"30 Bloonstones"
      },{
         "awarder":BountyMonkeySecret,
         "minimumCityLevel":15,
         "avatarClass":MonkeySecretBountyClip,
         "description":""
      }];
      
      public static const BOUNTY_SECRET_TYPE:String = "BountyMonkeySecret";
      
      public static const BOUNTY_WKP2_TYPE:String = "BountyWKP2";
      
      private static const awarderDataByID:Object = {};
      
      {
         staticInit();
      }
      
      public function KnowledgeBounty()
      {
         super();
      }
      
      private static function staticInit() : void
      {
         var _loc2_:Object = null;
         var _loc3_:String = null;
         var _loc1_:int = 0;
         while(_loc1_ < awarderData.length)
         {
            _loc2_ = awarderData[_loc1_];
            _loc3_ = getQualifiedClassName(_loc2_.awarder);
            _loc3_ = _loc3_.split("::")[1];
            _loc2_.id = _loc3_;
            awarderDataByID[_loc3_] = _loc2_;
            _loc1_++;
         }
      }
      
      public static function getRandomBountyID() : String
      {
         var _loc1_:Array = getAwarderDataForCityLevel();
         if(_loc1_.length < 1)
         {
            return null;
         }
         var _loc2_:int = Math.floor(Math.random() * _loc1_.length);
         var _loc3_:Object = _loc1_[_loc2_];
         return _loc3_.id;
      }
      
      private static function getAwarderDataForCityLevel() : Array
      {
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         var _loc1_:int = ResourceStore.getInstance().townLevel;
         if(lastLevelDataWasCached !== _loc1_)
         {
            lastLevelDataWasCached = _loc1_;
            cachedAwarderDataForLevel.length = 0;
            _loc2_ = 0;
            while(_loc2_ < awarderData.length)
            {
               _loc3_ = awarderData[_loc2_];
               if(_loc1_ >= _loc3_.minimumCityLevel)
               {
                  cachedAwarderDataForLevel.push(_loc3_);
               }
               _loc2_++;
            }
         }
         return cachedAwarderDataForLevel;
      }
      
      public static function getAwarderByID(param1:String) : Awarder
      {
         if(false === awarderDataByID.hasOwnProperty(param1))
         {
            return null;
         }
         var _loc2_:Object = awarderDataByID[param1];
         var _loc3_:Awarder = new _loc2_.awarder();
         return _loc3_;
      }
      
      public static function getAvatarClassByID(param1:String) : Class
      {
         if(false === awarderDataByID.hasOwnProperty(param1))
         {
            return MovieClip;
         }
         var _loc2_:Object = awarderDataByID[param1];
         var _loc3_:Class = _loc2_.avatarClass;
         return _loc3_;
      }
      
      public static function getDescriptionByID(param1:String) : String
      {
         if(false === awarderDataByID.hasOwnProperty(param1))
         {
            return "";
         }
         return awarderDataByID[param1].description;
      }
      
      public static function giveBounty(param1:MonkeyKnowledgeToken) : void
      {
         var _loc2_:Awarder = getAwarderByID(param1.subType);
         _loc2_.award();
      }
   }
}
