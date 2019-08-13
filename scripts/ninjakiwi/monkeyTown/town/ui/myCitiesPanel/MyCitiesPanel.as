package ninjakiwi.monkeyTown.town.ui.myCitiesPanel
{
   import assets.town.MyCitiesPanelClip;
   import assets.ui.MyCitiesInfoContainer;
   import assets.ui.NewDesertCityPanel;
   import com.greensock.TweenLite;
   import com.lgrey.utils.LGDisplayListUtil;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.utils.clearInterval;
   import flash.utils.getTimer;
   import flash.utils.setInterval;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.sound.MCSound;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.city.CityLoader;
   import ninjakiwi.monkeyTown.town.cityCommon.CityCommonDataManager;
   import ninjakiwi.monkeyTown.town.cityCommon.CityCommonDataSlot;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldViewSignals;
   import ninjakiwi.monkeyTown.town.ui.BuildProgressBar;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.town.ui.contestedTerritory.ContestedTerritoryPanel;
   import ninjakiwi.monkeyTown.town.ui.manageCitiesPanel.CityInformation;
   import ninjakiwi.monkeyTown.ui.HideRevealViewBottomUIPanel;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   import ninjakiwi.sharedFrameAnalyser.AnimationSharedFramesMap;
   import org.osflash.signals.Signal;
   
   public class MyCitiesPanel extends HideRevealViewBottomUIPanel
   {
      
      private static const DELAY_LOAD_INTERVAL:Number = 20000;
      
      private static const TIMER_UPDATE_INTERVAL:Number = 1000;
      
      public static const CITY_ID_GRASS_PASS:int = 0;
      
      public static const CITY_ID_BLOON_DUNES:int = 1;
      
      public static const preGameCityPanelRevealed:Signal = new Signal();
      
      public static const preGameCitySelected:Signal = new Signal();
       
      
      private var _clip:MyCitiesPanelClip;
      
      private var _grassyPassCity:MyCitiesInfoContainer;
      
      private var _bloonDunesCity:MyCitiesInfoContainer;
      
      private var _grassPassCityButton:ButtonControllerBase;
      
      private var _bloonDunesCityButton:ButtonControllerBase;
      
      private var _closeButton:ButtonControllerBase;
      
      private var _desertLockedPanel:NewDesertCityPanel;
      
      private var _desertStartNewCityButton:ButtonControllerBase;
      
      private var _cityInfoList:Vector.<CityInformation>;
      
      private var _attackListGrassyPass:Array;
      
      private var _attackListBloonDunes:Array;
      
      private var _topContainer:DisplayObjectContainer;
      
      private var _bottomContainer:DisplayObjectContainer;
      
      private var _shortestAttackTime:Number;
      
      private var _timeOfLastCityChange:Number;
      
      private var _timeOfLoadCoreWithDelayLoad:Number;
      
      private var _timeOfLastTimerUpdate:Number;
      
      private var _unlockAnimPlayedThisSession:Boolean;
      
      private var _isInDelayLoadPeriod:Boolean;
      
      public function MyCitiesPanel(param1:DisplayObjectContainer, param2:DisplayObjectContainer)
      {
         this._clip = new MyCitiesPanelClip();
         this._grassyPassCity = this._clip.city0;
         this._bloonDunesCity = this._clip.city1;
         this._grassPassCityButton = new ButtonControllerBase(this._clip.cityBtn0);
         this._bloonDunesCityButton = new ButtonControllerBase(this._clip.cityBtn1);
         this._closeButton = new ButtonControllerBase(this._clip.closeButton);
         this._desertLockedPanel = this._clip.desertLockedPanel;
         this._cityInfoList = new Vector.<CityInformation>();
         this._topContainer = param1;
         this._bottomContainer = param2;
         super(this._topContainer);
         addChild(this._clip);
         isModal = true;
         enableDefaultOnResize(this._clip);
         LGDisplayListUtil.getInstance().setPlayStateOfAllChildMovieClips(this,false,true,true);
         this._grassPassCityButton.setClickFunction(this.onGrassPassCitySelected);
         this._bloonDunesCityButton.setClickFunction(this.onBloonDunesCitySelected);
         this._closeButton.setClickFunction(this.hide);
         this._desertLockedPanel.addEventListener("onDesertUnlockAnimComplete",this.onDesertUnlockAnimComplete);
         this._desertLockedPanel.gotoAndStop(1);
         this._desertLockedPanel.lock.gotoAndStop(1);
         MonkeyCityMain.globalResetSignal.remove(this.onReset);
         MonkeyCityMain.globalResetSignal.add(this.onReset);
         WorldViewSignals.buildWorldEndSignal.add(this.onBuildWorldEnd);
         CityCommonDataManager.onDataSynced.add(this.onCityCommonDataSynced);
         ResourceStore.getInstance().townLevelChangedDiffSignal.add(this.onTownLevelChangedSignal);
         this._unlockAnimPlayedThisSession = false;
         this.onReset();
      }
      
      private function onCityCommonDataSynced(... rest) : void
      {
         this.populateInfo(MonkeySystem.getInstance().map.worldIsReady,MonkeySystem.getInstance().city.cityIndex);
      }
      
      private function onTownLevelChangedSignal(param1:int) : void
      {
         if(MonkeySystem.getInstance().city.cityIndex == CITY_ID_GRASS_PASS)
         {
            this._grassyPassCity.levelField.text = ResourceStore.getInstance().townLevel.toString();
         }
         else if(MonkeySystem.getInstance().city.cityIndex == CITY_ID_BLOON_DUNES)
         {
            this._bloonDunesCity.levelField.text = ResourceStore.getInstance().townLevel.toString();
         }
      }
      
      private function onReset() : void
      {
         _container = this._topContainer;
         this._unlockAnimPlayedThisSession = false;
         this._grassyPassCity.attackPending.visible = false;
         this._bloonDunesCity.attackPending.visible = false;
         this._grassyPassCity.townTier.gotoAndStop(1);
         this._bloonDunesCity.townTier.gotoAndStop(1);
         this._desertLockedPanel.gotoAndStop(1);
         this._timeOfLoadCoreWithDelayLoad = -DELAY_LOAD_INTERVAL;
         this._timeOfLastCityChange = -DELAY_LOAD_INTERVAL;
         this._timeOfLastTimerUpdate = 0;
      }
      
      private function onBuildWorldEnd() : void
      {
         _container = this._bottomContainer;
         this._timeOfLastCityChange = getTimer();
         this._isInDelayLoadPeriod = false;
      }
      
      public function populateInfo(param1:Boolean, param2:int = -1) : void
      {
         var _loc3_:CityCommonDataSlot = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         this.buildCityInfoList();
         if(param1 == false)
         {
            preGameCityPanelRevealed.dispatch();
         }
         if(this._cityInfoList.length > CITY_ID_GRASS_PASS)
         {
            _loc3_ = CityCommonDataManager.getInstance().getCitySlotClone(CITY_ID_GRASS_PASS);
            _loc4_ = _loc3_.cityLevel;
            this._attackListGrassyPass = _loc3_.incomingAttacks;
            if(_loc4_ > Constants.MAX_CITY_LEVEL)
            {
               _loc4_ = Constants.MAX_CITY_LEVEL;
            }
            _loc5_ = this.getNumberOfPendingAttacks(_loc3_);
            this._grassyPassCity.attackPending.mapBuildingNotifications.numberField.text = _loc5_.toString();
            this._grassyPassCity.attackPending.visible = _loc5_ != 0;
            this._grassyPassCity.levelField.text = _loc4_.toString();
            this._grassyPassCity.townGrassNameField.text = _loc3_.name;
            this._grassyPassCity.townTier.gotoAndStop(this.calculateTierFromLevel(_loc4_));
         }
         if(this._cityInfoList.length > CITY_ID_BLOON_DUNES)
         {
            _loc3_ = CityCommonDataManager.getInstance().getCitySlotClone(CITY_ID_BLOON_DUNES);
            _loc4_ = _loc3_.cityLevel;
            this._attackListBloonDunes = _loc3_.incomingAttacks;
            if(_loc4_ > Constants.MAX_CITY_LEVEL)
            {
               _loc4_ = Constants.MAX_CITY_LEVEL;
            }
            _loc5_ = this.getNumberOfPendingAttacks(_loc3_);
            this._bloonDunesCity.attackPending.mapBuildingNotifications.numberField.text = _loc5_.toString();
            this._bloonDunesCity.attackPending.visible = _loc5_ != 0;
            this._bloonDunesCity.levelField.text = _loc4_.toString();
            this._bloonDunesCity.townGrassNameField.text = _loc3_.name;
            this._bloonDunesCity.townTier.gotoAndStop(this.calculateTierFromLevel(_loc4_));
            this._desertLockedPanel.visible = false;
         }
         else
         {
            this._desertLockedPanel.visible = true;
         }
         if(param1)
         {
            this._clip.selectCityTitle.visible = false;
            this._clip.myCitiesTitle.visible = true;
            this._closeButton.fadeIn(0);
            if(param2 == CITY_ID_GRASS_PASS)
            {
               this._grassPassCityButton.disableMouseInteraction();
               this._grassPassCityButton.lock(3);
               this._bloonDunesCityButton.enableMouseInteraction();
               this._bloonDunesCityButton.unlock(1);
            }
            else if(param2 == CITY_ID_BLOON_DUNES)
            {
               this._grassPassCityButton.enableMouseInteraction();
               this._grassPassCityButton.unlock(1);
               this._bloonDunesCityButton.disableMouseInteraction();
               this._bloonDunesCityButton.lock(3);
            }
         }
         else
         {
            this._clip.selectCityTitle.visible = true;
            this._clip.myCitiesTitle.visible = false;
            this._closeButton.fadeOut(0);
            this._grassPassCityButton.enableMouseInteraction();
            this._grassPassCityButton.unlock(1);
            this._bloonDunesCityButton.enableMouseInteraction();
            this._bloonDunesCityButton.unlock(1);
         }
      }
      
      private function getNumberOfPendingAttacks(param1:Object) : int
      {
         var _loc4_:int = 0;
         var _loc2_:Number = MonkeySystem.getInstance().getSecureTime();
         var _loc3_:int = 0;
         if(param1.incomingAttacks)
         {
            _loc4_ = 0;
            while(_loc4_ < param1.incomingAttacks.length)
            {
               if(param1.incomingAttacks[_loc4_].hasOwnProperty("timeLeft"))
               {
                  if(param1.incomingAttacks[_loc4_].timeLeft > 0)
                  {
                     _loc3_++;
                  }
               }
               else if(param1.incomingAttacks[_loc4_].hasOwnProperty("expireAt"))
               {
                  if(param1.incomingAttacks[_loc4_].expireAt > _loc2_)
                  {
                     _loc3_++;
                  }
               }
               _loc4_++;
            }
         }
         return _loc3_;
      }
      
      override public function reveal(param1:Number = 0.5) : void
      {
         var time:Number = param1;
         if(PanelManager.getInstance().lock)
         {
            return;
         }
         if(this._cityInfoList.length <= CITY_ID_BLOON_DUNES)
         {
            if(CityCommonDataManager.getInstance().getCitySlotClone(CITY_ID_GRASS_PASS).cityLevel >= Constants.SECOND_CITY_UNLOCK_LEVEL)
            {
               this._bloonDunesCity.visible = false;
               this._bloonDunesCityButton.fadeOut(0);
               if(this._unlockAnimPlayedThisSession == false)
               {
                  this._unlockAnimPlayedThisSession = true;
                  TweenLite.delayedCall(time,function():void
                  {
                     _desertLockedPanel.play();
                     _desertLockedPanel.addEventListener("onDesertUnlockAnimComplete",onDesertUnlockAnimComplete);
                  });
               }
            }
         }
         else
         {
            this._desertLockedPanel.visible = false;
            this._bloonDunesCity.visible = true;
            this._bloonDunesCityButton.fadeIn(0);
         }
         removeEventListener(Event.ENTER_FRAME,this.onFrameEnter);
         addEventListener(Event.ENTER_FRAME,this.onFrameEnter);
         MCSound.getInstance().playSound(MCSound.OPEN_PANEL);
         super.reveal(time);
      }
      
      private function onFrameEnter(param1:Event) : void
      {
         if(getTimer() - this._timeOfLastTimerUpdate > TIMER_UPDATE_INTERVAL)
         {
            this.updateTimes();
            this._timeOfLastTimerUpdate = getTimer();
         }
      }
      
      private function updateTimes() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         if(this._cityInfoList.length < 1)
         {
            this._grassyPassCity.attackPending.visible = false;
            return;
         }
         if(this._cityInfoList[CITY_ID_GRASS_PASS].slot.incomingAttacks.length != 0)
         {
            _loc1_ = this.getTimeRemainingOnLowestNonExpiredAttack(CITY_ID_GRASS_PASS);
            this._grassyPassCity.attackPending.visible = _loc1_ > 0;
            this._grassyPassCity.attackPending.timeRemaining.text = this.getTimeStringHoursFromUnixTime(_loc1_);
         }
         else
         {
            this._grassyPassCity.attackPending.visible = false;
         }
         if(this._cityInfoList.length < 2)
         {
            this._bloonDunesCity.attackPending.visible = false;
            return;
         }
         if(this._cityInfoList[CITY_ID_BLOON_DUNES].slot.incomingAttacks.length != 0)
         {
            _loc2_ = this.getTimeRemainingOnLowestNonExpiredAttack(CITY_ID_BLOON_DUNES);
            this._bloonDunesCity.attackPending.visible = _loc2_ > 0;
            this._bloonDunesCity.attackPending.timeRemaining.text = this.getTimeStringHoursFromUnixTime(_loc2_);
         }
         else
         {
            this._bloonDunesCity.attackPending.visible = false;
         }
      }
      
      private function getTimeRemainingOnLowestNonExpiredAttack(param1:int) : Number
      {
         var _loc2_:Array = null;
         var _loc6_:Number = NaN;
         if(param1 == CITY_ID_GRASS_PASS)
         {
            _loc2_ = this._attackListGrassyPass;
         }
         else if(param1 == CITY_ID_BLOON_DUNES)
         {
            _loc2_ = this._attackListBloonDunes;
         }
         if(_loc2_.length == 0)
         {
            return 0;
         }
         var _loc3_:Number = 1000 * 60 * 60 * 24;
         var _loc4_:Number = _loc3_;
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc6_ = this.getTimeLeftOfAttack(_loc2_[_loc5_]);
            if(_loc6_ >= 0)
            {
               if(_loc6_ > 0 && _loc6_ < _loc4_)
               {
                  _loc4_ = _loc6_;
               }
            }
            _loc5_++;
         }
         if(_loc4_ == _loc3_)
         {
            return 0;
         }
         return _loc4_;
      }
      
      private function getTimeLeftOfAttack(param1:Object) : Number
      {
         var _loc4_:Number = NaN;
         var _loc2_:Number = 0;
         var _loc3_:Number = MonkeySystem.getInstance().getSecureTime();
         if(param1.hasOwnProperty("timeLeft"))
         {
            _loc4_ = getTimer() - CityCommonDataManager.getInstance().timestampOfDataPopulation;
            _loc2_ = param1.timeLeft - _loc4_;
         }
         else if(param1.hasOwnProperty("expireAt"))
         {
            _loc2_ = param1.expireAt - _loc3_;
         }
         else
         {
            _loc2_ = 0;
         }
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         return _loc2_;
      }
      
      private function getTimeStringHoursFromUnixTime(param1:Number) : String
      {
         param1 = param1 < 0?Number(0):Number(param1);
         var _loc2_:String = new String();
         var _loc3_:Date = new Date();
         _loc3_.setTime(param1);
         var _loc4_:String = _loc3_.hoursUTC < 10?String("0" + _loc3_.hoursUTC):String(_loc3_.hoursUTC);
         var _loc5_:String = _loc3_.minutesUTC < 10?String("0" + _loc3_.minutesUTC):String(_loc3_.minutesUTC);
         var _loc6_:String = _loc3_.secondsUTC < 10?String("0" + _loc3_.secondsUTC):String(_loc3_.secondsUTC);
         _loc2_ = _loc4_ + ":" + _loc5_ + ":" + _loc6_;
         return _loc2_;
      }
      
      private function onDesertUnlockAnimComplete(param1:Event) : void
      {
         this._desertStartNewCityButton = new ButtonControllerBase(this._desertLockedPanel.startNewDesertCityBtn);
         this._desertStartNewCityButton.setClickFunction(this.onBloonDunesCitySelected);
      }
      
      public function onGrassPassCitySelected() : void
      {
         this.citySelected(CITY_ID_GRASS_PASS);
      }
      
      public function onBloonDunesCitySelected() : void
      {
         this.citySelected(CITY_ID_BLOON_DUNES);
      }
      
      private function citySelected(param1:int) : void
      {
         var dataFormatDelayIntervalID:uint = 0;
         var requiresDataFormatUpdateDelay:Boolean = false;
         var citySwitchDelayIntervalID:uint = 0;
         var requiresCitySwitchDelay:Boolean = false;
         var dataFormatDelayStartingTime:Number = NaN;
         var dataFormatDelayEndingTime:Number = NaN;
         var citySwitchDelayStartingTime:Number = NaN;
         var citySwitchDelayEndingTime:Number = NaN;
         var cityID:int = param1;
         var transitionTime:Number = 1000;
         this.hide(transitionTime);
         BuildProgressBar.instance.fadeInEffects();
         if(this._isInDelayLoadPeriod)
         {
            return;
         }
         var timeSinceLoadCoreWithDelayLoad:Number = Number(getTimer()) - this._timeOfLoadCoreWithDelayLoad;
         requiresDataFormatUpdateDelay = timeSinceLoadCoreWithDelayLoad <= DELAY_LOAD_INTERVAL;
         if(requiresDataFormatUpdateDelay)
         {
            this._isInDelayLoadPeriod = true;
            transitionTime = DELAY_LOAD_INTERVAL - timeSinceLoadCoreWithDelayLoad;
            GameSignals.REPORT_GAME_LAUNCH_STATE.dispatch("Updating data: 0%");
            dataFormatDelayStartingTime = getTimer();
            dataFormatDelayEndingTime = dataFormatDelayStartingTime + transitionTime;
            dataFormatDelayIntervalID = setInterval(function():void
            {
               var _loc1_:* = (getTimer() - dataFormatDelayStartingTime) / (dataFormatDelayEndingTime - dataFormatDelayStartingTime);
               GameSignals.REPORT_GAME_LAUNCH_STATE.dispatch("Updating data: " + int(_loc1_ * 100) + "%");
            },100);
         }
         var timeSinceLastCitySwitch:Number = Number(getTimer()) - this._timeOfLastCityChange;
         requiresCitySwitchDelay = timeSinceLastCitySwitch <= DELAY_LOAD_INTERVAL;
         if(requiresCitySwitchDelay)
         {
            this._isInDelayLoadPeriod = true;
            transitionTime = DELAY_LOAD_INTERVAL - timeSinceLastCitySwitch;
            citySwitchDelayStartingTime = getTimer();
            citySwitchDelayEndingTime = citySwitchDelayStartingTime + transitionTime;
            citySwitchDelayIntervalID = setInterval(function():void
            {
               var _loc1_:* = (getTimer() - citySwitchDelayStartingTime) / (citySwitchDelayEndingTime - citySwitchDelayStartingTime);
               GameSignals.REPORT_GAME_LAUNCH_STATE.dispatch("Preparing your adventure... " + int(_loc1_ * 100) + "%");
            },100);
         }
         var transitionTimeSeconds:Number = transitionTime / 1000;
         if(transitionTimeSeconds < 1)
         {
            transitionTimeSeconds = 1;
         }
         TweenLite.delayedCall(transitionTimeSeconds,function():void
         {
            if(requiresDataFormatUpdateDelay)
            {
               clearInterval(dataFormatDelayIntervalID);
            }
            if(requiresCitySwitchDelay)
            {
               clearInterval(citySwitchDelayIntervalID);
            }
            if(CityCommonDataManager.getInstance().numberOfCities > cityID)
            {
               CityLoader.loadCity(CityCommonDataManager.getInstance().getCitySlotClone(cityID));
            }
            else
            {
               BuildProgressBar.instance.hide(0.1);
               TownUI.getInstance().newCityPanel.showNewCity();
            }
         });
         preGameCitySelected.dispatch();
      }
      
      override public function hide(param1:Number = 0.5) : void
      {
         removeEventListener(Event.ENTER_FRAME,this.onFrameEnter);
         super.hide(param1);
      }
      
      private function buildCityInfoList() : void
      {
         var _loc3_:CityInformation = null;
         var _loc1_:int = CityCommonDataManager.getInstance().numberOfCities;
         this._cityInfoList.length = 0;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = new CityInformation();
            _loc3_.syncToSaveSlot(CityCommonDataManager.getInstance().getCitySlotClone(_loc2_));
            this._cityInfoList.push(_loc3_);
            _loc2_++;
         }
      }
      
      private function calculateTierFromLevel(param1:int) : int
      {
         var _loc2_:int = 0;
         while(_loc2_ < ContestedTerritoryPanel.CONTESTED_TERRITORY_LEVEL_TIERS.length)
         {
            if(param1 < ContestedTerritoryPanel.CONTESTED_TERRITORY_LEVEL_TIERS[_loc2_])
            {
               return _loc2_ + 1;
            }
            _loc2_++;
         }
         return ContestedTerritoryPanel.CONTESTED_TERRITORY_LEVEL_TIERS.length;
      }
      
      public function get unlockAnimPlayedThisSession() : Boolean
      {
         return this._unlockAnimPlayedThisSession;
      }
      
      public function set timeOfLoadCoreWithDelayLoad(param1:Number) : void
      {
         this._timeOfLoadCoreWithDelayLoad = param1;
      }
   }
}
