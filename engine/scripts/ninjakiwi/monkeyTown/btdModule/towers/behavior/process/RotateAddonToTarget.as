package ninjakiwi.monkeyTown.btdModule.towers.behavior.process
{
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   
   public class RotateAddonToTarget extends BehaviorProcess
   {
       
      
      private var vec:Vector2;
      
      public function RotateAddonToTarget()
      {
         this.vec = new Vector2();
         super();
      }
      
      override public function process(param1:Tower, param2:Number) : void
      {
         if(param1.targetsByPriority.length <= 0)
         {
            param1.addonClips[0].gotoAndStop(0);
            return;
         }
         param1.addonClips[0].play();
         var _loc3_:Entity = param1.targetsByPriority[param1.targetsByPriority.length - 1];
         this.vec.x = _loc3_.x - param1.x;
         this.vec.y = _loc3_.y - param1.y;
         param1.addonRotation[param1.addonClips[0]] = this.vec.rotation;
      }
   }
}