package ninjakiwi.monkeyTown.btdModule.projectiles.behavior.roundOver
{
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   
   public class RoundOverDestroy extends BehaviorRoundOver
   {
       
      
      public function RoundOverDestroy()
      {
         super();
      }
      
      override public function execute(param1:Projectile) : void
      {
         param1.destroy();
      }
   }
}
