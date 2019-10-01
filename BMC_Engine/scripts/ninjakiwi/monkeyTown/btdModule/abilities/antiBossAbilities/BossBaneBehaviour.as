package ninjakiwi.monkeyTown.btdModule.abilities.antiBossAbilities
{
   import assets.sounds.PowerBane;
   import ninjakiwi.monkeyTown.btdModule.abilities.animations.BossBaneExplosion;
   import ninjakiwi.monkeyTown.btdModule.abilities.antiBossAbilities.def.IAntiBossAbilityBehaviour;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.sound.MaxSound;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.SpecialTrackManager;
   
   public class BossBaneBehaviour implements IAntiBossAbilityBehaviour
   {
      
      public static const DAMAGE:int = 1500;
       
      
      private var _bossBloon:Bloon;
      
      public function BossBaneBehaviour()
      {
         super();
      }
      
      public function reset() : void
      {
      }
      
      public function update(param1:Number) : void
      {
      }
      
      public function activate() : void
      {
         var _loc1_:BossBaneExplosion = null;
         this._bossBloon = SpecialTrackManager.getInstance().getBoss();
         if(this._bossBloon !== null)
         {
            this._bossBloon.damage(DAMAGE,1,null);
            _loc1_ = BossBaneExplosion.create();
            _loc1_.x = this._bossBloon.x;
            _loc1_.y = this._bossBloon.y;
            new MaxSound(PowerBane).play();
         }
      }
      
      public function deactivate() : void
      {
      }
   }
}
