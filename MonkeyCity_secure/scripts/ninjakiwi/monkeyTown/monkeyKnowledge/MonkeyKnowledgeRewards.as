package ninjakiwi.monkeyTown.monkeyKnowledge
{
   import ninjakiwi.monkeyTown.achievements.AchievementDefinition;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.pvp.IncomingRaid;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldView;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.MonkeyKnowledgePack;
   
   public class MonkeyKnowledgeRewards
   {
      
      public static const CAPTURE_TILE_AWARD_MIN_LEVEL:int = 12;
      
      public static const CAPTURE_TILE_AWARD_PROBABILITY:Number = 0.33;
      
      public static const TREASURE_CHEST_CHANCE_OF_EXTRA_ANCIENT:Number = 0.1;
      
      public static const TILE_CAPTURE_CHANCE_OF_PACK:Number = 0.333;
      
      private static var instance:MonkeyKnowledgeRewards;
       
      
      public function MonkeyKnowledgeRewards(param1:SingletonEnforcer#1533)
      {
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use MonkeyKnowledgeRewards.getInstance() instead of new.");
         }
      }
      
      public static function getInstance() : MonkeyKnowledgeRewards
      {
         if(instance == null)
         {
            instance = new MonkeyKnowledgeRewards(new SingletonEnforcer#1533());
         }
         return instance;
      }
      
      public function giveTreasureCaptureRewards() : Object
      {
         if(this.isValidLevel() == false)
         {
            return null;
         }
         var _loc1_:Object = {
            "packs":1,
            "ancientPacks":0
         };
         var _loc2_:MonkeyKnowledge = MonkeyKnowledge.getInstance();
         _loc2_.winPack();
         if(Math.random() < TREASURE_CHEST_CHANCE_OF_EXTRA_ANCIENT)
         {
            _loc1_.ancientPacks = 1;
            _loc2_.winPack(MonkeyKnowledgePack.ANCIENT_PACK);
         }
         return _loc1_;
      }
      
      public function giveTileCaptureRewards() : Object
      {
         if(this.isValidLevel() == false)
         {
            return null;
         }
         var _loc1_:MonkeyKnowledge = MonkeyKnowledge.getInstance();
         var _loc2_:Object = {"packs":0};
         var _loc3_:Boolean = GameEventManager.getInstance().monkeyKnowledgeMadness.getIsMonkeyKnowledgeMadnessActive();
         if(_loc3_ || Math.random() < TILE_CAPTURE_CHANCE_OF_PACK)
         {
            _loc2_.packs = 1;
            _loc1_.winPack();
         }
         return _loc2_;
      }
      
      private function isValidLevel() : Boolean
      {
         var _loc1_:int = ResourceStore.getInstance().townLevel;
         return _loc1_ >= CAPTURE_TILE_AWARD_MIN_LEVEL;
      }
   }
}

class SingletonEnforcer#1533
{
    
   
   function SingletonEnforcer#1533()
   {
      super();
   }
}
