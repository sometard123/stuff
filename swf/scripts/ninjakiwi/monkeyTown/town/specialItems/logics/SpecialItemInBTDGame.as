package ninjakiwi.monkeyTown.town.specialItems.logics
{
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.monkeyTown.town.specialItems.SpecialItem;
   import ninjakiwi.monkeyTown.town.specialItems.definition.SpecialItemDefinition;
   
   public class SpecialItemInBTDGame extends SpecialItem
   {
       
      
      public function SpecialItemInBTDGame(param1:SpecialItemDefinition, param2:int = 0)
      {
         super(param1,param2);
      }
      
      protected function getTowerParam(param1:BTDGameRequest, param2:String) : Object
      {
         if(param1.specialAbilities[param2] == null)
         {
            param1.specialAbilities[param2] = new Object();
         }
         return param1.specialAbilities[param2];
      }
   }
}
