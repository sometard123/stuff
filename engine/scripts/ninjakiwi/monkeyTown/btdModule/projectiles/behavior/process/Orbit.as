package ninjakiwi.monkeyTown.btdModule.projectiles.behavior.process
{
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   
   public class Orbit extends BehaviorProcess
   {
       
      
      public function Orbit()
      {
         super();
      }
      
      override public function execute(param1:Projectile, param2:Number) : void
      {
         var _loc3_:Tower = null;
         _loc3_ = param1.owner;
         var _loc4_:Vector2 = new Vector2(_loc3_.x - param1.x,_loc3_.y - param1.y);
         _loc4_.rotateBy(Math.PI * 2 * param2);
         param1.x = _loc3_.x - _loc4_.x;
         param1.y = _loc3_.y - _loc4_.y;
      }
   }
}
