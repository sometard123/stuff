package ninjakiwi.monkeyTown.btdModule.abilities.animations
{
   import assets.effects.SkullSpamClip;
   import ninjakiwi.monkeyTown.btdModule.effects.Spam;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   
   public class SkullSpam extends Spam
   {
       
      
      public function SkullSpam()
      {
         super(SkullSpamClip);
         waft.y = -1;
      }
      
      public static function create() : SkullSpam
      {
         var _loc1_:SkullSpam = Pool.get(SkullSpam);
         _loc1_.initPooled();
         return _loc1_;
      }
   }
}
