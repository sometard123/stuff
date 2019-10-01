package ninjakiwi.monkeyTown.btdModule.abilities.antiBossAbilities
{
   import assets.sounds.PowerWeaken;
   import ninjakiwi.monkeyTown.btdModule.abilities.animations.SkullSpam;
   import ninjakiwi.monkeyTown.btdModule.abilities.antiBossAbilities.def.IAntiBossAbilityBehaviour;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.sound.MaxSound;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.SpecialTrackManager;
   
   public class BossWeakenBehaviour implements IAntiBossAbilityBehaviour
   {
       
      
      private const DAMAGE_MODIFIER:Number = 2;
      
      private var _bossBloon:Bloon = null;
      
      public function BossWeakenBehaviour()
      {
         super();
      }
      
      public function reset() : void
      {
      }
      
      public function update(param1:Number) : void
      {
         var _loc2_:SkullSpam = null;
         if(this._bossBloon !== null && Math.random() < 0.3)
         {
            _loc2_ = SkullSpam.create();
            _loc2_.x = this._bossBloon.x + (Math.random() - 0.5) * 130;
            _loc2_.y = this._bossBloon.y + (Math.random() - 0.5) * 130;
         }
      }
      
      public function activate() : void
      {
         this._bossBloon = SpecialTrackManager.getInstance().getBoss();
         if(this._bossBloon !== null)
         {
            this._bossBloon.damageMultipler = this.DAMAGE_MODIFIER;
            new MaxSound(PowerWeaken).play();
         }
      }
      
      public function deactivate() : void
      {
         var _loc1_:Bloon = SpecialTrackManager.getInstance().getBoss();
         if(_loc1_ !== null)
         {
            _loc1_.damageMultipler = 1;
         }
         _loc1_ = null;
      }
   }
}
