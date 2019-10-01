package ninjakiwi.monkeyTown.btdModule.towers.behavior.destroy
{
   import assets.towers.EngineerSentryDeath;
   import assets.towers.EngineerSentryDeathFeet;
   import ninjakiwi.monkeyTown.btdModule.entities.ClipEffect;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   
   public class SentryDestroy extends BehaviorDestroy
   {
       
      
      public function SentryDestroy()
      {
         super();
      }
      
      override public function execute(param1:Tower) : void
      {
         var _loc2_:ClipEffect = null;
         _loc2_ = new ClipEffect();
         _loc2_.initialise(EngineerSentryDeathFeet);
         _loc2_.x = param1.x;
         _loc2_.y = param1.y;
         _loc2_.z = param1.z - 0.01;
         _loc2_.rotation = param1.addonRotation[param1.addonClips[0]];
         Main.instance.game.level.addEntity(_loc2_);
         _loc2_ = new ClipEffect();
         _loc2_.initialise(EngineerSentryDeath);
         _loc2_.x = param1.x;
         _loc2_.y = param1.y;
         _loc2_.z = param1.z;
         _loc2_.rotation = param1.rotation;
         Main.instance.game.level.addEntity(_loc2_);
      }
   }
}
