package ninjakiwi.monkeyTown.monkeyKnowledge
{
   import assets.ui.MonkeyKnowledgeLevelUpPopupClip;
   import com.greensock.TweenLite;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import ninjakiwi.data.DGData;
   import ninjakiwi.monkeyTown.achievements.tests.AttackWonTest;
   import ninjakiwi.monkeyTown.achievements.tests.BTDGameCompleteTest;
   import ninjakiwi.monkeyTown.achievements.tests.BloonResearchLabUpgradeCompleteTest;
   import ninjakiwi.monkeyTown.achievements.tests.BuildCompleteTest;
   import ninjakiwi.monkeyTown.achievements.tests.CashPillagedTest;
   import ninjakiwi.monkeyTown.achievements.tests.CityLevelChangedTest;
   import ninjakiwi.monkeyTown.achievements.tests.ContestedTest;
   import ninjakiwi.monkeyTown.achievements.tests.DefendAttackTest;
   import ninjakiwi.monkeyTown.achievements.tests.HonorTest;
   import ninjakiwi.monkeyTown.achievements.tests.MoneyCapacityIncreasedTest;
   import ninjakiwi.monkeyTown.achievements.tests.RevengeAttackLaunchedTest;
   import ninjakiwi.monkeyTown.achievements.tests.TileCapturedTest;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.contestedTerritory.ContestTestObjects;
   import ninjakiwi.monkeyTown.net.kloud.CoreDataPersistence;
   import ninjakiwi.monkeyTown.sku.urlLoader;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.mynk.save.TrafficGate;
   
   public class MonkeyKnowledgePersistence
   {
      
      private static var instance:MonkeyKnowledgePersistence;
       
      
      private var _trafficGate:TrafficGate;
      
      private var _saveData:Object;
      
      private var _saveInProgress:Boolean = false;
      
      private var _saveIsQueued:Boolean = false;
      
      public function MonkeyKnowledgePersistence(param1:SingletonEnforcer#1745)
      {
         this._trafficGate = new TrafficGate();
         this._saveData = {};
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use MonkeyKnowledgePersistence.getInstance() instead of new.");
         }
         this.initListeners();
      }
      
      public static function getInstance() : MonkeyKnowledgePersistence
      {
         if(instance == null)
         {
            instance = new MonkeyKnowledgePersistence(new SingletonEnforcer#1745());
         }
         return instance;
      }
      
      private function initListeners() : void
      {
         MonkeyKnowledgeTree.getInstance().requestSaveSignal.add(this.saveValue);
      }
      
      public function saveValue(param1:String, param2:*) : void
      {
         CoreDataPersistence.getInstance().saveMonkeyKnowledge(param1,param2);
      }
      
      private function finalSave() : void
      {
         CoreDataPersistence.getInstance().saveValue(CoreDataPersistence.MONKEY_KNOWLEDGE_KEY,this._saveData);
         this._saveData = {};
         this._saveInProgress = true;
         this.onSaveComplete();
      }
      
      private function onSaveComplete(... rest) : void
      {
         this._saveInProgress = false;
         if(this._saveIsQueued)
         {
            this._trafficGate.callFunction(this.finalSave);
            this._saveIsQueued = false;
         }
      }
   }
}

class SingletonEnforcer#1745
{
    
   
   function SingletonEnforcer#1745()
   {
      super();
   }
}
