package ninjakiwi.monkeyTown.town.specialItems.logics
{
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.town.specialItems.SpecialItem;
   import ninjakiwi.monkeyTown.town.specialItems.definition.SpecialItemDefinition;
   
   public class SpecialItemAddBTDInitialGameMoney extends SpecialItem
   {
       
      
      private var _addValue:int = 0;
      
      public function SpecialItemAddBTDInitialGameMoney(param1:SpecialItemDefinition, param2:int = 0, param3:int = 50)
      {
         super(param1,param2);
         this._addValue = param3;
      }
      
      override public function clear() : void
      {
         super.clear();
         ResourceStore.getInstance().getStartingCashSignal.remove(this.addStartingCash);
      }
      
      override protected function applyAbility() : void
      {
         ResourceStore.getInstance().getStartingCashSignal.add(this.addStartingCash);
      }
      
      private function addStartingCash(param1:Function) : void
      {
         param1(this._addValue);
      }
   }
}
