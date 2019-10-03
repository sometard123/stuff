package ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems
{
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.gameEvents.ui.GenericEventPopupPanel;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.EventsMenuItem;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.icons.BossIcon;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   
   public class BossBattleEventMenuItem extends EventsMenuItem
   {
      
      private static var _genericPopupCustomButtons:BossIsHidingCustomButtons = null;
       
      
      public function BossBattleEventMenuItem(param1:GameplayEvent)
      {
         super(param1);
         name = "Boss Battle";
         typeID = "bossBattle";
         displayPriority = 0;
         _iconClass = BossIcon;
      }
      
      override public function onOpen() : void
      {
         var _loc2_:GenericEventPopupPanel = null;
         if(false == hasRequiredLevel())
         {
            openRequiresHigherLevelPopup();
            return;
         }
         var _loc1_:Boolean = GameEventManager.getInstance().bossEventManager.bossIsActive;
         if(_loc1_)
         {
            PanelManager.getInstance().showFreePanel(TownUI.getInstance().bossBattleAttackPanel);
         }
         else
         {
            if(_genericPopupCustomButtons === null)
            {
               _genericPopupCustomButtons = new BossIsHidingCustomButtons();
            }
            _loc2_ = TownUI.getInstance().genericEventPopupPanel;
            _loc2_.setUp("Boss In Hiding","The Boss is currently in hiding. Summon the Boss using the Bloon Beacon.",_iconClass,endTime,true,_genericPopupCustomButtons.clip);
            PanelManager.getInstance().showFreePanel(_loc2_);
         }
      }
   }
}
