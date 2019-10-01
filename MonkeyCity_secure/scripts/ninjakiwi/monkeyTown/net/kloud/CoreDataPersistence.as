package ninjakiwi.monkeyTown.net.kloud
{
   import ninjakiwi.monkeyTown.town.ui.SavingNotifier;
   import ninjakiwi.mynk.save.TrafficGate;
   import org.osflash.signals.Signal;
   
   public class CoreDataPersistence
   {
      
      public static const CORE_KEY:String = "core";
      
      public static const RESOURCES_KEY:String = "resources";
      
      public static const SPECIAL_ITEMS_KEY:String = "specialItems";
      
      public static const TUTORIAL_KEY:String = "tutorial";
      
      public static const PREFERENCES_KEY:String = "preferences";
      
      public static const STATS_KEY:String = "stats";
      
      public static const DATA_STORE_KEY:String = "datastore";
      
      public static const QUESTS_KEY:String = "quests";
      
      public static const MONKEY_KNOWLEDGE_KEY:String = "monkeyKnowledge";
      
      public static const CRATES_KEY:String = "crates";
      
      public static const saveCompleteSignal:Signal = new Signal();
      
      private static var instance:CoreDataPersistence;
       
      
      private var _trafficGate:TrafficGate;
      
      private var _saveData:Object;
      
      private var _monkeyKnowledgeSaveData:Object;
      
      private var _isSaving:Boolean = false;
      
      private var _saveInProgress:Boolean = false;
      
      private var _saveIsQueued:Boolean = false;
      
      public function CoreDataPersistence(param1:SingletonEnforcer#1178)
      {
         this._trafficGate = new TrafficGate();
         this._saveData = {};
         this._monkeyKnowledgeSaveData = {};
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use CoreDataPersistence.getInstance() instead of new.");
         }
         this.initListeners();
      }
      
      public static function getInstance() : CoreDataPersistence
      {
         if(instance == null)
         {
            instance = new CoreDataPersistence(new SingletonEnforcer#1178());
         }
         return instance;
      }
      
      private function initListeners() : void
      {
      }
      
      public function saveMonkeyKnowledge(param1:String, param2:*) : void
      {
         this._monkeyKnowledgeSaveData[param1] = param2;
         this.saveValue(MONKEY_KNOWLEDGE_KEY,this._monkeyKnowledgeSaveData);
      }
      
      public function saveValue(param1:String, param2:*) : void
      {
         if(MONKEY_KNOWLEDGE_KEY == param1)
         {
            if(this._saveData.hasOwnProperty(MONKEY_KNOWLEDGE_KEY) == false)
            {
               this._saveData[MONKEY_KNOWLEDGE_KEY] = {};
            }
            this._saveData[MONKEY_KNOWLEDGE_KEY] = param2;
         }
         else if(CRATES_KEY == param1)
         {
            if(this._saveData.hasOwnProperty(CRATES_KEY) == false)
            {
               this._saveData[CRATES_KEY] = {};
            }
            this._saveData[CRATES_KEY] = param2;
         }
         else
         {
            if(this._saveData.hasOwnProperty(CORE_KEY) == false)
            {
               this._saveData[CORE_KEY] = {};
            }
            this._saveData[CORE_KEY][param1] = param2;
         }
         SavingNotifier.trafficGateOn();
         this._isSaving = true;
         if(this._saveInProgress)
         {
            this._saveIsQueued = true;
         }
         else
         {
            this._trafficGate.callFunction(this.finalSave);
         }
      }
      
      private function finalSave() : void
      {
         Kloud.saveCore(this._saveData,this.onSaveComplete);
         this._saveData = {};
         this._monkeyKnowledgeSaveData = {};
         this._saveInProgress = true;
      }
      
      private function onSaveComplete(... rest) : void
      {
         this._saveInProgress = false;
         if(this._saveIsQueued)
         {
            this._trafficGate.callFunction(this.finalSave);
            this._saveIsQueued = false;
         }
         else
         {
            this._isSaving = false;
            SavingNotifier.trafficGateOff();
         }
         saveCompleteSignal.dispatch();
      }
      
      public function get isSaving() : Boolean
      {
         return this._isSaving;
      }
   }
}

class SingletonEnforcer#1178
{
    
   
   function SingletonEnforcer#1178()
   {
      super();
   }
}
