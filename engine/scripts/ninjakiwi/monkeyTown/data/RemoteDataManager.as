package ninjakiwi.monkeyTown.data
{
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.FileReference;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.system.System;
   import flash.utils.ByteArray;
   import ninjakiwi.data.GoogleSpreadsheetTool;
   import org.osflash.signals.Signal;
   
   public class RemoteDataManager
   {
       
      
      private const bloonariusSpawnDataURL:String = "http://alpha.ninjakiwi.com/bmc/data_scripts/proxies/bloonarius_spawns_data_proxy.php";
      
      private const bossAttackCostDataURL:String = "http://alpha.ninjakiwi.com/bmc/data_scripts/proxies/boss_attack_cost.php";
      
      private const buildingDataURL:String = "http://alpha.ninjakiwi.com/bmc/data_scripts/proxies/building_data_proxy.php";
      
      private const upgradeBuildingsURL:String = "http://alpha.ninjakiwi.com/bmc/data_scripts/proxies/upgrade_buildings_data_proxy.php";
      
      private const specialBuildingsURL:String = "http://alpha.ninjakiwi.com/bmc/data_scripts/proxies/special_buildings_data_proxy.php";
      
      private const premiumBuildingsURL:String = "http://alpha.ninjakiwi.com/bmc/data_scripts/proxies/premium_buildings_data_proxy.php";
      
      private const upgradesDataURL:String = "http://alpha.ninjakiwi.com/bmc/data_scripts/proxies/upgrades_data_proxy.php";
      
      private const buildingUpgradesDataURL:String = "http://alpha.ninjakiwi.com/bmc/data_scripts/proxies/building_upgrades_data_proxy.php";
      
      private const monkeytownXpLevelDataURL:String = "http://alpha.ninjakiwi.com/bmc/data_scripts/proxies/monkeytown_xp_levels_data_proxy.php";
      
      private const monkeytownTerrainTypeDataURL:String = "http://alpha.ninjakiwi.com/bmc/data_scripts/proxies/terrain_types.php";
      
      private const configDataURL:String = "http://alpha.ninjakiwi.com/bmc/data_scripts/proxies/config.php";
      
      private const specialItemsDataURL:String = "http://alpha.ninjakiwi.com/bmc/data_scripts/proxies/special_items_data_proxy.php";
      
      private const cacheRequestURL:String = "http://alpha.ninjakiwi.com/monkeytown_data/cache/cache_json.php";
      
      private const cacheJSONDataURL:String = "http://alpha.ninjakiwi.com/monkeytown_data/cache/json_data.json";
      
      private const firstTimeTriggerDataURL:String = "http://alpha.ninjakiwi.com/bmc/data_scripts/proxies/first_time_triggers_proxy.php";
      
      private const terrainSpecialPropertiesURL:String = "http://alpha.ninjakiwi.com/bmc/data_scripts/proxies/terrain_special_properties.php";
      
      private const terrainDifficultyCurveURL:String = "http://alpha.ninjakiwi.com/bmc/data_scripts/proxies/terrain_difficulty_curve.php";
      
      private const questDataURL:String = "http://alpha.ninjakiwi.com/bmc/data_scripts/proxies/quest_data.php";
      
      private const pvpBuildingsDataURL:String = "http://alpha.ninjakiwi.com/bmc/data_scripts/proxies/pvp_buildings_data_proxy.php";
      
      private const bloonResearchLabUpgradesURL:String = "http://alpha.ninjakiwi.com/bmc/data_scripts/proxies/bloon_research_lab_upgrades.php";
      
      private const terrainTowerRestrictionsDataURL:String = "http://alpha.ninjakiwi.com/bmc/data_scripts/proxies/terrain_restrictions_data.php";
      
      private const bankUpgradeTiersURL:String = "http://alpha.ninjakiwi.com/bmc/data_scripts/proxies/bank_upgrade_tiers.php";
      
      private const specialMissionsURL:String = "http://alpha.ninjakiwi.com/bmc/data_scripts/proxies/special_missions.php";
      
      private const myMonkeysURL:String = "http://alpha.ninjakiwi.com/bmc/data_scripts/proxies/my_monkeys_proxy.php";
      
      private const achievementsURL:String = "http://alpha.ninjakiwi.com/bmc/data_scripts/proxies/achievements_data.php";
      
      private const monkeyKnowledgeURL:String = "http://alpha.ninjakiwi.com/bmc/data_scripts/proxies/monkey_knowledge.php";
      
      private const eventsDataURL:String = "http://alpha.ninjakiwi.com/bmc/data_scripts/proxies/events_data_proxy.php";
      
      private const bananaFarmUpgradeTiersURL:String = "http://alpha.ninjakiwi.com/bmc/data_scripts/proxies/banana_farm_upgrade_tiers.php";
      
      public var bloonariusSpawnData:Object = null;
      
      public var bossAttackCostData:Object = null;
      
      public var buildingData:Object = null;
      
      public var upgradeBuildingData:Object = null;
      
      public var specialBuildingsData:Object = null;
      
      public var upgradeData:Object = null;
      
      public var buildingUpgradeData:Object = null;
      
      public var monkeytownXpLevelData:Object = null;
      
      public var terrainData:Object = null;
      
      public var configData:Object = null;
      
      public var specialItems:Object = null;
      
      public var firstTimeTriggerData:Object = null;
      
      public var terrainSpecialProperties:Object = null;
      
      public var terrainDifficultyCurve:Object = null;
      
      public var questData:Object = null;
      
      public var pvpBuildingsData:Object = null;
      
      public var premiumBuildingsData:Object = null;
      
      public var bloonResearchLabUpgrades:Object = null;
      
      public var terrainTowerRestrictionsData:Object = null;
      
      public var bankUpgradeTiers:Object = null;
      
      public var specialMissions:Object = null;
      
      public var myMonkeys:Object = null;
      
      public var achievements:Object = null;
      
      public var monkeyKnowledge:Object = null;
      
      public var eventsData:Object = null;
      
      public var bananaFarmUpgradeTiers:Object = null;
      
      private var _loadQueue:Array;
      
      public var queueIndex:int = 0;
      
      public const dataBeginLoadingItemSignal:Signal = new Signal();
      
      public const dataLoadedSignal:Signal = new Signal();
      
      public const dataLoadFailedSignal:Signal = new Signal();
      
      private const JsonData:Class = RemoteDataManager_JsonData;
      
      public function RemoteDataManager()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         this._loadQueue = [new QueueItemDefinition(this.bananaFarmUpgradeTiersURL,"bananaFarmUpgradeTiers",GoogleSpreadsheetTool.NAMED_ITEMS_WITH_SUPPLIED_TYPES),new QueueItemDefinition(this.bloonariusSpawnDataURL,"bloonariusSpawnData",GoogleSpreadsheetTool.TABLE_WITH_SUPPLIED_TYPES),new QueueItemDefinition(this.bossAttackCostDataURL,"bossAttackCostData",GoogleSpreadsheetTool.TABLE_WITH_SUPPLIED_TYPES),new QueueItemDefinition(this.specialMissionsURL,"specialMissions",GoogleSpreadsheetTool.NAMED_ITEMS_WITH_SUPPLIED_TYPES),new QueueItemDefinition(this.eventsDataURL,"eventsData",GoogleSpreadsheetTool.NAMED_ITEMS_WITH_SUPPLIED_TYPES),new QueueItemDefinition(this.buildingDataURL,"buildingData",GoogleSpreadsheetTool.NAMED_ITEMS_WITH_SUPPLIED_TYPES),new QueueItemDefinition(this.upgradeBuildingsURL,"upgradeBuildingData",GoogleSpreadsheetTool.NAMED_ITEMS_WITH_SUPPLIED_TYPES),new QueueItemDefinition(this.specialBuildingsURL,"specialBuildingsData",GoogleSpreadsheetTool.NAMED_ITEMS_WITH_SUPPLIED_TYPES),new QueueItemDefinition(this.upgradesDataURL,"upgradeData",GoogleSpreadsheetTool.NAMED_ITEMS_WITH_SUPPLIED_TYPES),new QueueItemDefinition(this.buildingUpgradesDataURL,"buildingUpgradeData",GoogleSpreadsheetTool.NAMED_ITEMS_WITH_SUPPLIED_TYPES),new QueueItemDefinition(this.monkeytownXpLevelDataURL,"monkeytownXpLevelData",GoogleSpreadsheetTool.TABLE_WITH_SUPPLIED_TYPES),new QueueItemDefinition(this.monkeytownTerrainTypeDataURL,"terrainData",GoogleSpreadsheetTool.NAMED_ITEMS_WITH_SUPPLIED_TYPES),new QueueItemDefinition(this.configDataURL,"configData",GoogleSpreadsheetTool.NAMED_ITEMS_WITH_SUPPLIED_TYPES),new QueueItemDefinition(this.specialItemsDataURL,"specialItems",GoogleSpreadsheetTool.NAMED_ITEMS_WITH_SUPPLIED_TYPES),new QueueItemDefinition(this.firstTimeTriggerDataURL,"firstTimeTriggerData",GoogleSpreadsheetTool.NAMED_ITEMS_WITH_SUPPLIED_TYPES),new QueueItemDefinition(this.terrainSpecialPropertiesURL,"terrainSpecialProperties",GoogleSpreadsheetTool.NAMED_ITEMS_WITH_SUPPLIED_TYPES),new QueueItemDefinition(this.terrainDifficultyCurveURL,"terrainDifficultyCurve",GoogleSpreadsheetTool.TABLE_WITH_SUPPLIED_TYPES),new QueueItemDefinition(this.questDataURL,"questData",GoogleSpreadsheetTool.NAMED_ITEMS_WITH_SUPPLIED_TYPES),new QueueItemDefinition(this.pvpBuildingsDataURL,"pvpBuildingsData",GoogleSpreadsheetTool.NAMED_ITEMS_WITH_SUPPLIED_TYPES),new QueueItemDefinition(this.premiumBuildingsURL,"premiumBuildingsData",GoogleSpreadsheetTool.NAMED_ITEMS_WITH_SUPPLIED_TYPES),new QueueItemDefinition(this.bloonResearchLabUpgradesURL,"bloonResearchLabUpgrades",GoogleSpreadsheetTool.TABLE_WITH_SUPPLIED_TYPES),new QueueItemDefinition(this.terrainTowerRestrictionsDataURL,"terrainTowerRestrictionsData",GoogleSpreadsheetTool.NAMED_ITEMS_WITH_SUPPLIED_TYPES),new QueueItemDefinition(this.bankUpgradeTiersURL,"bankUpgradeTiers",GoogleSpreadsheetTool.NAMED_ITEMS_WITH_SUPPLIED_TYPES),new QueueItemDefinition(this.myMonkeysURL,"myMonkeys",GoogleSpreadsheetTool.NAMED_ITEMS_WITH_SUPPLIED_TYPES),new QueueItemDefinition(this.achievementsURL,"achievements",GoogleSpreadsheetTool.NAMED_ITEMS_WITH_SUPPLIED_TYPES),new QueueItemDefinition(this.monkeyKnowledgeURL,"monkeyKnowledge",GoogleSpreadsheetTool.NAMED_ITEMS_WITH_SUPPLIED_TYPES)];
      }
      
      public function loadCachedData() : void
      {
         var loader:URLLoader = new URLLoader();
         loader.addEventListener(Event.COMPLETE,this.onCachedDataLoaded);
         loader.addEventListener(IOErrorEvent.IO_ERROR,function(param1:IOErrorEvent):void
         {
            param1.currentTarget.removeEventListener(param1.type,arguments.callee);
            dataLoadFailedSignal.dispatch();
         });
         this.dataBeginLoadingItemSignal.dispatch("Loading cached data...");
         loader.load(new URLRequest(this.cacheJSONDataURL));
      }
      
      private function onCachedDataLoaded(param1:Event) : void
      {
         param1.currentTarget.removeEventListener(param1.type,arguments.callee);
         this.processJSONSavedData(param1.target.data);
         this.dataLoadedSignal.dispatch();
      }
      
      public function processJSONSavedData(param1:String) : void
      {
         var _loc3_:QueueItemDefinition = null;
         var _loc2_:Object = com.maccherone.json.JSON.decode(param1);
         var _loc4_:int = 0;
         while(_loc4_ < this._loadQueue.length)
         {
            _loc3_ = this._loadQueue[_loc4_];
            if(this.hasOwnProperty(_loc3_.storeInVariable))
            {
               this[_loc3_.storeInVariable] = _loc2_[_loc3_.storeInVariable];
            }
            _loc4_++;
         }
      }
      
      public function loadBakedData() : void
      {
         var _loc1_:String = null;
         var _loc2_:ByteArray = new this.JsonData() as ByteArray;
         _loc1_ = _loc2_.readUTFBytes(_loc2_.length);
         this.processJSONSavedData(_loc1_);
         this.dataLoadedSignal.dispatch();
      }
      
      public function startLoadingRemoteData() : void
      {
         this.loadNextCueItem();
      }
      
      private function loadNextCueItem() : void
      {
         var _loc1_:QueueItemDefinition = this._loadQueue[this.queueIndex];
         this.dataBeginLoadingItemSignal.dispatch(_loc1_.storeInVariable);
         GoogleSpreadsheetTool.loadData(_loc1_.url,this.onDataLoaded,_loc1_.format);
      }
      
      private function onDataLoaded(param1:Object) : void
      {
         var _loc2_:QueueItemDefinition = this._loadQueue[this.queueIndex];
         if(this.hasOwnProperty(_loc2_.storeInVariable))
         {
            this[_loc2_.storeInVariable] = param1;
         }
         this.queueIndex++;
         if(this.queueIndex < this._loadQueue.length)
         {
            this.loadNextCueItem();
         }
         else
         {
            this.dataLoadedSignal.dispatch();
         }
      }
      
      public function getDataAsJSON() : String
      {
         var _loc2_:QueueItemDefinition = null;
         var _loc1_:Object = {};
         var _loc3_:int = 0;
         while(_loc3_ < this._loadQueue.length)
         {
            _loc2_ = this._loadQueue[_loc3_];
            if(this.hasOwnProperty(_loc2_.storeInVariable))
            {
               _loc1_[_loc2_.storeInVariable] = this[_loc2_.storeInVariable];
            }
            _loc3_++;
         }
         var _loc4_:String = com.maccherone.json.JSON.encode(_loc1_,true);
         return _loc4_;
      }
      
      public function pushDataToServer(param1:Function = null) : void
      {
         var callback:Function = param1;
         var dataJSON:String = this.getDataAsJSON();
         var loader:URLLoader = new URLLoader();
         var request:URLRequest = new URLRequest(this.cacheRequestURL);
         request.method = URLRequestMethod.POST;
         var variables:URLVariables = new URLVariables();
         variables.json_data = dataJSON;
         request.data = variables;
         loader.addEventListener(Event.COMPLETE,function(param1:Event):void
         {
            param1.currentTarget.removeEventListener(param1.type,arguments.callee);
            if(callback != null)
            {
               callback();
            }
         });
         loader.addEventListener(IOErrorEvent.IO_ERROR,function(param1:IOErrorEvent):void
         {
            param1.currentTarget.removeEventListener(param1.type,arguments.callee);
         });
         loader.load(request);
      }
      
      public function saveDataToFile() : void
      {
         var _loc1_:String = this.getDataAsJSON();
         var _loc2_:FileReference = new FileReference();
         _loc2_.addEventListener(IOErrorEvent.IO_ERROR,this.saveDataToFileIOErrorHandler);
         System.setClipboard("C:\\Work\\mc_git\\bloons-monkey-city-code\\client\\common_code\\ninjakiwi\\monkeyTown\\data\\monkey_town_data.dat");
         _loc2_.save(_loc1_,"monkey_town_data.dat");
      }
      
      private function saveDataToFileIOErrorHandler(param1:IOErrorEvent) : void
      {
      }
   }
}

class QueueItemDefinition
{
    
   
   public var url:String;
   
   public var storeInVariable:String;
   
   public var format:int;
   
   function QueueItemDefinition(param1:String, param2:String, param3:int)
   {
      super();
      this.url = param1;
      this.storeInVariable = param2;
      this.format = param3;
   }
}
