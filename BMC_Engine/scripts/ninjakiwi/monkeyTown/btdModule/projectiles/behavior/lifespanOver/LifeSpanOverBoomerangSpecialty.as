package ninjakiwi.monkeyTown.btdModule.projectiles.behavior.lifespanOver
{
   import flash.utils.Dictionary;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   
   public class LifeSpanOverBoomerangSpecialty extends BehaviorLifeSpanOver
   {
      
      public static var rangas:Dictionary = new Dictionary();
       
      
      public function LifeSpanOverBoomerangSpecialty()
      {
         super();
      }
      
      override public function execute(param1:Projectile) : void
      {
         param1.destroy();
      }
      
      override public function cleanup(param1:Projectile) : void
      {
         delete rangas[param1];
      }
   }
}
