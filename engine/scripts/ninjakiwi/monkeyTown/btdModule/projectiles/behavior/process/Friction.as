package ninjakiwi.monkeyTown.btdModule.projectiles.behavior.process
{
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   import ninjakiwi.monkeyTown.btdModule.weapons.SpikeSpread;
   
   public class Friction extends BehaviorProcess
   {
       
      
      public function Friction()
      {
         super();
      }
      
      override public function execute(param1:Projectile, param2:Number) : void
      {
         if(SpikeSpread.spikeTo[param1] == null)
         {
            return;
         }
         if(SpikeSpread.spikeTo[param1].delay > 0)
         {
            SpikeSpread.spikeTo[param1].delay = SpikeSpread.spikeTo[param1].delay - param2;
            return;
         }
         if(param1.effectMask == Bloon.IMMUNITY_ALL)
         {
            param1.x = param1.x + (SpikeSpread.spikeTo[param1].to.x - param1.x) * 0.1;
            param1.y = param1.y + (SpikeSpread.spikeTo[param1].to.y - param1.y) * 0.1;
            if(Math.pow(SpikeSpread.spikeTo[param1].to.x - param1.x,2) + Math.pow(SpikeSpread.spikeTo[param1].to.y - param1.y,2) < 9)
            {
               param1.setEffectMask();
            }
         }
         param1.clip.looping = true;
      }
   }
}
