package ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems
{
   import flash.display.MovieClip;
   import ninjakiwi.monkeyTown.saleEvents.SaleEventItem;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.EventsMenuItem;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.icons.KnowledgePackSaleIcon;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   
   public class KnowledgePackSaleEventMenuItem extends EventsMenuItem
   {
       
      
      private var _saleItem:SaleEventItem;
      
      public function KnowledgePackSaleEventMenuItem(param1:SaleEventItem = null)
      {
         super(null);
         this._saleItem = param1;
         name = "Knowledge Pack Sale";
         displayPriority = 0;
         _iconClass = KnowledgePackSaleIcon;
      }
      
      override public function onOpen() : void
      {
         if(hasRequiredLevel())
         {
            PanelManager.getInstance().showFreePanel(TownUI.getInstance().knowledgePackSalePanel);
         }
         else
         {
            openRequiresHigherLevelPopup();
         }
      }
      
      override public function getIcon() : MovieClip
      {
         return new KnowledgePackSaleIcon(this._saleItem);
      }
   }
}
