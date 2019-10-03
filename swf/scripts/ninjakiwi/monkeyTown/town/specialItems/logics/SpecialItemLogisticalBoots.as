package ninjakiwi.monkeyTown.town.specialItems.logics
{
   import ninjakiwi.monkeyTown.town.specialItems.SpecialItem;
   import ninjakiwi.monkeyTown.town.specialItems.definition.SpecialItemDefinition;
   import ninjakiwi.monkeyTown.utils.Calculator;
   
   public class SpecialItemLogisticalBoots extends SpecialItem
   {
       
      
      public function SpecialItemLogisticalBoots(param1:SpecialItemDefinition, param2:int = 0)
      {
         super(param1,param2);
      }
      
      override public function clear() : void
      {
         super.clear();
         Calculator.globalCashModifier = 1;
      }
      
      override protected function applyAbility() : void
      {
         super.applyAbility();
         Calculator.globalCashModifier = 1.1;
      }
   }
}
