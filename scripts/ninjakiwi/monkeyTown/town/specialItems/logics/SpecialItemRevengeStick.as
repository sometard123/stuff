package ninjakiwi.monkeyTown.town.specialItems.logics
{
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.pvp.PvPSignals;
   import ninjakiwi.monkeyTown.town.specialItems.SpecialItem;
   import ninjakiwi.monkeyTown.town.specialItems.definition.SpecialItemDefinition;
   
   public class SpecialItemRevengeStick extends SpecialItem
   {
       
      
      public function SpecialItemRevengeStick(param1:SpecialItemDefinition, param2:int = 0)
      {
         super(param1,param2);
      }
      
      override public function clear() : void
      {
         super.clear();
         PvPSignals.setRevengeAttack.remove(this.onSetRevengeAttack);
      }
      
      override protected function applyAbility() : void
      {
         super.applyAbility();
         PvPSignals.setRevengeAttack.add(this.onSetRevengeAttack);
      }
      
      private function onSetRevengeAttack() : void
      {
         ResourceStore.getInstance().addBloontoniumWithTempOverage(300);
      }
   }
}
