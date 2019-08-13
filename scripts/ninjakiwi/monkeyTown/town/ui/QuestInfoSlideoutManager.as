package ninjakiwi.monkeyTown.town.ui
{
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldViewSignals;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelQueueManager;
   
   public class QuestInfoSlideoutManager extends PanelQueueManager
   {
       
      
      private var _isDelayingOpen:Boolean = false;
      
      private var _delayTimeoutID:uint;
      
      public function QuestInfoSlideoutManager()
      {
         super();
         MonkeyCityMain.globalResetSignal.add(this.reset);
         WorldViewSignals.buildWorldStartSignal.add(this.reset);
      }
      
      override public function reset() : void
      {
         super.reset();
         if(this._isDelayingOpen)
         {
            clearTimeout(this._delayTimeoutID);
            this._isDelayingOpen = false;
         }
      }
      
      override public function showPanel(param1:HideRevealView, param2:* = "_default_queue_", param3:int = 1) : void
      {
         if(PanelManager.getInstance().hasAnyOpenPanel() || this._isDelayingOpen)
         {
            queuePanel(param1);
            this.startDelayedOpen();
         }
         else
         {
            super.showPanel(param1);
         }
      }
      
      private function startDelayedOpen() : void
      {
         if(this._isDelayingOpen)
         {
            return;
         }
         this._delayTimeoutID = setTimeout(this.tryOpenNextQueuedPanel,1000);
         this._isDelayingOpen = true;
      }
      
      private function tryOpenNextQueuedPanel() : void
      {
         this._isDelayingOpen = false;
         if(PanelManager.getInstance().hasAnyOpenPanel())
         {
            this.startDelayedOpen();
         }
         else
         {
            clearTimeout(this._delayTimeoutID);
            super.showNextPanel();
         }
      }
      
      override public function showNextPanel() : void
      {
         this.tryOpenNextQueuedPanel();
      }
   }
}
