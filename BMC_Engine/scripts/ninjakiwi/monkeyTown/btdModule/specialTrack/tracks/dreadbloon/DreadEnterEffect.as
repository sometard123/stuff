package ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.dreadbloon
{
   import assets.bloons.DreadbloonRockWallClip;
   import ninjakiwi.monkeyTown.btdModule.abilities.animations.VortexSmokeParticle;
   import ninjakiwi.monkeyTown.btdModule.effects.Spam;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   
   public class DreadEnterEffect extends Spam
   {
       
      
      public function DreadEnterEffect()
      {
         super(DreadbloonRockWallClip);
      }
      
      public static function create() : DreadEnterEffect
      {
         var _loc1_:DreadEnterEffect = Pool.get(DreadEnterEffect);
         _loc1_.initPooled();
         return _loc1_;
      }
      
      override public function initPooled() : void
      {
         super.initPooled();
         _clip.gotoAndStop(0);
         Main.instance.game.cull(this);
         Main.instance.game.level.addEntity(this);
         z = 0;
      }
      
      override protected function clean() : void
      {
         super.clean();
         Main.instance.game.level.cull(this);
      }
      
      public function go() : void
      {
         _clip.gotoAndPlay(0);
      }
   }
}
