package ninjakiwi.monkeyTown.btdModule.abilities
{
   import ninjakiwi.monkeyTown.btdModule.abilities.def.AbilityDef;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.entities.MoabAssassin;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   
   public class MoabAssasin extends Ability
   {
       
      
      public function MoabAssasin()
      {
         super();
      }
      
      override public function execute(param1:Tower, param2:AbilityDef) : void
      {
         var _loc4_:MoabAssassin = null;
         var _loc3_:Bloon = param1.level.getStrongestClosestBloon(new Vector2(param1.x,param1.y));
         if(_loc3_ != null)
         {
            _loc4_ = new MoabAssassin();
            _loc4_.initialise(param1,_loc3_);
            param1.level.addEntity(_loc4_);
         }
         super.execute(param1,param2);
      }
   }
}
