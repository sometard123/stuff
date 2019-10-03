package ninjakiwi.monkeyTown.btdModule.abilities.animations
{
   import assets.effects.LightningFXBossBlast;
   import ninjakiwi.monkeyTown.btdModule.effects.Spam;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   
   public class BossBlastLightning extends Spam
   {
       
      
      public function BossBlastLightning()
      {
         super(LightningFXBossBlast);
      }
      
      public static function create() : BossBlastLightning
      {
         var _loc1_:BossBlastLightning = Pool.get(BossBlastLightning);
         _loc1_.initPooled();
         return _loc1_;
      }
   }
}
