package ninjakiwi.monkeyTown.btdModule.towers.behavior.roundOver
{
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundStart.SpawnGlaives;
   
   public class RetractGlaives extends BehaviorRoundOver
   {
       
      
      public function RetractGlaives()
      {
         super();
      }
      
      override public function execute(param1:Tower) : void
      {
         var _loc3_:Projectile = null;
         var _loc2_:Vector.<Projectile> = SpawnGlaives.glaives[param1];
         if(_loc2_ != null)
         {
            for each(_loc3_ in _loc2_)
            {
               _loc3_.destroy();
            }
            SpawnGlaives.glaives[param1] = null;
         }
      }
   }
}
