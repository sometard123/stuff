package ninjakiwi.monkeyTown.ui.panelManager
{
   import assets.ui.PVPIncomingRaidInfoBoxClip;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   
   public class PanelQueue
   {
      
      public static const PRIORITY_DEFAULT:Number = 1;
      
      public static const PRIORITY_HIGHER:Number = 2;
       
      
      public var priority:Number = 1;
      
      private var _queue:Vector.<QueuedView>;
      
      public function PanelQueue()
      {
         this._queue = new Vector.<QueuedView>();
         super();
      }
      
      public function add(param1:HideRevealView, param2:Number = 1) : void
      {
         this._queue.push(new QueuedView(param1,param2));
         this.sortByPriority();
      }
      
      public function remove(param1:HideRevealView) : void
      {
         var _loc2_:int = this._queue.length - 1;
         while(_loc2_ >= 0)
         {
            if(this._queue[_loc2_].view === param1)
            {
               this._queue.splice(_loc2_,1);
            }
            _loc2_--;
         }
      }
      
      public function clear() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._queue.length)
         {
            this._queue[_loc1_].view.hide(0);
            _loc1_++;
         }
         this._queue.length = 0;
      }
      
      public function getNext() : HideRevealView
      {
         return this._queue.shift().view;
      }
      
      public function hasQueuedItems() : Boolean
      {
         return this._queue.length > 0;
      }
      
      private function sortByPriority() : void
      {
         var _loc2_:QueuedView = null;
         var _loc1_:Array = [];
         var _loc3_:int = 0;
         while(_loc3_ < this._queue.length)
         {
            _loc2_ = this._queue[_loc3_];
            _loc1_.push(_loc2_);
            _loc3_++;
         }
         _loc1_.sortOn("priority",Array.NUMERIC | Array.DESCENDING);
         this._queue = Vector.<QueuedView>(_loc1_);
      }
   }
}

import ninjakiwi.monkeyTown.ui.HideRevealView;

class QueuedView
{
    
   
   public var view:HideRevealView = null;
   
   public var priority:Number = 1;
   
   function QueuedView(param1:HideRevealView, param2:Number)
   {
      super();
      this.view = param1;
      this.priority = param2;
   }
}
