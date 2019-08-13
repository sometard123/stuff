package ninjakiwi.monkeyTown.town.quests
{
   import flash.text.TextField;
   import flash.text.TextFormat;
   import ninjakiwi.monkeyTown.town.data.definitions.UpgradePathTierDefinition;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.specialItems.SpecialItemStore;
   import ninjakiwi.monkeyTown.town.specialItems.definition.SpecialItemDefinition;
   
   public class QuestCounter
   {
      
      private static const KEY_TREASURE_COUNT:String = "treasureCount";
      
      public static const KEY_MVM_PILLAGED_CASH:String = "mvmPillage";
      
      private static var instance:QuestCounter;
       
      
      private var customValue:Object;
      
      public function QuestCounter(param1:SingletonEnforcer#1159)
      {
         this.customValue = new Object();
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use QuestCounter.getInstance() instead of new.");
         }
         MonkeyCityMain.globalResetSignal.add(this.onReset);
         SpecialItemStore.TREASURE_CHEST_AQUIRED.add(this.onTreasureChestAquired);
      }
      
      public static function getInstance() : QuestCounter
      {
         if(instance == null)
         {
            instance = new QuestCounter(new SingletonEnforcer#1159());
         }
         return instance;
      }
      
      private function onReset() : void
      {
         this.customValue = {};
      }
      
      private function onTreasureChestAquired(param1:SpecialItemDefinition) : void
      {
         this.treasureCount++;
      }
      
      public function loadFromDB(param1:Object) : void
      {
         var _loc2_:* = null;
         if(param1 === null)
         {
            return;
         }
         for(_loc2_ in param1)
         {
            this.customValue[_loc2_] = param1[_loc2_];
         }
      }
      
      public function getCounterData() : Object
      {
         var _loc2_:* = null;
         var _loc1_:Object = new Object();
         for(_loc2_ in this.customValue)
         {
            _loc1_[_loc2_] = this.customValue[_loc2_];
         }
         return _loc1_;
      }
      
      public function setCustomValue(param1:String, param2:Object) : void
      {
         this.customValue[param1] = param2;
         QuestManager.questsStateChanged.dispatch();
      }
      
      public function getCustomValue(param1:String) : Object
      {
         if(this.customValue[param1] != null)
         {
            return this.customValue[param1];
         }
         return null;
      }
      
      public function set treasureCount(param1:int) : void
      {
         this.customValue.treasureCount = param1;
      }
      
      public function get treasureCount() : int
      {
         if(!this.customValue.hasOwnProperty(KEY_TREASURE_COUNT))
         {
            return 0;
         }
         return this.customValue.treasureCount;
      }
   }
}

class SingletonEnforcer#1159
{
    
   
   function SingletonEnforcer#1159()
   {
      super();
   }
}
