package ninjakiwi.monkeyTown.town.gameEvents.bloonBeacon.ui
{
   import assets.ui.BloonBeaconFirstTimePanelClip;
   import flash.display.DisplayObjectContainer;
   import flash.utils.setTimeout;
   import ninjakiwi.monkeyTown.data.KeyValueStore;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.BloonBeaconEventMenuItem;
   import ninjakiwi.monkeyTown.ui.HideRevealViewPopup;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   
   public class BloonBeaconTutorialPanel extends HideRevealViewPopup
   {
      
      public static const DATA_KEY:String = "BloonBeaconTutorialPanelData";
       
      
      private const _clip:BloonBeaconFirstTimePanelClip = new BloonBeaconFirstTimePanelClip();
      
      private const _closeButton:ButtonControllerBase = new ButtonControllerBase(this._clip.closeButton);
      
      private const _goToBeaconButton:ButtonControllerBase = new ButtonControllerBase(this._clip.goToBeaconButton);
      
      private var SHOW_EVERY_TIME:Boolean = false;
      
      public function BloonBeaconTutorialPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         super(param1,param2);
         this.isModal = true;
         enableDefaultOnResize(this._clip);
         this.addChild(this._clip);
         this._closeButton.setClickFunction(hide);
         this._goToBeaconButton.setClickFunction(this.goToBeacon);
      }
      
      private function goToBeacon() : void
      {
         setTimeout(function():void
         {
            var _loc1_:GameplayEvent = GameEventManager.getInstance().bloonBeaconSystem.eventManager.findCurrentEvent();
            var _loc2_:BloonBeaconEventMenuItem = new BloonBeaconEventMenuItem(_loc1_);
            _loc2_.onOpen();
            hide();
         },200);
      }
      
      public function revealIfNeverSeen() : void
      {
         var that:BloonBeaconTutorialPanel = null;
         if(this.SHOW_EVERY_TIME)
         {
            PanelManager.getInstance().showPanel(this);
            return;
         }
         if(ResourceStore.getInstance().townLevel < 2)
         {
            return;
         }
         that = this;
         KeyValueStore.getInstance().get(DATA_KEY,function(param1:Object):void
         {
            if(param1 !== null)
            {
               if(param1.hasOwnProperty("seen") && false == param1.seen)
               {
                  PanelManager.getInstance().showPanel(that);
               }
            }
            else
            {
               PanelManager.getInstance().showPanel(that);
            }
         });
      }
      
      override public function reveal(param1:Number = 0.4) : void
      {
         super.reveal(param1);
         KeyValueStore.getInstance().set(DATA_KEY,{"seen":true});
      }
   }
}
