package ninjakiwi.monkeyTown.btdModule.abilities.animations
{
   import assets.effects.VortexSmokeParticleClip;
   import assets.effects.VortexSmokeParticleGreyClip;
   
   public class VortexSmokeParticle extends SmokeParticle
   {
       
      
      public function VortexSmokeParticle(param1:Boolean = false)
      {
         var _loc2_:Class = VortexSmokeParticleClip;
         if(param1)
         {
            _loc2_ = VortexSmokeParticleGreyClip;
         }
         super(_loc2_);
      }
   }
}
