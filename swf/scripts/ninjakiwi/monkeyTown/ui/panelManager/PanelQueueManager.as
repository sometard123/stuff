package ninjakiwi.monkeyTown.ui.panelManager
{
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import ninjakiwi.luck.HappyCurve;
   import ninjakiwi.monkeyTown.pvp.OutgoingAttack;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.data.definitions.UpgradePathStateDefinition;
   import ninjakiwi.monkeyTown.town.data.definitions.UpgradeStateDefinition;
   import ninjakiwi.monkeyTown.town.quests.QuestCounter;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge._state;
   
   public class PanelQueueManager
   {
       
      
      private var _queues:Dictionary;
      
      private var _currentQueue:PanelQueue;
      
      private var _currentPanel:HideRevealView = null;
      
      private var _lock:Boolean = false;
      
      public const DEFAULT_QUEUE_ID:String = "_default_queue_";
      
      public function PanelQueueManager()
      {
         this._queues = new Dictionary();
         super();
         this.init();
      }
      
      private function init() : void
      {
         this.configurePanelGroup(this.DEFAULT_QUEUE_ID,PanelQueue.PRIORITY_DEFAULT);
      }
      
      public function showPanel(param1:HideRevealView, param2:* = "_default_queue_", param3:int = 1) : void
      {
         var _loc4_:PanelQueue = null;
         if(param2 === null)
         {
            param2 = this.DEFAULT_QUEUE_ID;
         }
         if(this._lock || this._currentPanel !== null)
         {
            _loc4_ = this.getQueueByID(param2);
            _loc4_.add(param1,param3);
         }
         else
         {
            this.revealPanel(param1);
            this._currentQueue = this.getQueueByID(param2);
         }
      }
      
      public function removePanel(param1:HideRevealView, param2:* = "_default_queue_") : void
      {
         if(param2 === null)
         {
            param2 = this.DEFAULT_QUEUE_ID;
         }
         var _loc3_:PanelQueue = this.getQueueByID(param2);
         _loc3_.remove(param1);
      }
      
      public function queuePanel(param1:HideRevealView, param2:* = "_default_queue_", param3:int = 1) : void
      {
         var _loc4_:PanelQueue = this.getQueueByID(param2);
         _loc4_.add(param1,param3);
      }
      
      private function revealPanel(param1:HideRevealView) : void
      {
         this._currentPanel = null;
         param1.onHideSignal.addOnce(this.onPanelHide);
         param1.reveal();
         this._currentPanel = param1;
      }
      
      public function hasOpenPanel() : Boolean
      {
         return this._currentPanel !== null;
      }
      
      public function showNextPanel() : void
      {
         var _loc1_:HideRevealView = this.getNextPanel();
         if(_loc1_ !== null)
         {
            this.revealPanel(_loc1_);
         }
      }
      
      private function onPanelHide(... rest) : void
      {
         this._currentPanel = null;
         this.showNextPanel();
      }
      
      public function configurePanelGroup(param1:*, param2:Number) : void
      {
         var _loc3_:PanelQueue = this.getQueueByID(param1);
         _loc3_.priority = param2;
      }
      
      private function getQueueByID(param1:*) : PanelQueue
      {
         if(this._queues[param1] === undefined)
         {
            this._queues[param1] = new PanelQueue();
         }
         return this._queues[param1];
      }
      
      private function getNextPanel() : HideRevealView
      {
         if(this._currentQueue === null || !this._currentQueue.hasQueuedItems())
         {
            this._currentQueue = this.getNextQueue();
         }
         if(this._currentQueue === null)
         {
            return null;
         }
         if(this._currentQueue.hasQueuedItems())
         {
            return this._currentQueue.getNext();
         }
         return null;
      }
      
      private function getNextQueue() : PanelQueue
      {
         var _loc2_:* = null;
         var _loc3_:PanelQueue = null;
         var _loc1_:Array = [];
         for(_loc2_ in this._queues)
         {
            _loc3_ = this._queues[_loc2_];
            if(_loc3_.hasQueuedItems())
            {
               _loc1_.push(_loc3_);
            }
         }
         if(_loc1_.length > 0)
         {
            _loc1_.sortOn("priority",Array.NUMERIC | Array.DESCENDING);
            return _loc1_[0];
         }
         return null;
      }
      
      public function reset() : void
      {
         var _loc1_:* = null;
         var _loc2_:PanelQueue = null;
         if(this._currentPanel !== null)
         {
            this._currentPanel.hide();
         }
         for(_loc1_ in this._queues)
         {
            _loc2_ = this._queues[_loc1_];
            _loc2_.clear();
            delete this._queues[_loc1_];
         }
      }
      
      public function get lock() : Boolean
      {
         return this._lock;
      }
      
      public function set lock(param1:Boolean) : void
      {
         this._lock = param1;
      }
   }
}
