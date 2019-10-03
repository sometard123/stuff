package ninjakiwi.monkeyTown.town.ui.eventsMenu
{
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.BananaFarmModifierEventMenuItem;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.BeaconBlitzMenuItem;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.BeaconModifiersEventMenuItem;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.BittyBeaconsMenuItem;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.BloonBeaconEventMenuItem;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.BloontoniumRateModifierMenuItem;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.BossBattleEventMenuItem;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.CrazyCreditEventMenuItem;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.CtOccupationEventMenuItem;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.DefaultEventMenuItem;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.FestivalOfBloonstonesMenuItem;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.KnowledgePackSaleEventMenuItem;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.MilestoneEventMenuItem;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.MiniLandGrabEventMenuItem;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.MonkeyKnowledgeMadnessEventMenuItem;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.MonkeyMerchantEventMenuItem;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.MonkeyTeamEventMenuItem;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.WarmongerEventMenuItem;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.WildRareEventMenuItem;
   
   public class EventsMenuData
   {
      
      private static const _menuItemClasses:Object = {
         "ctMilestones":MilestoneEventMenuItem,
         "bloonBeacon":BloonBeaconEventMenuItem,
         "ctOccupation":CtOccupationEventMenuItem,
         "bananaFarmRateModifier":BananaFarmModifierEventMenuItem,
         "monkeyTeam":MonkeyTeamEventMenuItem,
         "bloonstoneSpend":FestivalOfBloonstonesMenuItem,
         "warmonger":WarmongerEventMenuItem,
         "bloontoniumRateModifier":BloontoniumRateModifierMenuItem,
         "monkeyKnowledgeMadness":MonkeyKnowledgeMadnessEventMenuItem,
         "miniLandGrab":MiniLandGrabEventMenuItem,
         "cashBloonstoneExchangeRateModifier":CrazyCreditEventMenuItem,
         "monkeyMerchant":MonkeyMerchantEventMenuItem,
         "bossBattle":BossBattleEventMenuItem,
         "beaconblitz":BossBattleEventMenuItem,
         "beaconRechargeCostModifier":BittyBeaconsMenuItem,
         "beaconRechargeTimeModifier":BeaconBlitzMenuItem,
         "beaconModifiers":BeaconModifiersEventMenuItem,
         "wildRare":WildRareEventMenuItem,
         "knowledgePackSale":KnowledgePackSaleEventMenuItem
      };
       
      
      public function EventsMenuData()
      {
         super();
      }
      
      public static function getItemClass(param1:String) : Class
      {
         if(_menuItemClasses.hasOwnProperty(param1))
         {
            return _menuItemClasses[param1];
         }
         return DefaultEventMenuItem;
      }
   }
}
