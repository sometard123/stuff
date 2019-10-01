package ninjakiwi.monkeyTown.btdModule.weapons
{
   import ninjakiwi.monkeyTown.btdModule.entities.Bee;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   
   public class LaunchBee extends Standard
   {
       
      
      public function LaunchBee()
      {
         super();
      }
      
      public function Range(param1:Number) : LaunchBee
      {
         range = param1;
         return this;
      }
      
      public function ReloadTime(param1:Number) : LaunchBee
      {
         reloadTime = param1;
         return this;
      }
      
      public function Power(param1:Number) : LaunchBee
      {
         power = param1;
         return this;
      }
      
      public function Projectile(param1:ProjectileDef) : LaunchBee
      {
         projectile = param1;
         return this;
      }
      
      public function Proxied(param1:Boolean) : LaunchBee
      {
         proxied = param1;
         return this;
      }
      
      override public function execute(param1:Tower, param2:Entity, param3:Entity, param4:Vector2 = null) : void
      {
         var _loc5_:Bee = new Bee();
         _loc5_.initialise(param1,param3);
         param1.level.addEntity(_loc5_);
      }
   }
}
