package ninjakiwi.monkeyTown.btdModule.abilities.animations
{
   import assets.effects.BossBaneExplosionClip;
   import ninjakiwi.monkeyTown.btdModule.effects.Spam;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   
   public class BossBaneExplosion extends Spam
   {
       
      
      public function BossBaneExplosion()
      {
         super(BossBaneExplosionClip);
      }
      
      public static function create() : BossBaneExplosion
      {
         var _loc1_:BossBaneExplosion = Pool.get(BossBaneExplosion);
         _loc1_.initPooled();
         return _loc1_;
      }
   }
}
