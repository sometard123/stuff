package ninjakiwi.monkeyTown.town.quests
{
   import assets.ui.ZomgRadioGroupClip;
   import com.codecatalyst.promise.Promise;
   import com.greensock.TweenLite;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.pvp.PvPTimerManager;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.data.BuildingData;
   import ninjakiwi.monkeyTown.town.gameEvents.ui.MilestoneRewardInfoBox;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.quests.task.Quest;
   import ninjakiwi.monkeyTown.town.townMap.TownMap;
   import ninjakiwi.monkeyTown.town.ui.QuestCompletePanel;
   import ninjakiwi.monkeyTown.town.ui.QuestsUI;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.utils.DefinitionPopulator;
   import ninjakiwi.monkeyTown.utils.ErrorReporter;
   import org.osflash.signals.Signal;
   
   public class QuestManager
   {
      
      public static const questsStateChanged:Signal = new Signal();
      
      private static var instance:QuestManager;
       
      
      private const _resourceStore:ResourceStore = ResourceStore.getInstance();
      
      private const _system:MonkeySystem = MonkeySystem.getInstance();
      
      private const _buildingData:BuildingData = BuildingData.getInstance();
      
      private var _map:TownMap;
      
      private var _questUI:QuestsUI;
      
      private var _activatedQuestQueue:Vector.<Quest>;
      
      public function QuestManager(param1:SingletonEnforcer#674)
      {
         this._activatedQuestQueue = new Vector.<Quest>();
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use QuestManager.getInstance() instead of new.");
         }
         MonkeyCityMain.globalResetSignal.add(this.onReset);
      }
      
      public static function getInstance() : QuestManager
      {
         if(instance == null)
         {
            instance = new QuestManager(new SingletonEnforcer#674());
         }
         return instance;
      }
      
      public function initialiseBaseData(param1:Object) : void
      {
         var _loc3_:Quest = null;
         var _loc4_:Object = null;
         var _loc2_:DefinitionPopulator = new DefinitionPopulator();
         var _loc5_:int = 0;
         while(_loc5_ < QuestData.QUESTS.length)
         {
            _loc3_ = QuestData.QUESTS[_loc5_];
            _loc4_ = param1[_loc3_.id];
            _loc4_.cityAvailability = JSON.parse(_loc4_.cityAvailability);
            if(_loc4_ !== null)
            {
               _loc2_.populateDefinitionFromObject(_loc3_,_loc4_);
            }
            _loc3_.preSetPrevQuest();
            _loc5_++;
         }
      }
      
      private function onReset() : void
      {
         var _loc2_:Quest = null;
         this._resourceStore.townLevelChangedDiffSignal.remove(this.townLevelChanged);
         MonkeyCityMain.getInstance().signals.btdGameWonSignal.remove(this.checkActivatedQuestQueue);
         Building.buildingWasCompletedSignal.remove(this.buildingComplete);
         Quest.NEED_TO_REFRESH_LIST_SIGNAL.remove(this.needToRefreshList);
         QuestCompletePanel.collectButtonClickedSignal.remove(this.collectReward);
         var _loc1_:int = 0;
         while(_loc1_ < QuestData.QUESTS.length)
         {
            _loc2_ = QuestData.QUESTS[_loc1_];
            if(_loc2_.finishedSignal != null)
            {
               _loc2_.finishedSignal.remove(this.checkFinishedQuest);
            }
            _loc1_++;
         }
         if(this._questUI != null)
         {
            this._questUI.reset();
         }
         this.deactivateQuests();
      }
      
      public function init(param1:TownMap) : void
      {
         this._map = param1;
         this._questUI = TownUI.getInstance().questsUI;
         MonkeyCityMain.getInstance().signals.loadCityAllCompleteSignal.add(this.onMonkeyTownReadySignalHandler);
         MonkeyCityMain.getInstance().signals.buildWorldStartSignal.add(this.onBuildWorldStartSignalSignalHandler);
      }
      
      private function onBuildWorldStartSignalSignalHandler() : void
      {
         this._questUI.reset();
      }
      
      private function onMonkeyTownReadySignalHandler() : void
      {
         var _loc1_:Quest = null;
         var _loc2_:int = 0;
         while(_loc2_ < QuestData.QUESTS.length)
         {
            _loc1_ = QuestData.QUESTS[_loc2_];
            if(_loc1_.finishedSignal != null)
            {
               _loc1_.finishedSignal.removeAll();
               _loc1_.finishedSignal.add(this.checkFinishedQuest);
            }
            _loc2_++;
         }
         TweenLite.delayedCall(1,this.delayedSignalHandler);
      }
      
      private function delayedSignalHandler() : void
      {
         this.checkActivatedQuestQueue(true);
         this._resourceStore.townLevelChangedDiffSignal.add(this.townLevelChanged);
         MonkeyCityMain.getInstance().signals.btdGameWonSignal.add(this.checkActivatedQuestQueue);
         Building.buildingWasCompletedSignal.add(this.buildingComplete);
         Quest.NEED_TO_REFRESH_LIST_SIGNAL.add(this.needToRefreshList);
         QuestCompletePanel.collectButtonClickedSignal.add(this.collectReward);
      }
      
      private function townLevelChanged(param1:int) : void
      {
         this.checkActivatedQuestQueue();
      }
      
      private function buildingComplete(param1:Building) : void
      {
         this.checkActivatedQuestQueue();
      }
      
      private function needToRefreshList(param1:Quest) : void
      {
         this.checkActivatedQuestQueue();
      }
      
      private function checkActivatedQuestQueue(param1:Boolean = false) : void
      {
         if(param1)
         {
            this.delayCall(param1);
         }
         else
         {
            PvPTimerManager.getInstance().registerTimer("questTimer",10,this.delayCall);
         }
      }
      
      private function delayCall(param1:Boolean = false) : void
      {
         var _loc2_:Quest = null;
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc5_:int = this._system.city.cityIndex;
         var _loc6_:int = 0;
         while(_loc6_ < QuestData.QUESTS.length)
         {
            _loc2_ = QuestData.QUESTS[_loc6_];
            if(_loc2_.isAvailableToCity(_loc5_))
            {
               if(_loc2_.isDeactivated() == true)
               {
                  if(this._resourceStore.townLevel >= _loc2_.reachingMCL)
                  {
                     if(_loc2_.prevQuest == null || _loc2_.prevQuest.isAchieved() || _loc2_.prevQuest.isReceived())
                     {
                        _loc3_ = false;
                        if(_loc2_.extraCondition == Quest.EXTRA_NONE)
                        {
                           _loc3_ = true;
                        }
                        else
                        {
                           switch(_loc2_.extraCondition)
                           {
                              case Quest.EXTRA_TREASURE_VISIBLE:
                                 if(this._map.hasTreasuresVisible() == true)
                                 {
                                    _loc3_ = true;
                                 }
                                 break;
                              case Quest.EXTRA_DEFENDING_FINISHED:
                                 break;
                              case Quest.EXTRA_HAVE_MONKEY_ACADEMY:
                                 if(this._system.city.buildingManager.getCompletedBuildingCount(this._buildingData.MONKEY_ACADEMY.id).complete > 0)
                                 {
                                    _loc3_ = true;
                                 }
                                 break;
                              case Quest.EXTRA_HAVE_MONKEY_ACADEMY_AND_BOOMERANG_HUT:
                                 if(this._system.city.buildingManager.getCompletedBuildingCount(this._buildingData.MONKEY_ACADEMY.id).complete > 0 && this._system.city.buildingManager.getCompletedBuildingCount(this._buildingData.BOOMERANG_HUT.id).complete > 0)
                                 {
                                    _loc3_ = true;
                                 }
                                 break;
                              case Quest.EXTRA_SPECIAL_TERRAIN_VISIBLE:
                                 if(this._map.hasSpecialTerrainVisible() == true)
                                 {
                                    _loc3_ = true;
                                 }
                           }
                        }
                        if(_loc3_ == true)
                        {
                           if(_loc2_.checkPreAchieved() == false)
                           {
                              _loc4_ = true;
                              this._activatedQuestQueue.push(_loc2_);
                              _loc2_.activate();
                              this._questUI.addQuest(_loc2_,param1);
                           }
                           else
                           {
                              _loc2_.setAsAchieved();
                              this.checkFinishedQuest(_loc2_);
                           }
                        }
                     }
                  }
               }
            }
            _loc6_++;
         }
         if(_loc4_)
         {
            this._questUI.refreshQuests(param1);
         }
      }
      
      private function checkFinishedQuest(param1:Quest) : void
      {
         var _loc2_:int = this._activatedQuestQueue.indexOf(param1);
         if(_loc2_ != -1)
         {
            this._activatedQuestQueue.splice(_loc2_,1);
         }
         this._questUI.finishQuest(param1);
      }
      
      private function collectReward(param1:Quest) : void
      {
         if(param1 != null)
         {
            param1.receiveReward();
            questsStateChanged.dispatch();
            this.checkActivatedQuestQueue();
         }
      }
      
      private function cloneObject(param1:Object) : Object
      {
         return JSON.parse(JSON.stringify(param1));
      }
      
      public function populateFromSaveData(param1:Object) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:int = 0;
         while(_loc2_ < QuestData.QUESTS.length)
         {
            if(param1.hasOwnProperty(QuestData.QUESTS[_loc2_].id) && param1[QuestData.QUESTS[_loc2_].id] == true)
            {
               if(!QuestData.QUESTS[_loc2_].isAvailableToCity(MonkeySystem.getInstance().city.cityIndex))
               {
               }
               QuestData.QUESTS[_loc2_].setAsReceived();
            }
            else
            {
               if(param1.hasOwnProperty(QuestData.QUESTS[_loc2_].id) && QuestData.QUESTS[_loc2_].isAvailableToCity(MonkeySystem.getInstance().city.cityIndex) && param1[QuestData.QUESTS[_loc2_].id] == true)
               {
               }
               QuestData.QUESTS[_loc2_].deactivate();
            }
            _loc2_++;
         }
         QuestCounter.getInstance().loadFromDB(param1.counter);
      }
      
      public function deactivateQuests() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < QuestData.QUESTS.length)
         {
            QuestData.QUESTS[_loc1_].deactivate();
            _loc1_++;
         }
      }
      
      public function getSaveData() : Object
      {
         var _loc1_:Object = new Object();
         var _loc2_:int = 0;
         while(_loc2_ < QuestData.QUESTS.length)
         {
            if(QuestData.QUESTS[_loc2_].isReceived())
            {
               _loc1_[QuestData.QUESTS[_loc2_].id] = true;
            }
            _loc2_++;
         }
         var _loc3_:Object = QuestCounter.getInstance().getCounterData();
         if(_loc3_ != null)
         {
            _loc1_["counter"] = _loc3_;
         }
         return _loc1_;
      }
      
      public function resetState() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < QuestData.QUESTS.length)
         {
            QuestData.QUESTS[_loc1_].deactivate();
            _loc1_++;
         }
         QuestCounter.getInstance().loadFromDB({});
      }
      
      public function logData(param1:Boolean = true) : void
      {
         ErrorReporter.deep(this.getSaveData(),param1);
      }
   }
}

class SingletonEnforcer#674
{
    
   
   function SingletonEnforcer#674()
   {
      super();
   }
}
