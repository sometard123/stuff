package ninjakiwi.monkeyTown.pvp
{
   import com.codecatalyst.promise.Promise;
   import flash.net.URLRequest;
   import ninjakiwi.link.URLLoaderPromise;
   import ninjakiwi.link.User;
   import ninjakiwi.monkeyTown.analytics.ErrorMessageTracking;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.contestedTerritory.ContestPanelHelper;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldViewSignals;
   import ninjakiwi.monkeyTown.town.quests.QuestCounter;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   
   public class Pacifist
   {
      
      public static var TEST_ERROR_REPORT:Boolean = false;
      
      private static const PACIFIST_MODE_TIMER_NAME:String = "pacifistModeTimer";
      
      private static const PACIFIST_MODE_TIME_OF_LAST_SENT_ATTACK:String = "pacifistModeTimeOfLastSentAttack";
      
      private static const PACIFIST_MODE_TIME_OF_LAST_POPUP:String = "pacifistModeTimeOfLastPopup";
      
      private static const PACIFIST_MODE_TIME_OF_UPDATE_FOR_ERROR_REPORT:String = "pacifistModeTimeOfAttackForErrorReport";
      
      private static const PACIFIST_MODE_TIME_OF_LAST_PACIFIST_UPDATE:String = "pacifistModeTimeOfLastUpdate";
      
      public static const MAX_TIME_UNTIL_PACIFIST:Number = 3 * 24 * 60 * 60 * 1000;
      
      private static const ATTACK_SENT_BUFFER_PERIOD:Number = 16 * 60 * 1000;
       
      
      private var _timestampOfEnterBufferPeriod:Number = 0;
      
      public function Pacifist()
      {
         super();
         PvPSignals.pvpDataUpdatedSignal.add(this.onPvPDataUpdatedSignal);
         ResourceStore.getInstance().honourChangedDiffSignal.add(this.onHonourChanged);
         PvPSignals.sendMVMAttackSucceeded.add(this.onSendMvMAttackSucceeded);
         WorldViewSignals.buildWorldStartSignal.add(this.onReset);
      }
      
      private function onReset() : void
      {
         this._timestampOfEnterBufferPeriod = MonkeySystem.getInstance().getSecureTime() - ATTACK_SENT_BUFFER_PERIOD;
      }
      
      private function onPvPDataUpdatedSignal(param1:Object, param2:Object, param3:Object) : void
      {
         this.checkPacifistMode(param1,param2,param3);
      }
      
      private function checkPacifistMode(param1:Object, param2:Object, param3:Object) : void
      {
         PvPSignals.updatePacifistModeUI.dispatch(false);
         var _loc4_:Number = MonkeySystem.getInstance().getSecureTime() - this._timestampOfEnterBufferPeriod;
         if(_loc4_ < ATTACK_SENT_BUFFER_PERIOD)
         {
            return;
         }
         if(ResourceStore.getInstance().honour >= Constants.PACIFIST_HONOR_THRESHOLD)
         {
            return;
         }
         this.validityCheck(param1,param2,param3);
         if(TimeUntilPacifistTracker.getTimeUntilPacifist > 0)
         {
            PvPTimerManager.getInstance().registerTimer(PACIFIST_MODE_TIMER_NAME,TimeUntilPacifistTracker.getTimeUntilPacifist,this.onPacifistTimePassed);
         }
         else
         {
            this.onPacifistTimePassed();
         }
      }
      
      private function onPacifistTimePassed() : void
      {
         if(this.canPopUpPanelForLastAttack())
         {
            PanelManager.getInstance().showPanel(TownUI.getInstance().pacifistModePanel);
         }
         else
         {
            PvPSignals.updatePacifistModeUI.dispatch(true);
         }
      }
      
      private function canPopUpPanelForLastAttack() : Boolean
      {
         var _loc4_:Number = NaN;
         var _loc1_:Number = QuestCounter.getInstance().getCustomValue(PACIFIST_MODE_TIME_OF_LAST_SENT_ATTACK) as Number;
         var _loc2_:Number = QuestCounter.getInstance().getCustomValue(PACIFIST_MODE_TIME_OF_LAST_POPUP) as Number;
         if(_loc1_ == 0 && _loc2_ == 0)
         {
            _loc4_ = MonkeySystem.getInstance().getSecureTime();
            QuestCounter.getInstance().setCustomValue(PACIFIST_MODE_TIME_OF_LAST_SENT_ATTACK,_loc4_);
            QuestCounter.getInstance().setCustomValue(PACIFIST_MODE_TIME_OF_LAST_POPUP,_loc4_);
            return true;
         }
         var _loc3_:* = _loc1_ != _loc2_;
         if(_loc3_)
         {
            QuestCounter.getInstance().setCustomValue(PACIFIST_MODE_TIME_OF_LAST_POPUP,_loc1_);
         }
         return _loc3_;
      }
      
      private function onHonourChanged(... rest) : void
      {
         if(ResourceStore.getInstance().honour >= Constants.PACIFIST_HONOR_THRESHOLD)
         {
            PvPSignals.updatePacifistModeUI.dispatch(false);
            PvPTimerManager.getInstance().deleteTimer(PACIFIST_MODE_TIMER_NAME);
         }
      }
      
      private function onSendMvMAttackSucceeded(... rest) : void
      {
         var _loc2_:Number = MonkeySystem.getInstance().getSecureTime();
         QuestCounter.getInstance().setCustomValue(PACIFIST_MODE_TIME_OF_LAST_SENT_ATTACK,_loc2_);
         this._timestampOfEnterBufferPeriod = _loc2_;
         this.updateTimeOfLastPacifistModeUpdate(_loc2_);
      }
      
      public function updateTimeOfLastPacifistModeUpdate(param1:Number) : void
      {
         QuestCounter.getInstance().setCustomValue(PACIFIST_MODE_TIME_OF_LAST_PACIFIST_UPDATE,param1);
      }
      
      private function validityCheck(param1:Object, param2:Object, param3:Object) : Boolean
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         _loc4_ = QuestCounter.getInstance().getCustomValue(PACIFIST_MODE_TIME_OF_LAST_PACIFIST_UPDATE) as Number;
         _loc5_ = MonkeySystem.getInstance().getSecureTime();
         var _loc6_:Number = 1000 * 60 * 6;
         var _loc7_:Number = _loc5_ - _loc4_;
         var _loc8_:String = ContestPanelHelper.getTimeStringFromUnixTime(TimeUntilPacifistTracker.getTimeUntilPacifist);
         if(TEST_ERROR_REPORT)
         {
            ErrorMessageTracking.reportErrorMessageInvalidPacifist(MonkeySystem.getInstance().nkGatewayUser.loginInfo.id,MonkeySystem.getInstance().userName,_loc4_,TimeUntilPacifistTracker.getTimeUntilPacifist,_loc8_,param2,param3);
         }
         if(_loc4_ == 0)
         {
            return true;
         }
         var _loc9_:String = ContestPanelHelper.getTimeStringFromUnixTime(_loc7_);
         if(TimeUntilPacifistTracker.getTimeUntilPacifist == 0)
         {
            return true;
         }
         if(_loc7_ - _loc6_ > MAX_TIME_UNTIL_PACIFIST)
         {
            if(this.canReportAnErrorSinceLastUpdate())
            {
               ErrorMessageTracking.reportErrorMessageInvalidPacifist(MonkeySystem.getInstance().nkGatewayUser.loginInfo.id,MonkeySystem.getInstance().userName,_loc4_,TimeUntilPacifistTracker.getTimeUntilPacifist,_loc8_,param2,param3);
            }
            return false;
         }
         _loc10_ = MonkeySystem.getInstance().getSecureTime() - (MAX_TIME_UNTIL_PACIFIST - TimeUntilPacifistTracker.getTimeUntilPacifist);
         _loc11_ = Math.abs(_loc4_ - _loc10_);
         var _loc12_:Number = MonkeySystem.getInstance().getSecureTime() - _loc10_;
         var _loc13_:String = ContestPanelHelper.getTimeStringFromUnixTime(_loc11_);
         if(_loc11_ > _loc6_)
         {
            if(this.canReportAnErrorSinceLastUpdate())
            {
               ErrorMessageTracking.reportErrorMessageInvalidPacifist(MonkeySystem.getInstance().nkGatewayUser.loginInfo.id,MonkeySystem.getInstance().userName,_loc4_,TimeUntilPacifistTracker.getTimeUntilPacifist,_loc8_,param2,param3,_loc11_,_loc13_);
            }
            return false;
         }
         return true;
      }
      
      private function canReportAnErrorSinceLastUpdate() : Boolean
      {
         var _loc1_:Number = QuestCounter.getInstance().getCustomValue(PACIFIST_MODE_TIME_OF_UPDATE_FOR_ERROR_REPORT) as Number;
         var _loc2_:Number = QuestCounter.getInstance().getCustomValue(PACIFIST_MODE_TIME_OF_LAST_PACIFIST_UPDATE) as Number;
         if(_loc1_ != _loc2_)
         {
            QuestCounter.getInstance().setCustomValue(PACIFIST_MODE_TIME_OF_UPDATE_FOR_ERROR_REPORT,_loc2_);
            return true;
         }
         return false;
      }
   }
}
