package ninjakiwi.monkeyTown.btdModule.towers.behavior.roundOver
{
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundStart.BananaEmitter;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradeDef;
   
   public class HealthyBananas extends BehaviorRoundOver
   {
       
      
      public function HealthyBananas()
      {
         super();
      }
      
      override public function execute(param1:Tower) : void
      {
         var _loc3_:UpgradeDef = null;
         var _loc4_:BananaEmitter = null;
         var _loc2_:int = 1;
         if(param1.def.id == "MonkeyBank" || param1.def.id == "BananaRepublic")
         {
            _loc2_ = 4;
         }
         if(param1.def.id == "BananaInvestmentsAdvisory" || param1.def.id == "BananaResearchFacility")
         {
            _loc2_ = 5;
         }
         for each(_loc3_ in param1.upgrades)
         {
            if(_loc3_.id == "MoreBananas" || _loc3_.id == "BananaPlantation" || _loc3_.id == "LongLifeBananas" || _loc3_.id == "ValuableBananas")
            {
               _loc2_++;
            }
         }
         param1.level.setHealth(param1.level.health.value + _loc2_);
         if(param1.def && param1.def.behavior && param1.def.behavior.roundStart)
         {
            _loc4_ = param1.def.behavior.roundStart as BananaEmitter;
            if(_loc4_ != null)
            {
               _loc4_.setBankedFunds(_loc4_.getBankedFunds(param1) * _loc4_.intrestMultiplier,param1);
               param1.dispatchEvent(new PropertyModEvent("funds"));
            }
         }
      }
   }
}
