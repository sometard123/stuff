package ninjakiwi.monkeyTown.btdModule.abilities
{
   import ninjakiwi.monkeyTown.btdModule.abilities.def.AbilityDef;
   import ninjakiwi.monkeyTown.btdModule.entities.Whirpool;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   
   public class ActivateWhirpool extends Ability
   {
       
      
      public function ActivateWhirpool()
      {
         super();
      }
      
      override public function execute(param1:Tower, param2:AbilityDef) : void
      {
         var _loc3_:Whirpool = new Whirpool();
         _loc3_.initialise(param1);
         param1.level.addEntity(_loc3_);
         super.execute(param1,param2);
      }
   }
}
