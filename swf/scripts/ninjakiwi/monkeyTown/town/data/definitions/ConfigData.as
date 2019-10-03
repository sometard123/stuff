package ninjakiwi.monkeyTown.town.data.definitions
{
   public class ConfigData
   {
      
      private static var instance:ConfigData;
       
      
      public var startingMoney:int = 0;
      
      public var startingBloonstones:int = 0;
      
      public var firstBananaFarmStartingMoney:int = 0;
      
      public var costToAttackPerLevelOfTile:Number = 0;
      
      public var bananaFarmCapacityTier1:Number = 0;
      
      public var bananaFarmCapacityTier2:Number = 0;
      
      public var bloontoniumGeneratorCapacityTier1:Number = 0;
      
      public var bloontoniumGeneratorCapacityTier2:Number = 0;
      
      public function ConfigData(param1:SingletonEnforcer#1475)
      {
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: " + "Use ConfigData.getInstance() instead of new.");
         }
      }
      
      public static function getInstance() : ConfigData
      {
         if(instance == null)
         {
            instance = new ConfigData(new SingletonEnforcer#1475());
         }
         return instance;
      }
      
      public function initialiseFromDataObject(param1:Object) : void
      {
         var _loc2_:* = null;
         for(_loc2_ in param1)
         {
            if(this.hasOwnProperty(_loc2_))
            {
               this[_loc2_] = param1[_loc2_].value;
            }
         }
      }
   }
}

class SingletonEnforcer#1475
{
    
   
   function SingletonEnforcer#1475()
   {
      super();
   }
}
