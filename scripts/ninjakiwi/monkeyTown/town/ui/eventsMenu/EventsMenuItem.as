package ninjakiwi.monkeyTown.town.ui.eventsMenu
{
   import assets.ui.EventsMenuPlaceholderIcon;
   import flash.display.MovieClip;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.town.data.EventsData;
   import ninjakiwi.monkeyTown.town.data.definitions.EventsDataDefinition;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.gameEvents.ui.GenericEventPopupPanel;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   
   public class EventsMenuItem
   {
       
      
      public var name:String = "";
      
      public var typeID:String = "";
      
      public var displayPriority:Number = 0;
      
      public var endTime:Number = 0;
      
      protected var _gameEvent:GameplayEvent;
      
      protected var _iconClass:Class;
      
      public function EventsMenuItem(param1:GameplayEvent)
      {
         this._iconClass = EventsMenuPlaceholderIcon;
         super();
         this._gameEvent = param1;
      }
      
      public function getIcon() : MovieClip
      {
         return new this._iconClass();
      }
      
      public function onOpen() : void
      {
         var data:EventsDataDefinition = null;
         var panel:GenericEventPopupPanel = null;
         data = EventsData.getDefinitionByTypeID(this.typeID);
         panel = TownUI.getInstance().genericEventPopupPanel;
         if(data == null)
         {
            panel.setUp(this.name,"Placeholder",this._iconClass,this.endTime);
            PanelManager.getInstance().showFreePanel(panel);
            return;
         }
         if(this.hasRequiredLevel())
         {
            GameEventManager.getInstance().getDescription(data.typeID,function(param1:String):void
            {
               if(data !== null)
               {
                  panel.setUp(data.name,param1,_iconClass,endTime);
               }
               else
               {
                  panel.setUp(name,param1,_iconClass,endTime);
               }
               PanelManager.getInstance().showFreePanel(panel);
            });
         }
         else
         {
            this.openRequiresHigherLevelPopup();
         }
      }
      
      public function hasRequiredLevel() : Boolean
      {
         if(this._gameEvent == null)
         {
            return true;
         }
         var _loc1_:int = ResourceStore.getInstance().townLevel;
         return _loc1_ >= this._gameEvent.requiredLevel;
      }
      
      public function openRequiresHigherLevelPopup(param1:Boolean = true) : void
      {
         var _loc2_:GenericEventPopupPanel = TownUI.getInstance().genericEventPopupPanel;
         var _loc3_:* = "Reach City Level " + this._gameEvent.requiredLevel + " to participate.";
         _loc2_.setUp(this.name,_loc3_,this._iconClass,this.endTime,param1);
         PanelManager.getInstance().showFreePanel(_loc2_);
      }
   }
}
