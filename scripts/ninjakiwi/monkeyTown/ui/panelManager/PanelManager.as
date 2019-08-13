package ninjakiwi.monkeyTown.ui.panelManager
{
   import ninjakiwi.monkeyTown.friends.FriendsManager;
   import ninjakiwi.monkeyTown.pvp.PvPAttackDefinition;
   import ninjakiwi.monkeyTown.pvp.PvPMain;
   import ninjakiwi.monkeyTown.town.ui.QuestInfoPanel;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   
   public class PanelManager
   {
      
      private static var instance:PanelManager;
       
      
      private var _panelQueueManager:PanelQueueManager;
      
      private var _panelQueueManagerOverlay:PanelQueueManager;
      
      private var _freePanelManager:FreePanelManager;
      
      private var _lock:Boolean = false;
      
      private var _lockMainPanelsCount:int = 0;
      
      public const DEFAULT_QUEUE_ID:String = "_default_queue_";
      
      public function PanelManager(param1:SingletonEnforcer#1692)
      {
         this._panelQueueManager = new PanelQueueManager();
         this._panelQueueManagerOverlay = new PanelQueueManager();
         this._freePanelManager = new FreePanelManager();
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed:" + " Use PanelManager.getInstance() instead of new.");
         }
         this.init();
      }
      
      public static function getInstance() : PanelManager
      {
         if(instance == null)
         {
            instance = new PanelManager(new SingletonEnforcer#1692());
         }
         return instance;
      }
      
      public function showPanel(param1:HideRevealView, param2:* = "_default_queue_", param3:int = 1) : void
      {
         if(param1 is QuestInfoPanel)
         {
         }
         if(this._lockMainPanelsCount > 0)
         {
            this.queuePanel(param1,param2,param3);
         }
         this._panelQueueManager.showPanel(param1,param2,param3);
      }
      
      public function removePanel(param1:HideRevealView, param2:* = "_default_queue_") : void
      {
         this._panelQueueManager.removePanel(param1,param2);
      }
      
      public function queuePanel(param1:HideRevealView, param2:* = "_default_queue_", param3:int = 1) : void
      {
         this._panelQueueManager.queuePanel(param1,param2,param3);
      }
      
      public function hasOpenMainPanel() : Boolean
      {
         return this._panelQueueManager.hasOpenPanel();
      }
      
      public function hasAnyOpenPanel() : Boolean
      {
         return this._panelQueueManager.hasOpenPanel() || this._panelQueueManagerOverlay.hasOpenPanel() || this._freePanelManager.hasOpenPanel();
      }
      
      public function showPanelOverlay(param1:HideRevealView) : void
      {
         this._panelQueueManagerOverlay.showPanel(param1);
      }
      
      public function showFreePanel(param1:HideRevealView) : void
      {
         this._freePanelManager.showPopup(param1);
      }
      
      public function reset() : void
      {
         this._panelQueueManager.reset();
         this._panelQueueManagerOverlay.reset();
         this._freePanelManager.reset();
         this._lockMainPanelsCount = 0;
      }
      
      public function showNextPanel() : void
      {
         this._panelQueueManager.showNextPanel();
         this._panelQueueManagerOverlay.showNextPanel();
      }
      
      public function configurePanelGroup(param1:*, param2:Number) : void
      {
         this._panelQueueManager.configurePanelGroup(param1,param2);
         this._panelQueueManagerOverlay.configurePanelGroup(param1,param2);
      }
      
      private function init() : void
      {
         PanelGroups.configureGroups(this);
      }
      
      public function get lock() : Boolean
      {
         return this._lock;
      }
      
      public function set lock(param1:Boolean) : void
      {
         this._lock = param1;
         this._panelQueueManager.lock = param1;
         this._panelQueueManagerOverlay.lock = param1;
      }
   }
}

class SingletonEnforcer#1692
{
    
   
   function SingletonEnforcer#1692()
   {
      super();
   }
}
