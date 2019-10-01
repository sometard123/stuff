package ninjakiwi.monkeyTown.btdModule.towers.behavior.process
{
   import flash.utils.Dictionary;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundStart.SpawnGlaives;
   
   public class GlaiveLordProcess extends BehaviorProcess
   {
      
      private static var count:Dictionary = new Dictionary();
       
      
      private var vec:Vector2;
      
      public function GlaiveLordProcess()
      {
         this.vec = new Vector2();
         super();
      }
      
      public function updateGlaives(param1:Tower) : void
      {
         var _loc2_:Projectile = null;
         var _loc3_:Vector.<Projectile> = SpawnGlaives.glaives[param1];
         if(_loc3_ == null)
         {
            return;
         }
         if(count[param1] == null)
         {
            count[param1] = 0;
         }
         if(count[param1] == 0)
         {
            for each(_loc2_ in _loc3_)
            {
               _loc2_.effectMask = Bloon.IMMUNITY_NONE;
            }
         }
         else
         {
            for each(_loc2_ in _loc3_)
            {
               _loc2_.effectMask = Bloon.IMMUNITY_ALL;
            }
         }
         count[param1]++;
         if(count[param1] == 5)
         {
            count[param1] = 0;
         }
      }
      
      override public function process(param1:Tower, param2:Number) : void
      {
         this.updateGlaives(param1);
         if(!param1.inThrowAnimation || param1.targetsByPriority.length <= 0)
         {
            return;
         }
         var _loc3_:Entity = param1.targetsByPriority[param1.targetsByPriority.length - 1];
         this.vec.x = _loc3_.x - param1.x;
         this.vec.y = _loc3_.y - param1.y;
         param1.rotation = this.vec.rotation;
      }
   }
}
