package ninjakiwi.monkeyTown.btdModule.towers.behavior.process
{
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   
   public class RotateToMouse extends BehaviorProcess
   {
       
      
      private var vec:Vector2;
      
      public function RotateToMouse()
      {
         this.vec = new Vector2();
         super();
      }
      
      override public function process(param1:Tower, param2:Number) : void
      {
         var _loc3_:Vector2 = null;
         if(param1.targetingSystem == TowerDef.TARGETS_MOUSE)
         {
            _loc3_ = param1.level.getMousePos();
            this.vec.x = _loc3_.x - param1.x;
            this.vec.y = _loc3_.y - param1.y;
            param1.rotation = this.vec.rotation;
         }
      }
   }
}
