package ninjakiwi.monkeyTown.btdModule.abilities
{
   import ninjakiwi.monkeyTown.btdModule.abilities.def.AbilityDef;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.entities.Harpoon;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   
   public class MOABTakedown extends Ability
   {
       
      
      public function MOABTakedown()
      {
         super();
      }
      
      override public function execute(param1:Tower, param2:AbilityDef) : void
      {
         var _loc4_:Harpoon = null;
         var _loc3_:Bloon = param1.level.getStrongestClosestBloon(new Vector2(param1.x,param1.y),true,true);
         if(_loc3_ != null)
         {
            _loc4_ = new Harpoon();
            _loc4_.initialise(param1,_loc3_);
            param1.level.addEntity(_loc4_);
         }
         super.execute(param1,param2);
      }
   }
}
