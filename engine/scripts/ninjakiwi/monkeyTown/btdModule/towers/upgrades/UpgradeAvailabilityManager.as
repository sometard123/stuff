package ninjakiwi.monkeyTown.btdModule.towers.upgrades
{
   public class UpgradeAvailabilityManager
   {
      
      public static const instance:UpgradeAvailabilityManager = new UpgradeAvailabilityManager();
       
      
      private var _upgradesAvailable:Object;
      
      public function UpgradeAvailabilityManager()
      {
         this._upgradesAvailable = {};
         super();
      }
      
      public function setup(param1:Object) : void
      {
         var _loc2_:Object = null;
         var _loc3_:* = null;
         this._upgradesAvailable = {};
         for(_loc3_ in param1)
         {
            _loc2_ = param1[_loc3_];
            this._upgradesAvailable[_loc3_] = {
               "path1":_loc2_.path1,
               "path2":_loc2_.path2
            };
         }
      }
      
      public function getUpgradesUnlockedForTower(param1:String) : Object
      {
         if(this._upgradesAvailable[param1] !== undefined)
         {
            return this._upgradesAvailable[param1];
         }
         return {
            "path1":0,
            "path2":0
         };
      }
      
      public function getPathProgressForTower(param1:String, param2:int) : int
      {
         var _loc3_:String = "path" + param2.toString();
         if(this._upgradesAvailable[param1] !== undefined)
         {
            return this._upgradesAvailable[param1][_loc3_];
         }
         return 0;
      }
   }
}
