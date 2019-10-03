package ninjakiwi.monkeyTown.btdModule.towers.behavior.roundStart
{
   import assets.projectile.DoomShot;
   import flash.utils.Dictionary;
   import ninjakiwi.monkeyTown.btdModule.entities.MapElement;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   
   public class DeployRay extends BehaviorRoundStart
   {
      
      public static var rays:Dictionary = new Dictionary();
       
      
      public function DeployRay()
      {
         super();
      }
      
      override public function execute(param1:Tower) : void
      {
         var _loc2_:MapElement = new MapElement();
         _loc2_.initialise(DoomShot,99,0);
         param1.level.addEntity(_loc2_);
         rays[param1] = _loc2_;
      }
   }
}
