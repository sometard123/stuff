package ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.icons
{
   import com.codecatalyst.promise.Promise;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.utils.setTimeout;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.gameEvents.boss.BossData;
   import ninjakiwi.monkeyTown.ui.CountdownTimer;
   
   public class BossIcon extends MovieClip
   {
       
      
      private var _clip:MovieClip;
      
      private var _timerField:TextField = null;
      
      private var _countdownTimer:CountdownTimer = null;
      
      public function BossIcon()
      {
         this._clip = new MovieClip();
         super();
         addChild(this._clip);
         GameEventManager.getInstance().bossEventManager.activeStateChangedSignal.add(this.syncState);
         GameSignals.CITY_IS_FINALLY_READY.add(this.syncState);
         this.syncState();
      }
      
      public function syncState(... rest) : void
      {
         var bossIsActive:Boolean = false;
         var args:Array = rest;
         bossIsActive = GameEventManager.getInstance().bossEventManager.bossIsActive;
         this.selectIconForCurrentBoss();
         setTimeout(function():void
         {
            var _loc1_:Number = NaN;
            if(bossIsActive)
            {
               _clip.gotoAndStop(1);
               _loc1_ = GameEventManager.getInstance().bossEventManager.getBossActiveTimeRemaining() + MonkeySystem.getInstance().getSecureTime();
               if(GameEventManager.getInstance().bossEventManager.bossLevel == 1)
               {
                  _timerField.visible = false;
                  _countdownTimer.stop();
               }
               else
               {
                  _countdownTimer.setEndTime(_loc1_);
                  _countdownTimer.start();
                  _timerField.visible = true;
               }
            }
            else
            {
               _clip.gotoAndStop(2);
               _countdownTimer.stop();
               _timerField.visible = false;
            }
         },100);
      }
      
      private function selectIconForCurrentBoss() : void
      {
         var _loc1_:GameplayEvent = GameEventManager.getInstance().bossEventManager.findCurrentEvent();
         var _loc2_:Class = BossData.getInstance().getIconClass(_loc1_.dataID);
         if(this._clip === null || false === this._clip is _loc2_)
         {
            this._clip = new _loc2_();
            this.removeChildren();
            addChild(this._clip);
            this._timerField = this._clip.timeField;
            if(this._countdownTimer === null)
            {
               this._countdownTimer = new CountdownTimer(this._timerField,0);
            }
            else
            {
               this._countdownTimer.setTextfield(this._timerField);
            }
         }
      }
   }
}
