package ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems
{
   import ninjakiwi.monkeyTown.sound.MCSound;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.gameEvents.bloonBeacon.BloonBeaconSystem;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.EventsMenuItem;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.icons.BloonBeaconIcon;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   
   public class BloonBeaconEventMenuItem extends EventsMenuItem
   {
       
      
      public function BloonBeaconEventMenuItem(param1:GameplayEvent)
      {
         param1 = BloonBeaconSystem.getInstance().eventManager.findCurrentEvent();
         super(param1);
         name = "Bloon Beacon";
         typeID = "bloonBeacon";
         displayPriority = 0;
         _iconClass = BloonBeaconIcon;
      }
      
      override public function onOpen() : void
      {
         if(false == hasRequiredLevel())
         {
            openRequiresHigherLevelPopup(false);
            return;
         }
         if(BloonBeaconSystem.getInstance().isBeaconActive)
         {
            BloonBeaconSystem.getInstance().viewBeaconOnMap();
         }
         else
         {
            PanelManager.getInstance().showFreePanel(BloonBeaconSystem.getInstance().ui.bloonBeaconRechargePanel);
            MCSound.getInstance().playSound(MCSound.BEACON_CLICK);
         }
      }
   }
}
