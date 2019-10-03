package ninjakiwi.monkeyTown.btdModule.projectiles.behavior.destroy
{
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   import ninjakiwi.monkeyTown.btdModule.weapons.SpikeSpread;
   
   public class RemoveSpikeSpread extends BehaviorDestroy
   {
       
      
      public function RemoveSpikeSpread()
      {
         super();
      }
      
      override public function execute(param1:Projectile) : void
      {
         if(SpikeSpread.spikeTo[param1] != null)
         {
            SpikeSpread.spikeTo[param1] = null;
            delete SpikeSpread.spikeTo[param1];
         }
      }
   }
}
