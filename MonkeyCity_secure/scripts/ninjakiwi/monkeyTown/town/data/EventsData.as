package ninjakiwi.monkeyTown.town.data
{
   import ninjakiwi.monkeyTown.town.data.definitions.EventsDataDefinition;
   
   public class EventsData
   {
      
      public static const MONKEY_KNOWLEDGE_MADNESS:EventsDataDefinition = new EventsDataDefinition().Id("MonkeyKnowledgeMadness");
      
      public static const MINI_LAND_GRAB:EventsDataDefinition = new EventsDataDefinition().Id("MiniLandGrab");
      
      public static const MONKEY_TEAM:EventsDataDefinition = new EventsDataDefinition().Id("MonkeyTeam");
      
      public static const FESTIVAL_OF_BLOONSTONES:EventsDataDefinition = new EventsDataDefinition().Id("FestivalOfBloonstones");
      
      public static const BOUNTIFUL_HARVEST:EventsDataDefinition = new EventsDataDefinition().Id("BountifulHarvest");
      
      public static const CRAZY_CREDIT:EventsDataDefinition = new EventsDataDefinition().Id("CrazyCredit");
      
      public static const BLOONTONIUM_MELTDOWN:EventsDataDefinition = new EventsDataDefinition().Id("BloontoniumMeltdown");
      
      public static const WARMONGER:EventsDataDefinition = new EventsDataDefinition().Id("Warmonger");
      
      public static const TRAVELING_MERCHANT:EventsDataDefinition = new EventsDataDefinition().Id("TravelingMerchant");
      
      public static const definitions:Array = [MONKEY_KNOWLEDGE_MADNESS,MINI_LAND_GRAB,MONKEY_TEAM,FESTIVAL_OF_BLOONSTONES,BOUNTIFUL_HARVEST,CRAZY_CREDIT,BLOONTONIUM_MELTDOWN,WARMONGER,TRAVELING_MERCHANT];
      
      private static const _definitionsByID:Object = {};
      
      private static const _definitionsByTypeID:Object = {};
       
      
      public function EventsData()
      {
         super();
      }
      
      public static function populate(param1:Object) : void
      {
         var _loc3_:EventsDataDefinition = null;
         var _loc2_:int = 0;
         while(_loc2_ < definitions.length)
         {
            _loc3_ = definitions[_loc2_];
            if(param1.hasOwnProperty(_loc3_.id))
            {
               _loc3_.populateFromObject(param1[_loc3_.id]);
               _definitionsByID[_loc3_.id] = _loc3_;
               _definitionsByTypeID[_loc3_.typeID] = _loc3_;
            }
            _loc2_++;
         }
      }
      
      public static function getDefinitionByID(param1:String) : EventsDataDefinition
      {
         if(_definitionsByID.hasOwnProperty(param1))
         {
            return _definitionsByID[param1];
         }
         return null;
      }
      
      public static function getDefinitionByTypeID(param1:String) : EventsDataDefinition
      {
         if(_definitionsByTypeID.hasOwnProperty(param1))
         {
            return _definitionsByTypeID[param1];
         }
         return null;
      }
   }
}
