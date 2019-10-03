package ninjakiwi.monkeyTown.town.ui.clock
{
   import assets.town.WarmupClockClip;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.data.GameModConstants;
   import ninjakiwi.monkeyTown.town.data.GameMods;
   import ninjakiwi.monkeyTown.town.data.definitions.UpgradePathStateDefinition;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldView;
   import ninjakiwi.monkeyTown.town.upgrades.UpgradeSignals;
   
   public class PassiveUpgradeBuildingWarmupClock extends MovieClip
   {
       
      
      public var targetPath:UpgradePathStateDefinition = null;
      
      public var xpOnComplete:int;
      
      public var dieOnRemoveFromStage:Boolean = false;
      
      private var _clip:WarmupClockClip;
      
      private var _timeStarted:Number;
      
      private var _system:MonkeySystem;
      
      private var _completeNowPopup:CompleteNowPopup;
      
      public function PassiveUpgradeBuildingWarmupClock(param1:UpgradePathStateDefinition)
      {
         this._system = MonkeySystem.getInstance();
         super();
         this._clip = new WarmupClockClip();
         this.initFinishNowPopup();
         addChild(this._clip);
         this.targetPath = param1;
         this.xpOnComplete = this.targetPath.xpOnComplete;
         this.targetPath.getOnUpdateSignal().add(this.syncToTarget);
         this.targetPath.getOnCompleteSignal().add(this.onCompleteSignal);
         this._timeStarted = this.targetPath.warmupStartTime;
         this.addEventListener(MouseEvent.CLICK,this.onClick);
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         this._clip.addEventListener(MouseEvent.ROLL_OVER,this.onRollover);
         MonkeyCityMain.globalResetSignal.add(this.onReset);
         this.syncToTarget();
      }
      
      protected function initFinishNowPopup() : void
      {
         this._completeNowPopup = new CompleteNowPopup(this._clip);
         addChild(this._completeNowPopup);
      }
      
      protected function onRollover(param1:MouseEvent) : void
      {
         this._completeNowPopup.setCost(this.targetPath.getBloonstonesRequiredToSkip());
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         if(this.dieOnRemoveFromStage)
         {
            this.tidy();
         }
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         UpgradeSignals.passiveUpgradeClockClicked.dispatch(this.targetPath);
      }
      
      public function syncToTarget() : void
      {
         if(this.targetPath === null)
         {
            return;
         }
         var _loc1_:Number = this._system.getSecureTime();
         var _loc2_:Number = this.targetPath.warmupProgress;
         this._clip.gotoAndStop(Math.ceil(_loc2_ * this._clip.totalFrames));
         this._clip.timeField.text = this.getTimeString(_loc1_);
      }
      
      private function onCompleteSignal() : void
      {
         this.tidy();
      }
      
      public function tidy() : void
      {
         removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         WorldView.removeOverlayFlashItem(this);
         if(this.targetPath != null)
         {
            this.targetPath.getOnUpdateSignal().remove(this.syncToTarget);
            this.targetPath.getOnCompleteSignal().remove(this.onCompleteSignal);
            this.targetPath = null;
         }
      }
      
      public function getTimeString(param1:Number) : String
      {
         var _loc11_:* = null;
         if(this.targetPath === null)
         {
            return "00:00";
         }
         var _loc2_:Number = (param1 - this._timeStarted) * GameMods.getModifier(GameModConstants.UPGRADE_SPEED_MOD);
         var _loc3_:Number = this.targetPath.warmupDuration - _loc2_;
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         var _loc4_:int = _loc3_ / 1000;
         var _loc5_:Number = _loc4_ % 60;
         var _loc6_:Number = Math.floor(_loc4_ % 3600 / 60);
         var _loc7_:Number = Math.floor(_loc4_ / (60 * 60));
         var _loc8_:String = _loc7_ == 0?"":this.zeroPad(_loc7_,2);
         var _loc9_:String = this.zeroPad(_loc6_,2);
         var _loc10_:String = this.zeroPad(_loc5_,2);
         if(_loc7_ > 0)
         {
            _loc11_ = _loc8_ + "h " + _loc9_ + "m";
         }
         else if(_loc6_ > 0)
         {
            _loc11_ = _loc9_ + ":" + _loc10_;
         }
         else
         {
            _loc11_ = _loc10_ + "s";
         }
         return _loc11_;
      }
      
      public function zeroPad(param1:int, param2:int) : String
      {
         var _loc3_:String = "" + param1;
         while(_loc3_.length < param2)
         {
            _loc3_ = "0" + _loc3_;
         }
         return _loc3_;
      }
      
      private function onReset() : void
      {
         this.tidy();
      }
   }
}
