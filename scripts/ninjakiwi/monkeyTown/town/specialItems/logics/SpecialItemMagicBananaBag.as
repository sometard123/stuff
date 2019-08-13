package ninjakiwi.monkeyTown.town.specialItems.logics
{
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.town.city.ActiveCitySignals;
   import ninjakiwi.monkeyTown.town.specialItems.SpecialItem;
   import ninjakiwi.monkeyTown.town.specialItems.definition.SpecialItemDefinition;
   
   public class SpecialItemMagicBananaBag extends SpecialItem
   {
       
      
      private const _resourceStore:ResourceStore = ResourceStore.getInstance();
      
      public function SpecialItemMagicBananaBag(param1:SpecialItemDefinition, param2:int = 0)
      {
         super(param1,param2);
      }
      
      override public function clear() : void
      {
         super.clear();
         ActiveCitySignals.bankCheckingSignal.remove(this.expandCapacity);
      }
      
      override protected function applyAbility() : void
      {
         super.applyAbility();
         ActiveCitySignals.bankCheckingSignal.remove(this.expandCapacity);
         ActiveCitySignals.bankCheckingSignal.add(this.expandCapacity);
         this._resourceStore.setBonusBankCapacity(1500);
      }
      
      private function expandCapacity(param1:Function) : void
      {
         param1(1500);
      }
   }
}
