package ninjakiwi.monkeyTown.town.buildings.buildingManagers
{
   import ninjakiwi.monkeyTown.town.buildings.SpecialBuilding;
   import ninjakiwi.monkeyTown.town.data.BuildingData;
   import ninjakiwi.monkeyTown.town.management.Manager;
   
   public class SpecialBuildingManager extends Manager
   {
       
      
      private var _buildingData:BuildingData;
      
      private var _buildingCounts:Object;
      
      public function SpecialBuildingManager()
      {
         this._buildingData = BuildingData.getInstance();
         this._buildingCounts = {};
         super();
      }
      
      override public function register(param1:*) : Boolean
      {
         var _loc2_:Boolean = super.register(param1);
         var _loc3_:String = SpecialBuilding(param1).definition.id;
         if(this._buildingCounts[_loc3_] === undefined)
         {
            this._buildingCounts[_loc3_] = 0;
         }
         else
         {
            this._buildingCounts[_loc3_]++;
         }
         return true;
      }
      
      override public function deregister(param1:*) : Boolean
      {
         var _loc2_:Boolean = super.deregister(param1);
         return _loc2_;
      }
      
      override public function clear() : void
      {
         super.clear();
         this._buildingCounts = {};
      }
      
      public function get blahModifier() : Number
      {
         return 1;
      }
   }
}
