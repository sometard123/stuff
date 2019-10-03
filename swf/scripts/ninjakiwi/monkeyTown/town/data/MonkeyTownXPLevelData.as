package ninjakiwi.monkeyTown.town.data
{
   public class MonkeyTownXPLevelData
   {
      
      private static var instance:MonkeyTownXPLevelData;
       
      
      public var level:Array;
      
      public var xpNeededZeroed:Array;
      
      public var increase:Array;
      
      public var xpNeededCumulative:Array;
      
      public var levelingRewardMonkeyMoney:Array;
      
      public var levelingRewardBloonstones:Array;
      
      public function MonkeyTownXPLevelData(param1:SingletonEnforcer#1190)
      {
         this.level = [];
         this.xpNeededZeroed = [];
         this.increase = [];
         this.xpNeededCumulative = [];
         this.levelingRewardMonkeyMoney = [];
         this.levelingRewardBloonstones = [];
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use MonkeyTownXPLevelData.getInstance() instead of new.");
         }
         this.init();
      }
      
      public static function getInstance() : MonkeyTownXPLevelData
      {
         if(instance == null)
         {
            instance = new MonkeyTownXPLevelData(new SingletonEnforcer#1190());
         }
         return instance;
      }
      
      private function init() : void
      {
      }
      
      public function initFromDataObject(param1:Object) : void
      {
         this.level = param1.level;
         this.xpNeededZeroed = param1.xpNeededZeroed;
         this.increase = param1.increase;
         this.xpNeededCumulative = param1.xpNeededCumulative;
         this.levelingRewardMonkeyMoney = param1.levelingRewardMonkeyMoney;
         this.levelingRewardBloonstones = param1.levelingRewardBloonstones;
      }
      
      public function getTownLevelFromXP(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < this.xpNeededCumulative.length)
         {
            if(param1 >= this.xpNeededCumulative[_loc3_])
            {
               _loc2_ = this.level[_loc3_];
               _loc3_++;
               continue;
            }
            break;
         }
         return _loc2_;
      }
   }
}

class SingletonEnforcer#1190
{
    
   
   function SingletonEnforcer#1190()
   {
      super();
   }
}
