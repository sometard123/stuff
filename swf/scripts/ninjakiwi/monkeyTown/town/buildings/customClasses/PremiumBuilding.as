package ninjakiwi.monkeyTown.town.buildings.customClasses
{
   import assets.flare.PackUpEffect;
   import ninjakiwi.dancingShadows.DancingShadows;
   import ninjakiwi.dancingShadows.INumber;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.city.City;
   import ninjakiwi.monkeyTown.town.data.definitions.MonkeyTownBuildingDefinition;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldView;
   
   public class PremiumBuilding extends Building
   {
       
      
      protected var _cost:INumber;
      
      public function PremiumBuilding(param1:MonkeyTownBuildingDefinition, param2:int, param3:City = null)
      {
         this._cost = DancingShadows.getOne();
         this._cost.value = param2;
         super(param1,param3);
      }
      
      override public function demolish(param1:Boolean = true, param2:Boolean = true) : void
      {
         var _loc3_:PackUpEffect = null;
         Building.buildingWasDemolishedSignal.dispatch(this,false);
         Tile.tileChangedSignal.dispatch(homeTile);
         setHover(false,map);
         clearLandBeneathFootprint();
         _loc3_ = new PackUpEffect();
         _loc3_.x = homeTile.x;
         _loc3_.y = homeTile.y;
         _loc3_.x = _loc3_.x + (definition.width - 1) * 32;
         _loc3_.y = _loc3_.y + (definition.height - 1) * 32;
         _loc3_.gotoAndPlay(1);
         WorldView.addOverlayItem(_loc3_);
         _city.damageClockManager.killClock(damageClock);
         isDamaged = false;
         damageClock = null;
         this.die();
      }
      
      public function get cost() : int
      {
         return this._cost.value;
      }
   }
}
