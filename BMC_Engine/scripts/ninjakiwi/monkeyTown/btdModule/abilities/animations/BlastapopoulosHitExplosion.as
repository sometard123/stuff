package ninjakiwi.monkeyTown.btdModule.abilities.animations
{
   import assets.effects.LargeExplosionClip;
   import assets.sounds.BlastapopoulosImpact;
   import ninjakiwi.monkeyTown.btdModule.effects.Spam;
   import ninjakiwi.monkeyTown.btdModule.sound.MaxSound;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   
   public class BlastapopoulosHitExplosion extends Spam
   {
       
      
      public function BlastapopoulosHitExplosion()
      {
         super(LargeExplosionClip);
      }
      
      public static function create() : BlastapopoulosHitExplosion
      {
         var _loc1_:BlastapopoulosHitExplosion = Pool.get(BlastapopoulosHitExplosion);
         _loc1_.initPooled();
         new MaxSound(BlastapopoulosImpact).play();
         return _loc1_;
      }
   }
}
