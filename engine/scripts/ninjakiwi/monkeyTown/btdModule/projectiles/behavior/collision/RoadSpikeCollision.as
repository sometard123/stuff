package ninjakiwi.monkeyTown.btdModule.projectiles.behavior.collision
{
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   
   public class RoadSpikeCollision extends BehaviorCollision
   {
       
      
      public function RoadSpikeCollision()
      {
         super();
      }
      
      override public function execute(param1:Projectile) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = param1.clip.frameCount - 1;
         if(param1.pierce > _loc3_)
         {
            _loc2_ = 0;
         }
         else
         {
            _loc2_ = _loc3_ - param1.pierce;
         }
         param1.clip.gotoAndStop(_loc2_);
      }
   }
}
