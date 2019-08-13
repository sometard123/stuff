package ninjakiwi.monkeyTown.town.ui.salePanels
{
   import assets.ui.MonkeyKnowledegSaleLargePacksIcon;
   import assets.ui.MonkeyKnowledegSaleMediumPacksIcon;
   import assets.ui.MonkeyKnowledegSaleSmallPacksIcon;
   import assets.ui.MonkeyKnowledegSaleWildPacksIcon;
   import ninjakiwi.monkeyTown.pvp.IncomingRaid;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldView;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.EventsMenuButton;
   
   public class SaleItemData
   {
      
      private static var _data:Object = {
         "672":{
            "title":"5 Monkey Knowledge Packs",
            "description":"Educate your Monkeys! Get 5 Monkey Knowledge Packs now!",
            "cost":30,
            "quantity":5,
            "variableToIncrement":"unopenedPacks",
            "iconClass":MonkeyKnowledegSaleSmallPacksIcon,
            "itemID":672,
            "kongItemID":-1,
            "nonSaleItemID":"711"
         },
         "673":{
            "title":"15 Monkey Knowledge Packs",
            "description":"Send your Monkeys to University and get 15 Monkey Knowledge Packs now!",
            "quantity":15,
            "variableToIncrement":"unopenedPacks",
            "cost":70,
            "iconClass":MonkeyKnowledegSaleMediumPacksIcon,
            "itemID":673,
            "nonSaleItemID":"712"
         },
         "674":{
            "title":"30 Monkey Knowledge Packs",
            "description":"A bumper crop of Monkey Knowledge heading your way! Get 30 Monkey Knowledge packs now!",
            "quantity":30,
            "variableToIncrement":"unopenedPacks",
            "cost":120,
            "iconClass":MonkeyKnowledegSaleLargePacksIcon,
            "itemID":674,
            "kongItemID":-1,
            "nonSaleItemID":"713"
         },
         "710":{
            "title":"5 Wildcard Packs",
            "description":"Every pack contains 4 Wild Cards! Increased chance of Rares and Legendaries!",
            "quantity":5,
            "variableToIncrement":"unopenedWildcardPacks",
            "cost":100,
            "iconClass":MonkeyKnowledegSaleWildPacksIcon,
            "itemID":710,
            "kongItemID":-1
         },
         "711":{
            "title":"5 Monkey Knowledge Packs",
            "description":"Educate your Monkeys! Get 5 Monkey Knowledge Packs now!",
            "cost":60,
            "quantity":5,
            "variableToIncrement":"unopenedPacks",
            "iconClass":MonkeyKnowledegSaleSmallPacksIcon,
            "itemID":711,
            "kongItemID":-1
         },
         "712":{
            "title":"15 Monkey Knowledge Packs",
            "description":"Send your Monkeys to University and get 15 Monkey Knowledge Packs now!",
            "quantity":15,
            "cost":140,
            "variableToIncrement":"unopenedPacks",
            "iconClass":MonkeyKnowledegSaleMediumPacksIcon,
            "itemID":712
         },
         "713":{
            "title":"30 Monkey Knowledge Packs",
            "description":"A bumper crop of Monkey Knowledge heading your way! Get 30 Monkey Knowledge packs now!",
            "quantity":30,
            "variableToIncrement":"unopenedPacks",
            "cost":240,
            "iconClass":MonkeyKnowledegSaleLargePacksIcon,
            "itemID":713,
            "kongItemID":-1
         }
      };
      
      {
         staticInit();
      }
      
      public function SaleItemData()
      {
         super();
      }
      
      private static function staticInit() : void
      {
         var _loc1_:Object = null;
         var _loc2_:Object = null;
         for each(_loc1_ in _data)
         {
            if(_loc1_.hasOwnProperty("nonSaleItemID"))
            {
               _loc2_ = _data[_loc1_.nonSaleItemID];
               _loc1_.regularCost = _loc2_.cost;
            }
         }
      }
      
      public static function getItemData(param1:*) : Object
      {
         param1 = param1.toString();
         if(_data.hasOwnProperty(param1))
         {
            return _data[param1];
         }
         return null;
      }
   }
}
