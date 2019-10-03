package ninjakiwi.monkeyTown.btdModule.projectiles.behavior.process
{
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   
   public class GoToNextTarget extends BehaviorProcess
   {
       
      
      public function GoToNextTarget()
      {
         super();
      }
      
      override public function execute(param1:Projectile, param2:Number) : void
      {
         param1.lifespan = 99999;
         var _loc3_:Bloon = Main.instance.game.level.collisionGrid.getTargetForProjectile(param1,150,Tower.TARGET_CLOSE);
         if(_loc3_ == null)
         {
            param1.destroy();
            return;
         }
         var _loc4_:Number = param1.velocity.magnitude;
         param1.velocity.x = _loc3_.x - param1.x;
         param1.velocity.y = _loc3_.y - param1.y;
         param1.velocity.magnitude = 500;
         param1.x = param1.x + param1.velocity.x * param2;
         param1.y = param1.y + param1.velocity.y * param2;
      }
   }
}
