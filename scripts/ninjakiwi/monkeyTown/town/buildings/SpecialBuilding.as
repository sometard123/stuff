package ninjakiwi.monkeyTown.town.buildings
{
   import ninjakiwi.monkeyTown.town.city.City;
   import ninjakiwi.monkeyTown.town.data.definitions.MonkeyTownBuildingDefinition;
   import ninjakiwi.monkeyTown.town.townMap.TownMap;
   
   public class SpecialBuilding extends Building
   {
       
      
      public function SpecialBuilding(param1:MonkeyTownBuildingDefinition, param2:City = null)
      {
         super(param1,param2);
      }
      
      override public function placeOnMap(param1:TownMap, param2:Boolean = true, param3:Boolean = true, param4:Boolean = false) : Building
      {
         super.placeOnMap(param1,param2,param3,param4);
         if(!param4)
         {
            _city.specialBuildingManager.register(this);
         }
         return this;
      }
      
      override public function die() : void
      {
         super.die();
         _city.specialBuildingManager.deregister(this);
      }
   }
}
