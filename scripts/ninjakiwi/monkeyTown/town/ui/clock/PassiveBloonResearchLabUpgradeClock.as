package ninjakiwi.monkeyTown.town.ui.clock
{
   import assets.town.WarmupClockClip;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldView;
   import ninjakiwi.monkeyTown.ui.bloonResearchLab.BloonResearchLabUpgradeClock;
   
   public class PassiveBloonResearchLabUpgradeClock extends MovieClip
   {
       
      
      public var xpOnComplete:int;
      
      public var dieOnRemoveFromStage:Boolean = false;
      
      private var _clip:WarmupClockClip;
      
      private var _timeStarted:Number;
      
      private var _system:MonkeySystem;
      
      private var _targetClock:BloonResearchLabUpgradeClock = null;
      
      private var _completeNowPopup:CompleteNowPopup;
      
      public function PassiveBloonResearchLabUpgradeClock(param1:BloonResearchLabUpgradeClock)
      {
         this._system = MonkeySystem.getInstance();
         super();
         this._clip = new WarmupClockClip();
         this.initFinishNowPopup();
         addChild(this._clip);
         this.addEventListener(MouseEvent.CLICK,this.onClick);
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         this._targetClock = param1;
         param1.onCompleteSignal.addOnce(this.onComplete);
         param1.onUpdateSignal.add(this.syncToTarget);
         this._clip.addEventListener(MouseEvent.ROLL_OVER,this.onRollover);
         MonkeyCityMain.globalResetSignal.add(this.onReset);
      }
      
      protected function initFinishNowPopup() : void
      {
         this._completeNowPopup = new CompleteNowPopup(this._clip);
         addChild(this._completeNowPopup);
      }
      
      protected function onRollover(param1:MouseEvent) : void
      {
         this._completeNowPopup.setCost(this._targetClock.getBloonstonesRequiredToSkip());
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
         if(this._targetClock.isLocked())
         {
            return;
         }
         this._targetClock.offerSkip();
      }
      
      public function syncToTarget() : void
      {
         this._clip.gotoAndStop(Math.ceil(this._targetClock.progress * this._clip.totalFrames));
         this._clip.timeField.text = this._targetClock.timeText;
      }
      
      private function onCompleteSignal() : void
      {
         this.tidy();
      }
      
      public function tidy() : void
      {
         removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         WorldView.removeOverlayFlashItem(this);
         if(this._targetClock != null)
         {
            this._targetClock.onCompleteSignal.remove(this.onComplete);
            this._targetClock.onUpdateSignal.remove(this.syncToTarget);
         }
         this._targetClock = null;
      }
      
      private function onComplete() : void
      {
         this.tidy();
      }
      
      private function onReset() : void
      {
         this.tidy();
      }
   }
}
