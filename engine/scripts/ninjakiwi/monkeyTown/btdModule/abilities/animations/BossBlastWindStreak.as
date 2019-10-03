package ninjakiwi.monkeyTown.btdModule.abilities.animations
{
   import assets.effects.BlastBackCloudParticleClip;
   import assets.effects.BlastBackLeaf1ParticleClip;
   import assets.effects.BlastBackLeaf2ParticleClip;
   import assets.effects.BlastBackParticleClip;
   import display.Clip;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.effects.Spam;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.SpecialTrackManager;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   import ninjakiwi.monkeyTown.utils.WeightingManager;
   
   public class BossBlastWindStreak extends Spam
   {
      
      private static var _waftSpeed:Number = 7;
      
      private static var weights:WeightingManager = new WeightingManager();
      
      {
         staticInit();
      }
      
      private var _bossBloon:Bloon;
      
      public function BossBlastWindStreak()
      {
         super(null);
         _clip = new Clip();
         var _loc1_:ClipData = weights.getRandomItem();
         _clip.initialise(_loc1_.clipClass,16,false,_loc1_.scale);
      }
      
      private static function staticInit() : void
      {
         weights.addWeightedItem(new ClipData(BlastBackParticleClip),6);
         weights.addWeightedItem(new ClipData(BlastBackCloudParticleClip),4);
         weights.addWeightedItem(new ClipData(BlastBackLeaf1ParticleClip,1.6),1);
         weights.addWeightedItem(new ClipData(BlastBackLeaf2ParticleClip,1.6),1);
      }
      
      public static function create(param1:Vector2) : BossBlastWindStreak
      {
         var _loc2_:BossBlastWindStreak = null;
         _loc2_ = Pool.get(BossBlastWindStreak);
         _loc2_.initPooled();
         _loc2_._bossBloon = SpecialTrackManager.getInstance().getBoss();
         _loc2_.rotation = param1.rotation - Math.PI * 0.5;
         _loc2_.waft.x = param1.x * _waftSpeed;
         _loc2_.waft.y = param1.y * _waftSpeed;
         var _loc3_:Number = 70;
         _loc2_.x = _loc2_._bossBloon.x + (Math.random() * 2 - 1) * _loc3_ - param1.x * 20;
         _loc2_.y = _loc2_._bossBloon.y + (Math.random() * 2 - 1) * _loc3_ - param1.y * 30;
         return _loc2_;
      }
   }
}
