package ninjakiwi.monkeyTown.btdModule.abilities.animations
{
   import assets.effects.SnowSpamClip;
   import assets.effects.SnowSpamClip02;
   import ninjakiwi.monkeyTown.btdModule.effects.Spam;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   
   public class ChillSpam extends Spam
   {
       
      
      public function ChillSpam()
      {
         var _loc1_:Class = null;
         if(Math.random() < 0.5)
         {
            _loc1_ = SnowSpamClip;
         }
         else
         {
            _loc1_ = SnowSpamClip02;
         }
         super(_loc1_);
         waft.y = 0.5;
      }
      
      public static function create() : ChillSpam
      {
         var _loc1_:ChillSpam = Pool.get(ChillSpam);
         _loc1_.initPooled();
         return _loc1_;
      }
   }
}
